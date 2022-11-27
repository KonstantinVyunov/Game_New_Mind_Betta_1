////////////////////////////////

#include <ochkoGame.t>

/////////
prepareLevel4 : function {
   show_image('beach.jpg');
   hotelMachine.unregister;
   aquaMachine.register;
   if (global.is_easy==nil) {
       //"<b>* �������� ������ - ���������</b><br>";
       "<b>* �������� ������ - ����������</b><br>";
       "<b>* �������� ������ - �����</b><br>";
       //CraftSystem.enableCraft(CRAFT_TYPE_KRIO_WALL);
       CraftSystem.enableCraft(CRAFT_TYPE_MIND);
       CraftSystem.enableCraft(CRAFT_TYPE_DUP);
   }
   global.level_play_music = 'David_Szesztay_-_Beach_Party.ogg';
   stop_music_back();
   play_music_loop('David_Szesztay_-_Beach_Party.ogg');
   Me.travelTo(beach_start_room);
   Knife.moveInto(Me);
   Me.sel_weapon=Knife;
   NoneWeapon.moveInto(nil);
   Me.Heal;
   
   global.curr_level = 4;
   
   Statist.Prepare([flyboard gamedeck way_aerogel chairs_bus_room massage kust_at_rock]);
   
   //��������� � ���������� �������
   CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
   Pistol.moveInto(Me);
   Drobovik.moveInto(Me);
   CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
   CraftSystem.enableCraft(CRAFT_TYPE_SHOTGUN);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
   CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
   CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
   CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
   TorsionGenerator.moveInto(Me);
}

beach_start_room : room
  sdesc="����� � �����"
  lit_desc = '������� �������, �������������� �� �����, ��������� ���������� ���������. ������ ������� ���� ����������� ����� �� ������� ����������. ���� � �������� ������� ����� � ������ ���� ����� �����������.'
  north = beach_rock_room
  west = beach_game_room
  listendesc = "������ ��� ���� � ����� ����, ��� � �������������� ��������."
;

beachStartDecoration : decoration
  location = beach_start_room
  isHim = true
  desc = '���� ������/1�'
  noun = '�����/1�' '�����/1�' '�������/1�'
         '�����/2'  '�����/2'  '�������/2'
         '����/1�' '����/1�' '�����/1�' '�������/1�' '�����/1�'
  adjective = '�������/1�' '��������/1��'
;


trap : decoration
  location = beach_start_room
  desc = '�������/1�� �������/1�'
  noun = '�������/1�' '������/1�' '������/2' '�������/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "����������� ������ �� ����������� ������. ���������� ����������� ������� � ��������������� ����� ������� ���������� ������� �� ������ ��������. "
;

turists : decoration
  location = beach_start_room
  desc = '���������/2� �������/2'
  noun = '�������/2' '������/1�' '����������/2' '����������/1�' '����/2' '�������/1�'
  adjective = '���������/2�'
  ldesc = "������� ��������� �� �������, ����� �� �����, �, �������, ���������� �� ������������. "
;


flags : decoration
  location = beach_start_room
  desc = '����/1�'
  noun = '����/1�' '��������/1�' '�����/2'
  adjective = '�������/1��'
  isHim = true
  ldesc = "����� ���� ���������� ���� ������� �������������, ����������� ������������� ���������� ������. "
;

st_beach : distantItem
  location = beach_start_room
  desc = '����/1�'
  noun = '����/1�'
  isHim = true
  ldesc = "�������� ����, ���� ������� ��������. ������ �� �������. "
;

kuznec_game : DestructItem
   location = beach_start_room
   desc = '��������/1�'
   noun = '��������/1�' '�������/1�' '�����/1�'
   isHim = true
   ldesc = "��� ����������� ��������, ������� �����-�� ��� ������� ��������, �� ����� ������� ������ � ��������� ��������� ������ ��������. ������� ������������. ���� �� ��������, � ������ ��� ������, �������� �����."
;

zaryadnik : DestructItem
   location = beach_start_room
   desc = '��������/1�'
   noun = '��������/1�' '��������/1' '����������/1'
   adjective = '��������/1��'
   isHim = true
   ldesc = "� ������ ��������� ���������� �������� ���������� ��� ������ ��������, � ��������� ��� ������� ������� � ��������. ������ �������, �� ���������� ��������� ������. ������-���� �� �����. ������, ������� � ������ ���������� ������������� ���������."
;


/////////

beach_game_room : room
  sdesc="������� ����"
  lit_desc = '����� ������������ ������� ������������, ���� ���������� ���� ������� ���� ��� ��������. ������� ������� ��� � ������� �� �����.'
  east = beach_start_room
  west = beach_parking_room
  listendesc = "������ ��� ���� � ����� ����, ��� � �������������� ��������."
;


beachGameDecoration : decoration
  location = beach_game_room
  isHim = true
  desc = '���� ������/1�'
  noun = '�����/1�' '�����/1�' '�������/1�' '������/1�' '������/1�'  '��������/1�' '���������/1�' '�����/1�'
         '�����/2'  '�����/2'  '�������/2'  '�������/2' '�������/1�' '��������/2'  '����������/2' '�����/2'
         '����/1�' '����/1�' '�����/1�' '�������/1�' '�����/1�'
  adjective = '�������/1�' '��������/1��'
