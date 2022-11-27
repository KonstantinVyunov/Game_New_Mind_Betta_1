//Главное меню
#pragma C++

show_main_menu : function
{
    //play_music_loop('Miami_Sheriff_-_The_Neon_Night.ogg');
	"<br><b>Главное меню</b><br><br>";
	"1. Вступление<br>";
	"2. Новая игра на нормальном уровне сложности<br>";
    "3. Новая игра на лёгком уровне сложности<br>";
	"4. Открыть сохранённую игру<br>";
	"5. Помощь<br>";
	"6. Об игре и авторах<br>";
	"7. Выход<br>";
	">";
}

//Вступление


//Текст помощи


//Текст об авторах


startroom : room
  sdesc = ""
  ldesc = {
    local next_loop = true;
    play_music_loop('Miami_Sheriff_-_The_Neon_Night.ogg');
	show_main_menu();
    self.isseen = nil;
    while (next_loop)
    {
        local resp = cvtnum(input());
		//">";
		if (resp < 1 || resp > 6) {
		  "Введите правильную команду.<br>";
		}
		else {
		   switch(resp)
		   {
		      case 1: {
			     scen_cover();
				 "<i>(Для возврата в главное меню нажмите ВВОД</i>)<br>";
				 input();
				 //clearscreen();
				 show_main_menu();
				 break;
			  }
			  case 2: {
			     next_loop = nil;
			     //clearscreen();
                 global.is_easy = nil;
                 prepareLevel1_Full();
			     break;
			  }
              case 3: {
			     next_loop = nil;
			     //clearscreen();
                 global.is_easy = true;
                 prepareLevel1_Full();
			     break;
			  }
			  case 4: {
			     local savefile;
		         savefile = askfile('File to restore game from',
							ASKFILE_PROMPT_OPEN, FILE_TYPE_SAVE,
							ASKFILE_EXT_RESULT);
		         switch(savefile[1])
		         {
		         case ASKFILE_SUCCESS:
			       if (mainRestore(savefile[2]) == true)
                   {
                      next_loop = nil;
                      return;
                   }
                   break;
		         case ASKFILE_CANCEL:
			        "Отменено. ";
			        break;
		         case ASKFILE_FAILURE:
		         default:
			        "Неудача. ";
			         break;
		         }
                 break;
			  }
			  case 5: {
                 execCommand(Me, HelpVerb, nil, nil, nil, 0);
			     //HelpVerb.action(Me);
			     "<i>(Для возврата в главное меню нажмите ВВОД</i>)<br>";
				 input();
				 //clearscreen();
				 show_main_menu();
				 break;
			  }
			  case 6: {
                 show_image('enemy.jpg');
			     scen_about_autors();
			     "<i>(Для возврата в главное меню нажмите ВВОД</i>)<br>";
				 input();
				 //clearscreen();
				 show_main_menu();
				 break;
			  }
			  case 7: {
			     terminate();
				 quit();
				 break;
			  }
		   }
		}
	}
  }
;


replace commonInit: function
{
	"\H+"; 
	//debugTrace(1,true);
}