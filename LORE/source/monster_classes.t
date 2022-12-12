//������ �������
#pragma C++

//������� (������ ����� � DOOM)
class SimpleShooter : Monster
   _hp = 10
   _max_hp = 10
   _is_wait = nil
   _gen = 20
   ldesc = "������� �������. ������ �� �����, ������ �������� � ������ �������. ����� ������� ����� �� ������� ���������, ���� �� ������� � �������, ������ ���� �����. ������ ����� ������������ ��� ��������. ����: 3-15. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '����� ������� �� ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //� ������������ 30% ������ ������� ������ � ���� �������, ������ ��� ��������
      if ( rangernd(1,10) <= 3 ) {
         if (self._is_wait == true) self._is_wait = nil;
         else self._is_wait = true;
      }
      
      //� ����������� ����� ����������� ����� ��������� ���� ��������
      if (( rangernd(1,10) <= 3 ) && (self._hp < self._max_hp) && (global.is_easy==nil))
      {
         "<br><<self.sdesc>> ����������� ��������.<br>";
         self._hp = self._max_hp;
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     if (self._is_wait) return MON_ACT_TYPE_WAIT;
     return MON_ACT_TYPE_SHOOT;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (D<=3) return rangernd(5,15);
      else if (D<10) return rangernd(3,5);
      return rangernd(3,5);
   } 
;

//������� �������
class KingShooter : Monster
   _hp = 60
   _max_hp = 60
   _is_wait = nil
   _gen = 50
   ldesc = "������� �������. �� ������ ���-�� ������� �� ������. ������ �� �����, ������ �������� � �������. ����� �������. � ��� ����� ����� ��� ������� �������� �������. ���������� ����� �� ���� ����������, ������, �� ����� �������, ������ ����� ������� ���� �������� �� �������� � �������� ��������. ����: 3-10. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '����� ������� �� ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //�� ��������, �� ����
      if (self._is_wait == true) self._is_wait = nil;
      else self._is_wait = true;
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     if (self._is_wait) return MON_ACT_TYPE_WAIT;
     return MON_ACT_TYPE_SHOOT;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      return rangernd(3,8);
   } 
;

//���������
class SimpleTrooper : Monster
   _hp = 30
   _max_hp = 30
   _last_move = nil
   _curr_dir = 0
   _gen = 30
   ldesc = "������� ���������. ������ ��������� �� ���, ��������� ������ �����������. ������ ����� � ������ ���������� ��� � ������� ����� �����. ������� ���������� ����� � ������ �����. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '������ ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //���� ����� � ���� ��� ���������, �� ��� � ����
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
      else
      {
         //� ����������� ����� ����������� ������ ������ � ������ ����� �����
         if (( rangernd(1,10) <= 3 ) && (self._pos != loc._field_size) && (global.is_easy==nil) )
         {
            "<br><<ZAG(self,&sdesc)>> ������� ������ ������� ��� � ����� ����� � ��������.<br>";
            self._pos = loc._field_size;
            loc._pl_pos = loc._field_size;
         }
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //�� ����� ������ � ������, ������� ���
     if (self._pos == self.location._pl_pos) return MON_ACT_TYPE_SHOOT;
     else if (self._last_move == true) return MON_ACT_TYPE_WAIT;
     return MON_ACT_TYPE_MOVE;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (D==0) return rangernd(2,4);
      return rangernd(0,0);
   } 
;

//�������
class SimpleFireMon : Monster
   _is_move = nil //������ ��������
   _curr_dir = MOVE_DIR_FORWARD //������� ��������
   _hp = 10
   _max_hp = 10
   _gen = 10
   ldesc = "������� �������. ������ ����-���� � ������������ ��������������. ����� ��������� �������� ���, ������� ����� ������ �� ������ �����-�� �����. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '����� �������� ����� �� ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //� ������������ 30% ������ ������� ������ � ���� �������, ������ ��� ��������
      if ( rangernd(1,10) <= 3 ) {
         if (self._is_move == true) {
            self._is_move = nil;
         }
         else {
            self._is_move = true;
            self._curr_dir = rangernd(MOVE_DIR_FORWARD,MOVE_DIR_BACKWARD);
         }
      }
      
      if (self._is_move) {      
         //���� �������� � �����, �� ��� �������
         if ( (self._curr_dir==MOVE_DIR_FORWARD) && (self._pos == loc._field_size) ) self._curr_dir = MOVE_DIR_BACKWARD;
         else if ( (self._curr_dir==MOVE_DIR_BACKWARD) && (self._pos == 0) ) self._curr_dir = MOVE_DIR_FORWARD; 
      }
      
      //�������� �������� ����� � �������� ������
      if ( rangernd(1,10) <= 3 && (global.is_easy==nil) ) {
         "<br><<ZAG(self,&sdesc)>> �������� �� ��� �������� ��� �� �����!<br>";
         if (!FireBallLong.isIn(Me)) FireBallLong.moveInto(Me);
         //��������� ���� �� ����
         FireBallLong._numFireTimeLeft = FireBallLong._maxFireTimeLeft;
         //��������� ���� ����� ��
         FireBallLong.preBattleAny(Me);
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     if (self._is_move) return MON_ACT_TYPE_MOVE;
     return MON_ACT_TYPE_SHOOT;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (D<=3) return rangernd(8,12);
      else if (D<6) return rangernd(5,8);
      return rangernd(0,1);
   } 
