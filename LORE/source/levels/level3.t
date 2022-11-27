////////////////////////////////

#include <ochkoGame.t>

prepareLevel3 : function {
   show_image('lift.jpg');
   "<b>* ��������� ������ - ��������</b><br>";
   "<b>* �������� ������ - ������� ��� ���������</b><br>";
   Drobovik.moveInto(Me);
   edgeMachine.unregister;
   hotelMachine.register;
   CraftSystem.enableCraft(CRAFT_TYPE_SHOTGUN);
   global.level_play_music = 'Sara_Afonso_-_Underwater_Experience.ogg';
   stop_music_back();
   play_music_loop('Sara_Afonso_-_Underwater_Experience.ogg');
   Knife.moveInto(Me);
   Me.sel_weapon=Knife;
   NoneWeapon.moveInto(nil);
   Me.Heal;
   
   global.curr_level = 3;
   
   //��������� � ���������� �������
   CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
   Pistol.moveInto(Me);
   CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
   CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
   CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
   CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
   TorsionGenerator.moveInto(Me);
   
   Statist.Prepare([cleaner_bot tramvaika wooden_door hole_kitchen reshetka_to_kitchen fen_destruct living_window skaf_main_alien zaval_alien_one help_but_alien_two luk_alien_three]);
    
   Me.travelTo(startcor_room);
}

startcor_room: room
   sdesc="������ ������ ��������"
   lit_desc = '��������� ���� ����������� ����� ��� �������� ��������� ���������� ��������� ������ ������ �� ��������. �� ������ ����� ��������� ������ � ������. �������� ���� �� �������, ����� ������� ������������ �� �����.'
   //�����
   west = midcor_room
   //������
   east = {
     aresa_say('�� ������ ����������� � ����� �������������?');
     return nil;
   }
;

startcorDecoration : decoration
  location = startcor_room
  isHer = true
  desc = '��� �����/1� ���������'
  noun = '�������/1�' '�������/1�'
  adjective = '�����/1��'
;

cleaner_bot : DestructItem
   location = startcor_room
   desc = '�������/1�'
   noun = '�������/1�' '�����/1�' '�����/1�'
   isHim = true
   ldesc = "����������� ����� �������, ������ �����-����������."
;

tramvaika : DestructItem
   location = startcor_room
   desc = '������������/1�'
   noun = '������������/1�' '���������/1�'
   adjective = '��������/1��'
   isHim = true
   ldesc = "�����������, ��� ������� ��������� ����� ������������ ������� �������� ���������! ��� �������� ������, � ������, ��� ������, ����� �������, ������� ����������� � ����������� ������������ ������ ������� ������. ������, �� �����������? ���� ���� ��������� �����������. �������, �� ��������? ������� ����� � �� ������ ����������� ���� ���� �����! "
;

galogen : decoration
   location = startcor_room
   desc = '�����������/1�� �����/1�'
   noun = '�����/1�' '���������/1�' '����/1�'
   adjective = '�����������/1��' '���������/1��'
   isHer = true
   ldesc = "��������� ��������. ����� ���������. ���� �� ��������� �� ������� ������� �� �������. ��� ��� ����������. "
;

doors_far : distantItem
   location = startcor_room
   desc = '�����/2'
   ldesc = "���� ������� �������, ������ �� ���������. "
;

print_on_wall : decoration
   location = startcor_room
   desc = '�����/1�'
   noun = '�����/1�' '����������/1�' '�����/1�' '�����/1�' '����/1�' '�����/1�'
          '������/2' '����������/2'  '�����/2'  '�����/2'  '����/2'  '�����/2'
          '���������/1�' '������/1�'
   isHim = true
   ldesc = "������ ��������! �� ����� ���������� �����-�� ��������� ������ �� ����� ����, ������ ����� � ��� � ������� ����� �����, ������ �������� ������ �� �����. ������� �� ����� ����� �� �����, ������ ��������, �� ������ ������� ����� ��������. �������, �����-�� ������������� �����, � ������ �� ������, �������.  "
;


//////////////////////////

