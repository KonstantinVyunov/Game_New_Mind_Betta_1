////////////////////////////////

#include <threeLetterGame.t>

prepareLevel2 : function {
    show_image('eco_city.jpg');
    "<b>* ��������� ������ - ���������</b><br>";
    "<b>* �������� ������ - ������� ��� ����������</b><br>";
    "<b>* �������� ������ - ��������������</b><br>";
    
    global.curr_level = 2;
    Me.travelTo(edgeroom);
    shnekoMachine.unregister;
    edgeMachine.register;
    //���������� ��������� � ��������� ��������� �������
    Pistol.moveInto(Me);
    Knife.moveInto(Me);
    Me.sel_weapon=Knife;
    NoneWeapon.moveInto(nil);
    Me._hp = 100;
    CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
    CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
    global.level_play_music = 'Antnio_Bizarro_-_12_-_Across_this_River.ogg';
    stop_music_back();
    play_music_loop('Antnio_Bizarro_-_12_-_Across_this_River.ogg');
    //��������� �������� ���������� ��������, ���� ���� ��������
    CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
    
    Statist.Prepare([scyscreep green river edgemap tramvay_station right_side musorka kalian_home sliz_home lom firstUnblocker sadik_roofgarden rain_dron roofLiftButton secondUnblocker]);
}

/////////////////////////////

edgeroom: room
   sdesc="������ ������� ������"
   lit_desc = '���������, ������������� ������������ ���� � �������, � ����� ������ ��������� ���������� �������, ��� �������, �������, ����� ��������� �������, ������� ������ � ������ �����. ������ ����� ������ �� �����.'
   north = {
     if (edgemap.wasInitTalk==nil) {
       aresa_say('������, ��� ���� ������ ���� ������ ����.');
       return nil;
     }
     return secondroom;
   }
   south = {
     aresa_say('�� ������ ����� ������� ��� �������?');
     return nil;
   }
   listendesc = "������ ����� ���� � �������� ����."
;

scyscreep : decoration
  location = edgeroom
  desc = '��������/1�'
  noun = '��������/1�' '���������/2' '������/1�' '������/2' '�������/1�' '�������/2' '������/1�' '������/1�'
  adjective = '��������/1��'
  isHim = true
  ldesc = "������������ ��������� �������, ������ � ������! ������ ����� ���� ������ �������������� �������� ������� � ������ ������� �������. "
;

green : decoration
  location = edgeroom
  desc = '������/1�'
  noun = '������/1�' '�����/1�' '������/1�' '�����/1�' '������/2' '������/1�' '�����/2' '�����/1�' '���/1�' '������/2' '�������/1�' '�������/1�' '������2' '������/1�' '�����/2' '���������/2'
  adjective = '������/1��' '������������/1��'
  isHer = true
  ldesc = "����� ��� �������! ���� ����������� �������������, �� ����� �������� ������������ ������������� ���������� � ������������. ��� ���������� �������� ����� ��������� � �������������� �������� �������� ����������� �������. "
  verDoTouch(actor) = "��� ������������� ��������� ��������� ���������, ������ �������� ������������ ������� ��� �����������."
;

river : decoration
  location = edgeroom
  desc = '����/1�'
  noun = '����/1�' '�����/1�' '������/1�' '�������/1�' '����/1�' '����/1�' '�����/1�' '����/2' '�����/2' '��������/2' '��������/2' '��������/1�' '�������/1�' '�������/1�'
  adjective = '����������/1��' '����������/1��' '��������/1��'
  isHer = true
  ldesc = "������� �������� ���� ������������, ������� ����������� ���������� ����� ������ ������� � �������� ����������. �������� ����������� ������� ��, ����� ������� ���� ��� ����� ����� � �������� � ���� ������. ������ �� ���� ������������ ������� �������� �����, �������� ������������� ����������. "
  verDoShoot(actor) = "������� ����� �������, �������� ������� ������������ ������, �� ������������� ��� �������������."
;


mapDecoration : decoration
  location = edgeroom
  isHer = true
  desc = '��� �����/1� �����'
  noun = '�����/2' '�����/1�' '��������/1�' '�������/2' '������/1�' '�������/1�' '�������/2' '�����/1�' '�����/1�' '����/2' '�����/1�' '������/1�' '������/2' '������/2'
  adjective = '���������/2�'
;

