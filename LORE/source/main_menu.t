//������� ����
#pragma C++

show_main_menu : function
{
    //play_music_loop('Miami_Sheriff_-_The_Neon_Night.ogg');
	"<br><b>������� ����</b><br><br>";
	"1. ����������<br>";
	"2. ����� ���� �� ���������� ������ ���������<br>";
    "3. ����� ���� �� ����� ������ ���������<br>";
	"4. ������� ���������� ����<br>";
	"5. ������<br>";
	"6. �� ���� � �������<br>";
	"7. �����<br>";
	">";
}

//����������


//����� ������


//����� �� �������


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
		  "������� ���������� �������.<br>";
		}
		else {
		   switch(resp)
		   {
		      case 1: {
			     scen_cover();
				 "<i>(��� �������� � ������� ���� ������� ����</i>)<br>";
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
			        "��������. ";
			        break;
		         case ASKFILE_FAILURE:
		         default:
			        "�������. ";
			         break;
		         }
                 break;
			  }
			  case 5: {
                 execCommand(Me, HelpVerb, nil, nil, nil, 0);
			     //HelpVerb.action(Me);
			     "<i>(��� �������� � ������� ���� ������� ����</i>)<br>";
				 input();
				 //clearscreen();
				 show_main_menu();
				 break;
			  }
			  case 6: {
                 show_image('enemy.jpg');
			     scen_about_autors();
			     "<i>(��� �������� � ������� ���� ������� ����</i>)<br>";
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