#define USE_HTML_STATUS
#define USE_HTML_PROMPT

#define IDS_VERSION_NUM '1.5'

//��������� �����������
#define GENERATOR_INCLUDED
#include <advr.t>
#include <stdr.t>
#include <errorru.t>
#include <extendr.t>
#include <generator.t>
#include <math.t>
#include "patcher/index.t"

#include <statemachine.t>
#include <tmorph.t>

#include <statist.t>
#include <api.t>
#include <monster_classes.t>
#include <weapon_classes.t>
#include <combo_classes.t>
#include <areca.t>
#include <craft_obj_classes.t>
#include <craftsystem_menu.t>
#include <verbs.t>

#include <scenario.t>
#include <main_menu.t>
#include <run_auto_verb.t>

#pragma C++



replace sleepDaemon: function(parm)
{
}

replace eatDaemon: function(parm)
{
}

replace version: object
    sdesc = {
        "\b\t<font size='+3' color='blue'><b>����� �����. ������ 1.</b></font><br>";
        "<b><font size='-1' color='#7F2AFF'>������ " ;say (IDS_VERSION_NUM);"</font></b>\b\b";
        "\b<br>";
        show_image('cover.jpg');
    } 
;

replace scoreRank: function
{
    " � ����� �� "; say(global.turnsofar);
    " ���<<numok(global.turnsofar, '','�','��')>>, �� �������� ����� � ";
    say(global.score); " ������<<numok(global.score, '�','�','')>>.";
}

replace introduction: function
{
}


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
    
    parserGetMe().location = startroom;     //  ����������� ������ � ���������
    //��������� ����� ����� �� ������ ��������� ������ ����� � ������ ��������
    if (global.curr_level==1) prepareLevel1();
	else if (global.curr_level==2) prepareLevel2();
    else if (global.curr_level==3) prepareLevel3();
    else if (global.curr_level==4) prepareLevel4(); 
    
    if (parserGetMe().location==startroom) {
      parserGetMe().location.lookAround(true);  // �������� ������, ��� �� ���������
      parserGetMe().location.isseen = true;     // ��������, ��� ������� ���� �������
      scoreStatus(0, 0);                        // ���������������� ����������� �����
    }
    randomize();			  // ���, ���� ����� ����������� � ����
}


replace commonInit: function
{
	"\H+"; 
    setOutputFilter(morphFilter);	
    //debugTrace(1,true);
}

replace die: function
{
    "\b*** ��� �����! ����������� ��� ���. ***\b";
    //scoreRank();
    "\b��������: ������������ ����������� ����, ������ ������� ������ ��� �����.\n";
    while (true)
    {
        local resp;

        "\n����������, ������� ������������, ������ ��� �����: >";
        resp = upper(input());
        resp = loweru(resp);
        if ((resp=='restore') || (resp=='������������') || (resp=='���������') )
        {
            resp = askfile('���� ��� ��������������:',
                            ASKFILE_PROMPT_OPEN, FILE_TYPE_SAVE);
            if (resp == nil)
                "�������� �� �������. ";
            else if (restore(resp))
                "�������� �� �������. ";
            else
            {
                parserGetMe().location.lookAround(true);
                scoreStatus(global.score, global.turnsofar);
                abort;
            }
        }
        else if ((resp == 'restart') or (resp=='������'))
        {
		    createRestartParam();
            scoreStatus(0, 0);
            restart(initRestartStartLevel,global.restartParam);
        }
        else if ((resp == 'exit') || (resp=='�����'))
        {
            terminate();
            quit();
            abort;
        }
    }
}

