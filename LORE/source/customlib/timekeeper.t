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

// ���������� ��� �������� ������������ ������� ������
// ������ 0.7-fix
// ���������� ���������� ���������� ����� ����� advr.t � stdr.t
// ���� init() � mainRestore() ����� � ������� ���������� ���������� replace, �� � ��� ���� ������������ ������ timekeeper

// ��������� � ����� ����� � ���������� � �������
modify scoreVerb
	showScore(actor) =
	{
		scoreRank();
		timeRank();
	}
;

// �������, ������������ ������������ ������� ������
timeRank: function()
{
	local time := timekeeper.finalTime(gettime()[9]), hours, minutes, seconds;
	hours := time/3600;
	minutes := (time - hours*3600)/60;
	seconds := time - hours*3600 - minutes*60;
	"������������ ������� ������ ��������� ";
	if(hours != 0)
		"<<hours>> ���<<numok(hours, '', '�', '��')>>, ";
	if(minutes != 0)
		"<<minutes>> �����<<numok(minutes, '�', '�', '')>>, ";
	"<<seconds>> ������<<numok(seconds, '�', '�', '')>>.\n";
}

// ������-��������� � ������� � ������� ������� ������
timekeeper: object
	startTime = 0 // ����� ������ ����
	saveTime = 0 // ����� ���������� ���������� ����
	intervals = [] // ������ ���������� ������� ������
	// ����� ��� ��������� �������� �������� ���� �� ��������������
	restoreTime(time) =
	{
		// ��� ��������������, ��������� �������� �� ������� ������ �� ������� ���������� � ������������� ������
		intervals := intervals + (self.saveTime - self.startTime);
		self.startTime := time;
	}
	// ����� ��� �������� ��������� ������� ������� ������
	finalTime(time) =
	{
		local fullTime, i, len = length(intervals);
		// �������� ����������� ���������� �������� ���������
		fullTime := time - self.startTime;
		// ���� ���� ������� ��������� �� ����������, �� ���������� �� � ������� �������
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

// �������� ������� init() � mainRestore(), ������� � ��� �������� �������

replace init: function
{
#ifdef USE_HTML_STATUS
    /* 
     *   �� ���������� HTML-����� ��������� ������ -- ����� �������,
     *   ��� ������������ ������������� ���������� ����� ������, �����
     *   ������������ ���� ���. (��� ��������� ������ ����������
     *   systemInfo, ����� ����������, ������������ �� �������������
     *   HTML ��� ��� -- HTML �� �������� ��������� �� �������
     *   �������������� 2.2.4.)
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
        "\b\b\(��������! ��� ���� ������� ������������� TADS ������
        2.2.4 ��� ����. ������, ��� �� ����������� ����� ������ ������
        ��������������. �� ������ ����������� ��������� ��� ����, ������,
        ����������� �������� ������ ����� �� �������� ���������. ����
        �� ����������� ����� ���� ���������, �� ������ �����������
        ������� �� ����� ����� ������ �������������� TADS.\)\b\b";
    }
#endif

    /* ���������� ����� ������������� */
    /* perform common initializations */
    commonInit();
    
    introduction();

    version.sdesc;                // ����� �������� � ������ ����

    setdaemon(turncount, nil);         // ������ ������ (deamon) �������� �����
                                       //         start the turn counter daemon
    setdaemon(sleepDaemon, nil);                  // ������ ������ (deamon) ���
                                                  //     start the sleep daemon
    setdaemon(eatDaemon, nil);                 // ������ ������ (deamon) ������
                                               //       start the hunger daemon
   //switchPlayer(newPlayer);			// ������ ������������ ������ �� ������
    parserGetMe().location := startroom;     //  ����������� ������ � ���������
                                             //                         �������
                                             // move player to initial location
    startroom.lookAround(true);            // �������� ������, ��� �� ���������
                                           //           show player where he is
    startroom.isseen := true;             // ��������, ��� ������� ���� �������
                                          //      note that we've seen the room
    scoreStatus(0, 0);                    // ���������������� ����������� �����
                                          //       initialize the score display
    randomize();			  // ���, ���� ����� ����������� � ����

	// ���������� ����� ������ ����
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

		// ���������� ����� �������������� ����
		timekeeper.restoreTime(gettime()[9]);

		/* tell the user we succeeded, and show the location */
		"�������������.\b";
		parserGetMe().location.lookAround(true);
		
		/* success */
		return true;

	case RESTORE_FILE_NOT_FOUND:
		"���� ���������� ���� �� ����� ���� ������. ";
		return nil;

	case RESTORE_NOT_SAVE_FILE:
		"� ���� ����� ��� ������ � ����������� ����. ";
		return nil;

	case RESTORE_BAD_FMT_VSN:
		"���� ���� ������ ������ ����� ��� �������, �� ����������� � ������. ";
		return nil;

	case RESTORE_BAD_GAME_VSN:
		"���� ���� ������ ������ ����� ��� �������, �� ����������� � ������. ";
		return nil;

	case RESTORE_READ_ERROR:
		"�� ����� ������ ����� ����������� ���� �������� ������; ��������,
		 ���� ��� ��������.  ���� ����� ���� �������� �������������,
		 ��� ���� ����������� ���������� ����; ���� ���� ��������� �� ��������,
		 ��� ������� ������ � ������. ";
		return nil;

	case RESTORE_NO_PARAM_FILE:
		/* 
		 *   ignore the error, since the caller was only asking, and
		 *   return nil 
		 */
		return nil;

	default:
		"�������������� �� �������. ";
		return nil;
	}
}

// ������������ ������� basicStrObj � saveVerb ��� ��������� � ������ ���������� �������� �������

modify basicStrObj
	saveGame(actor) =
	{
		// ���������� ����� ���������� ����
		timekeeper.saveTime := gettime()[9];

		if (save(self.value))
		{
			"���������� �� �������. ";
			return nil;
		}
		else
		{
			"���������. ";
			return true;
		}
	}
;

modify saveVerb
	saveGame(actor) =
	{
		local savefile;
		
		// ���������� ����� ���������� ����
		timekeeper.saveTime := gettime()[9];

		savefile := askfile('���� ��� ����������:',
							ASKFILE_PROMPT_SAVE, FILE_TYPE_SAVE,
							ASKFILE_EXT_RESULT);
		switch(savefile[1])
		{
		case ASKFILE_SUCCESS:
			if (save(savefile[2]))
			{
				" �� ����� ���������� ��������� ������. ";
				return nil;
			}
			else
			{
				"���������. ";
				return true;
			}

		case ASKFILE_CANCEL:
			"��������. ";
			return nil;
			
		case ASKFILE_FAILURE:
		default:
			"�������. ";
			return nil;
		}
	}
;