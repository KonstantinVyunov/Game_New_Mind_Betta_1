// VERBS.T
// Библиотека системных глаголов игры
#pragma C++

changeInputModeVerb: sysverb
 verb = 'приглашение' 
 sdesc = "приглашение"
 action(actor) = {
    if (global.input_mode==INPUT_MODE_LITE) {
	   global.input_mode = INPUT_MODE_FULL;
	   "Полное приглашение включено.<br>";
	}
	else if (global.input_mode==INPUT_MODE_FULL) {
	   global.input_mode = INPUT_MODE_LITE;
	   "Краткое приглашение включено.<br>";
	}
 }
;

replace jumpVerb: deepverb
	verb =	'прыгнуть' 'перепрыгнуть' 'перепрыгни' 'спрыгнуть' 'спрыгни' 'прыгать' 
			'подпрыгнуть' 'подпрыгни' 'прыгни' 'прыгай'
	sdesc = "прыгнуть"
	doAction = 'Jump'
	action(actor) = { 
        if ( (parserGetMe().location!=nil) && (parserGetMe().location.mayJumpOut == true) ) {
          "Вы мощно выпрыгнули. <br>";
          Me.travelTo(parserGetMe().location.out);
        } else {
          "Вы приготовились к прыжку, но в последний момент передумали. <br>";
        }        
    }
;

replace yellVerb: deepverb
	verb = 'орать' 'кричать' 'визжать' 'заорать' 'вопить' 'оборать'
'ори' 'кричи' 'визжи' 'заори' 'вопи' 'обори' 'крикнуть' 'крикни'
	sdesc = "орать"
	action(actor) =
	{
		"Вы издали настолько сильный звук, что чуть не сломали синтезатор. ";
	}
;

changeEnemyModeVerb: sysverb
 verb = 'опвраги' 
 sdesc = "опвраги"
 action(actor) = {
    if (global.enemy_mode==ENEMY_MODE_FULL) {
	   global.enemy_mode = ENEMY_MODE_SHORT;
	   "Краткая информация о врагах во время боя включена.<br>";
	}
    else if (global.enemy_mode==ENEMY_MODE_SHORT) {
	   global.enemy_mode = ENEMY_MODE_FULL;
	   "Подробная информация о врагах во время боя включена.<br>";
	}
 }
;

closerVerb: deepverb
verb = 'назад'
       'дальше'
       'дл'
       'нз'
sdesc = "назад"
action(actor) = {
   if (HaveMonsters(actor.location))
   {
      if (actor.location._pl_pos == 0)
      {
         "Назад уже нельзя.";
      }
      else
      {
         "Вы отошли назад.<br>";
         battleMove(actor,MOVE_DIR_BACKWARD);
      }
   }
   else
   {
      "Противников нет, зачем перемещаться?";
   }
}
;

fartherVerb: deepverb
verb = 'вперед'
       'ближе'
       'бл'
       'вп'
sdesc = "вперёд"
action(actor) = {
   if (HaveMonsters(actor.location))
   {
      if (actor.location._pl_pos == actor.location._field_size)
      {
         "Вперёд уже нельзя.";
      }
      else
      {
         "Вы прошли вперёд.<br>";
         battleMove(actor,MOVE_DIR_FORWARD);
      }
   }
   else
   {
      "Противников нет, зачем перемещаться?";
   }
}
;

replace waitVerb: darkVerb
	verb = 'ж' 'ждать' 'подождать' 'жди' 'подожди'
	sdesc = "ждать"
	action(actor) =
	{
        if (HaveMonsters(actor.location))
        {
           "Вы ожидаете.";
           combo_wait(actor);
        }
        else
        {
		   "Прошло некоторое время...\n";
        }
	}
;

selfShootVerb: deepverb
	verb = 'застрелиться' 'застрелись'
	sdesc = "застрелиться"
	action(actor) =
	{
        "Всё не так плохо, без паники.\n";
	}
;

//Прицелиться и стрелять
shootVerb: deepverb
verb = 'стрелять'
       'стреляй'
	   'выстрели'
	   'выстрелить'
	   'стрелять в'
       'стреляй в'
	   'выстрели в'
	   'выстрелить в'
	   'стрелять по'
       'стреляй по'
	   'выстрели по'
	   'выстрелить по'
       'стрелять на'
       'стреляй на'
	   'выстрели на'
	   'выстрелить на'
