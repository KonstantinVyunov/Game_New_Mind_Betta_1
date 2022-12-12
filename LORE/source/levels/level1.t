////////////////////////////////

prepareLevel1 : function {
   shnekoMachine.register;
   Statist.Prepare([fonar_seccont window_seccont table_seccont manipu_seccont button_seccont monitor_seccont reshetka_floor comm_floor platform_floor richag_cabin]);
   stop_music_back();
   global.level_play_music = 'Antnio_Bizarro_-_09_-_Berzerker.ogg';
   play_music_loop('Antnio_Bizarro_-_09_-_Berzerker.ogg');
   show_image('shnek.jpg');
   global.curr_level = 1;
   Me._hp = 100;
   Me.travelTo(startroom_lvl1);
}

prepareLevel1_Full : function {
    stop_music_back();
    play_music_loop('Miami_Sheriff_-_Intercept.ogg');
    show_image('med_block.jpg');
    scen_introduction_1();
    "<br><br>";
    "<i>(��� ����������� ������� ����</i>)<br>";
    input();
    "<br><br>";
    show_image('cabinet.jpg');
    scen_introduction_2();
    "<i>(��� ����������� ������� ����</i>)<br>";
    input();
    prepareLevel1();
}

//////////////////////////////////////////////

startroom_lvl1: room
   sdesc="����������� �����"
   _field_size = 2
   lit_desc = {
      if (fonar_seccont.isListed == nil) return '������ �������������� ����������. ��� ������ ��������� ������ ������ �������� ����� ������������ ������. �����-�� ����� � ����� ����. �� ������ ����������� ����������.';
      else return '������ �������������� ����������. �����-�� ����� � ����� ����. �� ������ ����������� ����������.';
   }
   out = { return self.north; }
   north = {
      if (shnekoMachine.allowMoveSecond) return contsecfloor;
      else {
        "���� �������. �� ������������ ��������� ���������.";
        return nil;
      }
   }
   listendesc = "������ ���� ������ �����."
;


uproomDecoration1 : decorationNotDirect
  location = startroom_lvl1
  isHer = true
  desc = '��� �����/1� ���������'
  noun = '���������/1�' '�����������/1�' '�����/1�' '������/1�'
  adjective = '�������������/1��' '�����������/1��'
;

fonar_seccont : item
   location = startroom_lvl1
   desc = '������������/1�� ������/1�'
   noun = '������/1�' '����������/1�' '���������/1�' '����/1�' '�����/1�'
   adjective = '������������/1��' '����������/1��'
   isHim = true
   isListed = nil
   ldesc = "���������� ����� ����, ������� ����� �������� ������."
   doTake(actor) = {
     if (self.isListed == nil) {
        "������ �� ������� ���������, �� ������� �� ��������. ����� ������, ��� ������ ���� �����������. ";
        self.isListed = true;
     }
     pass doTake;
   }
   verDoTake(actor) = {
     if (shnekoMachine.allowTakeLamp == nil) aresa_say('���� �� �������, ��� ���� ���� ������� � ����� ������?');
   }
;

koika_seccont : BedSimple
   location = startroom_lvl1
   desc = '���������/1�� �����/1�'
   noun = '�����/1�' '�������/1�' '���������/1�' '�����������/1�'
   adjective = '���������/1��' '����������/1��'
   isHer = true
   ldesc = "������� ��������� ����� ������ ��������� � ���, ������� ���������� �����������."
   verDoLookunder(actor)=aresa_say('��������� ����� ��������� �� ����! ��� ��� ��������� ������������? �, ����, � ��� ����������� ��������...')
   verDoTake(actor) = {aresa_say('�� ����, ������ �����, �����? ������, ������ �������� � �� ���� ������, �� �� ������.');}
;

window_seccont : Window
   location = startroom_lvl1
   desc = '�����/1�� ����/1�'
   noun = '����/1�' '����/1�'
   adjective = '�����/1��'
   ldesc = "� ���� ������ ���������� �����, ������ �������� �������. ����� � ���� ���������."
   haveThruLook = nil
   thrudesc = {
      self.haveThruLook = true;
      "�� � �������� �� ������ �������� �������! �� ����� �����, ���� ���� ������, �� � ������ �������� ����� ����� �������� ��������� ������� �� ����� ���������� ������.";
   }
   doLookin(actor)={self.thrudesc;}
   verDoShoot(actor)={aresa_say('��� ����� ��������� ��� ����? � ��� ���� �������� ���� ���� ���� � �� ��������...');}
   verDoUnboard(actor)={self.verDoShoot(actor);}
   verDoOpen(actor)={aresa_say('���� ����������, ��� �� �������, ����� ��� �������...');}