edgemap : Actor
   location = edgeroom
   desc = '�����/1�'
   noun = '�����-���/1�' '�����/1�' '���/1�' '�����/1�'
   isHer = true
   ldesc = { 
   show_image('table.jpg');
   "����� ����� ������, �������� ��� ������������ ����� �� ������. �� ����� ������� ����������, � ��������������� ���������, �������� ��������������. ����� ���������� ��������� ����� �������������� � ����������� � ������ ������ ������. ���� ����� ����� �������� ���������� � �������. ";}
   actorDesc = "[|����� � ������ �������������� ����� �� ���� ��� ����� ��������./����� � ������ ������������� �� ��������� ������ � ���� ��������� �������./�� ������ � ������ ������������� ������ �������.]"
   verDoRead(actor) = {self.verDoTalk(actor);}
   verDoSearch(actor) = {self.verDoTalk(actor);}
   verDoLookunder(actor) = {self.verDoTalk(actor);}
   verDoLookin(actor) = {self.verDoTalk(actor);}
   verDoTalk(actor) = { if (self.wasWinGame == true) "����� ������ ��������, ������ �� �� �� ��� ������ � �����."; }
   verDoShoot(actor) = {aresa_say('��, ������! ������ ��� ������, ����� ����� � �����������. ����� � ����� ���� �������?');}
   wasInitTalk = nil
   wasWinGame = nil
   nTry = 0
   
   
   doRead(actor) = {self.doTalk(actor);}
   doSearch(actor) = {self.doTalk(actor);}
   doLookunder(actor) = {self.doTalk(actor);}
   doLookin(actor) = {self.doTalk(actor);}
   
   doTalk(actor) = {
      local word_out,res;
      local maxTries = rangernd(10,15);
      if (self.wasInitTalk == nil)
      {
         scen_lvl2_map_talk();
         self.wasInitTalk = true;
         return;
      }
      "- ���� �� ��������� ��� ��� �� ������ ������, �� � ��������. ������ �������� ���� �� ������� �������� �����. ����� ������ �������� �� ��� ���� � ��������� ��� ����� �� ����������� �����. �������� ����� �� �������. ������ ��� ����� ����, ������� ����� �� ������? �������. ���� �� �� ������� ����� ����� ��� ���������, �� ���� �������������, ����� ������� ����� ��� �����������. ���� � �� ����� ����� �����, �� � ��������� � ����� ���� ����. �������!<br>";
      ThreeLetterGame.prepareGame;
      word_out = ThreeLetterGame.getFirstWord;
      "- �� �����: <<word_out>>";
      while (true)
      {
        local resp,res_user;
        "<br>>";
        resp=input();
        if (resp=='���' || resp=='���' || resp=='���')
        {
           "<br>- �� �� ��! ���������� ��������� ������ ������� ����! ������ �� ���� ��������, �� �� ��������� ��� ����� ���� ����� (-5).<br>";
           Me.Hit(nil,5);
           abort;
        }
        res_user = ThreeLetterGame.checkNextWord(resp);
        
        if (length(resp)==0) {
           "- �� ���� �������, ������ ������� �����.";
        }
        else if (res_user==NEXT_WORD_OK)
        {
           word_out = ThreeLetterGame.memWordAndGetOwn(resp);
           if (word_out == '')
           {
               "- �� ���� ������ ���������! �� �������, ��� ���� �������.<br>";
               self.wasWinGame = true;
               ResourceSystem.Add('WIN_MAP_GAME',RESOURCE_AMOUNT_HIGH);
               abort;
           }
           nTry += 1;
           if (nTry < maxTries) {
               "- �������! �� �����: <<word_out>><br>";
           }
           else 
           {
              "- �� ���� ������ ���������, ��� �� ���! �� �������, ��� ���� �������.<br>";
              ResourceSystem.Add('WIN_MAP_GAME',RESOURCE_AMOUNT_HIGH);
              self.wasWinGame = true;
              abort;
           }
        }
        else if (res_user==NEXT_WORD_UNKNOWN)
        {
           "- � �� ���������� ������ �����! ���, ��������� � �������, �� ���� ��� �������. ����� ����� ��� ���������.";
           abort;
        }
        else if (res_user==NEXT_WORD_FAIL)
        {
           "- ���, �� ����� ������������, �� ��� ������ �� �������� �� ��������! ��������� ��� �������...";
           abort;
        }
        else if (res_user==NEXT_WORD_LAST)
        {
           "- �� ��� �� �� ���������� �����! ���� ����������� ������� �������. ����� ��� ��������...";
           abort;
        }
        else if (res_user==NEXT_WORD_ALREADY)
        {
           "- ��� ����� ��� ����! ���� ����� ��� ����� ����������.";
           abort;
        }
     }
   }
   
   verDoTake(actor)="����� ������������ �� �������, ��� ���, ���, ��������� �������������.";
;

/////////////////
secondroom : room
  sdesc="��������� �������"
  lit_desc = '����� ���������� ����� ����� ��������� ��������� ���� � ��������� ���������� � �������, �� ���� ��������� - ��������� �������. ����� ������ ����� ��������� ��������� ��������������� ������������ �������� ��� ������� �� �����. ����� �������� � ��� �� �����. '
  north = thirdroom
  south = edgeroom
  up = {
    if (!musorka._is_moved){
       "������ �� �� ������ ��������� �� �����.";
       return nil;
    }
    else
    {
        //������ �� �����
        scen_lvl2_up_lift();
        Me.travelTo(roofstart);
        //��������� ������� � ������
        "<b>* ��������� ������ - �������</b><br>";
        "<b>* �������� ������ - ��������</b><br>";
        CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
        TorsionGenerator.moveInto(Me);
    }
  }
  listendesc = "������� ����� �������� ����� ������ � ������� �����."