sdesc = "стрелять"
doAction = 'Shoot'
ioAction(withPrep) = 'ShootWith'
action(actor)={
   local mon = GetCloserMon(actor.location);
   if (mon != nil) 
   {
       if (actor.sel_weapon.isCloseCombat && (actor.location._pl_pos != mon._pos) )
       {
          "У вас оружие ближнего боя, в ближайшего монстра на таком расстоянии не попасть!";
       }
       else
       {
          if (shootMonster(actor,mon)==nil)
          {
             "<br>Недостаточно патронов!<br>";
          }
       }
   }
   else 
   {
      "Здесь нет ближайшего монстра для выстрела!";
   }
}
;

replace breakVerb: deepverb
;

replace attackVerb: deepverb
	verb = 'убить' 'убей' 'ударить' 'ударь' 'врезать' 'врежь' 'бить' 'бей' 'атаковать' 'атакуй'
	'напасть на' 'напади на' 'наброситься на' 'набросься на' 'ударить по' 'ударь по' 'ударить в' 'ударь в'
	'врезать в' 'врежь в' 'врезать по' 'врежь по' 'дать по' 'дай по' 'дать в' 'дай в' 'бить по' 'бей по'
	'бить в' 'бей в' 'разбить' 'сломать' 'уничтожить' 'порвать' 'ломать' 'разбей' 'сломай' 'уничтожь' 'порви' 
    'разорвать' 'разорви' 'ломай' 'разобрать' 'разбери' 'резать' 'режь' 'колоть' 'заколоть'
    doAction = 'Shoot'
    ioAction(withPrep) = 'ShootWith'
    sdesc = "ударить"
    action(actor)={
        local mon = GetCloserMon(actor.location);
        if (mon != nil) 
        {
            if (actor.sel_weapon.isCloseCombat && (actor.location._pl_pos != mon._pos) )
            {
               "У вас оружие ближнего боя, в ближайшего монстра на таком расстоянии не попасть!";
            }
            else if (!actor.sel_weapon.isCloseCombat)
            {
               "У вас оружие дальнего боя! Используйте выстрелы.";
            }
            else
            {
               shootMonster(actor,mon);
            }
        }
        else 
        {
           "Здесь нет ближайшего монстра для удара!";
        }
    }
;

replace getOutVerb: deepverb
	verb = 'сойти' 'сойди' 'слезть' 'слезь' 'вылезть' 'вылезь' 'вылезти' 
		   'сойти с' 'сойти со' 'сойди с' 'сойди со' 'слезть с' 'слезть со' 'слезь с' 'слезь со' 'выйти из'
		   'выйди из' 'вылезти из' 'вылези из' 'подняться с' 'подняться со' 'поднимись с' 'поднимись со'
		   'встань с'  'встань со' 'встать с' 'встать со'
	vopr = "Откуда "
	sdesc = "сойти"
	doAction = 'Unboard'
	action(actor) = { askdo; }
	doDefault(actor, prep, io) =
	{
		if (actor.location and actor.location.location)
			return ([] + actor.location);
		else
			return [];
	}
	pred=fromPrep
;

selectVerb: deepverb
verb = 'выбрать'
	   'выбери'
sdesc = "выбрать"
doAction = 'Select'
no_mon_turn = true
action(actor) = {
  "Текущее оружие: <<actor.sel_weapon.sdesc>>";
}
;

syntesisVerb: deepverb
verb = 'синтез' 'синтезировать' 'синтезируй'
sdesc = "синтез"
no_mon_turn = true
action(actor) = {
  CraftSystem.startCraft;
}
;

replace undoVerb: sysverb
	verb = 'undo' 'отмена' 'взад' 'откат'
	sdesc = "отмена"
	action(actor) =
	{
		"В этой игре отмена хода отключена! Пользуйтесь сохранениями. ";
		abort;
	}
;


useVerb: deepverb
	verb = 'использовать' 'исп' 'используй' 'применить' 'примени'
    doAction = 'Use'
    sdesc = "использовать"
    action(actor) =
	{
       local i;
       local find_using = nil;
       local act_synt_list = [];
       local act_synt_id = [];
       for (i=1;i<=length(actor.contents);i++) 
       {
           if (isclass(actor.contents[i],SyntesisItem))
           {
               local synt_item = actor.contents[i];
               find_using = true;
               //Добавляем только если еще нет
               if (find(act_synt_id,synt_item.craft_id)==nil) {
                  act_synt_list += [synt_item];
                  act_synt_id += [synt_item.craft_id];
               }
           }
       }
       if (!find_using) "Нет предметов для использования.";
       else{
          local resp;
          local resp_str;
          "<b>Выберите элемент для применения (пустая строка для выхода):</b><br>";
          for (i=1;i<=length(act_synt_list);i++) 
          {
             local synt_item = act_synt_list[i];
             say(synt_item.craft_id); " : "; synt_item.sdesc; "<br>";
          }
          "<br>>";
          resp_str = input();
          if (resp_str=='') {
             "Отмена использования.<br>";
             return;
          }
          resp = cvtnum(resp_str);
          for (i=1;i<=length(act_synt_list);i++) 
          {
             local synt_item = act_synt_list[i];
             if (resp == synt_item.craft_id)
             {
                "<br>";
                synt_item.doUse(actor);
                return;
             }
          }
          "Нет такого номера элемента.";
       }
    }