;


windowDecoration : decoration
  location = startroom_lvl1
  isHim = true
  desc = '���� ������/1� � ����'
  noun = '����/1�' '�����/2' '�������/1�' '�������/2' '������/1�' '�������/2' '������/1�' '������/2' '��������/1�' '���������/2' '����/1�' '����/2'
  adjective = '������/2' '����������/1��'
;


/////

contsecfloor: room
   sdesc="����� �������"
   _field_size = 2
   lit_desc = {
      local text_out = '����� ������� ��� � �������� ��������� ����� ���������� ����. ';
      if (monitor_seccont.location == contsecfloor) text_out += '� ��������������� �������� ������ �������������� ������ ���������� ';
      else text_out += '�� ������ ';
      if (table_seccont.location==contsecfloor) text_out += '������ � ';
      text_out += '������������� �����-����������� �� ��������������� �����. �������� �� ���.';
      return text_out;
   }
   south = startroom_lvl1
   out = { return self.down; }
   down = {
     if (shnekoMachine.allowMoveDown) return mech_floor;
     else {
         "���� ��� ��������� ����������� �����.";
         return nil;
     }
   }
   listendesc = "������ ���� ������ �����."
;


uproomDecoration2 : decorationNotDirect
  location = contsecfloor
  isHer = true
  desc = '��� �����/1� ���������'
  noun = '���������/1�' '�����/1�' '������/1�' '�����/1�'
  adjective = '�������/1��' '���������������/1��'
;

luk_down : LukSimple
   location = contsecfloor
   desc = '�������/1�� ���/1�'
   isHim = true
   ldesc = "������� ���, ���� ����-�� ����."
;

table_seccont : FunnyFixedItem
   location = contsecfloor
   desc = '����������/1�� ������/1�'
   noun = '����/1�' '������/1�' '���������/1�'
   adjective = '����������/1��' '���������/1��'
   isHim = true
   ldesc = "��������� ���������� ������, ������ ������������� ��� ��������� ��� ������ ��������, ������ ����� ������� � ���, ��� ���-�� ������ �� � �����."
   verDoLookunder(actor)=aresa_say('�� �� �� ����������! ���� ��� ��� ���� ����������, �� ��� ��� ������ ���.')
;

tableDecoration : decoration
  location = contsecfloor
  isHer = true
  desc = '��� �����/1� �����'
  noun = '�������/1�' '��������/2' '�����/1�' '�����/1�' '�����/2'
  adjective = '������/2�' '������/1��' '������/2�' '������/1��'
;

manipu_seccont : fixeditem
   location = contsecfloor
   desc = '�������������/1�� �����������/1�'
   noun = '�����������/1�' '�����/1�' '�����-�����������/1�' '����/1�' '������/1�'
   adjective = '�������������/1��' '��������/1��' '��������/1��'
   isHim = true
   ldesc = "�������� ���, ������ ��� ����� �������� �������� ������, � ���� �� ��� ��� ������ �������� � ������ ��� �������� ������ ����-������ ��������. �������, ������ �� ��������� � ����� ������ ���. ����� ������� ������ ������, ������� ������� ���������� �� �����."
   verDoMove(actor) = "��� ������ �� ���������� �������� �����������, �� ����� ����������. ����� ����� �������� ��������."
   verDoPull(actor) = {self.verDoMove(actor);}
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoTake(actor) = {self.verDoMove(actor);}
   verDoTurnon(actor) = {button_seccont.verDoPush(actor);}
   doTurnon(actor) = {button_seccont.doPush(actor);}
;

button_seccont : Button
   location = contsecfloor
   desc = '������/1�� ������/1�'
   noun = '������/1�' '�����/1�'
   adjective = '�������/1��' '������/1��'
   isHer = true
   ldesc = "��� �������, �������� �� ������."
   isTurnOn = nil
   verDoPush(actor) = {
      if (panel_cabin.isLookPanel==nil) "�� ��������. ����� ����-�� �� �������?";
   }
   doPush(actor) = {
      self.isTurnOn = true;
      DustKiller.mustHunt = nil;
      DustKiller.moveInto(nil); //������������� �������� �����, ����� �� �� ����� ������� ��������� � �����
      "����������� ������� � ���������. ";
      play_sound('hydraulic.ogg');
      dustkiller_broken.moveInto(contsecfloor);
   }