;


////////////////////////////////////////
//��������
class KrioWall : Monster
   _hp = 10
   _max_hp = 10
   _isFriend = true
   _isDynamic = true
   _live_count = 0
   sdesc = "���������"
   rdesc = "���������"
   ddesc = "���������"
   vdesc = "���������"
   tdesc = "����������"
   pdesc = "���������"
   noun = '���������' '���������' '���������' '����������'
   isHer = true
   ldesc = "���������. ������ ���� �� ����� � ����� �������� �� ���������. ����������� ����� 10 �������. ������: <<self._hp>>/<<self._max_hp>>."
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      self._live_count++;
      if (self._live_count > 10){
        self.moveInto(nil);
        "��������� ���������. ";
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     return MON_ACT_TYPE_WAIT;
   }
;

class Duplicate : Monster
   _hp = 50
   _max_hp = 50
   _isFriend = true
   isEquivalent = true
   pluraldesc = "���������"
   rpluraldesc = "����������"
   sdesc = "��������"
   rdesc = "���������"
   ddesc = "���������"
   vdesc = "��������"
   tdesc = "����������"
   pdesc = "���������"
   noun = '��������' '���������' '����������'
   isHim = true
   ldesc = "�������� ��������. �������� � ���������� � ������� � ������� ��������. ������: <<self._hp>>/<<self._max_hp>>."
   
   need_attack=true
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      local closerMon = GetCloserMonTo(loc,self._pos);    
      
      //���� ����� � ���� ��� �������, �� ���� � ����
      self.need_attack = nil;
      if (closerMon != nil)
      {
		  //"[Closest mon: <<closerMon.sdesc>>]";
          self.need_attack = true;
          if ( self._pos != closerMon._pos)
          {
            if (self._pos < closerMon._pos) self._curr_dir = MOVE_DIR_FORWARD;
            else self._curr_dir = MOVE_DIR_BACKWARD;
            self.need_attack = nil;
          }
      }
      
   }
   
   SayDead(who) = {
        //������� �� ���������� ������, ��� ������
        Me.followList -= self;
        pass SayDead;
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     if (self.need_attack) return MON_ACT_TYPE_SHOOT;
     return MON_ACT_TYPE_MOVE;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   
   /*virtual int*/ calcHit(/*int*/D) = {
      return rangernd_no_complex(2,8);
   }
;

table_seccont_mon : Monster
   desc = '����������/1�� ������/1�'
   noun = '����/1�' '������/1�'
   adjective = '����������/1��' '���������/1��'
   isHim = true
   ldesc = "��������� ���������� ������. ���������: <<self._hp>>/<<self._max_hp>>."
   _hp = 1
   _max_hp = 1
   _pos = 2
;

//����-���������
class SpiderFixer : Monster
   _hp = 10
   _max_hp = 10
   _last_move = nil
   _curr_dir = 0
   _gen = 0
   corpse = nil
   ldesc = "����������� ����-���������. ����� ���������, ��� ��� ��������� �� ������. ������ ��������� �� ���, ������� ��������� ���� ������������ ������������. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '������� ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //���� ����� � ���� ��� ���������, �� ��� � ����
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //�������������, ����� ����� ��������� �������
     //�� ����� ������ � ������, ������� ���
     if (rangernd(0,10)<=4) return MON_ACT_TYPE_WAIT;
     if (self._pos == self.location._pl_pos) return MON_ACT_TYPE_SHOOT;
     else if (self._last_move == true) return MON_ACT_TYPE_WAIT;
     return MON_ACT_TYPE_MOVE;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (D==0) return rangernd(5,15);
      return rangernd(0,0);
   } 
   //protected:
   ///*virtual void*/SayHitMe(points) = {
   //    if (prob(33)) {
	//	 robotRemBeforeActTemplates.print;
	//	 "<br>";
	//   }
   //    robotRemTemplatesPerson.print;
   //    "<<ZAG(who,&sdesc)>> <<who.sel_weapon.shoot_desc>> <<dToS(self,&ddesc)>> (-<<points>>).<br>";
   //}
   /*virtual void*/SayDead(who) = {
     "<font color='fuchsia'><<ZAG(self,&sdesc)>> ���������.</font><br>";
     if (self.corpse != nil) self.corpse.moveInto(Me.location); //���������� �� ��� ����� �������
   }