;

streetDecoration : decoration
  location = secondroom
  isHer = true
  desc = '��� �����/1� �������'
  noun = '�����/1�' '�����/1�'
;

ecoDecorDecoration : decoration
  location = secondroom
  isHer = true
  desc = '��� ������/1�'
  noun = '������/1�' '��������/1�' '�������/1�' '������/1�' '�����/2' '����/1�' '�����/1�' '���������/1�' '��������/1�' '���������/2' '���/1�' '����/2'
  adjective = '�������/1��'
;

tramvay_station : decoration
  location = secondroom
  desc = '���������/1� �������'
  noun = '���������/1�' '������/2' '�����/1�' '��������/1�' '�����/1�' '�������/1�' '����/1�'
  isHer = true
  ldesc = "��� �� ��� �������� ��� ����� ��������� ������ ����� ������� � ����������� ������? ��������, � ������� ��������� ������� ������ �������� ������, �������� ������ �����, ����� ��������� ����� � ������ ���� ����������� ���������� ������. �� ��������, ���� � ���������� ������ ��������� ��������� � ������� ��������� ������������� ���������. "
;

right_side : FunnyClibDecor
  location = secondroom
  desc = '������/1�� �����/1�'
  noun = '�����/1�' '��������/1�' '������/1�' '�����/1�' '�����/1�'
  adjective = '������������/1��' '������/1��'
  isHer = true
  ldesc = "���������, ��� �� ��������� ����� �� ����������, � � ������������, �� ������� ��������� �����, ������� �� ����� � ������� �������� �����. ���������� ���-�� ����� ������������� ������� ������, ����� �����������. "
;

mon1 : SimpleFireMon
   desc = '�������������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 5
;


mon2 : SimpleFireMon
   desc = '�������������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 7
;


mon3 : SimpleFireMon
   desc = '��������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 10
;

musorka : fixeditem, surface
   desc = '��������/1�'
   noun = '��������/1�' '���������/1�' '���������/2' '������/1�'
   adjective = '������������/1��' '���������������/1��' '������������/1�'
   isHer = true
   ldesc = { 
      "��� ������������ ���������� ���������� ������� �����, �������� � ��������� ���������. ��� ������� ���������� ������ �� ���������. ";
      if (lom.location!=self) " �������, ������-��, �����������.";
   }
   location = secondroom
   _is_moved = nil
   ioPutOn(actor, dobj) =
   {
      if (dobj == lom)
      {
         //"�� ���������� ���������";
         lom.isfixed = true;
		 dobj.doPutOn(actor, self);
         self._is_moved = true;
         edgeMachine.startJoke = true;
      }
      else "�������� �� ��������� ��� �������� ���.";
   }
   verDoStandon(actor) = {if (!self._is_moved) "�� ������ �� ������ ������ �� ���������."; }
   doStandon(actor) = { 
     //������ �� �����
     scen_lvl2_up_lift();
     Me.travelTo(roofstart); 
     //��������� ������� � ������
     "<b>* ��������� ������ - �������</b><br>";
     "<b>* �������� ������ - ��������</b><br>";
     CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
     TorsionGenerator.moveInto(Me);
   }
;

power_lines : decoration
  location = secondroom
  desc = '�������/1�� �����/1�'
  noun = '�����/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "������������ ������� � �������, ���� ����� ������������ ����������� � �������������, ����������� ���� ���������, ��� ����, ���� �� �������������, �� �� ����� ���������� ����������� � ���-������������ ������. "
;

roof_far : distantItem
  location = secondroom
  desc = '�����/1�'
  noun = '�����/1�' '����/1�' '������/1�'
  isHer = true
  ldesc = "���� ����� ������������� � ������� ��������� �� �����. ���-�� ������ �� ������� ������, ������������ ������ �� ��������. ��������� ������������ ���."
;

//////////////

thirdroom: room
   sdesc="����� ������� ��������"
   lit_desc = '���������� ���������������� ����� ��������� �������� �����, ����������� �� ������� ������������ �������. ������ ����� ������� ���������� - ��������� ��������� ���������� ������������ �� ������� �����. �� ������ ��������� ��������� �������� �����. ��������� ����� �� ��.'
   south = secondroom
   north = {
     fly_lot_demons.ldesc;
     return nil;
   }
   _field_size = 20
   _pl_pos = 10
   listendesc = "������ �������� ���� �������."
;

ecoDecorThirdDecoration : decoration
  location = thirdroom
  isHer = true
  desc = '��� ������/1�'
  noun = '����/2' '����/1�' '����/2' '����/1�' '����/1�' '������-�����/1�' '������-������/2' '�������/1�' '��������/2' '������/1�' '�������/2' '�������/1�' '�������/2' '�����/2' '����/1�' '�������/1�' '����������/1�' '������/1�' '������/1�'
  adjective = '�������������/2�' '�������������/1��' '��������������/1��'