win: function
{
    "\b*** �� ��������! ***\b";
    
    "��� ��������� ��������� �������, ������� ��� \"���������������\" � ������ ������� ������. ���������� ������� ����������� � ������� ����������� �������� � ����� �������������� ����������! \b";
    
    //scoreRank();
    "\b��������: ������������ ����������� ����, ������ ������, �����.\n";
    while (true)
    {
        local resp;

        "\n����������, ������� ������������, ������ ��� �����: >";
        resp = upper(input());
        resp = loweru(resp);
        if ((resp=='restore') || (resp=='������������') || (resp=='���������') )
        {
            resp = askfile('���� ��� ��������������:',
                            ASKFILE_PROMPT_OPEN, FILE_TYPE_SAVE);
            if (resp == nil)
                "�������� �� �������. ";
            else if (restore(resp))
                "�������� �� �������. ";
            else
            {
                parserGetMe().location.lookAround(true);
                scoreStatus(global.score, global.turnsofar);
                abort;
            }
        }
        else if ((resp == 'restart') or (resp=='������'))
        {
            scoreStatus(0, 0);
            restart();
        }
        else if ((resp == 'exit') || (resp=='�����'))
        {
            terminate();
            quit();
            abort;
        }

    }
}


modify global
   curr_level = 0
   need_move = nil
   input_mode = INPUT_MODE_FULL
   enemy_mode = ENEMY_MODE_FULL
   music_volume = 30
   sound_volume = 70
   play_battle_music = nil
   level_play_music = nil
   stop_auto_music = nil //������� ������ ������
   restartParam = []
   is_easy = nil //(true) - ����� ������� ���������, nil - ����������
;


replace turncount: function(parm)
{
   //������ �� ������ � ������ �������
   if (Me.location==startroom) return;
   //�� ������������� turncount
   incturn();
   global.turnsofar = global.turnsofar + 1;
   scoreStatus(global.score, global.turnsofar);
   if (global.need_move)
   {
      //������� ���� ��� ����� ������ �������� �� �������
      if (Me.location.see_mon==nil) Me.location.see_mon = true;
      //����� ��������� ��� (������������ ���������� ������)
      monsterTurn(Me);
   }
   
   //������ ��� ���������� �������
   if (global.stop_auto_music == nil) {
       if (HaveMonsters(Me.location) && (global.play_battle_music==nil))
       {
          local battle_music=['ANtarcticbreeze_-_Fighter__Extreme_Sports_.ogg' 'Plastic3_-_Extreme_Sport_Energy.ogg' 'Soundatelier_-_New_Style__Instrumental_.ogg'];
          global.play_battle_music = true;
          stop_music_back();
          play_music_loop(battle_music[rand(length(battle_music))]);
       }
       else if (!HaveMonsters(Me.location) && (global.play_battle_music==true))
       {
          global.play_battle_music = nil;
          stop_music_back();
          play_music_loop(global.level_play_music);
       }
   }
   
   //�������� ���������������
   if (RunAutoVerb.run_auto == true) {
	  if (global.curr_machine != nil) global.curr_machine.nextTurn;
      RunAutoVerb.processNextCmd;
   }
}


//��������� ������ � ������� ������, � ����������� ���������� ������
play_music : function(file){
   local sound_str;
   sound_str = '<SOUND SRC="../res/' + file + '" LAYER=BACKGROUND VOLUME=' + cvtstr(global.music_volume) + ' >';
   say(sound_str);
}

play_sound : function(file){
   local sound_str;
   sound_str = '<SOUND SRC="../res/' + file + '" LAYER=FOREGROUND VOLUME=' + cvtstr(global.sound_volume) + ' >';
   say(sound_str);
}

//��������� ������ � ������� ������, � ����������� ���������� ������, � �����
play_music_loop : function(file){
   local sound_str;
   sound_str = '<SOUND SRC="../res/' + file + '" LAYER=BACKGROUND VOLUME=' + cvtstr(global.music_volume) + ' REPEAT=LOOP>';
   say(sound_str);
}

//���������� ������� ������
stop_music_back : function(){
   say('<SOUND CANCEL=BACKGROUND>');
}

//�������� �����������
show_image : function(file){
   local sound_str = '<br><IMG SRC="../res/' + file + '"><br>';
   say(sound_str);
}