;

//�������-������������
DustKiller : Monster
   _hp = 9000
   _max_hp = 9000
   _curr_state = 0
   _last_loc = nil
   _gen = 0
   mustHunt = nil
   desc = '�����������/1��'
   noun = '�������/1�' '�����������/1�' '�����/1�' '������������/1�' '�������/1�'
   isHim = true
   ldesc = {
      show_image('duster.jpg');
      "����������� ������� ��� ����� � ����������� ������� ������ �� ��������� ����������. ���� � ��������������������� �������� ������� �������� ���� � ������ �������, � ����� ����� ���������� � ����������. ���������: <<self._hp>>/<<self._max_hp>>.";
   }
   me_attack_desc = '��������� ������� �� ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //������ - ������ ������� �� ����������, ��������� �����
      //self.location = Me.location;
      self._pos = loc._pl_pos;
      //��������� ��������� ��������� - �� ������.
      self._curr_state += 1;
      //�������� � ��� ���������
      if (self._curr_state == 1) "����������� ��������� � ���� ���������� ���� � ������ ��������.";
      else if (self._curr_state == 3) { "C������ ����������� ������, ��������� � ������."; play_sound('vacuum.ogg');}
      
      if (self._curr_state==5) self._curr_state=1;
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     if (self._curr_state==4) return MON_ACT_TYPE_SHOOT;
     return MON_ACT_TYPE_WAIT;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      return rangernd(1,3);
   }
;


dustkiller_broken : DestructItem
   desc = '���������/1�� �����������/1��'
   noun = '�������/1�' '�����������/1�' '�����/1�' '������������/1�'
   adjective = '���������/1��'
   ldesc = "�������� �� ����� ����������� ������� ��� ����� � ����������� ������� ������ �� ��������� ����������, ������� ���������� ��� ���������� ������ �������. ��,� �� �����-�� �����������."
   isHim = true
   enegryItem = true
   enegryGive = 50
;


lifter_gost : Monster
   desc = '����������/1�� �����/1�'
   noun = '�����/1�'
   adjective = '����������/1��'
   isHim = true
   ldesc = "���������: <<self._hp>>/<<self._max_hp>>."
   _hp = 1
   _max_hp = 1
   _pos = 0
;

//electro_cocon : Monster
//   desc = '�������������/1�� �����/1�'
//   noun = '�����/1�' '������������/1�'
//   adjective = '�������������/1��'
//   isHim = true
//   ldesc = "���� ������������ ���� �� � �����. ����� ��� ������� �������������, ������ ��� �� ���� ���-�� ���������. ���������: <<self._hp>>/<<self._max_hp>>."
//   _hp = 1000
//   _max_hp = 1000
//   _pos = 10
//;

//���������� ����
LifterLady : Monster
   location = lifterroom
   _hp = 100
   _max_hp = 100
   _curr_state = 0
   _gen = 50
   _pos = 10
   desc = '����������/1��� ����/1��'
   noun = '����/1��' '�������/1��' '����/1��' '�������/1��' '����-�������/1��'
   adjective = '����������/1���'
   isHer = true
   ldesc = "�������� ������� ������ ���������� ������� ������, � ��������� �������� � ����������. ��� ���� �� ����� �����, ���� �� �� �������������� ���� � ����� ��������� ������ ����. �� ����� ������� � ������ �� ���������. ������������ ����� �������� ����������������� ����, ���� ����������. �����: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '������� ��� �����'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //��������� ��������� ��������� - �� ������.
      self._curr_state += 1;
      //�������� � ��� ���������
      if (self._curr_state == 2) "������� �������� ������ ����.";
      else if (self._curr_state == 3) { "�������, ����-������� ������������� � ������� �����!"; play_sound('highvoltage.ogg'); }
      
      if (self._curr_state==5) self._curr_state=1;
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     return MON_ACT_TYPE_SHOOT;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (self._curr_state == 4) {
         if  (global.is_easy==nil) return rangernd(50,60);
         else return 20; //��� ������� ���� ��������
      }
      else return rangernd(2,6);
   }
;