;

big_towers : FunnyClibDecor
  location = thirdroom
  desc = '����������������/1�� �����/1�'
  noun = '�����/1�' '������/1�' '�����/1�' '�������/1�' '���������/1�'
  adjective = '����������������/1��' '������������/1��' '�������/1��'
  isHer = true
  ldesc = "������� �������. �������� ��� ������� ���� � �������������� ������-������, � ������� �����. ��������� ������-������ � ��������, �� �������� �������� �������� �������������� �������� ������ ���������."
;


kalian_home : decoration
  location = thirdroom
  desc = '���������/1�'
  noun = '���������/1�' '������/1�' '������/1�' '�������/1�'
  adjective = '����������������/1��'
  isHer = true
  ldesc = "��������� �����, ���������� ��������. � ������� ����� ������� ����� � ���������� ������� ���� ������������ ������ �������, �� ���������� ��� ��������� � �������� ������. �� ������ � ����������� ������ ������� ����� ���������, � ��������� ������ ������� ������ �� ��������������� ��������. ������ ������ ����������. "
;

sliz_home : decoration
  location = thirdroom
  desc = '�������/1�� �����/1�'
  noun = '�����/1�' '�������/1�' '������/2' '������/1�'
  adjective = '�������/1��'
  isHer = true
  ldesc = "����� �� ���� ��������� �������� ����������� �������, ���������� �������� �����-������ ������� �������. ������ ����� ���������� �������� � ����� � ���������, ���������, �� ������� �� ����� � ��� ��������� - �������� ������ ���. ����, ����� �� ���� ��-�������..."
;


fly_lot_demons : decoration
  location = thirdroom
  desc = '��������/1�� ������/1�'
  noun = '������/1�' '�������/1�'
  adjective = '��������/1��'
  isHer = true
  ldesc = "������� �� ���! ����� �����! �������� ����� ����-����, ������� ������. ��, ���-�� ��������� �������. � �� ������� ����� �� ����, ���� �� ������ ��� ������� ����������."
  verDoShoot(actor) = { aresa_say('��� ���� ����� ��� ������������! �� ��� ����, ���� ������������, �������.'); }
;

mon4 : SimpleShooter
   desc = '��������/1��� �������/1��'
   location = nil
   isHim = true
   _pos = 20
;


mon5 : SimpleTrooper
   desc = '��������/1��� ���������/1��'
   location = nil
   isHim = true
   _pos = 0
;

lom : item
   desc = '���������/1�'
   noun = '���������/1�' '����/1�' '�����/1�'
   ldesc = "����, ������ ������������ ���������� ��������������� ���, �������� � ��������� ������� �� ���������� ����������. � ����� ������� ������ ����������� �������� ��� ������ �� ������������ ��������."
   location = thirdroom
   isHim = true
   have_try = nil
   verDoTake(actor) = {
     if (HaveMonsters(self.location)) "��� ��������� ����� ������ ��� ����� ����!";
   }
   doTake(actor) = {
     if (!self.have_try)
     {
        self.have_try = true;
        scen_lvl2_see_demons();
        mon1.moveInto(secondroom);
        mon2.moveInto(secondroom);
        mon3.moveInto(secondroom);
        mon4.moveInto(thirdroom);
        mon5.moveInto(thirdroom);
        return;
     }
     pass doTake;
   }
   verDoStandon(actor) = {if (self.location != musorka) aresa_say('�� ���� ������� ���������? ������� �������� �� ��� � ������ �����?'); }
   doStandon(actor) = { musorka.doStandon(actor); }
   verDoShoot(actor) = { aresa_say('�����, ��������� ��� ����������, ��� ����� ���������� �� ������.'); }
;

////////////
roofstart: room
   sdesc="�����, ��� �����������"
   lit_desc = '���������� ���� ��������� �����, ������� ��� ������� � �������� � ��������� ������������.'
   north = roofglass
   east = roofhigh
   _field_size = 4
   _pl_pos = 0
;

roof_near : decoration
  location = roofstart
  desc = '�����/1�'
  noun = '�����/1�' '����/1�' '����/1�' '������/1�' '������/1�' '������/1�'
  adjective = '����������/1��'
  isHer = true
  ldesc = "���� ����� ������������� � ��������� � ���� �����. �������� ��������, ��� ����� ������ �� �����-�������, ������ ������� �� ������."
;

/////////////////

roofglass: room
   sdesc="���������� �����"
   lit_desc = '��� � ���� ����� ����������, �� ������������. ����� ������ �� ����� ��� �� ��.'
   north = roofdarkkorner
   south = roofstart
   _field_size = 10
   _pl_pos = 2
   ownFloor = true
;

stek_floor : decoration
  location = roofglass
  desc = '����������/1�� ���/1�'
  isHer = true
  ldesc = "������������ ����������� �� ��������� ����� �������, ������ ����� �������������. "
  verDoShoot(actor) = "�� ����� ����."
;