aresa_say : function(text){
  "<i>�<<text>></i><br>";
}

modify thing
  verDoShoot(actor) = {"�� ���������. ���������� ��-�������.";}
  verDoShootWith(actor, iobj) = {"��� ��������� ����������� �����: ������� \<����\> ��� �������� � \<����\>. ����� �������������� ������� ��������� ������.";}
  verDoUse(actor) = {"�� ������ ������������ ������ ������������� ��������.";}
  verDoChmok(actor) = {aresa_say('�� ���� ���������� ������? � �� ���!');}
  verDoClean(actor) = {aresa_say('������ ������ � ������� �������, �� ����� ������� �����.');}
;

modify Monster
   verDoShoot(actor) = {
      if (actor.sel_weapon.isCloseCombat)
      {
         if (actor.location._pl_pos!=self._pos){
            "� ��� ������ �������� ���, �� ����� ���������� �� �������!";
         }
      }
      else if (actor.sel_weapon._bullets<=0)
      {
         "<br>������������ ��������!<br>";
      }
   }
   doShoot(actor) = {
      if (shootMonster(actor,self) == nil)
      {
         "<br>��� ����������� ����������!<br>";
      }
   }
   actorDesc =
   {
        local dist = self._pos - self.location._pl_pos;
        if (self.location.see_mon == true)
        {
            if (HaveMonsters(self.location)) {
                if (dist>0) "�� <<dist>> ������ ������� ��� <<glok(self,'����������')>> <<self.sdesc>> ";
                else if (dist<0) "�� <<-dist>> ������ ������ ��� <<glok(self,'����������')>> <<self.sdesc>> ";
                else "����� <<glok(self,'����������')>> <<self.sdesc>> ";
                " (<<self._hp>>).";
            }
            else
            {
               "����� <<glok(self,'����������')>> <<self.sdesc>>.";
            }
        }
   }
;

printFullPrompt: function()
{
   local sel_prn = Me.sel_weapon.shortdesc;
    
   if (Me.sel_weapon.isCloseCombat==true) "\b�����: <<Me._hp>>, ������: <<sel_prn>>";
   else "\b�����: <<Me._hp>>, ������: <<sel_prn>> (<<Me.sel_weapon._bullets>>)";
}

replace commandPrompt: function(code)
{   
    if (global.input_mode == INPUT_MODE_LITE) {
       "\b&gt;";
    }
    else if (global.input_mode == INPUT_MODE_FULL) {
        printFullPrompt();
        "&gt;";
	}
}

modify Me
  sdesc = "��"
  rdesc = "���"
  ddesc = "���"
  vdesc = "���"
  tdesc = "����"
  pdesc = "���"
  isHim = nil
  isThem = true
  lico = 2
  fmtYou = "��"
  fmtToYou = '���'
  fmtYour = '���'
  fmtYours = '����'
  fmtYouve = '���'
  fmtWho = '��'
  fmtMe = '����'
  noun = '����' '��' '���' '���' '����' '���#d' '����#t'
  isOnBeach = nil
  ldesc = { 
    if (self.isOnBeach) {
       show_image('tourist.jpg');
       scen_main_hero_beach();
    }
    else{
       show_image('myself.jpg');
       scen_main_hero(); 
    }
  }
  followList = []
  sel_weapon = NoneWeapon
  _hp = 100
  Heal = {
    "�������� �������������.";
    self._hp = 100;
  }
  verDoTouch(actor) = { aresa_say('������ ������������� ��� ���!'); }
  /*void*/ Hit(who,/*int*/ points) = { //��������� ����� �� �������� ���������� �����
      if (points <= 0) {
         if (global.enemy_mode == ENEMY_MODE_FULL && who!=nil) "<<ZAG(who,&sdesc)>> ����������� �� ���.<br>";
         else if (global.enemy_mode == ENEMY_MODE_SHORT && who!=nil) "0.";
         return;
      }
      if (self._hp <= points) {
         self._hp = 0;
         die();
      }
      else
      {
         self._hp -= points;
         if (global.enemy_mode == ENEMY_MODE_FULL && who!=nil) "<font color='maroon'><<ZAG(who,&sdesc)>> <<who.me_attack_desc>> (-<<points>>).</font><br>";
         else if (global.enemy_mode == ENEMY_MODE_SHORT && who!=nil) "<<points>>.";
         
      }
    }
   actorAction(verb, dobj, prep, iobj) = 
   {
        if ( ( verb.issysverb == true) || ( verb.no_mon_turn == true ) ) {
            global.need_move = nil;
        }
        else
        {
           global.need_move = true;
        }
        
        
        //��������� ���������� ����-�� ���� ����� � �������
        if ( ( verb == boardVerb) || ( verb == sitVerb ) || ( verb == lieVerb ) || ( verb == standOnVerb ) ) {
            if (HaveMonsters(Me.location))
            {
               "���� ����� �����, �� �� ������ ����� �������!";
               exit;
            }
        }
   }
   verDoShoot(actor)={aresa_say('����� ���������� � ���� �����������, ���� �����.');}