midcor_room : room
   sdesc="�������� ������ ��������"
   lit_desc = {
      if (reshetka_to_kitchen.location == midcor_room) return '������� ������������ �� �����, �� ����� ����� ���������� ����� ������, ���� ������ �� ���� �������������� �����, �������� ������������ ��������.';
      return '������� ������������ �� �����, �� ����� ����� ���������� ����� ������, ���� ������ �� ���� �������������� �����.';
   }
   was_find_pair = nil
   enterRoom(actor) = 
   {
      if (self.was_find_pair==nil) {
         scen_lvl3_meet_pair();
         self.was_find_pair=true;
      }
      pass enterRoom;
   }
   //�����
   west = fincor_room
   //������
   east = startcor_room
   north = {
     if (hole_kitchen.seeExit == nil) {
        aresa_say('���� �� ������ ���������� � ����� ���-��?');
        return nil;
     }
     //����� ����������
     scen_lvl3_ventil();
     return kitchen_room;
   }
;


wooden_door : fixeditem
  desc = '����������/1�� �����/1�'
  ldesc = "�� ���� ������� ���������� �����."
  location = midcor_room
  isHer = true
  verDoOpen(actor) = {aresa_say('�� ��� �� ������ �����������! �� �� ���, ���������� �������, ���� ������ ������ ����.');}
  verDoKnock(actor) = {aresa_say('���-���, ����� ������, ��� � ���� ������� ����. ������ ���, ��� ������.');}
  verDoShoot(actor) = {aresa_say('���-���! ����� �����! � ���, ��������� ������� � ������ �������, �� ����� ����� ��������.');}
;

fire_mon_hunt1 : SimpleFireMon
   desc = '���������/1��� �������/1��'
   location = midcor_room
   isHim = true
   _pos = 5
;

fire_mon_hunt2 : SimpleFireMon
   desc = '����������/1��� �������/1��'
   location = midcor_room
   isHim = true
   _pos = 4
;

hole_kitchen : LukSimple
   location = midcor_room
   desc = '��������������/1�� �����/1�'
   noun = '�����/1�' '����/1�'
   adjective = '��������������/1��'
   isHer = true
   seeExit = nil
   ldesc = {
      "���������� ����������, ����� �� �����������. ����� �� �����.";
      hole_kitchen.seeExit = true;
   }
;

reshetka_to_kitchen : EasyTake
   location = midcor_room
   desc = '��������������/1�� �������/1�'
   noun = '�������/1�'
   adjective = '��������������/1��'
   isHer = true
   ldesc = { 
      "������ ������� ��������� ������ �� �����.";
      hole_kitchen.seeExit = true;
   }
   verDoTake(actor) = {}
   doTake(actor) = {
      "�� ����� ������� ����� ��������� � �������� ����������� ������ ��������.";
      self.moveInto(nil);
   }
;

/////////////////////////

fincor_room : room
   sdesc="����� ������ ��������"
   lit_desc = '������� ��� �������������, ������� ������ �� ������. � ���� ������ ������������� ����� � ���� �� �������.'
   //������
   east = midcor_room
   out = midcor_room
;

broned_door : fixeditem
  desc = '�������������/1�� �����/1�'
  noun = '�����/1�' '�����/1�'
  ldesc = "�������� � ���������� �����, ������� ����� � ��� ��������."
  location = fincor_room
  isHer = true
  verDoKnock(actor) = {aresa_say('���-���, ����� ������, ��� � ���� ������� ����. ������ ���, ��� ������.');}
  verDoShoot(actor) = {aresa_say('���-���! ����� �����! � ���, ��������� ������� � ������ �������, �� ����� ����� ��������.');}
;

///////////////////////

kitchen_room : room
   sdesc="�����"
   lit_desc = '�����-���������� ���-�����. ���������� ����� � ���� ������� ������������ �����, �� ������� ������ ��������� ������������ �������. �������� ������� ����. �� ������-������� ������ � ������, �� ������-������ � ��������.'
   //������-������
   ne = bath_room
   //������-�����
   nw = living_room
;