;

monitor_seccont : DestructItem
   isListed = nil
   location = contsecfloor
   desc = '���������������/1�� �������/1�'
   noun = '�������/1�' '�����/1�' '������/2'
   adjective = '���������������/1��' '���������'
   isHim = true
   resAmount = RESOURCE_AMOUNT_MID
   ldesc = "�� �������� ������������ ������, ������� �� ������������, ����� ����� �������� ���� �� ����������."
   allowDestruct = nil
   verDoShoot(actor) = {
      if (self.allowDestruct==nil) aresa_say('������� ��������� �������, ���� ��� ������� ����������.');
   }
   doShoot(actor) = {
      monitorDecoration.moveInto(nil);
      pass doShoot;
   }
;


monitorDecoration : decoration
  location = contsecfloor
  isHim = true
  desc = '���� ������/1� �� ��������'
  noun = '������/1�' '�������/1�' '�������/1�' '�����/1�' '��������/2' '�����/2' '��������/1�' '��������/2'
  adjective = '������������/1��' '�������/1��' '������/2�' '������/1��'
;

/////
mech_floor: room
   sdesc="������������"
   _field_size = 2
   lit_desc = { 
       if (panel_cabin.isLookPanel==nil) return '����� ����� ��������� � ����� �� ����� �������, ���������� ���������� ����������. � ������ ���� �������� �������� �������������� ���������. ������ ������������ �� ��.';
       else return '����� ����� ��������� � ����� �� ����� �������, ���������� ���������� ����������. � ������ ���� �������� �������� �������������� ���������. ������ ������������ �� ��. ������ ���� � �������� ����� ��������� ������ � ������.';
   }
   south = out_floor
   up = contsecfloor
   out = { return self.south; }
   north = {
      if (panel_cabin.isLookPanel) return cabin_shnek;
      return self.noexit;
   }
   listendesc = "������ ���������� �� �����������."
;

downroomDecoration1 : decorationNotDirect
  location = mech_floor
  isHer = true
  desc = '��� �����/1� ���������'
  noun = '���������/1�' '�����/1�' '������/1�' '������������/1�' '�������/1�' '������/1�'
  adjective = '�����/1��'
;

luk_up : LukSimple
   location = mech_floor
   desc = '�������/1�� ���/1�'
   isHim = true
   ldesc = "������� ���, ���� ����-�� �����."
;

hole_to_cabin : LukSimple
   location = nil
   desc = '������/1�� ����/1�'
   noun = '����/1�' '���������/1�'
   adjective = '������/1��' '��������/1��'
   isHer = true
   ldesc = "�������� ����, ���� � ������ �� ������."
;

machine_floor : decoration
   location = mech_floor
   desc = '���������/2� ��������/2'
   noun = '��������/2' '������/2' '���������/1�' '�����/1�'
   adjective = '���������/2�' '�������/2�'
   isThem = true
   ldesc = "��� ������ ������������ �������������, � ����� ��� ���-������ ��������."
;

reshetka_floor : EasyTake
   location = mech_floor
   desc = '�������/1�'
   noun = '�������/1�'
   isHer = true
   ldesc = {
      if (self.wasTaken==nil) "������� ��������� ��������� �������������� �����, ��������� ��������� ����������.";
      else "������� ��������� ��������� ����������";
   }
   wasTaken = nil
   verDoTake(actor) = {if (self.wasTaken) aresa_say('������ �������� �������! ����� �� ��� �����.'); }
   doTake(actor) = {
      "�� �������� ������� � �������, �� ��� �������� ��������� ������������.<br>";
      aresa_say('���, ��� �� ��� �����! ������ ����� ���������� �������� �������� ��������� ��� �������, ��-�� ������� ��� ����� � ���������� ���-������ ������!');
      self.wasTaken = true;
      comm_floor.moveInto(mech_floor);
   }
;

comm_floor : DestructItem
   location = nil
   desc = '������������/1�'
   noun = '������������/1�' '����������/1�' '�����������/1�'
   adjective = '��������������/1��'
   isHim = true
   ldesc = "�������������� ����������, �� ������ ����� ����� ��������� �������� �������."
;