mon_roofglass1 : SimpleShooter
   desc = '�������/1�� �������/1��'
   location = roofglass
   isHim = true
   _pos = 10
;


mon_roofglass2 : SimpleTrooper
   desc = '��������/1�� ���������/1��'
   location = roofglass
   isHim = true
   _pos = 1
;


class roofUnbloker : Button
   isListed = true
   desc = '�������/1�� �����/1�'
   noun = '�����/1�' '�������/1�'
   ldesc = "������� ����� � �������� \"������������� �����\". ���� �� �����, ���������� ��������� ������� ������ � ������."
   isHim = true
   isActivated = nil
   activate = {
     "����� ��������� �� ����� � �������� ������.";
     self.isActivated = true;
   }
   verDoPush(actor) = { if (self.isActivated) "����� ��� �����!"; }
   doPush(actor) = { self.activate; }
;

firstUnblocker : roofUnbloker
  location = roofdarkkorner
;

mon_roofdarkkorner1 : SimpleTrooper
   desc = '����������/1�� ���������/1��'
   location = nil
   isHim = true
   _pos = 0
;

//mon_roofdarkkorner2 : SimpleTrooper
//   desc = '������/1��� ���������/1��'
//   location = roofdarkkorner
//   isHim = true
//   _pos = 0
//;

//mon_roofdarkkorner3 : SimpleTrooper
//   desc = '������/1��� ���������/1��'
//   location = roofdarkkorner
//   isHim = true
//   _pos = 0
//;

///////////////////////////

roofdarkkorner: room
   sdesc="Ҹ���� ����"
   lit_desc = '���� ���� ����� ������ ����� �������, ������ ���-���� ����������, ������ ����� �� ������ ��� �� ��.'
   east = roofgarden
   south = roofglass
   _field_size = 5
   _pl_pos = 5
;

///////////////////////////

roofgarden: room
   sdesc="��������� �� �����"
   lit_desc = '���� ��������� ����� ��������� �� �������������� �����������, ����� ������ ������ � ������. ������ ��� � ������ �� ������.'
   east = roofelevator
   west = roofdarkkorner
   _field_size = 4
   _pl_pos = 0
;

sadik_roofgarden : decoration
   location = roofgarden
   desc = '�����/1�'
   noun = '�����/1�' '���/1�' '������/1�'
   adjective = '���������/1��' '���������/1��'
   isHim = true
   ldesc = { if (rain_dron.location == roofgarden) "����� ����� ���������� ������ ����� �������� ��������� ������������ �����.";
             else "������ ������ ������� �����, ���������, ������� �� ����� ��������� ��� ����������? ���, ������ ������������� ������, ����� ���� ����� ��������� ����� ��������� � ������� �� ��� ����, ����������� �� � ���.";
   }
;

rain_dron : DestructItem
   isListed = nil
   resAmount = RESOURCE_AMOUNT_MID
   location = roofgarden
   desc = '�����������/1�� ����/1�'
   noun = '����/1�' '�����/1�'
   adjective = '�����������/1��'
   isHim = true
   ldesc = "�� ��� �� ����������� ����! �������� ����� � ��������. �������, ��� ������-����� ����� �� �������. ����� ��������, �������� ��������� ���-�� ��������."
;


roofLiftButton : Button
   desc = '������/1�'
   ldesc = "������ ������ �����."
   isHer = true
   wasHitButton = nil
   location = roofelevator
   verDoPush(actor) = { if (!firstUnblocker.isActivated || !secondUnblocker.isActivated) "�� ��������, ������� �� ������������!"; }
   doPush(actor) = { 
      if ( self.wasHitButton == nil)
      {
         "��� ������ �� ���������� ������ ������ ��� ����� �������. ���-�� ������� ���������� ������ �������� ������ � ���������� ������ ������.";
         mon_roofdarkkorner1.moveInto(roofdarkkorner);
         firstUnblocker.isActivated = nil;
         self.wasHitButton = true;
      }
      else
      {
         edgeMachine.startJoke = nil;
         Me.Heal;
         "�� ������ ������ � �������� ������ ������ ���� ����. ������ ��������� ����� ����������� �������. ���� �������� � �������������� �������� ������! ������� ���� ���������� �� �������� � ������ �������-�������� ����������� �� ���������� ���������� � ���� ��������� � ����������� ��������� �����-���� � �������� �����. <br>";
         "- ���, ��� ����� �������� �����������, ����� ��� ��! ��������� ��� �� ���������, ���� ������ ������� �� ������ � ������������ ������� ���� �� ���������� ���� �������. ���, �� �� �� �� ������� �����������, � ��� ���� ���������! �����, �� �� ������� ���� �� ����� ����������. �������� ������������ �� �������� ���� ������ ����� ������������ � ���, ����� ��������, � ����������. ����� ������������ �� �����, ����� �� ��� �������.<br>";
         "<b>* �������� ������ - ������������</b><br>";
         "<b>* �������� ������ - �����������</b><br>";
         "<b>* �������� ������ - ��</b><br>";
         
         CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
         CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
         CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
         Me.travelTo(elevetorDownRoom); 
         //win();
      }
   }