kitchenDecor : decoration
   location = kitchen_room
   isHer = true
   desc = '��� �����/1� �����'
   noun = '���������/1�' '���������/1�' '��������/1�' 
          '���������/2'  '����������/2' '���������/2' 
          '����/1�' '����/1�' '����/1�' 
   adjective = '�������/1��' '�����/1��' '���������/1��'
               '�������/2�'  '�����/2�'  '���������/2�'
;


polka : decoration
   location = kitchen_room
   desc = '����������/1�� �����/1�'
   noun = '�����/1�' '�����/1�' '�����/2' '�����/2'
   adjective = '����������/1��' '����������/2�'
   isHer = true
   ldesc = "���������� �����, ��� � ����������. ������ ��������� ��������� ������ � ����� ��������� ������, ��� �������� � ����� ���� ���� ��� ���� �� ������."
;

plates : decoration
   location = kitchen_room
   desc = '������������/2� �������/2'
   noun = '�������/2' '�������/1�' '�����/2' '�����/1�' '������/1�'
   isThem = true
   ldesc = "��������� ������� ������ �������, ������ ���� ���������� ��������� ����������."
;

pech : fixeditem
   location = kitchen_room
   desc = '�������/1�� ����/1�'
   noun = '����/1�' '�����/1�'
   adjective = '�������/1��'
   isHer = true
   ldesc = "��������� �������� ����, ��� � ����. ������ ����� �������."
;

door_pech : EasyTake
   location = kitchen_room
   desc = '������/1�'
   noun = '������/1�' '�����/1�' '��������/1�' '��������/1�'
   isHer = true
   ldesc = "������ ������ ��������� �����."
   wasTaken = nil
   verDoTake(actor) = {if (self.wasTaken) aresa_say('�� ��� ����� �������, ��� ������ ������ ���.'); }
   doTake(actor) = {
      "�� ������� ������ � �� ��� ���������� ������������ ��� �� ���� � �������.<br>";
      aresa_say('��� �� ������� �� ��������� ������� ������! ��, ��� ��������, �� �� ������� ���� � �� ������� ����, � �� ��� ������� ���������?');
      self.wasTaken = true;
      kolobok.moveInto(kitchen_room);
      "����� �� �������� �������� �������, ������ � ��������� ������� �������� ��������� ���� �����.<br>";
   }
;


kolobok : DestructItem
   location = nil
   resAmount = RESOURCE_AMOUNT_HIGH
   desc = '�������/1�'
   noun = '�������/1�' '���/1�' '�����/1�' '�������/1�' '����/1�'
   adjective = '������������/1��' '�������/1��' '��������/1��'
   isHim = true
   ldesc = "������� ����, ������� �� ��� ������ ��������. �������, �� ������� ������� ���� ���� �� ���������."
;

/////////////
bath_room : room
   sdesc="������ �������"
   lit_desc = '����� � ����� ����. �������� ���������� ������ ��������� �������� ������� �����, ������ � ��������� ��������. �� ���-������ ����� �� �����.'
   //���-�����
   sw = kitchen_room
   out = kitchen_room
;

fen_destruct : DestructItem
   location = bath_room
   desc = '���/1�'
   isHim = true
   ldesc = "������������ ��� ����� ���������� �������� ������������� ����. ������� �������? ������� ���! �� ������� ���� � ���� ���� ����� ������ �������� �������, ���� ���-�� ����� ��������� �� ���-�� ������������. "
;

plitka : decoration
   location = bath_room
   desc = '����������/1�� ������/1�'
   noun = '������/1�' '������/2'
   adjective = '����������/1��'
   isHer = true
   ldesc = "��� ����� �������, ��� �� ��� ����� �������� ��������. � 3D."
;

trub : decoration
   location = bath_room
   desc = '�������/1�� �����/1�'
   noun = '�����/1�' '�����/2'
   adjective = '�������/1��'
   isHer = true
   ldesc = "����� ������� �����������. ���� ���� �������� ��������� �����, �� ������� ��������� ��� ������. ������� ������ �� ����� ������ ������� �� ���� ���������������?"