;

//Запрещаем изменение состояния для определённых глаголов
modify inspectVerb
  no_mon_turn = true
;

modify osmVerb
  no_mon_turn = true
;

modify lookVerb
  no_mon_turn = true
;

replace iVerb: deepverb
    no_mon_turn = true
	verb = 'ин' 'инв' 'инвентарь'
	sdesc = "инвентарь"
	useInventoryTall = true
	action(actor) =
	{
		if (itemcnt(actor.contents))
		{
			/* use tall or wide mode, as appropriate */
			if (self.useInventoryTall)
			{
                local i, have_effects;
				/* use "tall" mode */
                "Ресурсы: кристаллы энергии-<<ResourceSystem.crystals>>, пласталь-<<ResourceSystem.aluminium>>, кремний-<<ResourceSystem.selicon>><br>";
				"У <<actor.fmtYouve>> имеется:\n";
				global.vinpadcont=0;
				nestlistcont(actor, 1);
			    global.vinpadcont=1;
                "\nАктивные эффекты(подробная информация по команде \"эффекты\"):\n";
                have_effects = nil;
                for (i=1;i<=length(actor.contents);i++) 
                   if (isclass(actor.contents[i],Combo) && (actor.contents[i].showInList == true))
                   {
                       local comb = actor.contents[i];
                       "\t<<comb.sdesc>>\n";
                       have_effects = true;
                   }
                   
                if (have_effects==nil) "\tНет активных эффектов.\n";
			}
			else
			{
				/* use wide mode */
				"У <<actor.fmtYouve>> есть "; global.vinpadcont=0; listcont(actor);". ";
				listcontcont(actor); global.vinpadcont=1;
			}
		}
		else
			"У <<actor.fmtYouve>> ничего нет.\n";
	}
;

comboVerb: deepverb
    no_mon_turn = true
	verb = 'эффекты' 'эффект' 'эфф'
	sdesc = "эффекты"
    action(actor) =
	{
       local i, have_effects;
       have_effects = nil;
       for (i=1;i<=length(actor.contents);i++) 
           if (isclass(actor.contents[i],Combo) && actor.contents[i].showInList)
           {
               local comb = actor.contents[i];
               have_effects = true;
               "<b><<comb.sdesc>></b>:\n";
               "\t";comb.ldesc;
               "\b";
           }
           
       if (have_effects==nil) "\tНет активных эффектов.\n";
    }
;

superLifeVerb: deepverb
    no_mon_turn = true
	verb = 'супержизнь'
	sdesc = "супержизнь"
    action(actor) =
	{
       actor._hp += 1000;
       "Чит выполнен.";
    }
;


superResAdd: deepverb
    no_mon_turn = true
	verb = 'суперкрафт'
	sdesc = "суперкрафт"
    action(actor) =
	{
       ResourceSystem._alum = 1000;
       ResourceSystem._crystal = 1000;
       ResourceSystem._selicon = 1000;
       "Чит выполнен.";
    }
;

autoTestVerb: deepverb
    no_mon_turn = true
	verb = 'стопрандом'
	sdesc = "стопрандом"
    action(actor) =
	{
       "<br>Генаратор случайных чисел остановлен. Выдаётся всегда среднее значение.<br>";
       global.isFixedRndRangeMid = true;
    }
;

putDownVerb: deepverb
	verb = 'опустить' 'опусти'
	sdesc = "опустить"
    doAction = 'Putdown'
;

chmokVerb: deepverb
	verb = 'поцеловать' 'целовать' 'целуй' 'поцелуй'
	sdesc = "поцеловать"
    doAction = 'Chmok'
;