;

mon_roofelevator1 : SimpleShooter
   sdesc = "����� �������"
   rdesc = "������ �������"
   ddesc = "������ �������"
   vdesc = "������ �������"
   tdesc = "����� ��������"
   pdesc = "������ �������"
   noun = '�����' '������' '�����' '������' '�������'
   location = roofelevator
   isHim = true
   _pos = 4
;

mon_roofelevator2 : SimpleFireMon
   desc = '������������/1��� �������/1��'
   location = roofelevator
   isHim = true
   _pos = 2
;

///////////////////////////

roofelevator: room
   sdesc="����"
   lit_desc = '�������� ����� � ������� �� �����. ���� ����� �� ����� ��� �� ��.'
   west = roofgarden
   south = roofmaterials
   _field_size = 4
   _pl_pos = 0
;

ploshadka_lifta : fixeditem
  location = roofelevator
  desc = '��������/1�'
  noun = '��������/1�' '����/1�'
  ldesc = "�������� ��������, �������, ����� ������ ������ � ��������. �� ������ ������ �� ���."
  verDoBoard(actor) = { self.verDoSiton(actor); }
  verDoStandon(actor) = { self.verDoSiton(actor); }
  verDoSiton(actor) = {aresa_say('�� ��� ����� �� ��������, ����� ���� �������� �� ��?');}
  verDoLieon(actor) = {aresa_say('����� ������ �� ��������? ��� ������� ����� ��������� ���������� ��� ������ ����?');}
;


///////////////////////////

roofmaterials: room
   sdesc="������������� �����"
   lit_desc = '����� ��������, ��� ��������� ������ ������, ����� ��������� ����������� � �������. ���������� ����� � ��� �� �����.'
   north = roofelevator
   south = roofadvert
   _field_size = 8
   _pl_pos = 0
;

mon_roofmaterials1 : SimpleShooter
   desc = '��������/1��� �������/1��'
   location = roofmaterials
   isHim = true
   _pos = 6
;

//mon_roofmaterials2 : SimpleShooter
//   desc = '������/1��� �������/1��'
//   location = roofmaterials
//   isHim = true
//   _pos = 6
//;

//mon_roofmaterials3 : SimpleShooter
//   desc = '������/1��� �������/1��'
//   location = roofmaterials
//   isHim = true
//   _pos = 6
//;

instruments_all : decoration
   location = roofmaterials
   desc = '�����������/2'
   noun = '�����������/2' '����������/1�'
   isThem = true
   ldesc = "�� �������� � ��� ��� �� �������. ���� ���� �������������� ������������ ������, ������� �������� ������������ � ����������� �������������� ������."
;

hoduli_instr : decoration
   location = roofmaterials
   desc = '��������������/2� ������/2'
   noun = '������/2'
   isThem = true
   ldesc = "��������� ������ � ���������������� � ���������� ��� ���. ��� ��� ����������."
;

exzo_instr : decoration
   location = roofmaterials
   desc = '����������/1�'
   noun = '����������/1�' '������/1�'
   isHim = true
   ldesc = "������ ��� �����������, ������ ������ ����������� � ���������� ���� ����� � ���������. ������������ ������."
;

stanok_instr : decoration
   location = roofmaterials
   desc = '��������������/1�� ������/1�'
   isHim = true
   ldesc = "��� �������� ����������� ��������� ����������. ������ �� ������� ���������� � ���������� ��� �������, � ���������."
;

secondUnblocker : roofUnbloker
  location = roofadvert
;

///////////////////////////

roofadvert: room
   sdesc="������� �������"
   lit_desc = '���� ���� ����� ���� �������, ��� ������� �������� �������� ������� ��������� �������. ������ ��� � ������ �� �����.'
   north = roofmaterials
   west = roofhigh
   _field_size = 4
   _pl_pos = 0
;

reklama : FunnyClibDecor
   location = roofadvert
   desc = '��������/1�� �������/1�'
   noun = '�������/1�' '�������/1�' '�������/1�'
   adjective = '��������/1��' '��������/1��' '��������/1��'
   isHer = true
   ldesc = "������� ��� ��� ������, ������� ������ ��� ������ �� ��������� ��������. � ������ ������� ��������� ������� ��������, � ��� ���� �� �� �� ������ ����. "
   verDoShoot(actor) = {aresa_say('�� ����� ������� ���-������, ��� � ������ ������ �������.');}
;

///////////////////////////

roofhigh: room
   sdesc="�������������"
   lit_desc = '��� ������� ����� ����� �������, ������ ����� ������� ����� ������ ���� � �����, � ����� ����� �������� ��� ����. ����� ���������� �� ����� ��� �� ������.'
   east = roofadvert
   west = roofstart
   _field_size = 4
   _pl_pos = 0
;