;


racovina : decoration
   location = bath_room
   desc = '���������/1�� ��������/1�'
   noun = '��������/1�' '���������/1�' '����/1�' '���������/2' '�����/2'
   adjective = '���������/1��' '�����/1��' '������������/1��'
   isHer = true
   ldesc = "����� ������������ ��������, � ����������� ��������. ��� ��������� ��������� ��� ������� � �������� ����. ���������, ����. � ������� ���� ����� ����� � ����� ���������? "
;

/////////////
living_room : room
   sdesc="��������"
   lit_desc = '����� ���������� ������� ��������� �� ������������� �������. ����������� ������� ���������� ����� ����� �� ����. ����� � ��������� �������� ���������� ����. �� ���-������� ����� �� �����.'
   //���-������
   se = kitchen_room
;


bed_living : BedSimple
   location = living_room
   desc = '�������/1�'
   noun = '�������/1�' '�����������/1�' '���������/1' '�������/1�' '������/1'
   adjective = '�����������/1��'
   isHer = true
   ldesc = "����������� ������� � ������� �������������. ������ �������, ��� ����� ����� ����� ����� ���� �� ���������. ��������� � ������� � ��������� �����. "
;

stolik_living : decoration
   location = living_room
   desc = '���������/1�� ������/1�'
   noun = '������/1�' '�������/1�' '���������/1�'
   isHim = true
   ldesc = "��������������� ������ �� ��������� ��� ���������. ��-���� ����� ������ ������� �� �������, � ������, ������, ��� ����� ���������� ��� ����� ���."
   verDoOpen(actor) = {"����� �� ������� ������, �� ������ ��������� ���������� ����� ����������� �����, ��� ������ �������� ���. ����� ������ ����, ������� �� ������. �� ������ ���� � ������� �������.";}
;

living_window : fixeditem
  desc = '����������/1�� ����/1�'
  ldesc = "Ҹ���� ����, ���������� ��������� ��� �� ���."
  location = living_room
  verDoOpen(actor) = {aresa_say('�� �����������, ��� ����������!');}
  verDoShoot(actor) = {}
  doShoot(actor) = {
    show_image('flyer.jpg');
    scen_lvl3_jump_on_car();
    Me.travelTo(car_flying_room);
  }
;

//////////
car_flying_room : room
  sdesc="�� �������� ������"
  listendesc = "����� ������� ������ ��������!"
  lit_desc = '����� �����, ��������� �� ����� ������ ��������� ����� ������� ���������. ����� ����, ��������� ������, ����� � ���� �� ���������.'
  _field_size = 3
  mayJumpOut = true
  noexit = {
    //��� ������ �� �������, �������
    if (hotelMachine.allow_jump) {
      "�������� �� ����� ������, �� ������ ����������� �� ���, �� �������. ����� ��� ���� ����������� � ���� � ������� �� �����-�� �������� �� �������� ��������. <br>";
      hotelMachine.out_of_car = true;
      Me.Heal;
      scen_lvl3_in_angar();
      show_image('alien.jpg');
      return alien_main_room;
    }
    else{
        "�������� � ������ �� ������ ���������.";
        die();
        return nil;
    }
  }
;

flyerDecor : decorationNotDirect
   location = car_flying_room
   isHer = true
   desc = '���� ������/1�'
   noun = '�����/1�' '������/1�' '������/1�' '�����/1�' '������/1�'
          '������/2' '�������/2' '������/2'  '�����/2'  '������/2'
          '��������/1�'   
   adjective = '���������/1��' '������/1��' '����������/1��' '���������/1��'
;

//////////
alien_main_room : room
  sdesc="� ������ �������� ����"
  lit_desc = '������� ��� ��� ���������. ��� �������� ������ ����� ���� ���������. �� ������� ��������� ������� � ��������� ������. � ����� �� ���� ���������� ������� �������. ������ ����� �� �����, �� � ������.'
  listendesc = "������� ������ ��������� ��������� ������."
  north = alien_one_room
  up = alien_two_room
  south  = alien_three_room
  isSayShow = nil
  leaveRoom(actor) =
  {
     if (isSayShow == nil){
        scen_lvl3_find_robots();
        isSayShow = true;
     }
     pass leaveRoom;
  }
