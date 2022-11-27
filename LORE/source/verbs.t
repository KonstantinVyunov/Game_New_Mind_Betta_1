// VERBS.T
// ���������� ��������� �������� ����
#pragma C++

changeInputModeVerb: sysverb
 verb = '�����������' 
 sdesc = "�����������"
 action(actor) = {
    if (global.input_mode==INPUT_MODE_LITE) {
	   global.input_mode = INPUT_MODE_FULL;
	   "������ ����������� ��������.<br>";
	}
	else if (global.input_mode==INPUT_MODE_FULL) {
	   global.input_mode = INPUT_MODE_LITE;
	   "������� ����������� ��������.<br>";
	}
 }
;

replace jumpVerb: deepverb
	verb =	'��������' '������������' '����������' '���������' '�������' '�������' 
			'�����������' '���������' '������' '������'
	sdesc = "��������"
	doAction = 'Jump'
	action(actor) = { 
        if ( (parserGetMe().location!=nil) && (parserGetMe().location.mayJumpOut == true) ) {
          "�� ����� ����������. <br>";
          Me.travelTo(parserGetMe().location.out);
        } else {
          "�� ������������� � ������, �� � ��������� ������ ����������. <br>";
        }        
    }
;

replace yellVerb: deepverb
	verb = '�����' '�������' '�������' '�������' '������' '�������'
'���' '�����' '�����' '�����' '����' '�����' '��������' '������'
	sdesc = "�����"
	action(actor) =
	{
		"�� ������ ��������� ������� ����, ��� ���� �� ������� ����������. ";
	}
;

changeEnemyModeVerb: sysverb
 verb = '�������' 
 sdesc = "�������"
 action(actor) = {
    if (global.enemy_mode==ENEMY_MODE_FULL) {
	   global.enemy_mode = ENEMY_MODE_SHORT;
	   "������� ���������� � ������ �� ����� ��� ��������.<br>";
	}
    else if (global.enemy_mode==ENEMY_MODE_SHORT) {
	   global.enemy_mode = ENEMY_MODE_FULL;
	   "��������� ���������� � ������ �� ����� ��� ��������.<br>";
	}
 }
;

closerVerb: deepverb
verb = '�����'
       '������'
       '��'
       '��'
sdesc = "�����"
action(actor) = {
   if (HaveMonsters(actor.location))
   {
      if (actor.location._pl_pos == 0)
      {
         "����� ��� ������.";
      }
      else
      {
         "�� ������ �����.<br>";
         battleMove(actor,MOVE_DIR_BACKWARD);
      }
   }
   else
   {
      "����������� ���, ����� ������������?";
   }
}
;

fartherVerb: deepverb
verb = '������'
       '�����'
       '��'
       '��'
sdesc = "�����"
action(actor) = {
   if (HaveMonsters(actor.location))
   {
      if (actor.location._pl_pos == actor.location._field_size)
      {
         "����� ��� ������.";
      }
      else
      {
         "�� ������ �����.<br>";
         battleMove(actor,MOVE_DIR_FORWARD);
      }
   }
   else
   {
      "����������� ���, ����� ������������?";
   }
}
;

replace waitVerb: darkVerb
	verb = '�' '�����' '���������' '���' '�������'
	sdesc = "�����"
	action(actor) =
	{
        if (HaveMonsters(actor.location))
        {
           "�� ��������.";
           combo_wait(actor);
        }
        else
        {
		   "������ ��������� �����...\n";
        }
	}
;

selfShootVerb: deepverb
	verb = '������������' '����������'
	sdesc = "������������"
	action(actor) =
	{
        "�� �� ��� �����, ��� ������.\n";
	}
;

//����������� � ��������
shootVerb: deepverb
verb = '��������'
       '�������'
	   '��������'
	   '����������'
	   '�������� �'
       '������� �'
	   '�������� �'
	   '���������� �'
	   '�������� ��'
       '������� ��'
	   '�������� ��'
	   '���������� ��'
       '�������� ��'
       '������� ��'
	   '�������� ��'
	   '���������� ��'
sdesc = "��������"
doAction = 'Shoot'
ioAction(withPrep) = 'ShootWith'
action(actor)={
   local mon = GetCloserMon(actor.location);
   if (mon != nil) 
   {
       if (actor.sel_weapon.isCloseCombat && (actor.location._pl_pos != mon._pos) )
       {
          "� ��� ������ �������� ���, � ���������� ������� �� ����� ���������� �� �������!";
       }
       else
       {
          if (shootMonster(actor,mon)==nil)
          {
             "<br>������������ ��������!<br>";
          }
       }
   }
   else 
   {
      "����� ��� ���������� ������� ��� ��������!";
   }
}
;