;


trap2 : decoration
  location = beach_game_room
  desc = '�������/1�� �������/1�'
  noun = '�������/1�' '������/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "����������� ������ �� ����������� ������. ���������� ����������� ������� � ��������������� ����� ������� ���������� ������� �� ������ ��������. "
;

attractor : decoration
  location = beach_game_room
  desc = '����������/1�'
  noun = '����������/1�' '��������/1�' '����������/1�' '�������/1�' '������/1�' 
         '�����������/2' '��������/2'  '����������/2'  '�������/2'  '������/2'
         '�������/1�' '����/2'
  isHim = true
  ldesc = "��������� ����������, �������, ����������� ��������. "
;

replace customPreCraft : function()
{
   if (gamedeck.giveMoney==true) {
       aresa_say('��� ������! ���� ������� ����, ��� ���������! ���� �� ��������� ��� ������� ���������, �� ������ ��� ���� �������! ���� �� �� ���� ������� ������, �� �������� �� ��� �������!');
       ResourceSystem._alum = 0;
       ResourceSystem._crystal = 0;
       ResourceSystem._selicon = 0;
       gamedeck.giveMoney=nil;
   }
}

gamedeck : Actor
   location = beach_game_room
   desc = '���������/1�� ������/1�'
   noun = '������/1�' '����/1�'
   adjective = '���������/1��'
   isHim = true
   ldesc = "��������� ������ � �������� ���������� �������� �������� ����������. "
   actorDesc = "[|��������� ������ ����� ������ �����./��������� ������ �������������� �� ��������, ���������� �����������./�� ��������� ������� ����� ������ ���� �� ������.]"
   verDoTalk(actor) = { if (self.nTry >= 3) "������ �� �������� �� ��� �������� �������� � ��� ���������� �������."; }
   nTry = 0
   giveMoney = nil
   
   
   doTalk(actor) = {
      local st=0, money, my_num, ai_num;
      "- ����, ��������� ������! ������� � 21 �� ����� ��������? ��� ����� ������. ������� �� ������� ������ ����������������� � ����� �� �������� ����. ���� �� ������ ������ �� ������, ������ �������! ����������? �� �������������, ��� ����� �������� �������� �� ���. <br>";
      if (ResourceSystem.crystals<1) {
        "- ��, � ���������, � ��� ��� ����������! ��������� ��� �� �����������.";
        abort;
      }
      while (true)
      {
        local resp,res_user;
        if (st==0) "(�������� \"�������\", ��� ������ ���������� ��� \"�����\" ��� ������, �� ��������� ��������� ���������� �������)";
        if (st==1) "������� ���� ������ �� 1 �� <<ResourceSystem.crystals>> ����������.";
        if (st==2) "�������� ����� ��� �����������? (\"��������\", \"�������\")";
        "<br>>";
        resp=input();        
        if (st==0)
        {
            if (resp == '�������') {
               "- ������� (������) �������� ������. ��������� ���� � �����: ��� � 11 �����; ������ � 4 ����; ���� � 3 ����; ����� � 2 ����; ��������� ����� �� ������ ��������. ������ ��������� ��������, ����� ����� �������� ��� �����. ������� ���� ���� ��� ����� � ��������� ����� ���������, ��������� ���. ������ ��� ����������� ������ ����� �� �������. ����� �������� ������, �� ������� �� ����� ������� � ������ ����, �� ������� �� ��������� ����� ����������, ������� ��������� � ����. �������� � ��� 10 ����������. ����� �������: ���� �� 5� � ������ ���� ����� � �������. ���� ������ �� ������� �����, ����� ������� 21 ����, �� �� ������ ��� �����. �����, ������� �������� 21 ����, ����� ����������� ����������� � �������� �� ����� ���� �������. ���� ����� ������ ����� 21 ����, �� �� ������ ��������� ���� � ����. �����, ������� �������� ������ ����� �����, ����������. ���� ����� ����� ����������, �� ������, ��������� ��������, ������������ �� �������. �����, ������� ��������, ������ � ���� ���� �������� � ���� ������������. ���������� ����� ����� ������� ������, ������ ����� ������ ������ �������� �����, ����� ���� ���� ����� ����� � ���������� ����.";
            }
            else if (resp == '�����')
            {
              st=1;
              The21Game.nextDeck;
            }
            else
            {
               "- �� ����� ������!";
               abort;
            }
        }
        else if (st==1)
        {
           money = cvtnum(resp);
           if (money > 0 && money <= ResourceSystem.crystals)
           {
              st=2;
              "���� �����:<br>";
              The21Game.showMyDeck;
           }
           else
           {
              "- ������� ���������� ������!";
           }
        }
        else if (st==2)
        {
           local was_end = nil;
           if (resp == '��������')
           {
             The21Game.my_deck += [The21Game.getRandCardFromDeck];
             was_end = true;
           }
           else if (resp == '�������')
           {
             was_end = true;
           }
           else
           {
              "- ���������, ��� �����!";
           }
           
           //��������� ������
           if (was_end)
           {
              self.nTry += 1;
              my_num = The21Game.countMyDeck;
              ai_num = The21Game.countAiDeck;
              if (my_num>21)
              {
                 "- � ��� �������! ������ ��������� �������.";
                 ResourceSystem.Pay(0,money,0);
              }
              else if (ai_num>21)
              {
                 "- � ������� �������! �� ��������� �������.";
                 self.giveMoney = true;
                 ResourceSystem.GenFromEnemy(money);
              }
              else if (my_num==ai_num)
              {
                 "- �����! ��� �������� ��� ����.";
              }
              else if (my_num<ai_num)
              {
                 "- �� ���������! ���� ������ ������ ����! ����� ��������.";
                 ResourceSystem.Pay(0,money,0);
              }
              else if (my_num>ai_num)
              {
                 "- ������� �� ��������! �������� ���������.";
                 self.giveMoney = true;
                 ResourceSystem.GenFromEnemy(money);
              }
              "���� �����:<br>";
              The21Game.showMyDeck;
              "����� �����:<br>";
              The21Game.showAiDeck;
              
              if (self.nTry >= 3) "- ������� ��������! � ������� ����������� �� ������ ��������.";
              
              abort;
           }
        }
     }
   }