;

alienMainDecor : decorationNotDirect
   location = alien_main_room
   isHer = true
   desc = '���� ������/1�'
   noun = '�����/1�' '������/1�' '������/1�' '������/1�' '�����/1�' 
          '�����/2'  '�������/2' '�������/2' '������/2'  '�����/2'
          '���/1�' '�������/1�' '�����/1�'
   adjective = '�������/1��' '������������/1�'
;

mon_block : fixeditem
  desc = '����/1�'
  noun = '����/1�' '�������/1�' '�����/1�' '��������/2' '������/2'
  ldesc = "���� ��������� ���������� ��� ��������, �������. ������ ��������� � �����������, �� ����� �������."
  location = alien_main_room
;

circ_table : FunnyFixedItem
  desc = '��������/1�� ����/1�'
  noun = '����/1�' '������/1�'
  adjective = '��������/1��'
  ldesc = "�������� ���� ������ ��� �������� ������� � ��������� ������� ����������. � ������ ��������� ������������ �����."
  location = alien_main_room
;

skaf_main_alien : fixeditem
  desc = '�������/1�� ����/1�'
  noun = '����/1�' '�������/1�'
  adjective = '�������/1��'
  ldesc = "������� �������, ��� ����� ����� �� �� �����������."
  location = alien_main_room
  isOpen = nil
  isHim = true
  verDoShoot(actor) = {aresa_say('���� ����� �� ����������, ���� �� ��� � ���� ��������!');}
  verDoEnter(actor) = {}
  doEnter(actor) = {self.doBoard(actor);}
  verDoBoard(actor) = {}
  doBoard(actor) = {
     if (hotelMachine.say_out_alien == nil) aresa_say('����� ������� � ���� �����, ���� � ���� ������������ ����� �������! ����, � ���� ���������� ���-�� ����...');
     else
     {
        if (HaveMonsters(Me.location)) aresa_say('� ���� ��������, ������ � ���� ��� ������, ����� ��� ���� ��������. ��������� � ��� �������.');
        else
        {
           Statist.Show(3);
           "<i>(��� ����������� ������� ����</i>)<br>";
           input();
           scen_lvl3_in_self();
           resourceSaveToGlobal();
           prepareLevel4();
           //win();
        }
     }
  }
  verDoOpen(actor) = {}
  doOpen(actor) = {
     if (self.isOpen == nil)
     {
        "�� ������� ����<br>";
        aresa_say('���, ����� ������ �� ��������� � ���� �����?');
        self.isOpen = true;
     }
     else
     {
        "���� ��� ������.";
     }
  }
  verDoClose(actor) = {}
  doClose(actor) = {
     if (self.isOpen == nil){aresa_say('����� ��������� �������� ����, �� ������ ��?');}
     else {aresa_say('�� ��� ��� ����� �������� � ������ ��� ������ ������� ��������?');}
  }
;

////////

alien_one_room : room
  sdesc="������� � �������"
  lit_desc = '������� �������, � ����� �������� ����� �� ����� �������. ��������� ����� �� ��.'
  south = alien_main_room
  listendesc = "������� ������ ��������� ��������� ������."
;


alienOneDecor : decorationNotDirect
   location = alien_one_room
   isHer = true
   desc = '���� ������/1�'
   noun = '������/1�' '������/1�' '�����/1�' 
          '�������/2' '������/2'  '�����/2'
          '�������/1�'
;

broken_bot1 : DestructItem
   location = alien_one_room
   desc = '����������/1�� �����/1�'
   noun = '�����/1�' '��������/2' '��������/1�'
   adjective = '����������/1��'
   isHim = true
   ldesc = "��������� ������ ����� �� ���������� ���������. �������� ����������� ��������� ���������� �� ����. ����� ��������, ��� ��� ����� ������ �� ���� � ����� ���������."
;