replace breakVerb: deepverb
;

replace attackVerb: deepverb
	verb = '�����' '����' '�������' '�����' '�������' '�����' '����' '���' '���������' '������'
	'������� ��' '������ ��' '����������� ��' '��������� ��' '������� ��' '����� ��' '������� �' '����� �'
	'������� �' '����� �' '������� ��' '����� ��' '���� ��' '��� ��' '���� �' '��� �' '���� ��' '��� ��'
	'���� �' '��� �' '�������' '�������' '����������' '�������' '������' '������' '������' '��������' '�����' 
    '���������' '�������' '�����' '���������' '�������' '������' '����' '������' '��������'
    doAction = 'Shoot'
    ioAction(withPrep) = 'ShootWith'
    sdesc = "�������"
    action(actor)={
        local mon = GetCloserMon(actor.location);
        if (mon != nil) 
        {
            if (actor.sel_weapon.isCloseCombat && (actor.location._pl_pos != mon._pos) )
            {
               "� ��� ������ �������� ���, � ���������� ������� �� ����� ���������� �� �������!";
            }
            else if (!actor.sel_weapon.isCloseCombat)
            {
               "� ��� ������ �������� ���! ����������� ��������.";
            }
            else
            {
               shootMonster(actor,mon);
            }
        }
        else 
        {
           "����� ��� ���������� ������� ��� �����!";
        }
    }
;

replace getOutVerb: deepverb
	verb = '�����' '�����' '������' '�����' '�������' '������' '�������' 
		   '����� �' '����� ��' '����� �' '����� ��' '������ �' '������ ��' '����� �' '����� ��' '����� ��'
		   '����� ��' '������� ��' '������ ��' '��������� �' '��������� ��' '��������� �' '��������� ��'
		   '������ �'  '������ ��' '������ �' '������ ��'
	vopr = "������ "
	sdesc = "�����"
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
verb = '�������'
	   '������'
sdesc = "�������"
doAction = 'Select'
no_mon_turn = true
action(actor) = {
  "������� ������: <<actor.sel_weapon.sdesc>>";
}
;

syntesisVerb: deepverb
verb = '������' '�������������' '����������'
sdesc = "������"
no_mon_turn = true
action(actor) = {
  CraftSystem.startCraft;
}
;

replace undoVerb: sysverb
	verb = 'undo' '������' '����' '�����'
	sdesc = "������"
	action(actor) =
	{
		"� ���� ���� ������ ���� ���������! ����������� ������������. ";
		abort;
	}
;


useVerb: deepverb
	verb = '������������' '���' '���������' '���������' '�������'
    doAction = 'Use'
    sdesc = "������������"
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
               //��������� ������ ���� ��� ���
               if (find(act_synt_id,synt_item.craft_id)==nil) {
                  act_synt_list += [synt_item];
                  act_synt_id += [synt_item.craft_id];
               }
           }
       }
       if (!find_using) "��� ��������� ��� �������������.";
       else{
          local resp;
          local resp_str;
          "<b>�������� ������� ��� ���������� (������ ������ ��� ������):</b><br>";
          for (i=1;i<=length(act_synt_list);i++) 
          {
             local synt_item = act_synt_list[i];
             say(synt_item.craft_id); " : "; synt_item.sdesc; "<br>";
          }
          "<br>>";
          resp_str = input();
          if (resp_str=='') {
             "������ �������������.<br>";
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
          "��� ������ ������ ��������.";
       }
    }
;

//��������� ��������� ��������� ��� ����������� ��������
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
	verb = '��' '���' '���������'
	sdesc = "���������"
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
                "�������: ��������� �������-<<ResourceSystem.crystals>>, ��������-<<ResourceSystem.aluminium>>, �������-<<ResourceSystem.selicon>><br>";
				"� <<actor.fmtYouve>> �������:\n";
				global.vinpadcont=0;
				nestlistcont(actor, 1);
			    global.vinpadcont=1;
                "\n�������� �������(��������� ���������� �� ������� \"�������\"):\n";
                have_effects = nil;
                for (i=1;i<=length(actor.contents);i++) 
                   if (isclass(actor.contents[i],Combo) && (actor.contents[i].showInList == true))
                   {
                       local comb = actor.contents[i];
                       "\t<<comb.sdesc>>\n";
                       have_effects = true;
                   }
                   
                if (have_effects==nil) "\t��� �������� ��������.\n";
			}
			else
			{
				/* use wide mode */
				"� <<actor.fmtYouve>> ���� "; global.vinpadcont=0; listcont(actor);". ";
				listcontcont(actor); global.vinpadcont=1;
			}
		}
		else
			"� <<actor.fmtYouve>> ������ ���.\n";
	}