;

/////////

beach_parking_room : room
  sdesc="������� �������"
  lit_desc = '����� ������ ����������� ��� ������, ���� ���������� �� �����. ������� ������� � ������-�������� �������� ������� �� ������ � �������� �������� ��������. ������ �� ���������� ����� �� ������.'
  east = beach_game_room
  listendesc = "������ ��� ���� � ����� ����, ��� � �������������� ��������."
;

beachParkingDecoration : decoration
  location = beach_parking_room
  isHim = true
  desc = '���� ������/1�'
  noun = '�����/1�' '�����/1�' '�������/1�' '������/1�' '������/1�'  '��������/1�' '���������/1�' '��������/1�'
         '�����/2'  '�����/2'  '�������/2'  '�������/2' '�������/1�' '��������/2'  '���������/2'  '���������/1�'
         '����/2' '����/1�' '����/1�' '�����/1�' '�������/1�' '�����/1�' '�����/1�' '�����/2' '����/1�'
  adjective = '�������/1�' '��������/1��'
;

stand_flyer : decoration
  location = beach_parking_room
  desc = '�����/1�� ������/1�'
  noun = '������/1�' '�����/1�' '�������/2' '������/2'
  isHim = true
  ldesc = "�������� ������������ �������� �������� ������. ����� �������� ��������� ������������ ����������, ���� �� ��������� ������ ����������, ������������� �� ��� � �������� � ����."
;