zaval_alien_one : fixeditem
  desc = '�����/1�'
  noun = '�����/1�' '�����/1�' '����/1�' '������/1�' '��������/1�' '��������/2'
  ldesc = "���� �������, ���������������� ������ � ������ ������."
  location = alien_one_room
  tryOpen = nil
  isHim = true
  verDoShoot(actor) = {}
  doShoot(actor) = {
     aresa_say('����� ������� �������, ��� �� ���������, ������� ������ ������ �����!');
     self.tryOpen = true;
  }
;

/////////

alien_two_room : room
  sdesc="�����"
  lit_desc = '��������� �����, ����������� ������. ������ ������ ���������� ������ �������� ����������. ���������� ����� ����. '
  listendesc = "������� ������ ��������� ��������� ������."
  down = alien_main_room
;


alienTwoDecor : decorationNotDirect
   location = alien_two_room
   isHer = true
   desc = '���� ������/1�'
   noun = '������/1�' '������/1�' '�����/1�' '������/1�'
          '�������/2' '������/2'  '�����/2'  '�������/2'
          '�����/1�' '������/1�'
   adjective = '�����������/1��' '���������/1��'
;

broken_bot2 : DestructItem
   location = alien_two_room
   desc = '����������/1�� ��������/1�'
   noun = '��������/1�' '�����/1�' '������/1�' '������/1�' '��������/1�'
   adjective = '����������/1��'
   isHim = true
   ldesc = "��� �������� ������� �� �������� ��������� ������� �������� ��������. ������ ���� ����� ��������� ������������."
;

help_but_alien_two : Button
  desc = '������/1�'
  isHer = true
  ldesc = "��������� ����� ������ ������ ������."
  location = alien_two_room
  tryOpen = nil
  verDoPush(actor) = {}
  doPush(actor) = {
     aresa_say('������ �� ��������! ������� ������ �� � �������. ������� ������ ���-�� ������.');
     self.tryOpen = true;
  }
;

/////////

alien_three_room : room
  sdesc="������ ���������"
  lit_desc = '����� ����� ���� ����� ����������� ������� �����. � ���� ������� ���������� ���. ����� �� ������.'
  north = alien_main_room
  listendesc = "������� ������ ��������� ��������� ������."
;

alienThreeDecor : decorationNotDirect
   location = alien_two_room
   isHer = true
   desc = '���� ������/1�'
   noun = '������/1�' '������/1�' '�����/1�' '����/1�'
          '�������/2' '������/2'  '�����/2'  '����/2'
          '�����/1�' '������/1�'
   adjective = '�����������/1��' '���������/1��'
;

workplace : decoration
   location = alien_three_room
   desc = '�������/1�� �����/1�'
   noun = '�����/1�'
   adjective = '�������/1��'
   ldesc = "������� ������� ����� - ������ ���������. ���� ����������� ������������� - ��� ����� �� ����������."
;

broken_bot3 : DestructItem
   location = alien_three_room
   desc = '����������/1�� ��������/1�'
   noun = '�����/1�' '��������/1�' '�����/1�' '���/1�'
   adjective = '����������/1��'
   isHim = true
   ldesc = "������ ������������ ������ ��������, � ������������ ���������� �� ���� �������."
;

luk_alien_three : LukSimple
  desc = '����������/1�� ���/1�'
  ldesc = "��������������� ���, ����� ����, ��������� � ������ �������."
  location = alien_three_room
  tryOpen = nil
  isHim = true
  verDoShoot(actor) = {aresa_say('��, ��� ������ ���� ���������.');}
  verDoBoard(actor) = {aresa_say('�� �� ������ �������� � �������� ���, ��� ������ �����!');}
  verDoOpen(actor) = {}
  doOpen(actor) = {
     aresa_say('�������! �� ��� �� ������? ������� ������ ��� ������.');
     self.tryOpen = true;
  }
;