;

//���� � ������� ���� ����������� ���, �� ����������� �������� � ��������� �������
modify theFloor
   location =
   {
        if (parserGetMe().location == self)
            return self.sitloc;
        else if ( (parserGetMe().location != nil) && (parserGetMe().location.ownFloor == true) )
            return startroom;
        else
            return parserGetMe().location;
   }
   verDoSiton(actor) = {aresa_say('������ �� ����� �������������!');}
   verDoLie(actor) = {aresa_say('������ �� ����� �������� ���-������!');}
;

bodyDecoration : decoration, floatingItem
  location = {return parserGetMe().location; }
  locationOK = true
  isHer = true
  desc = '�����/1� ������ ����'
  noun = '����/1�' '����/1�' '�����/2' '���/1�' '���/1�' '���/2' '����/1�' '����/1�' '����/2' '����/2' '������/2' '������/1�' '����/1�' '�����/2' '�����/1�' '���/1�' '�����/1�' '��������/1�'
;

////////////////////////////////
//����� ������-�����, �������������� ������ doPush, verDoPush, ��������� �� ��� ������
class Button : fixeditem
   verDoPull(actor)={self.verDoPush(actor);}
   verDoMove(actor)={self.verDoPush(actor);}
   verDoTurn(actor)={self.verDoPush(actor);}
   verDoTurnon(actor)={self.verDoPush(actor);}
   verDoTurnoff(actor)={self.verDoPush(actor);}
   verDoSwitch(actor)={self.verDoPush(actor);}
   verDoPutdown(actor)={self.verDoPush(actor);}
   verDoShoot(actor)={aresa_say('������ ���� ����� ������������ �� ����������, �� ������� ��� �� �������� ���� � ��������? ������ ���, ����� ������ ��������������...');}
   
   doPull(actor)={self.doPush(actor);}
   doMove(actor)={self.doPush(actor);}
   doTurn(actor)={self.doPush(actor);}
   doTurnon(actor)={self.doPush(actor);}
   doTurnoff(actor)={self.doPush(actor);}
   doSwitch(actor)={self.doPush(actor);}
   doPutdown(actor)={self.doPush(actor);}
;

//����� ���� ��� �������� �������������, ��������� ������ thrudesc ��� ����, ����� ���������� ��� �� �����
class Window : fixeditem, seethruItem
   doLookin(actor)={self.thrudesc;}
;