autobus : fixeditem
   location = beach_parking_room
   desc = '�������/1�'
   ldesc = "������� �������, ��������� ������ ��������� ����� ��� ���������� �����."
   
   verDoOpen(actor) = {"<<ZAG(self,&sdesc)>> ��� ������.";}
   verDoClose(actor) = {"<<ZAG(self,&sdesc)>> ������ �������.";}
   verDoBoard(actor) = {}
   doBoard(actor) = {
      //�� ��������� � �������, ��� ��� � ��� ������, ��� ����� ���������� ����
      if (shwartz.location == Me.location)
      {
         shwartz.moveInto(nil);
         stallone.moveInto(nil);
         shwartzMonster.travelTo(bus_room);
         stalloneMonster.travelTo(bus_room);
         aquaMachine.st = 5;
         aquaMachine.num_steps_guys = 0;
         aquaMachine.is_lead_guys = nil;
         //���������� ��� �����
         Me.isOnBeach = nil;
         "<br>����� �������� ����������, ����� �� ��������� � ��������.<br>";
      }
      Me.travelTo(bus_room);
   }
   verDoEnter(actor) = { self.verDoBoard(actor); }
   doEnter(actor) = { self.doBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   doEnterOn(actor) = { self.doBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
   doEnterIn(actor) = { self.doBoard(actor); }
;


/////////

bus_room : room
  sdesc="������ ��������"
  lit_desc = '������ ����������� ������ ������ � ��� � ����������� � ��������� ������� ����� ��������� ��������.'
  out = {
     if (HaveMonsters(self)) {
        aresa_say('�� �������� ������? �� �� ���, �������� � �����, ����������.');
        return nil;
     }
     else {
        //���� �������, ����� ����� ��� �� ����� ���-��
        if (shwartz.location != nil) return beach_parking_room;
        if ( (shwartzMonster.location == nil) && (stalloneMonster.location == nil) )
        {
            //�������� ������������� ������ ��������
            aquaMachine.have_protect_boy = true;
            show_image('mother.jpg');
            scen_lvl4_out_bus();
            global.level_play_music = 'The_Pandoras_-_01_-_Haunted_Beach_Party.ogg';
            stop_music_back();
            play_music_loop('The_Pandoras_-_01_-_Haunted_Beach_Party.ogg');
            return beach_parking_room2;
        }
        else return beach_parking_room;
     }
  }
  _field_size = 4
;

beachBusDecoration : decoration
  location = bus_room
  isHim = true
  desc = '���� ������/1�'
  noun = '����������/1�' '�������/1�'
  adjective = '�������������/1�'
;


chairs_bus_room : decoration
  location = bus_room
  desc = '�����������/1� ������/1�'
  noun = '������/1�' '������/2'
  adjective = '������/1��' '������/2�'
  ldesc = "������ ������������ �� ����, ����� ������������� �����������. ��������� ������ ���� ����� ���������."
  verDoSiton(actor)={aresa_say('�� ����� �������������!');}
;


shwartzMonster : HardTrooper
   location = nil
   desc = '������������/1��'
   noun = '������������/1�' '�������/1�' '����/1�' '�����/1�' '�����/1�'
   isHim = true
   _pos = 3
;

stalloneMonster : HardTrooper
   location = nil
   desc = '��������/1��'
   noun = '��������/1�' '���������/1�' '����/1�' '�����/1�'
   isHim = true
   _pos = 3
;

/////////

beach_rock_room : room
  sdesc="����� �� ������"
  lit_desc = '��������� ����� � �������� ����������� ����� ���������� �� ������������ ����. ���� ��������� ����� ������������ �� �����, ��������� � ������� ���������� ����� �� ��.'
  south = beach_start_room
  west = beach_main_room
  listendesc = "������ ��� ���� � ����� ����, ��� � �������������� ��������."
;

beachRockDecoration : decoration
  location = beach_rock_room
  isHim = true
  desc = '���� ������/1�'
  noun = '�����/1�' '�����/1�' '������/1�' '������/1�'  '��������/1�'
         '�����/2'  '�����/2'  '�������/2' '�������/1�' '��������/2' 
         '����/2' '����/1�' '�����/1�' '�������/1�' '����������/1�'
  adjective = '�������/1�' '��������/1��' '���������/1��'
;

kust_at_rock : decoration
  location = beach_rock_room
  desc = '��������/1�� ���������/1�'
  noun = '���������/1�' '����/1�' '����/1�' '�����/1�' '�����/1�' '�����/1�'
  adjective = '��������/1��' '���������/1��'
  isHim = true
  ldesc = "��������� ����, ����� ����� ������� � ����������� ������������ �����. ����� �������� ����������."
  verDoEnter(actor) = { self.verDoBoard(actor); }
  verDoEnterOn(actor) = { self.verDoBoard(actor);}
  verDoEnterIn(actor) = { self.verDoBoard(actor);}
  verDoBoard(actor) = {aresa_say('��������� � ������ - �� ��� �����, �������.');}
;

water_at_rock : decoration
  location = beach_rock_room
  desc = '������������/1�� ����/1�'
  noun = '����/1�' '����/1'
  adjective = '������������/1��'
  isHer = true
  ldesc = "������-������ ����, �� ������� ���������� ����� �������� � ��� �� ��������. �����������, ��� ������ ���� ������� ������������ ����?"
;

sander_at_rock : decoration
  location = beach_rock_room
  desc = '��������/1�� ����/1�'
  noun = '����/1�' '����/1�' '�����/1�'
  adjective = '��������/1��'
  isHim = true
  ldesc = "����������� ������ ����� �����, ��������, � �������."
;


trap_r : decoration
  location = beach_rock_room
  desc = '�������/1�� �������/1�'
  noun = '�������/1�' '������/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "����������� ������ �� ����������� ������. ���������� ����������� ������� � ��������������� ����� ������� ���������� ������� �� ������ ��������. "
;

/////////

beach_main_room : room
  sdesc="�������� ����"
  lit_desc = '�������� ����� �������� �������. ���� ���������� � ����, ������ �������� ��������, �������� ������ ��������� �� ���� ��� � ���� ��� ���������. ��������� ��������� ��� ��������� ��������� �����. �� ������ ������, � ������� ����� �� ���������.'
  east = beach_rock_room
  west = beach_pirs_room
;

beachMainDecoration : decoration
  location = beach_main_room
  isHim = true
  desc = '���� ������/1�'
  noun = '�����/1�' '�����/1�' '������/1�' '������/1�'  '��������/1�' '��������/1�' '������/1�' '����/1�' '�����/1�' '�������/1�' '������/1�'
         '�����/2'  '�����/2'  '�������/2' '�������/1�' '��������/2'  '��������/2'  '�������/2' '����/2'  '�����/2'  '�������/2'  '�������/2'
         '����/2' '����/1�' '�����/1�' '�������/1�' '����������/1�' '������/1�' '������/2' '����/2' '���/2' 
         '��������/1�' '��������/2'
  adjective = '�������/1�' '��������/1��' '�����������/2�' '�������������/1��'
;

beach_items : decoration
  location = beach_main_room
  desc = '�����/1�'
  noun = '�����/1�' '������/1�'
  isHim = true
  ldesc = "������ � �������, ������ �������, ������� ����������� ���������� �� ����������� ��������� ��� ������ ��������?"
;

water_at_main : decoration
  location = beach_main_room
  desc = '����/1�'
  noun = '����/1�' '����/1'
  adjective = '������������/1��'
  isHer = true
  ldesc = "������-������ ����, �� ������� ���������� ����� �������� � ��� �� ��������. ����� ����������, ����� ��� ���������� �����."
;

sander_at_main : decoration
  location = beach_main_room
  desc = '��������/1�� ����/1�'
  noun = '����/1�' '����/1�' '�����/1�'
  adjective = '��������/1��'
  isHim = true
  ldesc = "����������� ������ ����� �����, �������� � �������."
;

massage : Actor
   location = beach_main_room
   desc = '���������/1�'
   noun = '���������/1�' '�����/1�' '�����-���������/1�'
   isHim = true
   adjective = '���������/1��' '���������/1��'
   ldesc = "��������� ��������� ����� �� ������� ���� �������� ���� ����� ����. �� ��� ��������. ������� �� ����, ����� �������� ��� � ���� ������ �������� ����������� �������. ���� �� ��� ��������� ������������� ������ ����� ���������� � ������� ������������. �������� ��� ����� ������� � ������-��������������, ������������� ���������, ����� ������ �� ������."
   actorDesc = "[|�������� ����� ������ ����������� �� ��������� �����./����������� �������� �������, ����� ����� ��� ��� ������������� �����./�����-��������� ������ ����������� ����� �� ����� ���������� ������ ����./��������� ����������� �������� � ���������� �������.]"
   verDoTalk(actor) = {aresa_say('���� ������ �������������, ��� ��� ����������.');}
   verDoShoot(actor) = {}
   doShoot(actor)={
      "��� ������ �� ���������� ��������� ������, � ���� ��������� ����������� ������ � ��� ������� ��������� �������� ���� (-5). ���� �� ��� �������, ���� ���-�� �� ������� ��� ����������.";
      Me.Hit(nil,5);
   }
;

/////////

beach_pirs_room : room
  sdesc="������"
  lit_desc = '�������� � ���� ������� �� ��������, �������������� ������ ��� ��� �� ��� ������� ����� ���� ����������, �������� ���������� �� ����������. ��������, ����������� � �������, ������ ������������� �� ������. �������� ���� �� �������.'
  east = beach_main_room
  listendesc = "������ ��� ���� � ����� ����, ��� � �������������� ��������."
;

beachPirsDecoration : decoration
  location = beach_pirs_room
  isHim = true
  desc = '���� ������/1�'
  noun = '�����/1�' '�����/1�' '������/1�' '������/1�'  '��������/1�' '��������/1�' '������/1�' '����/1�' '�����/1�' '�������/1�' '������/1�' '��������/1�'
         '�����/2'  '�����/2'  '�������/2' '�������/1�' '��������/2'  '��������/2'  '�������/2' '����/2'  '�����/2'  '�������/2'  '�������/2' '���������/2'
         '����/2' '����/1�' '�����/1�' '�������/1�' '����������/1�' '������/2'
  adjective = '�������/1�' '��������/1��'
;

way_aerogel : decoration
  location = beach_pirs_room
  desc = '�������/1�'
  noun = '�������/1�' '��������/1�' '������/1�' '�������/1�'
  adjective = '����������/1��'
  isHer = true
  ldesc = "��� ������� ��� ���������� � �������� ��������������� ������� ������ �� ����������� ������� �������. ����� ��� ����� �����������, ��� - �����."
;


flyboard : fixeditem
   location = beach_pirs_room
   desc = '��������/1�'
   noun = '��������/1�' '���������/1�' '�����/1�'
   ldesc = "��������� ����������� �����, ����� ��� � �����, �� ����� ������� ��� ������� ������� ���� �������� ������ �� ���� � �������� �� ������."
   verDoBoard(actor) = {aresa_say('���, ������, ��� ���������� �� ��������! ��� ������ �� ������� ���� �������.');}
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
   verDoStandon(actor) = { self.verDoBoard(actor); }
   verDoTake(actor) = { self.verDoBoard(actor); }
;

shwartz : Actor
   location = beach_pirs_room
   desc = '������������/1��'
   noun = '������������/1�' '�������/1�' '����/1�' '�����/1�' '�����/1�'
   isHim = true
   ldesc = "���� ����� ��� ��� ����� ���� ����� �� ������������ ��������� � ���������."
   actorDesc = "[|������������ ������� �� ��� ����������./���� ���-�� ������ �� ��� ��������./������� ���������� ������� �����.]"
   verDoTalk(actor) = {aresa_say('���� �� ������� ��� �� �� ������ �����������, �� � �� ����?');}
   verDoShoot(actor) = {aresa_say('����� �������, �� ����� ������� �����, �� ���� ����� ������������. ���� ����� �������� ����� � ����������� � ����.');}
   verDoMove(actor) = "������� ��� ��������� �� ���, ��� � ��� ������� ��������� ����� ��� ��������."
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoPull(actor) = {self.verDoMove(actor);}
;

stallone : Actor
   location = beach_pirs_room
   desc = '��������/1��'
   noun = '��������/1�' '���������/1�' '����/1�' '�����/1�'
   isHim = true
   ldesc = "���� ����� - ������� ��������."
   actorDesc = "[|��������� ������ ��������./�������� ������� � ����./�������� ��������� �� ������� � ���� �������.]"
   verDoTalk(actor) = {aresa_say('���, � ��� �������� �� ��������, � ���� ����������.');}
   verDoShoot(actor) = {aresa_say('������� ���������, ��� ������ ��� �� ������� �� ������ ��� �������� �����, ����� �� ����������, ����� ������, ������, ���� ����� ���������� ����� � ������������ � ����.');}
   verDoMove(actor) = "������� ��� ��������� �� ���, ��� � ��� ������� ��������� ����� ��� ��������."
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoPull(actor) = {self.verDoMove(actor);}
;


/////////

beach_start_room2 : room
  sdesc="����� � �����"
  lit_desc = '������� ������� ������������ �� �����. ���� �� ������.'
  north = beach_rock_room2
  west = beach_game_room2
;

trap_r2 : decoration
  location = beach_start_room2
  desc = '�������/1�� �������/1�'
  noun = '�������/1�' '������/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "������ �� ����������� ������, ������ �� ��� ���������. "
;

st_beach2 : distantItem
  location = beach_start_room2
  desc = '����/1�'
  noun = '����/1�'
  isHim = true
  ldesc = "�������� ����, ���� ������� ��������. ������ �� �������. "
;

/////////

beach_game_room2 : room
  sdesc="������� ����"
  lit_desc = '���������� ������� �����������. ������� ������������ � ������� �� �����.'
  east = beach_start_room2
  west = beach_parking_room2
  _pl_pos = 3
;

fallen_game_table : DestructItem
   location = beach_game_room2
   desc = '���������/1�� ������/1�'
   noun = '������/1�' '����/1�'
   adjective = '���������/1��'
   isHim = true
   ldesc = "��������� ������ ����� �� ������. ������ �� ����� �� ����. ���� ���� ��� ����������, ������ �������� � ���������. � ������ ����� ����, �� ����� ������� �������� ����� �������� ��������."
;

trap_r3 : decoration
  location = beach_game_room2
  desc = '�������/1�� �������/1�'
  noun = '�������/1�' '������/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "������ �� ����������� ������, ������ �� ��� ���������. "
;

attractor2 : decoration
  location = beach_game_room2
  desc = '����������/1�'
  noun = '����������/1�'
  isHim = true
  ldesc = "��������� ����������, ������� �� ������ ������. "
;

simple_mon_hunt_boy4 : SimpleShooter
   desc = '���������/1��� �������/1��'
   location = beach_game_room2
   isHim = true
   _pos = 0
;

simple_mon_hunt_boy5 : SimpleShooter
   desc = '����������/1��� �������/1��'
   location = beach_game_room2
   isHim = true
   _pos = 5
;

/////////

beach_parking_room2 : room
  sdesc="������� �������"
  lit_desc = '����������� ������ ���������� ������ ������� � ��� �����, ��� ��� �������. ���������� ��� �� ������.'
  east = beach_game_room2
  _pl_pos = 3
;

stand_flyer2 : decoration
  location = beach_parking_room2
  desc = '���������/1�� ������/1�'
  noun = '������/1�' '����/1�'
  adjective = '�����������/1��' '���������/1��'
  isHim = true
  ldesc = "�� ����� �� ��������� ������� �������� ���� �������, �� ������ ��� �� ����� ��������, � ������ ������."
;


simple_mon_hunt_boy1 : SimpleShooter
   desc = '����������/1��� �������/1��'
   location = beach_parking_room2
   isHim = true
   _pos = 5
;

simple_mon_hunt_boy2 : SimpleShooter
   desc = '����������/1��� �������/1��'
   location = beach_parking_room2
   isHim = true
   _pos = 4
;


simple_mon_hunt_boy3 : SimpleShooter
   desc = '�����/1��� �������/1��'
   location = beach_parking_room2
   isHim = true
   _pos = 3
;

/////////

beach_rock_room2 : room
  sdesc="����� �� ������"
  lit_desc = '��������� ����� � �����������. ���� ��������� ����� ������������ �� �����, ��������� � ������� ���������� ����� �� ��.'
  south = beach_start_room2
  west = beach_main_room2
;

kust_at_rock2 : decoration
  location = beach_rock_room2
  desc = '��������/1�� ���������/1�'
  noun = '���������/1�' '����/1�' '����/1�' '�����/1�'
  adjective = '��������/1��' '���������/1��'
  isHim = true
  ldesc = "��������� ����, ����� ����� ������� � ����������� ������������ �����. "
;

water_at_rock2 : decoration
  location = beach_rock_room2
  desc = '������������/1�� ����/1�'
  noun = '����/1�' '����/1'
  adjective = '������������/1��'
  isHer = true
  ldesc = "������-������ ����, �� ������� ���������� ����� �������� � ��� �� ��������. �����������, ��� ������ ���� ������� ������������ ����?"
;

sander_at_rock2 : decoration
  location = beach_rock_room2
  desc = '��������/1�� ����/1�'
  noun = '����/1�' '����/1�' '�����/1�'
  adjective = '��������/1��'
  isHim = true
  ldesc = "����������� ������ ����� �����, �������� � �������."
;


trap_r22 : decoration
  location = beach_rock_room2
  desc = '�������/1�� �������/1�'
  noun = '�������/1�' '������/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "������ �� ����������� ������."
;

/////////

beach_main_room2 : room
  sdesc="�������� ����"
  lit_desc = '�������� ����� �������� �������. ���������� ������ � ��������� �������. �� ������ ������, � ������� ����� �� ���������.'
  east = beach_rock_room2
  west = beach_pirs_room2
;

beach_items2 : decoration
  location = beach_main_room2
  desc = '�����/1�'
  noun = '�����/1�' '������/1�'
  isHim = true
  ldesc = "������ � ������� �������� � �������� ��� ������."
;

massage2 : DestructItem
   location = beach_main_room2
   desc = '���������/1��� ���������/1��'
   noun = '���������/1��' '�����/1�' '�����-���������/1�'
   isHim = true
   adjective = '���������/1���' '���������/1��' '���������/1��'
   ldesc = "��������� ��������� �����, ������� ���� ������������ �����..."
;

/////////

beach_pirs_room2 : room
  sdesc="������"
  lit_desc = '�������� � ���� ������� ��� �������������� �� �������� � �� ���������. � ������� �������� ��������. �������� ���� �� �������.'
  east = beach_main_room2
;

way_aerogel2 : decoration
  location = beach_pirs_room2
  desc = '�������/1�'
  noun = '�������/1�' '��������/1�' '������/1�'
  adjective = '����������/1��' '�����������/1��'
  isHer = true
  ldesc = "�������� ������ �������� ����� ���������� ���������, ������ ������� ������� ��������� �������."
;

flyboard2 : fixeditem
   location = beach_pirs_room2
   desc = '��������/1�'
   noun = '��������/1�' '���������/1�' '�����/1�'
   ldesc = "��������� ����������� �����, ����� ��� � �����, �� ����� ������� ��� ������� ������� ���� �������� ������ �� ���� � �������� �� ������."
   verDoBoard(actor) = {}
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
   verDoStandon(actor) = { self.verDoBoard(actor); }
   doBoard(actor) = {
      global.stop_auto_music = true;
      stop_music_back();
      play_music_loop('Julius_Nox_-_Giulio_s_Page_-_Tortoise.ogg');
      scen_lvl4_meet_fish();
      show_image('fish.jpg');
      Me.travelTo(beach_run_room);
   }
   doEnter(actor) = { self.doBoard(actor); }
   doEnterOn(actor) = { self.doBoard(actor); }
   doEnterIn(actor) = { self.doBoard(actor); }
   doStandon(actor) = { self.doBoard(actor); }
;

/////////

//������������� ������ �� �����
#define CMD_MOVE_STAY  0
#define CMD_MOVE_UP    1
#define CMD_MOVE_DOWN  2
#define CMD_MOVE_NORTH 3
#define CMD_MOVE_SOUTH 4
#define CMD_MOVE_WEST  5
#define CMD_MOVE_EAST  6
#define TEXT_OK_MOVE  '�� ���������� �� �����.<br>'
#define TEXT_BAD_MOVE '�� ��������� � �����, � ����� �� ����� � ����, ��� ��� ���������...'

beach_run_room : room
  sdesc="������ �� ���������"
  lit_desc = '�� ������ �� ������� ��������, ����� �� ����� ����� ��������� ��������� �����.'
  ok_last_move = true
  processNextMove = {
     local currRow = self.move_list[self.curr_move_id];
     local currMv = currRow[1];
     //�� ������, ��� ������
     if ( (self.ok_last_move == true) || (currMv==CMD_MOVE_STAY) )
     {
        self.curr_move_id += 1;
        if (self.curr_move_id > length(self.move_list))
        {
           Statist.Show(4);
           "<i>(��� ����������� ������� ����</i>)<br>";
           input();
           //��������� ������ ������ ��� ����������� ������ ���������
           if (global.is_easy==nil) {
               show_image('final.jpg');
               stop_music_back();
               play_music_loop('pornophonique_-_rock_n_roll_hall_of_fame.ogg');
               scen_lvl4_final();
           }
           else
           {
              "<br>� ���������, �� ����� ������ ���������� ��������� ������, ���������� ������ ���� �� ���������� ���������! :) <br>";
           }
           win();
        }
        else
        {
           local nextRow = self.move_list[self.curr_move_id];
           local nextMv = nextRow[1];
     
           if (nextMv==CMD_MOVE_STAY) aresa_say('������ �� ������ ����.');
           else if (nextMv==CMD_MOVE_UP) aresa_say('������ ���� ������!');
           else if (nextMv==CMD_MOVE_DOWN) aresa_say('���� ����!');
           else if (nextMv==CMD_MOVE_WEST) aresa_say('������� ��������!');
           else if (nextMv==CMD_MOVE_EAST) aresa_say('������� ���������!');
           else if (nextMv==CMD_MOVE_NORTH) aresa_say('������ ��������!');
           else if (nextMv==CMD_MOVE_SOUTH) aresa_say('����� �����!');
        }
        self.ok_last_move = nil;
     }
     else
     {
       say(TEXT_BAD_MOVE);
       die();
     }
  }
  haveUdilshik = {
     local currRow = self.move_list[self.curr_move_id];
     return currRow[2];
  }
  haveShark = {
     local currRow = self.move_list[self.curr_move_id];
     return currRow[3];
  }
  curr_move_id = 1
  //������ �������� � ��������� ������
  move_list = [
     //��������       ��������  �����
     [CMD_MOVE_STAY     nil     nil  ]
     [CMD_MOVE_STAY     true    nil  ]
     [CMD_MOVE_STAY     true    nil  ]
     [CMD_MOVE_STAY     nil     true ]
     [CMD_MOVE_UP       nil     true ]
     [CMD_MOVE_NORTH    nil     nil  ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     nil     true ]
     [CMD_MOVE_STAY     nil     nil  ]
     [CMD_MOVE_DOWN     true    nil  ]
     [CMD_MOVE_DOWN     true    nil  ]
     [CMD_MOVE_WEST     nil     true ]
     [CMD_MOVE_EAST     true    true ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     true    nil  ]
     [CMD_MOVE_STAY     nil     nil  ]
     [CMD_MOVE_UP       nil     nil  ]
     [CMD_MOVE_UP       nil     nil  ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_WEST     true    true ]
     [CMD_MOVE_SOUTH    true    true ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     true    true ]
  ]
  
  checkMoveDir(way) = {
    local currRow = self.move_list[self.curr_move_id];
    local currMv = currRow[1];
    //�������� ����������� �����������
    if (currMv==way) {
       say(TEXT_OK_MOVE);
       self.ok_last_move = true;
    }
    else
    {
       say(TEXT_BAD_MOVE);
       die();
    }
    return nil;
  }
  north = {return self.checkMoveDir(CMD_MOVE_NORTH);}
  south = {return self.checkMoveDir(CMD_MOVE_SOUTH);}
  west = {return self.checkMoveDir(CMD_MOVE_WEST);}
  east = {return self.checkMoveDir(CMD_MOVE_EAST);}
  up = {return self.checkMoveDir(CMD_MOVE_UP);}
  down = {return self.checkMoveDir(CMD_MOVE_DOWN);}
;

////////////////////////////////////
// ������ ��������� ��� ����� ��������
aquaMachine : StateMachine
   st = 0
   num_steps_guys = 0
   is_lead_guys = nil
   have_protect_boy = nil
   boy_start_turn = 0
   boy_walk_with_isk = nil

   nextTurn={
     local i;
     if (self.st== 0)
     {
       The21Game.prepareGame;
       Me.isOnBeach = true;
       self.st = 1;
     }
     else if (self.st == 1 && (Me.location==beach_pirs_room))
     {
       scen_lvl4_meet_kach();
       self.st = 4;
     }
     
     //������� ����������� ������ �� �����
     if ( self.st == 4 )
     {
         if ( Me.location == beach_pirs_room )
         {
            self.is_lead_guys=true;
            self.num_steps_guys = 0;
         }
         else if (self.num_steps_guys >= 8) //����� �������� �� ������
         {
            if (shwartz.location != beach_pirs_room) {
                "������ ������� ������� �� ���� � ��� ��������� � �������.";
                shwartz.moveInto(beach_pirs_room);
                stallone.moveInto(beach_pirs_room);
            }
            self.is_lead_guys=nil;
            self.num_steps_guys = 0;
         }
         
         if (self.is_lead_guys)
         {
            if (shwartz.location != Me.location) {
                shwartz.travelTo(Me.location);
                stallone.travelTo(Me.location);
            }
            self.num_steps_guys += 1;
         }
     }
     else if (self.st == 5 && self.have_protect_boy)
     {
        //���������� �������� � ����������� ����
        loneBoy.travelTo(beach_parking_room2);
        self.st = 6;
        self.boy_start_turn = self.currTurn;
     }
     else if (self.st==6)
     {
        //������� ������� ����� 3 ���� � ������� ����
        if (self.currTurn-self.boy_start_turn>=3){
           self.st = 7;
           self.boy_start_turn = self.currTurn;
           loneBoy.travelTo(beach_game_room2);
           aresa_say('������� ������, ����� �� ���!');
        }
     }
     else if (self.st==7)
     {
        //������� ������� ����� 3 ���� � ������
        if (self.currTurn-self.boy_start_turn>=3){
           self.st = 8;
           loneBoy.travelTo(beach_rock_room2);
        }
     }
     else if (self.st==8 && Me.location==beach_rock_room2)
     {
        //�� ����� ��������
        self.st = 9;
        self.boy_walk_with_isk = true;
        aresa_say('�������, �� �����, ��� ��� ����� ��������. ������ ���� ��� ������� �������.');
     }
     else if (self.st==9 && Me.location==beach_parking_room2)
     {
        //������� � ����
        scen_lvl4_save_child();
        self.st = 10;
        self.boy_walk_with_isk = nil;
        self.have_protect_boy = nil;
        loneBoy.moveInto(nil);
     }
     
     if (self.boy_walk_with_isk) {
        if (Me.location != loneBoy.location) loneBoy.travelTo(Me.location);
     }
     
     if (self.have_protect_boy && loneBoy._hp<=0)
     {
        "�� �� ������ �������� ��������.<br>";
        die();
     }
     
     if ( Me.location == beach_run_room )
     {
        if (self.have_protect_boy) {
           "<br>�� ��������, ���� �� �� ������ �������� ��������.<br>";
           die();
        }
        
        beach_run_room.processNextMove;
        //������������ ��� �� ��
        if (fishUdilshik._hp > 0 && beach_run_room.haveUdilshik && fishUdilshik.location != beach_run_room)
        {
           fishUdilshik.travelTo(beach_run_room);
        }
        else if (fishUdilshik._hp > 0 && !beach_run_room.haveUdilshik && fishUdilshik.location == beach_run_room)
        {
           fishUdilshik.travelTo(beach_parking_room2);
        }
        
        if (plashShark._hp > 0 && beach_run_room.haveShark && plashShark.location != beach_run_room)
        {
           plashShark.travelTo(beach_run_room);
        }
        else if (plashShark._hp > 0 && !beach_run_room.haveShark && plashShark.location == beach_run_room)
        {
           plashShark.travelTo(beach_parking_room2);
        }
     }
     
     self.currTurn = self.currTurn+1;
   }
;