;

comboVerb: deepverb
    no_mon_turn = true
	verb = '�������' '������' '���'
	sdesc = "�������"
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
           
       if (have_effects==nil) "\t��� �������� ��������.\n";
    }
;

superLifeVerb: deepverb
    no_mon_turn = true
	verb = '����������'
	sdesc = "����������"
    action(actor) =
	{
       actor._hp += 1000;
       "��� ��������.";
    }
;


superResAdd: deepverb
    no_mon_turn = true
	verb = '����������'
	sdesc = "����������"
    action(actor) =
	{
       ResourceSystem._alum = 1000;
       ResourceSystem._crystal = 1000;
       ResourceSystem._selicon = 1000;
       "��� ��������.";
    }
;

autoTestVerb: deepverb
    no_mon_turn = true
	verb = '����������'
	sdesc = "����������"
    action(actor) =
	{
       "<br>��������� ��������� ����� ����������. ������� ������ ������� ��������.<br>";
       global.isFixedRndRangeMid = true;
    }
;

putDownVerb: deepverb
	verb = '��������' '������'
	sdesc = "��������"
    doAction = 'Putdown'
;

chmokVerb: deepverb
	verb = '����������' '��������' '�����' '�������'
	sdesc = "����������"
    doAction = 'Chmok'
;

replace talkVerb: deepverb
	verb = '����������' '��������' '���������' '��������' '��������' '������' '�������������' 
	'����������' '�������' '������������' '���������' '���������� �' '�������� �' '��������� �' 
	'�������� �' '�������� �' '���������� ��' '�������� ��' '��������� ��' '�������� ��' '�������� ��'
	'������ �' '������������� �' '���������� �' '������� �' '������������ �' '��������� �'
	'������ ��' '������������� ��' '���������� ��' '������� ��' '������������ ��' '��������� ��' '���������� �' '���������� ��' '�������� �' '�������� ��' '������ �' '������ ��' 
	vopr="� ��� "
	sdesc = "����������"
	doAction = 'Talk'
;

superKillVerb: deepverb
    no_mon_turn = true
	verb = '���������'
	sdesc = "���������"
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
          "��� ��������.";
       }
       else
       {
          "��� ��������.";
       }
    }
;

cheatTeleportLvl1: deepverb
	verb = '�����������1'
	sdesc = "�����������1"
    action(actor) =
	{
       prepareLevel1();
    }
;

cheatTeleportLvl2: deepverb
	verb = '�����������2'
	sdesc = "�����������2"
    action(actor) =
	{
       prepareLevel2();
    }
;

cheatTeleportLvl3: deepverb
	verb = '�����������3'
	sdesc = "�����������3"
    action(actor) =
	{
       prepareLevel3();
    }
;

cheatTeleportLvl4: deepverb
	verb = '�����������4'
	sdesc = "�����������4"
    action(actor) =
	{
       prepareLevel4();
    }
;

