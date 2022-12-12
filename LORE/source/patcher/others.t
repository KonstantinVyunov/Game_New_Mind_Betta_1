/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// Проверено на TADS 2.5.11 русский релиз 27
// Дата последнего изменения 2017.10.01

// Патчим extendr.t

// Добавляем русские варианты для команд показа уведомлений об изменении счёта
// Также отключаем в этой команде изменение счётчика ходов
modify notifyVerb
	action(actor)=
	{
	if (not global.incscorenotified) 
		{
		"Уведомление об изменении счета включено. ";
		global.incscorenotified:=true;
		}
	else 
		{
		"Уведомление об изменении счета выключено. ";
		global.incscorenotified:=nil;
		}
		abort;
	}
	verb = 'notify' 'уведомление' 'уведомления' 'уведомлять' 'уведомляй' 'уведомить' 'уведомь'
;