//�����
Alien : Monster
   location = nil
   _hp = 100
   _max_hp = 100
   _last_move = nil
   _curr_dir = 0
   _gen = 60
   sdesc = "�����"
   rdesc = "������"
   ddesc = "������"
   vdesc = "������"
   tdesc = "�����"
   pdesc = "������"
   noun = '�����/1��' '������' '������' '�����' '������#d' '�����#t' '���������/1��'
   isHim = true
   ldesc = "�����. ����� ��� ��������� �� ������. ��� �������� ������������ �����, ��������� ������ ������������ �� ������ �����������, ��� �������� ������� ��� �� ������������, ��� � �������������� ���������� � ������������ ����� ������ ���������-������������� � ���������� ���������. ��� ������ ������ ���, ������ ��������� � ������, ����� �������� ����������� ������� � ���������� ����. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '������ ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //���� ����� � ���� ��� ���������, �� ��� � ����
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //�� ����� ������ � ������, ������� ���
     if (self._pos == self.location._pl_pos) return MON_ACT_TYPE_SHOOT;
     else if (self._last_move == true) return MON_ACT_TYPE_WAIT;
     return MON_ACT_TYPE_MOVE;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (D==0) return rangernd(10,20);
      return rangernd(0,0);
   } 
;

//�����-���������
class HardTrooper : Monster
   _hp = 80
   _max_hp = 80
   _last_move = nil
   _curr_dir = 0
   _gen = 40
   ldesc = "������� ���������. ������ ��������� �� ���, ��������� ������ ������� ����. ����� ����� � ������� �����. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '������ ���'
   
   //�������� ������ �������
   /*void*/UpdateLogic(loc) = {
      //���� ����� � ���� ��� ���������, �� ��� � ����
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //�� ����� ������ � ������, ������� ���
     if (self._pos == self.location._pl_pos) return MON_ACT_TYPE_SHOOT;
     else if (self._last_move == true) {
        //����� ����, � �������� ���� ��������� - �������
        if ( ((self._pos-1) == self.location._pl_pos) || ((self._pos+1) == self.location._pl_pos) ) return MON_ACT_TYPE_SHOOT;
        else return MON_ACT_TYPE_WAIT;
     }
     return MON_ACT_TYPE_MOVE;
   }
   
   /*virtual int*/ GetMoveDir() = {
      return self._curr_dir;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (D<=1) return rangernd(10,20);
      return rangernd(0,0);
   } 
;


loneBoy : Monster
   desc = '����������/1��� �������/1��'
   noun = '�������/1��' '�����/1��' '�������/1��'
   adjective = '����������/1���' '���������/1���'
   isHim = true
   ldesc = "���������� �������. �� �������� ��� ���������� � ��������� ��������, ���� ��� ��������. ������: <<self._hp>>/<<self._max_hp>>."
   _hp = 20
   _max_hp = 20
   _pos = 2
   _isFriend = true
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //�� ����� ������ � ������, ������� ���
     if (rangernd(1,3)==1)  return MON_ACT_TYPE_WAIT;
     return MON_ACT_TYPE_MOVE;
   }
   /*virtual int*/ GetMoveDir() = {
      if (rangernd(1,2)==1) return MOVE_DIR_FORWARD;
      return MOVE_DIR_BACKWARD;
   }
;


fishUdilshik : Monster
   desc = '��������/1�'
   noun = '��������/1�' '����-��������/1�' '����/1�'
   adjective = '�������/1��'
   isHim = true
   ldesc = "������ ������������� ����, �� ��������� ��������� � ������ ��� �������. ���� ������� ���� ������� ��������� � ����� ������� ����������� �� ���� ��� �����. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '������ ���'
   _hp = 70
   _max_hp = 70
   _pos = 0
   _gen = 40
   _is_atk = nil
   /*void*/UpdateLogic(loc) = {
     if (_is_atk == nil) "������� ���� ��������� �������!<br>";
     self._is_atk = !_is_atk;
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
      if (self._is_atk) return MON_ACT_TYPE_SHOOT;
      return MON_ACT_TYPE_WAIT;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      return rangernd(10,20);
   } 
;


plashShark : Monster
   desc = '�����������/1�� �����/1�'
   noun = '�����/1�'
   adjective = '�����������/1��'
   isHer = true
   ldesc = "�������� ������� ���� � ������ �����. �� ����� ��������� �������� ��� ���� � ������ ������ �����. ������: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = '����������� �� ���'
   _hp = 70
   _max_hp = 70
   _pos = 0
   _gen = 40
   _is_atk = nil
   /*void*/UpdateLogic(loc) = {
     if (_is_atk == nil) "����� ���������� ����� �������!<br>";
     self._is_atk = !_is_atk;
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     if (self._is_atk) return MON_ACT_TYPE_SHOOT;
      return MON_ACT_TYPE_WAIT;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      return rangernd(10,20);
   } 
;

#pragma C-