replace talkVerb: deepverb
	verb = 'поговорить' 'поговори' 'поболтать' 'поболтай' 'говорить' 'говори' 'разговаривать' 
	'беседовать' 'беседуй' 'побеседовать' 'побеседуй' 'поговорить с' 'поговори с' 'поболтать с' 
	'поболтай с' 'говорить с' 'поговорить со' 'поговори со' 'поболтать со' 'поболтай со' 'говорить со'
	'говори с' 'разговаривать с' 'беседовать с' 'беседуй с' 'побеседовать с' 'побеседуй с'
	'говори со' 'разговаривать со' 'беседовать со' 'беседуй со' 'побеседовать со' 'побеседуй со' 'пообщаться с' 'пообщаться со' 'поиграть с' 'поиграть со' 'играть с' 'играть со' 
	vopr="С кем "
	sdesc = "поговорить"
	doAction = 'Talk'
;

superKillVerb: deepverb
    no_mon_turn = true
	verb = 'суперудар'
	sdesc = "суперудар"
    action(actor) =
	{
       if (HaveMonsters(actor.location))
       {
          local mon_list = GetMonsterList(actor.location);
          local i;
          for (i=1;i<=length(mon_list);i++)
          {
             mon_list[i].moveInto(nil);
          }
          "Чит выполнен.";
       }
       else
       {
          "Нет монстров.";
       }
    }
;

cheatTeleportLvl1: deepverb
	verb = 'читбыстрона1'
	sdesc = "читбыстрона1"
    action(actor) =
	{
       prepareLevel1();
    }
;

cheatTeleportLvl2: deepverb
	verb = 'читбыстрона2'
	sdesc = "читбыстрона2"
    action(actor) =
	{
       prepareLevel2();
    }
;

cheatTeleportLvl3: deepverb
	verb = 'читбыстрона3'
	sdesc = "читбыстрона3"
    action(actor) =
	{
       prepareLevel3();
    }
;

cheatTeleportLvl4: deepverb
	verb = 'читбыстрона4'
	sdesc = "читбыстрона4"
    action(actor) =
	{
       prepareLevel4();
    }
;

cheatTeleportBoard: deepverb
	verb = 'читборд'
	sdesc = "читборд"
    action(actor) =
	{
       "Чит выполнен!";
       shnekoMachine.unregister;
       aquaMachine.register;
       Knife.moveInto(Me);
       NoneWeapon.moveInto(nil);
       Pistol.moveInto(Me);
       Drobovik.moveInto(Me);
       CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
       CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
       CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
       CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
       CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
       CraftSystem.enableCraft(CRAFT_TYPE_KRIO_WALL);
       CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
       ResourceSystem._alum = 13;
       ResourceSystem._crystal = 100;
       ResourceSystem._selicon = 7;
       Me.travelTo(beach_pirs_room2);
    }
;


createRestartParam : function
{
   global.restartParam = [global.score 
   global.curr_level
   global._temp_alum
   global._temp_crystal
   global._temp_selicon
   global.turnsofar
   global.is_easy];
}

ejectRestartParam : function(restartParam)
{
   global.score=restartParam[1];
   global.curr_level=restartParam[2];
   global._temp_alum=restartParam[3];
   global._temp_crystal=restartParam[4];
   global._temp_selicon=restartParam[5];
   global.turnsofar = restartParam[6];
   global.is_easy  = restartParam[7];
}

initRestartStartLevel: function(restartParam)
{
    ejectRestartParam(restartParam);
    resourceLoadFromGlobal(global);
}

replace restartVerb: sysverb
	verb = 'restart' 'заново'
	sdesc = "restart"
	restartGame(actor) =
	{
		local yesno;
		while (true)
		{
			"Точно хотите начать уровень сначала? (YES/NO или ДА/НЕТ) > ";
		yesno = input();
		yesno = loweru(yesno);
		"\b";
		if ((yesno == 'д') || (yesno == 'yes') || (yesno == 'y') || (yesno == 'да'))

			{
				"\n";
			    createRestartParam();
				scoreStatus(0, 0);
				restart(initRestartStartLevel,global.restartParam);
				break;
			}
			else
			{
				"\nКак угодно.\n";
				break;
			}
		}
	}
	action(actor) =
	{
		self.restartGame(actor);
		abort;
	}
;

complexVerb: deepverb
	verb = 'сложность'
	sdesc = "сложность"
    action(actor) =
	{
       "Ваш уровень сложности: <<global.is_easy == true ? 'лёгкий' : 'нормальный'>>";
    }
;