vent_tube : decoration
   location = mech_floor
   desc = '��������������/1�� �����/1�'
   noun = '�����/1�' '���������/1�'
   adjective = '��������������/1��'
   isHer = true
   ldesc = "� ��������� ��������� �����, ���������� �������, ������ ����������."
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor);}
   verDoEnterIn(actor) = { self.verDoBoard(actor);}
   verDoBoard(actor) = {aresa_say('����� ���������, �� ��������.');}
;

////
out_floor: room
   sdesc="����������� ���������"
   _field_size = 3
   lit_desc = '��������� ��� �������� ���-�� �� �������� ������� �� ������ ����. �������� ��������� ������ � ������������ ���������� ������������� ����� ������. '
   north = mech_floor
   block_down = nil
   out = {
      if (HaveMonsters(self)) "�� �� ������ ����������� � �����, ��������� ������ ������!"; 
      else "����� ���������� ������� ���������� �������, ��� ����� ��� ������ �� ��������. ������� ������ ������ ����.";
      return nil; 
   }
   down = {
     if (platform_floor.isFindHole == nil) return self.noexit;
     if (self.block_down == true) {
        "-�� ���, ����� ��� �� ��� �����������? � ��� ��� ���� ������ � ������, ���� - �� ����!";
        return nil;
     }
     return under_ramp;
   }
   listendesc = "������������ �������� ������� ������� ������� �� ���������."
;

downroomDecoration2 : decorationNotDirect
  location = out_floor
  isHer = true
  desc = '��� �����/1� ���������'
  noun = '���������/1�' '�����/1�' '������/1�' '������������/1�'
  adjective = '�����/1��'
;

platform_floor : fixeditem
   location = out_floor
   desc = '�����������/1�� ���������/1�'
   noun = '���������/1�' '������������/1�' '����/1�' '����/1�'
   adjective = '�����������/1��' '���������/1��' '������/1��'
   isHer = true
   isLookUnder = nil
   isFindHole = nil
   ldesc = "������ ��������� ��� ������, ����� ������ ���� �����-�� ��������� ��������. ����� ���������� � ����� ���� ��������� ������������."
   verDoLookunder(actor) = {  if (HaveMonsters(self.location)) "� ��� �� ���������� ���������� ��� ���������, ���� ��� ���!"; }
   doLookunder(actor) =
   {
     self.isLookUnder = true;
     if (fonar_seccont.isIn(Me)) {
        "�������� ��� ���������, �� ������� ������������� ��� ����� ����� �������� ��������� � �����. �� ����� �����, �������� �������� � � �������������� ���� ������ �������� �����. ��� ������ �� ������, ������ ������� � �������� ���������, � �������, ���� ����� ������.";
        fonar_seccont.moveInto(nil);
        self.isFindHole = true;
     }
     
     if (self.isFindHole) "����� ���� �������� ����, ����� �� ����� ���������� ��� �����.";
     else "��� ���������� ���������� ����� ����� ����� ��������, ������ ����� �����, ������ �� �����.";
   }
   verDoEnter(actor) = {"�� ��� ������ �� ���������, �� ����� ��� � ����� ���� ��������� �����.";}
   verDoBoard(actor) = { self.verDoEnter(actor); }
   verDoEnterIn(actor) = { self.verDoEnter(actor);}
   verDoEnterOn(actor) = { self.verDoEnter(actor);}
   verDoMove(actor) = {aresa_say('��������� ��������! �� � �� ��������, ����� ����� ���������, ���-��.');}
   verDoPull(actor) = {self.verDoMove(actor);}
   verDoDetach(actor) = {self.verDoMove(actor);}
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoTake(actor) = {self.verDoMove(actor);} 
;

door_floor : fixeditem
   location = out_floor
   desc = '�������������/1�� �����/1�'
   noun = '�����/1�' '�������/1�' '�������/2'
   adjective = '�������������/1��'
   isHer = true
   ldesc = {
      if (HaveMonsters(self.location)) "�� �� ������ ��������� �����, ���� ������ � ��������.";
      else "������������� ����� ������.";
   }
   verDoOpen(actor) = { "����� �������� �������� ��������! ���� ������ ������ �����.";  }
;

fixer1 : SpiderFixer
   desc = '�������/1�� ���������/1�'
   noun = '����/1�' '���������/1�' '�����/1�' '����������/1�'
   adjective = '�������/1��' '�����������/1��'
   isHim = true
   verDoTake(actor)={"��� �� �� �������� �������� �������� ������ �� ���������� ����������, ������ �� �����.";}
   _pos = 3
   corpse = fixer1_broken //��� ������ ����
;

fixerDecoration : decoration
  location = out_floor
  isHim = true
  desc = '���� ������/1� � ������'
  noun = '����������/1�' '�����/1�'
  adjective = '�����������/1��' '����������/1��'
;


fixer1_broken : DestructItem
   desc = '��������/1�� �����/1�'
   noun = '�����/1�' '�����/1�' '�����/1�' '����������/1�'
   adjective = '��������/1��' '��������/1��'
   ldesc = "�� ��� �������� �� ������� �������� ����������. ���� �� ����� �� ����������, �������� ��� ����� � �������� ���������, ���� ������ ������� � ������������ �� ����� ���������� �����������."
   isHim = true
   enegryItem = true
   enegryGive = 30
;

fixer2 : SpiderFixer
   desc = '�������/1�� ��������/1�'
   noun = '����/1�' '���������/1�' '��������/1�' '�����/1�'
   adjective = '�������/1��'
   isHim = true
   verDoTake(actor)={"�������� ����� ����� ���������� ����� ���������� ������� � ��������� � ����, ����� ��-���� ����� � ����� ��������� �������...";}
   _pos = 3
;

fixer3 : SpiderFixer
   desc = '�������/1�� ���������/1�'
   noun = '����/1�' '���������/1�' '���������/1�' '�����/1�'
   adjective = '�������/1��'
   isHim = true
   verDoTake(actor)={"������� ��������� ����� ����� ������ ���-�� �������� ������� �� ������� � ���� ���������� ������� �� ������ ��������������.";}
   _pos = 3
;

////
under_ramp: room
   sdesc="��� �����������"
   listendesc = "������ ����� ��������..."
   ldesc = {
      //����� ����� ����������
      local cur_line = self.getCurrentLine;
      local fut_line = self.getFutureLine;
      
      //����� ���������� �� ���� ������
      //������ ����� ���������
      if (self.plX == 1) {
        "�� ������ ����������� ����������. ";
        if (cur_line[2]==1) " �� ������� �����. ";
        if (fut_line[1]==1) " ������� �� ������ �����! ";
      }
      else if (self.plX == 3) {
        "�� ������� ����������� ����������. ";
        if (cur_line[2]==1) " �� ������ �����. ";
        if (fut_line[3]==1) " ������� �� ������ �����! ";
      }
      else if (self.plX == 2) {
        "�� �� ������ �����. ";
        if (cur_line[1]==1) " �� ������ �����. ";
        if (cur_line[3]==1) " �� ������� �����. ";
        if (fut_line[2]==1) " ������� �� ������ �����! ";
      }
   }
   north = {
      local fut_line = self.getFutureLine;
      if (fut_line[self.plX]==1) {
        "�� ��������� �� ����� � ������ ��� ����������� ���� �� �������� ��������. ";
        die();
      }
      else {
        self.plY += 1;
        if (self.plY == self.endY) {
           return cabin_shnek;
        }
        else "�������� ������ �� ������: <<self.endY-self.plY>>. ";
      }
      return nil;
   }
   west = {
      local cur_line = self.getCurrentLine;
      if (self.plX==1) {
        "��� ������ �� ���������� ������� ��������, �� ��� �������� ������� �� ����������� ����. ";
        die();
      }
      else if (cur_line[self.plX-1]==1) {
        "�� ��������� �� ����� � ������ ��� ����������� ���� �� �������� ��������. ";
        die();
      }
      else {
        self.plX-=1;
        "�� ���������� ��������.";
      }
      return nil;
   }
   east = {
      local cur_line = self.getCurrentLine;
      if (self.plX==3) {
        "��� ������ �� ���������� ������� ���������, �� ��� �������� ������� �� ����������� ����. ";
        die();
      }
      else if (cur_line[self.plX+1]==1) {
        "�� ��������� �� ����� � ������ ��� ����������� ���� �� �������� ��������. ";
        die();
      }
      else {
        self.plX+=1;
        "�� ���������� ���������.";
      }
      return nil;
   }