cheatTeleportBoard: deepverb
	verb = '�������'
	sdesc = "�������"
    action(actor) =
	{
       "��� ��������!";
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
	verb = 'restart' '������'
	sdesc = "restart"
	restartGame(actor) =
	{
		local yesno;
		while (true)
		{
			"����� ������ ������ ������� �������? (YES/NO ��� ��/���) > ";
		yesno = input();
		yesno = loweru(yesno);
		"\b";
		if ((yesno == '�') || (yesno == 'yes') || (yesno == 'y') || (yesno == '��'))

			{
				"\n";
			    createRestartParam();
				scoreStatus(0, 0);
				restart(initRestartStartLevel,global.restartParam);
				break;
			}
			else
			{
				"\n��� ������.\n";
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
	verb = '���������'
	sdesc = "���������"
    action(actor) =
	{
       "��� ������� ���������: <<global.is_easy == true ? '�����' : '����������'>>";
    }
;

replace HelpVerb: sysverb
	verb = 'help' '������'
	sdesc = "������"
	action(actor) = {
		"\t\b<b>��� � ��� ������?</b>\b  
            \t���������� ����������� ���� �� ����� �������� ����� � ������ ��
			�������, ������� �� ������ ���������.\b
 
			\t������� ����� ��������� �������� �������������� ����� ���
			�������������� ����������, � �������� ����� �������� �������� �
			��������������� ������. �� �������, ���� �������, ����
			�����������. ���������� ���������� ������.\b\b
 
			��������:\b
 
			\t\"<i>�����������</i>\" (��� ������ \"<i>�</i>\")\n
			\t\"<i>��������� ����� �����</i>\" (��� \"<i>� �����
			�����</i>\")\n
			\t\"<i>���� �� ��</i>\" (��� \"<i>�</i>\")\n
			\t\"<i>����� ����</i>\"\n
			\t\"<i>���������</i>\" (��� ������ \"<i>�</i>\")\n
			\t\"<i>������� ����� ������</i>\"\n
			\t\"<i>������� �����</i>\"\n
			\t\"<i>�����, ������ �����</i>\"\n
			\t\"<i>���������� \"������\" �� ����������</i>\"\n
			\t� �.�.\b  
            � ���� ���� ������������ ����� �����. �� ���������� �������������, ����� � ������� ���������� ���� �� ���� ���������. �� ������� ������������ ���������� �����, �������������� �������. �������� ����� (�����), �������� ����������� � �������� ������ �������, �������� ������(�����) ������ ��� � �������� ������ �������. ������ ����� ���� ������� � ����������� �� ��������� �� ����. ������ �������� ��� ����� ��������� ���� ������ �� ����� ������ ������ � ����. ���� ����������� � �����: \n
            - ��������� ������� \n
            - ������������ �����/������ �� ����� \n
            - ����� \n
            - ������������ ��������, ���������� ���� ������� \n
            - ������� ����������� (����� �������� ��� �������������) \n
            ���� � ����� �� ����������� ������� ��������� (����� ��������� � �������), ������� ��������� ��������� ���. ������ ������ ��� ���: \n
            \t\"<i>������� ������</i>\",\n
            \t\"<i>�������� � �������</i>\",\n
            \t\"<i>��������/�������</i>\", ��������� ���������� � ��� �������\n
            \t\"<i>�����</i>\", �������� �� ����� �����\n
            \t\"<i>�����/�����</i>\" (��� ������ \"<i>��</i>\" ��� \"<i>��</i>\"), ����������� �� �����.\n
            \t\"<i>�������</i>\", ����� ������ ������� ��������.\n
			\b<b>������ ��������� �������:</b>\b
            \t\"<i>�����������</i>\", �������� ������ �����������.\n
            \t\"<i>�������</i>\", ������ ��� �������� ��������� ���������� � ������ � ���.\n
			\t\"<i>���������\"</i>, \"<i>������������</i>\" - ��������� �����
			����������� ����\n
			\t\"<i>�����</i>\" - ����� ����� �� ����\n
			\t\"<i>������</i>\" - �������\n
			\t\"<i>�����</i>\" - ������ ���� ���� (����) � ����\n
			\t\"<i>��������</i>\" - ���������� ������� ����\n
			\t\"<i>������</i>\" - �������� ������ ����\n
			\t\"<i>������</i>\" - ������ ���� ������\n
			\t\"<i>�������</i>\" (\"<i>������</i>\") - ������ ����������� 
			������ �������� �������. � \"�������\" ������ ��� ������ ����� 
			� ������� ����� ����������� �� ������.\n
			\t\"<i>������</i>\" - ��������� ��� �������� ������ (���� ����-��
			��� �� ��������)\n";
		
		if (systemInfo(__SYSINFO_SYSINFO) != true
				|| systemInfo(__SYSINFO_VERSION) > '2.5.7')
			"\t\"<i>��</i>\" - ��������� ��������� ����������� ��������� �
			��������� �������� ����� ��� ���������� �����\n";
			
		"\t\"<i>������</i>\" (��� ������ \"<i>�</i>\") - ��������� ���������
			�������\n\b
 
			\t�������������� ���������� ����� ����� �� �����
			<<displayLink( 'http://rtads.org',
			'http://rtads.org' )>>.\n\b
			 
			\t�� ������������ ������� ��������� ������ ���� �� ����� Anton_Lastochkin@mail.ru\b
 
			\t������ ��� �������� ����!\n\b";
			abort;
	}
;

#pragma C-