replace HelpVerb: sysverb
	verb = 'help' 'помощь'
	sdesc = "помощь"
	action(actor) = {
		"\t\b<b>Как в это играть?</b>\b  
            \tПопробуйте представить себя на месте главного героя и пишите те
			команды, которые он должен выполнить.\b
 
			\tКоманды нужно указывать глаголом неопределенной формы или
			повелительного наклонения, к которому можно добавить основной и
			вспомогательный объект. Не бойтесь, игра уточнит, если
			понадобится. Рекомендую выражаться кратко.\b\b
 
			Например:\b
 
			\t\"<i>осмотреться</i>\" (или просто \"<i>о</i>\")\n
			\t\"<i>осмотреть серый валун</i>\" (или \"<i>о серый
			валун</i>\")\n
			\t\"<i>идти на юг</i>\" (или \"<i>ю</i>\")\n
			\t\"<i>взять ключ</i>\"\n
			\t\"<i>инвентарь</i>\" (или просто \"<i>и</i>\")\n
			\t\"<i>открыть дверь ключом</i>\"\n
			\t\"<i>бросить палку</i>\"\n
			\t\"<i>Шарик, возьми палку</i>\"\n
			\t\"<i>напечатать \"привет\" на клавиатуре</i>\"\n
			\tи т.д.\b  
            В этой игре используется режим битвы. Он включается автоматически, когда в локации находиться хотя бы один противник. На локацию проецируется одномерная карта, фиксированного размера. Движение ближе (назад), означает перемещение к меньшему номеру позиции, движение дальше(вперёд) уводит вас к большему номеру позиции. Оружие имеет свой разброс в зависимости от дальности до цели. Оружие ближнего боя может атаковать цель только на одной клетке вместе с вами. Ваши возможности в битве: \n
            - Атаковать монстра \n
            - Перемещаться ближе/дальше по карте \n
            - Ждать \n
            - Использовать предметы, полученные путём синтеза \n
            - Решение головоломок (когда ситуация это подразумевает) \n
            Если в битве вы пользуетесь другими командами (кроме системных и осмотра), монстры выполняют следующий ход. Список команд для боя: \n
            \t\"<i>выбрать оружие</i>\",\n
            \t\"<i>стрелять в монстра</i>\",\n
            \t\"<i>стрелять/ударить</i>\", атаковать ближайшего к вам монстра\n
            \t\"<i>ждать</i>\", ожидание во время битвы\n
            \t\"<i>вперёд/назад</i>\" (или просто \"<i>вп</i>\" или \"<i>нз</i>\"), перемещение по карте.\n
            \t\"<i>эффекты</i>\", вывод списка текущих эффектов.\n
			\b<b>Важные системные команды:</b>\b
            \t\"<i>приглашение</i>\", изменить формат приглашения.\n
            \t\"<i>опвраги</i>\", убрать или добавить подробную информацию о врагах в бою.\n
			\t\"<i>сохранить\"</i>, \"<i>восстановить</i>\" - загрузить ранее
			сохраненную игру\n
			\t\"<i>выход</i>\" - чтобы выйти из игры\n
			\t\"<i>помощь</i>\" - справка\n
			\t\"<i>отчет</i>\" - запись хода игры (лога) в файл\n
			\t\"<i>остотчет</i>\" - остановить ведение лога\n
			\t\"<i>версия</i>\" - сообщает версию игры\n
			\t\"<i>заново</i>\" - начать игру заново\n
			\t\"<i>коротко</i>\" (\"<i>длинно</i>\") - режимы отображения 
			текста описания локаций. В \"длинном\" режиме при каждом входе 
			в комнату будет выполняться ее осмотр.\n
			\t\"<i>ссылки</i>\" - отключает или включает ссылки (если кому-то
			они не нравятся)\n";
		
		if (systemInfo(__SYSINFO_SYSINFO) != true
				|| systemInfo(__SYSINFO_VERSION) > '2.5.7')
			"\t\"<i>ой</i>\" - позволяет исправить неправильно набранное и
			непонятое системой слово при предыдущем вводе\n";
			
		"\t\"<i>повтор</i>\" (или просто \"<i>п</i>\") - повторяет последнюю
			команду\n\b
 
			\tДополнительные инструкции можно найти на сайте
			<<displayLink( 'http://rtads.org',
			'http://rtads.org' )>>.\n\b
			 
			\tОб обнаруженных ошибках сообщайте автору игры на почту Anton_Lastochkin@mail.ru\b
 
			\tЖелаем Вам приятной игры!\n\b";
			abort;
	}
;

#pragma C-