//����� ��� �������� ��������, ������, ��������� ��������, �������������� verDoTake � doTake, ����������� ����������
class EasyTake : fixeditem
   verDoOpen(actor)={self.verDoTake(actor);}
   verDoPull(actor)={self.verDoTake(actor);}
   verDoMove(actor)={self.verDoTake(actor);}
   verDoTurn(actor)={self.verDoTake(actor);}
   verDoPush(actor)={self.verDoTake(actor);}
   verDoDetach(actor)={self.verDoTake(actor);}
   verDoUnscrew(actor) = {self.verDoTake(actor);}
   
   doOpen(actor)={self.doTake(actor);}
   doPull(actor)={self.doTake(actor);}
   doMove(actor)={self.doTake(actor);}
   doTurn(actor)={self.doTake(actor);}
   doPush(actor)={self.doTake(actor);}
   doDetach(actor) = {self.doTake(actor);}
   doUnscrew(actor) = {self.doTake(actor);}
;

//������� ���, ������� ������ � �������� ���������, � ����� ������� ���� ��������� �� ������������
class LukSimple : fixeditem
   verDoOpen(actor) = {"<<ZAG(self,&sdesc)>> ��� ������.";}
   verDoClose(actor) = {"<<ZAG(self,&sdesc)>> ������ �������.";}
   verDoBoard(actor) = {"������ ������� �����������, ���� ����� <<dToS(self,&sdesc)>>.";}
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
;

//������� �������, ������� �� ��� �������� ��� ��������
class BedSimple : EasyTake
    verDoBoard(actor) = { self.verDoSiton(actor); }
	verDoStandon(actor) = { self.verDoSiton(actor); }
	verDoSiton(actor) = {aresa_say('��, ��������, ������ �� ����� ��������, ���������� �������.');}
	verDoLieon(actor) = {aresa_say('�� �����, ��������! ���� ��� � ������ ����������? �����������!');}
    verDoTake(actor) = {aresa_say('�� �� ������ �������� ����� ��������� ������, ��� ������ ������ ����?');}
;

//�������� ������������� ������� � ������� ����������� �� ������ ������������
class FunnyFixedItem : fixeditem
    verDoTalk(actor)={aresa_say('�� �������? ������������� ������� � ���, ����� ����� ���� ���������� ����������.');}
    verDoMove(actor) = {aresa_say('��-��, �������������. ����� ����� � ��������� �������?');}
	verDoPull(actor) = {self.verDoMove(actor);}
	verDoDetach(actor) = {self.verDoMove(actor);}
	verDoPush(actor) = {self.verDoMove(actor);}
	verDoTake(actor) = {aresa_say('�������� �����? � ���� ��������? ����� �� ������.');}
	verDoDrop(actor) = {aresa_say('��������� �������������� ������!');}
	verDoThrow(actor) = {self.verDoDrop(actor);}
    verDoStandon(actor) = {aresa_say('������, �� ��� �������� ������ ������������ ������, ������� ������� �� ����-�� ������� � �������. �� �� �� � ����� ��������� ������, ������?');}
    verDoSiton(actor) = {self.verDoStandon(actor);}
	doThrow(actor) = { self.doDrop(actor); }
;

//�������� ����� �� ������� ����� �������� �������
class FunnyClibDecor : decoration
    verDoClimb(actor) = { aresa_say('������� ����-����. � ����� ���� ����� ��������� ����� � ��������.'); }
    verDoBoard(actor) = { self.verDoClimb(actor); }
	verDoStandon(actor) = { self.verDoClimb(actor); }
;

//��������� � ���������� � �������� ����������
class decorationNotDirect: fixeditem
	ldesc = {ZAG(self,&sdesc);" �� ������������ ��������. ";} //��
	dobjGen(a, v, i, p) =
	{
		if (v <> inspectVerb && v<>osmVerb)
		{
			"<<ZAG(self, &sdesc)>> �� ������������ ��������. ";
			exit;
		}
	}
	iobjGen(a, v, d, p) =
	{
		{"<<ZAG(self,&sdesc)>> �� ������������ ��������. ";}
		exit;
	}
;

////////////////////////////////
#include <level1.t>
#include <level2.t>
#include <level3.t>
#include <level4.t>

#include <level_tech.t>