//private:
   getCurrentLine = {return self.pattern[self.patCurPos];}
   getFutureLine = {
      if (self.patCurPos==1) return self.pattern[7];
      return self.pattern[self.patCurPos-1];
   }
   //������� � ���������� �������� �����������
   nextPattern = {
      local cur_line;
      if (self.patCurPos > 1) self.patCurPos -= 1;
      else self.patCurPos = 7;
      
      cur_line = self.getCurrentLine;
      if (cur_line[self.plX]==1) {
         "�� �������� �� ����� � ��������� ����������� � �������� ����� ��� ���������� ����.";
         die();
      }
   }
   //������ ���������� � ���� ������� (1-����������, 0 - ���)
   pattern = [
     [1 0 0]
     [1 1 0]
     [1 0 0]
     [0 0 0]
     [0 1 1]
     [0 0 1]
     [0 0 0]
   ]
   plX = 2//�� ��� X(��������� ��������������� ������������)
   plY = 0//�� ��� Y(��� �� �������)
   patCurPos = 7
   endY = 8
;

Shnekorotor : decoration
   location = under_ramp
   desc = '����������/1�'
   noun = '����������/1�' '����/1�'
   isHim = true
   ldesc = "�������� ����������� ������. �� ��������� ������������ �������� �� ����� ��������?"
;

Kochka : decoration
   location = under_ramp
   desc = '�����/1�'
   isHer = true
   ldesc = "���������� �����. �������� ������, ����� �� ��������� �� �� � ������� ���������."
;

decorUnderRamp : decoration
   location = under_ramp
   desc = '���� ������'
   noun = '�����/1�'
;

////
cabin_shnek: room
   sdesc="������ ���������"
   isseen = true
   _field_size = 6
   lit_desc = {
     if (panel_cabin.isLookPanel==nil) return '������ ������� ���������� ����������. �������� ������ �������� ����������� ������, ����������� �� ����. �� ������� ������ ������������ ��������������� ������ ����������. ';
     else return '������ ������� ���������� ����������. �� ������� ������ ������������ ��������������� ������ ����������. �� ��� ����������� �������� ������ ����� � ������. ';
   }
   out = { return self.south; }
   south = {
      if (panel_cabin.isLookPanel) return mech_floor;
      return self.noexit;
   }
   listendesc = "�������� ���� �������."
;

hole_to_gener : LukSimple
   location = nil
   desc = '������/1�'
   isHim = true
   ldesc = "������ �� ����-��������, ���� � ������ �� ���."
;

door_shnek : fixeditem
   location = cabin_shnek
   desc = '�����/1�'
   noun = '�����/1�'
   isHer = true
   ldesc = "��� ����� �������, ���� ������ ������ �����.";
;


lustra_cabin : fixeditem
   location = cabin_shnek
   desc = '�����������/1�� ������/1�'
   noun = '������/1�' '�����/1�'
   adjective = '�����������/1��'
   isHer = true
   ldesc = "���, ��������� ����� �����, �������������, ������������ ������� �������������� ������� � �������."
;

sphere_decor : decoration
   location = cabin_shnek
   desc = '�����/1�� ���/1�'
   noun = '���/1�' '����������/1c' '�������/1�'
   adjective = '�����/1��' '��������/1��'
   isHim = true
   ldesc = "�������� ������ ����� ���, � ���� �� ������ �� ������, ��� ��������� �������� ���� ����� ����������?"
;

slang_decor : decoration
   location = cabin_shnek
   desc = '�������������/1�� �����/1�'
   noun = '�����/1�' '�����/1�' '�����/1�'
          '������/2' '�����/2'   '�����/2'
   adjective = '�������������/1��'
   isHim = true
   ldesc = "�������� �����, ��� �������. � �������� ��� �������� ���� �� �����."
;

panel_cabin : Window
   location = cabin_shnek
   desc = '�������/1�� ������/1�'
   noun = '������/1�' '������/1�' '����������/1�'
   adjective = '����������/1��' '�������/1��' '����/1�' '���������������/1��'
   isHer = true
   isLookPanel = nil
   ldesc = {
      if (self.isLookPanel == nil)
      {
          isLookPanel = true;
      }
      "�� ������ ��� ������ �� �������, ����� ������ ���������� ���������.";
   }
   thrudesc = "�� ����� ������ �� �����, ����� � ������. ������ ��� ������� ����� ����� ����� ����� �����."
;


window2Decoration : decoration
  location = cabin_shnek
  isHim = true
  desc = '���� ������/1� � ����'
  noun = '�����/2' '�����/1�' '���/1�' '�����/1�'
  adjective = '�������/2�' '�������/1��'
;