center_far : distantItem
  location = roofhigh
  desc = '�����/1�'
  noun = '�����/1�' '�����/1�' '������/1�'
  isHim = true
  ldesc = "�������������� ������. �������� ���������������� ������ ����������, �������� ���������� ������� � ���������� ������, ���� ����� ���� ����� ������������. ��������� ���� ��������� � ��������� ������ ���������� � ���������� �����������. ����� ���������� �� �����, ����� ��������� ����� ���������. "
;

center_farDecoration : decoration
  location = roofhigh
  isHer = true
  desc = '��� �����/1� �������'
  noun = '������/1�' '������/1�' '�����/1�' '�����������/1�'
         '������/2' '�������/2'  '�����/2'
          
  adjective = '��������������/1��' '����������/2�'
;

pereulok_far : distantItem
  location = roofhigh
  desc = '��������/1�'
  isHim = true
  ldesc = "�������, ���� ��������� ������ �� ���������. � �������, ��� ��� ���� �� ����������. "
;


ant_roofhigh : DestructItem
   location = roofhigh
   desc = '��������/1�� ����/1�'
   noun = '����/1�' '�������/1�'
   adjective = '��������/1��'
   isHim = true
   ldesc = "�������� ����, � ����� ������������ � ����������� �����������. "
;

///////////////////////////

elevatorDecor : decorationNotDirect
  location = elevetorDownRoom
  isHim = true
  desc = '���� ������/1�'
  noun = '����/1�' '�����/2' '��������/1�' '���������/2' '��������/1�' '�������/1�' '�����/1�' '�����/2' '�������/1�' '��������/2'
  adjective = '����������/1��' '����������/2�' '��������������/1��' '��������/1��' '���������/1��'
;

elevatorLifter : distantItem
  location = elevetorDownRoom
  isHim = true
  ldesc = "�� ����� �����, ������ ������ �����������."
  desc = '�����/1�'
  noun = '�����/1�' '�������/1�' '�����-�������/1�'
  adjective = '����������/1��'
;

elevetorDownRoom : room
   sdesc="�� ���������� �����"
   listendesc = "������ ������� ���� ��������� ���������."
   ldesc = {
      local curr_lvl = self.liftLvlCurr[self.currLift];
      local pos1 = self.liftLvlCurr[1]; 
      local pos2 = self.liftLvlCurr[2]; 
      local pos3 = self.liftLvlCurr[3]; 
      if (self.currLift == 1) "�� �� ������ <<curr_lvl>>. �������� ���� �� ������ <<pos2>>.";
      else if (self.currLift == 2) "�� �� ������ <<curr_lvl>>. �������� ���� �� ������ <<pos3>>. ��������� ���� �� ������ <<pos1>>. ";
      else if (self.currLift == 3) "�� �� ������ <<curr_lvl>>. ��������� ���� �� ������ <<pos2>>. �������� �� ������ ������.";
      //"(<<pos1>>, <<pos2>>, <<pos3>>).";
   }
   mayJumpOut = true
   isseen = true
   currLift = 1
   totLift = 3
   liftLvlCurr =[ 5  5  3]     //������� �������
   liftLvlMax = [ 6  7  4]     //������������ ������� ���������� �����
   liftLvlMin = [ 3  4  1]     //����������� ������� ���������� �����
   liftLvlDir = [ 1  0  1]    //����������� �������� �����
   //�����
   out = {
     return self.west;
   }
   west = {
      local curr_lvl = self.liftLvlCurr[self.currLift];
      if ( self.currLift == 3 )
      {
         if (curr_lvl==1)
         {
            scen_lvl2_see_madam();
            show_image('dama.jpg');
            edgeMachine.startHit = nil;
            Me.travelTo(lifterroom);
         }
         else
         {
            "�� ������������ ���� ��������� ������� �����.";
            die();
         }
      }
      else 
      {
         local next_lvl = self.liftLvlCurr[self.currLift+1];
         if (curr_lvl==next_lvl)
         {
            "�� ������������ �� ������ ����!";
            self.currLift+=1;
         }
         else
         {
           "�� ������������ ���� ����� � ����� � �����!";
           die();
         }
      }
      return nil;
   }
   //������
   east = {
      local curr_lvl = self.liftLvlCurr[self.currLift];
      if ( self.currLift == 1 )
      {
         "�� ������������ ���� ��������� �������� �����. ������� ���� ������...";
         die();
      }
      else 
      {
         local next_lvl = self.liftLvlCurr[self.currLift-1];
         if (curr_lvl==next_lvl)
         {
            "�� ������������ �� ������ ����!";
            self.currLift-=1;
         }
         else
         {
           "�� ������������ ���� ����� � ����� � �����!";
           die();
         }
      }
      return nil;
   }
   down={aresa_say('��� �� ��������� ����?'); return nil;}
   up={aresa_say('��� ����� �� ������� ������!'); return nil;}
;

//////////////
//������� �������

lifterroom: room
   sdesc="�����-��������"
   lit_desc = '������������� ��� ������� ��������� ���������� � ������������� ������� ������ �����. �������� ����� ������� �������������� ������������ ��������. ��������� ��������� ��� ������ ������ �� �����, ������ �������������� ������� �� ����� �������. '
   north = {
      if (HaveMonsters(lifterroom)) aresa_say('�������� ��, �� ��� ���������� ����, ���� �� ��� ���������.');
      else
      {
         Statist.Show(2);
         "<i>(��� ����������� ������� ����</i>)<br>";
	     input();
         scen_lvl2_final();
         "<i>(��� ����������� ������� ����</i>)<br>";
	     input();
         resourceSaveToGlobal();
         prepareLevel3();
         return startcor_room;
         //win();
      }
   }
;

liftRoomNonDirectDecor : decorationNotDirect
  location = lifterroom
  isHer = true
  desc = '��� �����/1� ���������'
  noun = '��������/1�' '���������/1�'
  adjective = '�����/1��' '������������/1��'
;

liftDecor : decoration
   location = lifterroom
   isHer = true
   desc = '��� �����/1� ��������'
   noun = '�������/1�' '�����/1�' '�����/1�' '�������/1�' '�������/1�' '�������/1�' '�������/1�' '���/1�' 
          '�������/2'  '�����/2'  '�����/2' '�������/2'  '�������/2' '��������/2'   '�������/2'  '����/2' 
          '����/1�' '������/1�' '�������/1�'
   adjective = '�������������/1��' '���������������/1��' '������������/1��' '���������/1��' '���������/1��' '��������������/1��' '��������������/2'
;


/////////////
////////////////////////////////////
// ������ ��������� ��� ����� ���������
edgeMachine : StateMachine
   lastSt = 0
   st = 0
   lastStoryTurn = 0
   lastUserLoc = nil
   stateWithMon = 0
   startHit = nil
   startJoke = nil
   nextTurn={
     if ((self.currTurn >= 0) && (self.st == 0)) {
        self.st = 1;
        Me.Heal;
     }
     else if (self.st >= 1 && self.st < 3 && (Me.location==elevetorDownRoom))
     {
       //��������� � ���������� ���������, ����� �������� �����
       self.st += 1;
     }
     else if (self.st == 3 && (Me.location==elevetorDownRoom))
     {
        //��������� � ���������� ���������, ����� �������� �����
        aresa_say('��� ������! �� ��� ���-�� ��������, ������� �����-�������. ����� ��������� �� �������� ����� � �� ������ ����� �������, ����� ������ � ������� �������!');
        self.startHit = true;
        self.st = 10;
     }
       
     //����� ���������, �� �������� ����������� �������� � �������
     if (self.startJoke)
     {
       if ( (Me.location == self.lastUserLoc) && (HaveMonsters(Me.location)) )
       {
          local mon_list, new_loc,i;
          self.stateWithMon += 1;
          if (self.stateWithMon==3)
          {
             //���������� �������� �� ������� � ���������
             mon_list = GetMonsterList(Me.location);
              
             if      (Me.location == roofstart) new_loc=roofglass;
             else if (Me.location == roofglass) new_loc=roofgarden;
             else if (Me.location == roofgarden) new_loc=roofdarkkorner;
             else if (Me.location == roofdarkkorner) new_loc=roofhigh;
             else if (Me.location == roofhigh) new_loc=roofelevator;
             else if (Me.location == roofelevator) new_loc=roofmaterials;
             else if (Me.location == roofmaterials) new_loc=roofadvert;
             else if (Me.location == roofadvert) new_loc=roofstart;
             else new_loc = Me.location;

             for (i=1;i<=length(mon_list);i++)
             {
                mon_list[i].travelTo(new_loc);
                mon_list[i]._pos = 0;
             }
             "<br>[|-���� �������!/-������ ������ ����!/-���� �������?]<br>";
             self.stateWithMon = 0;
          }
       }
       else
       {
          self.stateWithMon = 0;
       }
     }
     
     if (Me.location==elevetorDownRoom)
     {
        local i;
        for (i=1;i<=elevetorDownRoom.totLift;i++)
        {
           local cur_lvl = elevetorDownRoom.liftLvlCurr[i];
           if (elevetorDownRoom.liftLvlDir[i]==1) {
              cur_lvl += 1;
              //�������� � �����
              if (cur_lvl==elevetorDownRoom.liftLvlMax[i]) {
                 elevetorDownRoom.liftLvlDir[i] = 0;
              }
           }
           else if (elevetorDownRoom.liftLvlDir[i]==0) {
              cur_lvl -= 1;
              //�������� � ���
              if (cur_lvl==elevetorDownRoom.liftLvlMin[i]) {
                 elevetorDownRoom.liftLvlDir[i] = 1;
              }
           }
           
           elevetorDownRoom.liftLvlCurr[i] = cur_lvl;
        }
        elevetorDownRoom.ldesc;
     }
     
     if (self.startHit==true)
     {
       Me.Hit(lifter_gost,rangernd(0,3));
     }
     
     
     self.lastUserLoc = Me.location;
     
     self.currTurn = self.currTurn+1;
   }
;