////////////////////////////////////
// ������ ��������� ��� ����� ��������
hotelMachine : StateMachine
   st = 0
   st_list = 0
   delay_mon_add = 0
   next_mon_pos = 1
   car_wait_time = 0
   allow_jump = nil
   out_of_car = nil
   say_out_alien = nil
   hunt_list = []
   delay_alien_come = 0
   //next_mon_list = [fire_mon_hunt3 fire_mon_hunt4 king_mon_1 fire_mon_hunt5 king_mon_2 fire_mon_hunt6 king_mon_3 king_mon_4 fire_mon_hunt7 king_mon_5 king_mon_6 fire_mon_hunt8 king_mon_7 fire_mon_hunt9 king_mon_8 fire_mon_hunt10 king_mon_9 king_mon_10]
   next_mon_list = [fire_mon_hunt3 fire_mon_hunt4 king_mon_1 fire_mon_hunt5 king_mon_2 fire_mon_hunt6  fire_mon_hunt7 fire_mon_hunt8 fire_mon_hunt9 fire_mon_hunt10]
   next_mon_list2 = [king_mon_3 king_mon_4 king_mon_5 king_mon_6]
   
   allHuntersTravel(loc)={
     local i;
     //���� ���� �� �����, �������
     for (i=1;i<=length(self.hunt_list);i++)
     {
        if (self.hunt_list[i].location != nil) self.hunt_list[i].travelTo(loc);
     }
   }
   
   nextTurn={
     local i;
     //�������� ������ �� ������ � ��������� �����, ����������
     if (midcor_room.isseen && self.st == 0) {
        self.hunt_list += [fire_mon_hunt1 fire_mon_hunt2];
        self.st = 1;
     }
     else if (self.st == 1) //������ �� ��������
     {
        if (self.out_of_car==true) 
        {
           self.st = 2;
        }
        else
        {
            //���� ���� �� �����, �������
            self.allHuntersTravel(Me.location);
            //��������� ������
            self.delay_mon_add += 1;
            //������� ���������� �������
            if (self.st_list == 0)
            {
                if (self.delay_mon_add == 5) {
                   if (self.next_mon_pos <= length(self.next_mon_list))
                   {
                       local mon = self.next_mon_list[self.next_mon_pos];
                       mon.travelTo(Me.location);
                       self.hunt_list += [mon];
                       self.next_mon_pos += 1;
                   }
                   else
                   {
                      //��������� �� ������ ���� - ��������
                      self.st_list = 1; 
                   }
                   self.delay_mon_add = 0;
                }
            }
            else if (self.st_list == 1)
            {
               aresa_say('���! �������, ��������. ���� ����� ������� ����������.');
               self.st_list = 2;
            }
        }
     }
     else if (self.st == 2) //����� ������
     {
        //������� ������
        if (Me.location == beach_start_room)
        {
           self.st = 3;
        }
        if (Alien.location == nil) {
           self.delay_alien_come += 1;
           if (self.delay_alien_come == 6) {
             "[|������ ����� ������� ���������./���-�� ����� ������� �����./������� �������./�� �������� ���-�� �����������.]";
             if (global.is_easy) aresa_say('���� ����� ��� ������ ������!');
           }
           else if (self.delay_alien_come == 7) {
              Alien.travelTo(Me.location);
           }
        }
        else
        {
          if (Alien._hp < 30) { //���� ������ - ���������
             self.delay_alien_come = 0;
             Alien.moveInto(nil);
             Alien._hp = Alien._max_hp;
             "<br>����� �����!<br>";
          }
          else if (Alien.location != Me.location) //������� �� ������, ���� ������
          {
             Alien.travelTo(Me.location);
          }
        }
        
        //�������� �� �� �������
        if ( (Me.location == alien_main_room) && 
             (zaval_alien_one.tryOpen) &&
             (help_but_alien_two.tryOpen) &&
             (luk_alien_three.tryOpen) &&
             (self.say_out_alien == nil))
        {
           "<br>";
           aresa_say('� ���� ��������� �����! ���� �� �� �����-�� �������, �� ����� �� ������� � �� �������� �������� � ������� �����, ��� ������ ����� ��������� ���� ��������� ���� ���? ������, ���� ������� � ����, � � ��� ����� ������� ���� � ���� ��������� �������, ����� ��� ����� �� ������, ��� ���� � ��� ���������, � �� ������ ���������! ������ ����� ������� ����������� � ���� ��� ����� �� ������, �����? ��������, ������!');
           self.say_out_alien = true;
        }
     }
     
     //�� ������ �����
     if (Me.location == car_flying_room) {
       self.car_wait_time += 1;
       if (self.car_wait_time == 1) {
          "<br>����� ������������ ���������� �� ������ ������ ��������.<br>";
          self.allHuntersTravel(startcor_room);
          //��������� ������� ��������
          self.hunt_list += self.next_mon_list2;
          for (i=1;i<=length(self.next_mon_list2);i++) {
             local mon = self.next_mon_list2[i];
             mon.travelTo(startcor_room);
          }
       }
       else if (self.car_wait_time == 2) {
          "<br>�������� ������ ������� ��� � �������� �����, ����� ��� ���������. � ������� ������ ��� ������� ���������� �� ������� ����� ���������� �����.<br>";
          car_flying_room.lit_desc = '���������� ����� ����������� ����� � �����.';
       }
       else if (self.car_wait_time == 3) {
          self.allHuntersTravel(startcor_room);
          "<br>����� ���������� ��������������� �����, ��� �� �� �������� ����������, �� �� ����� ���������� � ������ �� ������ ��������� � ��������-���������..<br>";
          car_flying_room.lit_desc = '������ ��������� �����.';
       }
       else if (self.car_wait_time == 4) {
          "<br>�� ��������� ������������ � ������� ����.<br>";
       }
       if (self.car_wait_time == 9)
       {
          aresa_say('� ���� �� ��������� �������� �� �������� ������, ��������� � ������!');
          self.allow_jump = true;
       }
       else if (self.car_wait_time > 10)
       {
         "����� ������ ������ ������� ��� ��������� �������� � �� ����� � ������� ������.";
         die();
       }
     }
     
     self.currTurn = self.currTurn+1;
   }
