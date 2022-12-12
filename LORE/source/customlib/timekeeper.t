/*
Copyright (C) 2017 Nikita Tseykovets <tseikovets@rambler.ru>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Библиотека для подсчёта хронометража игровой сессии
// Версия 0.7-fix
// Библиотеку желательно подключать сразу после advr.t и stdr.t
// Если init() и mainRestore() далее в проекте заменяются директивой replace, то в них надо восстановить вызовы timekeeper

// Добавляем в показ счёта и информацию о времени
modify scoreVerb
	showScore(actor) =
	{
		scoreRank();
		timeRank();
	}
;

// Функция, показывающая длительность игровой сессии
timeRank: function()
{
	local time := timekeeper.finalTime(gettime()[9]), hours, minutes, seconds;
	hours := time/3600;
	minutes := (time - hours*3600)/60;
	seconds := time - hours*3600 - minutes*60;
	"Длительность игровой сессии составила ";
	if(hours != 0)
		"<<hours>> час<<numok(hours, '', 'а', 'ов')>>, ";
	if(minutes != 0)
		"<<minutes>> минут<<numok(minutes, 'у', 'ы', '')>>, ";
	"<<seconds>> секунд<<numok(seconds, 'у', 'ы', '')>>.\n";
}

// Объект-хранилище с данными о времени игровой сессии
timekeeper: object
	startTime = 0 // Время старта игры
	saveTime = 0 // Время последнего сохранения игры
	intervals = [] // Список интервалов игровой сессии
	// Метод для обработки ситуации загрузки игры из восстановления
	restoreTime(time) =
	{
		// При восстановлении, сохраняем интервал от времени старта до времени сохранения и перезапускаем отсчёт
		intervals := intervals + (self.saveTime - self.startTime);
		self.startTime := time;
	}
	// Метод для возврата итогового времени игровой сессии
	finalTime(time) =
	{
		local fullTime, i, len = length(intervals);
		// Получаем хронометраж последнего игрового интервала
		fullTime := time - self.startTime;
		// Если есть игровые интервалы от сохранений, то прибавляем их к полному времени
		if(len > 0)
		{
			for(i := 1; i <= len; i++)
			{
				fullTime := fullTime + intervals[i];
			}
		}
	return fullTime;
	}
;

// Заменяем функции init() и mainRestore(), внедряя в них контроль времени

replace init: function
{
#ifdef USE_HTML_STATUS
    /* 
     *   Мы используем HTML-стиль статусной строки -- будем уверены,
     *   что используется интерпретатор достаточно новой версии, чтобы
     *   поддерживать этот код. (Код статусной строки использует
     *   systemInfo, чтобы обнаружить, поддерживает ли интерпретатор
     *   HTML или нет -- HTML не работает правильно на версиях
     *   предшествующих 2.2.4.)
     *   
     *   We're using the adv.t HTML-style status line - make sure the
     *   run-time version is recent enough to support this code.  (The
     *   status line code uses systemInfo to detect whether the run-time
     *   is HTML-enabled or not, which doesn't work properly before
     *   version 2.2.4.)  
     */
    if (systemInfo(__SYSINFO_SYSINFO) != true
        || systemInfo(__SYSINFO_VERSION) < '2.2.4')
    {
        "\b\b\(ВНИМАНИЕ! Эта игра требует интерпретатор TADS версии
        2.2.4 или выше. Похоже, что вы используете более старую версию
        интерпретатора. Вы можете попробовать запустить эту игру, однако,
        отображение игрового экрана может не работать правильно. Если
        вы испытываете какие либо трудности, вы можете попробовать
        перейти на более новую версию интерпретатора TADS.\)\b\b";
    }
#endif

    /* выполнение общей инициализации */
    /* perform common initializations */
    commonInit();
    
    introduction();

    version.sdesc;                // показ названия и версии игры

    setdaemon(turncount, nil);         // запуск демона (deamon) счетчика ходов
                                       //         start the turn counter daemon
    setdaemon(sleepDaemon, nil);                  // запуск демона (deamon) сна
                                                  //     start the sleep daemon
    setdaemon(eatDaemon, nil);                 // запуск демона (deamon) голода
                                               //       start the hunger daemon
   //switchPlayer(newPlayer);			// Меняем стандартного игрока на нового
    parserGetMe().location := startroom;     //  переместить игрока в начальную
                                             //                         локацию
                                             // move player to initial location
    startroom.lookAround(true);            // показать игроку, где он находится
                                           //           show player where he is
    startroom.isseen := true;             // отметить, что локация была увидена
                                          //      note that we've seen the room
    scoreStatus(0, 0);                    // инициализировать отображение очков
                                          //       initialize the score display
    randomize();			  // это, если нужны случайности в игре

	// Записываем время старта игры
	timekeeper.startTime := gettime()[9];
}

replace mainRestore: function(fname)
{
	/* try restoring the game */
	switch(restore(fname))
	{
	case RESTORE_SUCCESS:
		/* update the status line */
		scoreStatus(global.score, global.turnsofar);

		// Записываем время восстановления игры
		timekeeper.restoreTime(gettime()[9]);

		/* tell the user we succeeded, and show the location */
		"Восстановлено.\b";
		parserGetMe().location.lookAround(true);
		
		/* success */
		return true;

	case RESTORE_FILE_NOT_FOUND:
		"Файл сохранённой игры не может быть открыт. ";
		return nil;

	case RESTORE_NOT_SAVE_FILE:
		"В этом файле нет данных о сохраненной игре. ";
		return nil;

	case RESTORE_BAD_FMT_VSN:
		"Этот файл создан другой игрой или версией, не совместимой с данной. ";
		return nil;

	case RESTORE_BAD_GAME_VSN:
		"Этот файл создан другой игрой или версией, не совместимой с данной. ";
		return nil;

	case RESTORE_READ_ERROR:
		"Во время чтения файла сохраненной игры возникла ошибка; Возможно,
		 файл был повреждён.  Игра может быть частично восстановлена,
		 что даст возможность продолжать игру; если игра правильно не работает,
		 вам придётся начать её заново. ";
		return nil;

	case RESTORE_NO_PARAM_FILE:
		/* 
		 *   ignore the error, since the caller was only asking, and
		 *   return nil 
		 */
		return nil;

	default:
		"Восстановление не удалось. ";
		return nil;
	}
}

// Модифицируем объекты basicStrObj и saveVerb для внедрения в методы сохранения контроль времени

modify basicStrObj
	saveGame(actor) =
	{
		// Записываем время сохранения игры
		timekeeper.saveTime := gettime()[9];

		if (save(self.value))
		{
			"Сохранение не удалось. ";
			return nil;
		}
		else
		{
			"Сохранено. ";
			return true;
		}
	}
;

modify saveVerb
	saveGame(actor) =
	{
		local savefile;
		
		// Записываем время сохранения игры
		timekeeper.saveTime := gettime()[9];

		savefile := askfile('Файл для сохранения:',
							ASKFILE_PROMPT_SAVE, FILE_TYPE_SAVE,
							ASKFILE_EXT_RESULT);
		switch(savefile[1])
		{
		case ASKFILE_SUCCESS:
			if (save(savefile[2]))
			{
				" Во время сохранения произошла ошибка. ";
				return nil;
			}
			else
			{
				"Сохранено. ";
				return true;
			}

		case ASKFILE_CANCEL:
			"Отменено. ";
			return nil;
			
		case ASKFILE_FAILURE:
		default:
			"Неудача. ";
			return nil;
		}
	}
;