richag_cabin : Button
   desc = '�����/1�'
   noun = '�����/1�' '����/1�' '����-�����/1�' '����-����/1�' '����/1�' '������/2'
   adjective = '������-�����/1��' '�������/1��' '�����/1��'
   isHim = true
   ldesc = "������-����� ����� ���������� ���������."
   verDoPush(actor)={
     if (HaveMonsters(cabin_shnek)) "��� ������ ������� �� ����� �����-�������!";
   }
   
   doPush(actor)={
      //��������� �� ��������� �����
      Statist.Show(1);
      "<i>(��� ����������� ������� ����</i>)<br>";
	  input();
      show_image('near_city.jpg');
      scen_lvl1_final();
      "<i>(��� ����������� ������� ����</i>)<br>";
	  input();
      resourceSaveToGlobal();
      prepareLevel2();
   }
;


////////////////////////////////////
// ������ ��������� ��� ����� ���������
shnekoMachine : StateMachine
   lastSt = 0
   st = 0
   lastStoryTurn = 0
   tmLookUnder = 0
   nextTurn={
     if ((self.currTurn >= 0) && (self.st == 0)) {
        scen_lvl1_meetings();
        self.st = 1;
     } else if (self.st == 1) {
         aresa_say('���, ���, ��� � ������ ��������, ���� � ������.');
         "<br><b>(�������� \"���������� � ����\")</b>";
         self.st = 2;
     } else if ((self.st == 2) && (window_seccont.haveThruLook==true)) {
         "<br>";
         aresa_say('�������, ��� ���� ���������� ������. ���� � �������, ������ ��� ���� ������� ���������. ���� ���� ����� ���, ���������� �� �������� ������ �������. �������, �� �������� ���, � ���� � ����������, ����?');
         "<br><b>(�������� \"���� �� ����� ��� ������ �����\")</b>";
         self.allowMoveSecond = true;
         self.st = 3;
     } else if ((self.st == 3) && (Me.location==contsecfloor)) {
        "<br>";
        aresa_say('� ������, ���� ��� �� ����� � ���� ���� �� �����������. ���� ��� � ������, ������, ������ �������� ������ � ���������� ��������, � ��� ��� ����� ������� � ��������� �������. ����, ����� �����, ���� ����������� ���������� ��������� ��������� �������� ����! � ��������� ������ ���������� - �������. ��������� � ��������� �� ���� ����������, �� ��� ������ �� ����������� ������� � ����������. ��� ������������ ��� ������ � ������� ���, ���������� ������ ����� ������� �����-������ ����������� ���������� �����. ������ ���.');
        "<br><b>(�������� \"������� �������\")</b>";
        Knife.moveInto(Me);
        self.st = 4;
     } else if ((self.st == 4) && (Me.sel_weapon==Knife) && (Me.location==contsecfloor)) {
        "<br>";
        aresa_say('���, ���� ��������� � �������. ���-�� ���������, ���-�� ���������. ����! ��� ��� ���������� ������, ����� �� ����� ����� �����������! � ���� �������������� ���� ������������, ������ ��� ������ ����������� ��������� ������ ������ ������ �����. ���, ��� ��� ������� ����������� ����������, ����� ��� ��� ��������� � ���������� ��������. ����������, �� �����, ����� � ��� ������� ������, �� ������ ��������, �����, �������� ���!');
        "<br><b>(�������� \"�����������\", ����� \"������� ������\")</b>";
        NoneWeapon.moveInto(nil);
        table_seccont.moveInto(nil);
        table_seccont_mon.moveInto(contsecfloor);
        self.st = 5;
     }
     else if ((self.st == 5) && (contsecfloor._pl_pos!=table_seccont_mon._pos)) {
        "<br>";
        aresa_say('���. ����������, ���� �������, ����� ��������� ����� �� ��������. ����� ���� ���!');
        "<br><b>(�������� \"������\", ����� ������������)</b>";
        self.st = 6;
     }
     else if ((self.st == 6) && (table_seccont_mon.location==nil)) {
        "<br>";
        aresa_say('�� ������ ���! � ��� �����! ������ ���� ����������� ������ ���� ����������. ���� ���, ������� ����������� � ����������� �������������� ��������.');
        self.st = 61;
        self.allowMoveDown = true;
     }
     else if ((self.st == 61) && (Me.location==mech_floor)) {
       "<br>";
       aresa_say('������ ���� �������, ��� � ��������� ������������ � ����� ������� �������, �� �� ����� ��� �� ���� �� � ���������. ��� ����� ��������� ������ �������� �����, ��������� �� ����� ������. � ������ � ��������� �� ������ ���������, �������� � �������. ����� ����-������ � ���� ���������, ��� ������ � �������� �������, ����� �� �������.');
       self.st = 7;
       monitor_seccont.allowDestruct = true;
     }
     else if ((self.st == 7) && (Me.location==out_floor)) {
        "<br>";
        scen_lvl1_spiders();
        self.st = 8;
        fixer1.moveInto(out_floor);
        fixer2.moveInto(out_floor);
        fixer3.moveInto(out_floor);
     }
     else if ((self.st == 8) && (!HaveMonsters(out_floor))) {
        "<br>";
        fixerDecoration.moveInto(nil);
        aresa_say('� ���� �� �����������, �������. ������� �� �������� �������� �������� �����! ���� ����������� � ���������, � ����� �������� ������� ����� ���������� �������� ��� ������� ���������� �������. � ����� �������, � ������� �������� �������, ����� �� ����!');
        if (ResourceSystem.aluminium > 0) {
             aresa_say('����� ��������, �� ������� ������������� ��������� ������ ���������, ��������.');
             "<br>";
        }
        else
        {
            aresa_say('����� ��������, �� ��� �� ������������� ��������� ������ ���������, �� �� ����� ���-���� � ������������, ����� ��� � ����� �������� �������������.');
            "<br>";
        }
        "<b>(�������� \"������\" ����� �������� ����� � ������� ����������, ����� ��������� � ������� \"������������ �����\" ��� ������ \"������������\" � ������� �� ������)</b>";
        self.st = 9;
        CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
     }
     else if ((self.st == 9) && (platform_floor.isLookUnder)) {
        "<br>";
        aresa_say('�������, ��� ����� ���-�� ����. ����� ������ ���-������ ������� ��� ������ ���������. �� ������ �� ������?');
        self.allowTakeLamp = true;
        self.st = 10;
     }
     else if ((self.st == 10) && (platform_floor.isFindHole)) {
        "<br>";
        aresa_say('����� ����! ���� ���������� � ���������.');
        "<br><b>(����������� ����������� ����� ������������)</b>";
        self.st = 11;
     }
     else if ((self.st == 11) && (Me.location == under_ramp)) {
        scen_lvl1_under_shneko();
        self.st = 12;
     }
     else if ((self.st == 12) && (Me.location == cabin_shnek)) {
        scen_lvl1_in_shneko();
        self.st = 13;
     }
     else if ((self.st == 13) && (panel_cabin.isLookPanel == true)) {
          scen_lvl1_dustsocker();
          //��������� �����, ������� � ������� �����
          richag_cabin.moveInto(cabin_shnek);
          lustra_cabin.moveInto(nil);
          slang_decor.moveInto(nil);
          sphere_decor.moveInto(nil);
          DustKiller.travelTo(cabin_shnek);
          DustKiller.mustHunt = true;
          out_floor.block_down = true; //������ ���������� ���� ����� ��������
          hole_to_cabin.moveInto(mech_floor);
          hole_to_gener.moveInto(cabin_shnek);
          self.st = 14;
     }
     else if ((self.st == 14) && (button_seccont.isTurnOn) ) {
        scen_lvl1_kick_vacuum();
        button_seccont.isTurnOn = nil;
        self.st = 15;
     }
     
     //����� ��� ������, �� ������� �������
     if (Me.location==under_ramp) {
       under_ramp.nextPattern;
       under_ramp.ldesc;
     }
     
     //������ ������� �������� � ������, �� ����� ��� �����������
     if (DustKiller.mustHunt)
     {
        if (DustKiller.location != Me.location)
        {
           DustKiller.travelTo(Me.location);
        }
     }
     
     //��������� ���������� ��� ���������
     if ((self.st == 9) && (!platform_floor.isLookUnder) && (global.is_easy))
     {
        self.tmLookUnder += 1;
        //����� ����� 10 ���� � ������ 10 �����
        if (self.tmLookUnder >= 10 && (self.tmLookUnder % 10==0)) {
          aresa_say('�������� ��� ���������!');
        }
     }
     
     //���� ��������� ��������� ���������, ���������� ���, ��� ������� ������
     if (self.lastSt != self.st)
     {
        self.lastSt = self.st;
        self.lastStoryTurn = self.currTurn;
     }
     self.currTurn = self.currTurn+1;
   }
//������
   allowMoveSecond = nil //��������� ���� � ��������� �������
   allowMoveDown = nil   //��������� ���������� ����
   allowTakeLamp = nil   //��������� ����� �����
;