;

//�������������� ��������
fire_mon_hunt3 : SimpleFireMon
   desc = '������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 3
;

fire_mon_hunt4 : SimpleFireMon
   desc = '�����/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 2
;

fire_mon_hunt5 : SimpleFireMon
   desc = '������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 2
;

fire_mon_hunt6 : SimpleFireMon
   desc = '���������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 1
;

fire_mon_hunt7 : SimpleFireMon
   desc = '������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 3
;

fire_mon_hunt8 : SimpleFireMon
   desc = '������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 2
;

fire_mon_hunt9 : SimpleFireMon
   desc = '����������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 1
;

fire_mon_hunt10 : SimpleFireMon
   desc = '�����������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 0
;

king_mon_1 : KingShooter
  desc = '�������/1��� �������/1��'
  location = nil
  isHim = true
  _pos = 3
;

king_mon_2 : KingShooter
  desc = '������������/1��� �������/1��'
  location = nil
  isHim = true
  _pos = 2
;

king_mon_3 : KingShooter
  desc = '������/1��� �����������/1��'
  location = nil
  isHim = true
  _pos = 1
;

king_mon_4 : KingShooter
  desc = '�������/1��� ������������/1��'
  location = nil
  isHim = true
  _pos = 0
;

king_mon_5 : KingShooter
  desc = '������������/1��� �����/1��'
  location = nil
  isHim = true
  _pos = 3
;

king_mon_6 : KingShooter
  desc = '������/1��� ��������/1��'
  location = nil
  isHim = true
  _pos = 2
;

king_mon_7 : KingShooter
  desc = '��������/1��'
  location = nil
  isHim = true
  _pos = 1
;


king_mon_8 : KingShooter
  desc = '�����������/1��� ����������/1��'
  location = nil
  isHim = true
  _pos = 0
;


king_mon_9 : KingShooter
  desc = '���������/1��� �����/1��'
  location = nil
  isHim = true
  _pos = 0
;


king_mon_10 : KingShooter
  desc = '������/1��� ����/1��'
  location = nil
  isHim = true
  _pos = 0
;