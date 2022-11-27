//������ ���������� � ����
#pragma C++

////////////////////////////////////////////////
//��������� ���������� ����������

//������ �� ���������� - ������� � ������ ComboEffectProcessor
//������ �������� �����������, ����� new
//������� ����� delEffect ComboEffectProcessor
class Effect : object
  //protected virtual:
  doEffect = {
     //TODO: ���������� ��������� ������� � ���� ������, ����� ���������� ������� ������ ����� delete
  }
  //���������� ��������
  deact={
  }
;

ComboEffectProcessor : Combo
   showInList = nil
   effect_list = []
   location = Me
   reset={
     local i;
     for (i=1;i<=length(self.effect_list);i++)
     {
        local eff = self.effect_list[i];
        self.effect_list -= eff;
        eff.deact;
        delete eff;
     }
   }
   //��������� ����-������
   addEffect(effect) = {
      self.effect_list += [effect];
   }
   //protected:
   delEffect(effect) = {
      self.effect_list -= [effect];
      delete effect;
   }
   
   procEffect = {
     local i;
     for (i=1;i<=length(self.effect_list);i++)
     {
        self.effect_list[i].doEffect;
     }
   }
   //�� ����� �������� ������������ ������
   shootTar(who,tar,wpn,points)={self.procEffect;}
   battleWt(who)={self.procEffect;}
   battleMv(who,direction)={self.procEffect;}
;


////////////////////////////////////////////////
//���

ComboKnifeJump : Combo
   _state = 0
   _last_dir = 0
   desc = '������/1� � �����'
   ldesc = "���� �� �������� ���, � ������ ��������� ����� � ���������� � ������� ���� ����� ������, �� �� ���������� � ���������� ���������� � �������� ��� ������ ����."
   reset={
     self._state = 0;
   }
   battleMv(who,direction)={
      if ( (self._state == 0) && (who.sel_weapon == Knife) )
      {
          self._last_dir = direction;
          self._state = 1;
      }
      else if ( (self._state == 1) && (who.sel_weapon == Knife) && (direction == self._last_dir) )
      {
         local closer_mon = GetCloserMonByDir(who.location,direction);
         if (closer_mon!=nil)
         {
            //���������� ������ � ���������� �����
            who.location._pl_pos = closer_mon._pos;
            "<font color='lime'>� ��������� � ���� � ��������� �������� �� �������� ���������� �� ���� ���������� � ������� ���.</font> ";
            closer_mon.Hit(nil,Knife.calcHit(0));
            self.moveInto(nil);
         }
         self.reset;
      }
      else
      {
         self.reset;
      }
   }
;

ComboKnifeThrow : Combo
   desc = '������/1� ����'
   ldesc = "���� ���� ��������� ����� ��� � ������ �� ���, �� ���������� �������������� ������ ����. ��������� ������ ����. �������� �������: <<self._numActLeft>>"
   _numActLeft = 5 //������� �������� �������.
   preBattleAny(who) = {
      if ( who.sel_weapon == Knife )
      {
         local pos = who.location._pl_pos;
         local mon = GetMonOnPos(who.location,pos);
         if (mon == nil) mon = GetMonOnPos(who.location,pos+1);
         else if (mon == nil) mon = GetMonOnPos(who.location,pos-1);
         
         if (mon != nil)
         {
            "<font color='lime'>����� <<mon.vdesc>>, ��� ��������� �������� � ����.</font> ";
            mon.Hit(nil,Knife.calcHit(0));
            self._numActLeft -= 1;
            if (self._numActLeft==0) self.moveInto(nil);
         }
         self.reset;
      }
      else
      {
         self.reset;
      }
   }
;

ComboKrioAbsorb : Combo
   _state = 0
   _saved_hp = 0
   desc = '��������������/1��'
   ldesc = "���� �� ������ ������� � ������� ���� �����, �� ���������� �� ������ ���� ����������� �� ������ ��� �������������� � ��������. �������� ����������: <<self._numActLeft>>"
   _numActLeft = 3 //������� �������� ����������
   reset={
     self._state = 0;
   }
   battleWt(who)={
      if ( self._state == 0 ) {
         self._state = 1;
         self._saved_hp = who._hp;
      }
      else if ( self._state == 1 ) { 
         local diff = (self._saved_hp - who._hp);
         if (diff > 0)
         {
            "<font color='lime'>�������������� ���������, ��� ������������� ����� �������� ����� �����������.</font> ";
            who._hp += diff;
            self._numActLeft -= 1;
            if (self._numActLeft==0) self.moveInto(nil);
         }
         self.reset;
      }
      else {
         self.reset;
      }
   }
;

class KrioWaveEffect : Effect
  shot_pos = 0
  end_pos = 0
  move_dir = 0
  hit_val = 3
  doEffect = {
     if (self.move_dir == MOVE_DIR_FORWARD) self.shot_pos += 1;
     else if (self.move_dir == MOVE_DIR_BACKWARD) self.shot_pos -= 1;
     
     if (self.shot_pos!=end_pos)
     {     
        local mon = GetMonOnPos(Me.location,self.shot_pos); //TODO: ���������� �� Me
        "��������� �� ������� <<self.shot_pos>>. ";
        if (mon!=nil) mon.Hit(nil,hit_val);
     }
     else
     {
        //������� ������
        "��������� �������. ";
        ComboEffectProcessor.delEffect(self);
     }
  }
;

ComboKrioWave : Combo
   _wave_dir = 0
   desc = '��������/1�� ���������/1��'
   ldesc = "��������� ����-�����, ������� ����� ���� � �������� ����� ����� � ����������� �� ���, ������ ��������� ����������� ���� �����������."
   preBattleAny(who)={
     local eff = new KrioWaveEffect;
     //if (self._wave_dir == MOVE_DIR_FORWARD)
     //{
        eff.move_dir = MOVE_DIR_BACKWARD;
        eff.shot_pos = who.location._field_size;
        eff.end_pos = who.location._pl_pos;
     //}
     //else
     //{
     //   eff.move_dir = MOVE_DIR_FORWARD;
     //   eff.shot_pos = 0;
     //   eff.end_pos = who.location._pl_pos;
     //}
     ComboEffectProcessor.addEffect(eff);
     "��������� ��������. ";
     self.moveInto(nil);
     self.reset;
   }
;

////////////////////////////////////////////////
//��������

//���������� ���������� 
ComboPistolPristrel : Combo
   _state = 0
   _last_tar = nil
   desc = '����������/1� �����������'
   ldesc = "���� �� �������� �������� � ������ ��� ������ ��������� � ������� �� �������� ����� ����� �� ���� �������������."
   reset={
     self._state = 0;
   }
   shootTar(who,tar,wpn,points)={
      if ( (self._state == 0) && (wpn==Pistol) && (points > 0) )
      {
         self._state = 1;
         self._last_tar = tar;
      }
      else if ( (self._state == 1) && (wpn==Pistol) && (points > 0) && (self._last_tar == tar) )
      {
         self._state = 2;
      }
      else if ( (self._state == 2) && (wpn==Pistol) && (points > 0) && (self._last_tar == tar) )
      {
         "�� ��� ��� ����������� ����������� � ���������� ����� �� ������ ����� �� ���� ������. ";
         tar.Hit(nil,points);
         self.reset;
      }
      else
      {
         self.reset;
      }
   }
;


class RoboshotEffect : Effect
  shot_dir = 0
  shot_pos = 0
  end_pos = 1
  hit_val = 2
  doEffect = {
     if (self.shot_dir == MOVE_DIR_FORWARD) self.shot_pos += 1;
     else if (self.shot_dir == MOVE_DIR_BACKWARD) self.shot_pos -= 1;
     
     if (self.shot_pos!=self.end_pos)
     {     
        local mon = GetMonOnPos(Me.location,self.shot_pos); //TODO: ���������� �� Me
        "����������� �� <<self.shot_pos>>. ";
        if (mon!=nil) mon.Hit(nil,hit_val);
     }
     else
     {
        //������� ������
        "����������� ��������. ";
        ComboEffectProcessor.delEffect(self);
     }
  }
;

//���������� �����������
ComboPistolRoboShot : Combo
   desc = '�����������/1�'
   ldesc = "���������� ����� ����������� �������� � ��������� �� ��� ����������� �� ����� ����� ������ ��� �� ������ �� �������� � ��������� �������."
   preBattleAny(who)={       
     local eff = new RoboshotEffect;
     //if (gr_pos == (who.location._pl_pos+1))
     //{
        eff.shot_dir = MOVE_DIR_FORWARD;
        eff.shot_pos = who.location._pl_pos+1;
        eff.end_pos = who.location._field_size+1;
     //}
     //else
     //{
     //   eff.shot_dir = MOVE_DIR_BACKWARD;
     //   eff.shot_pos = gr_pos;
     //   eff.end_pos = -1;
     //}
     ComboEffectProcessor.addEffect(eff);
     "����� ������������ �����������. ";         
     self.reset;
   }
;

////////////////////////////////////////////////
//��������

//���������� ������� ���������
//ComboDroboShot : Combo
//   showInList = nil
//   location = Me
//   desc = '�������/1� ���������'
//   ldesc = "����� �� ��������� ���������� � ����, �� ������ ���� � ���� �� ������ �������� ����."
//   canDeactive = nil
//   shootTar(who,tar,wpn,points)={
//      if ( (wpn==Drobovik) && (points > 0) )
//      {
//         local mon_list = GetMonListOnPos(who.location,tar._pos);
//         local curr_dist = GetDist(who.location,tar);
//         local i;
//         for (i=1;i<=length(mon_list);i++)
//         {
//            if (mon_list[i] != tar)
//            {
//               mon_list[i].Hit(who,wpn.calcHit(curr_dist));
//            }
//         }
//      }
//   }
//;

////////////////////////////////////////////////
//�������

//���������� �������� �������
class PoisenEffect : Effect
  pois_tar = nil
  total_pos_num = 0
  doEffect = {     
     if ( pois_tar.location != nil )
     {     
        "<font color='lime'>�� ��������� �� <<pois_tar.rdesc>>.</font> ";
        pois_tar.Hit(nil,7);
        total_pos_num += 1;
     }
     else
     {
        //������� ������ ����� ������
        //"�� �������� �����������. ";
        ComboEffectProcessor.delEffect(self);
     }
  }
;

ComboPoisenShot : Combo
   desc = '��������/1�� �������/1�'
   ldesc = "����� �� ��������� ��������� � ����, �� ������ �������� ���� �� ������� � ���� (3) ������ ���."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local eff = new PoisenEffect;
         eff.pois_tar = tar;
         ComboEffectProcessor.addEffect(eff);
         "<font color='lime'>�� �������� <<tar.rdesc>>.</font> ";
         self.moveInto(nil);
      }
   }
;

//���������� �������������
class MindTrickEffect : Effect
  mind_tar = nil
  total_pos_num = 0
  doEffect = {     
     //������� ������ ����� ���� �����
     if ( (mind_tar.location != nil) && (self.total_pos_num<=5) && (HaveMonsters(mind_tar.location)) )
     {     
        self.total_pos_num += 1;
     }
     else
     {
        //������� ������
        if (mind_tar.location != nil) "<font color='lime'>������������� ��������� �����������.</font> ";
        mind_tar._isFriend = nil;
        ComboEffectProcessor.delEffect(self);
     }
  }
  deact = {
     mind_tar._isFriend = nil;
  }
;

ComboMindShot : Combo
   desc = '����������/1�'
   ldesc = "����� �� ��������� ��������� � ����, �� ������ ��-�� ������������� �������� �� �������� �������� � ������� ���� �����."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local eff = new MindTrickEffect;
         eff.mind_tar = tar;
         tar._isFriend = true;
         ComboEffectProcessor.addEffect(eff);
         "<font color='lime'><<tar.sdesc>> ���������������.</font> ";
         self.moveInto(nil);
      }
   }
;

//���������� �������
class ParalizeEffect : Effect
  mind_tar = nil
  total_pos_num = 0
  doEffect = {     
     if ( (mind_tar.location != nil) && (self.total_pos_num<3) )
     {     
        "<font color='lime'>�������� ������������ (�������� �����: <<3-self.total_pos_num>>). </font> ";
        self.total_pos_num += 1;
     }
     else
     {
        //������� ������
        if (self.total_pos_num >= 3) "<font color='lime'>�������� ��������� �����������. </font> ";
        mind_tar._isParalized = nil;
        ComboEffectProcessor.delEffect(self);
     }
  }
  deact = {
     mind_tar._isParalized = nil;
  }
;

ComboParalizeShot : Combo
   desc = '��������/1�'
   ldesc = "����� �� ��������� ��������� � ����, �� ������ �� �������� � ������� ���� �����."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local eff = new ParalizeEffect;
         eff.mind_tar = tar;
         tar._isParalized = true;
         ComboEffectProcessor.addEffect(eff);
         "<font color='lime'><<tar.sdesc>> ����������.</font> ";
         self.moveInto(nil);
      }
   }
;

//���������� ��������
ComboDuplicate : Combo
   desc = '��������/1�'
   ldesc = "����� �� ��������� ��������� � ����, �� ����� � ���, ���������� ���� ��������� �����, � ������� ������� - ���������."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local isk = new Duplicate;
		 Duplicate._hp = Duplicate._max_hp;
         Duplicate._pos = tar._pos;
         //������ ��� �������� ����������� � ������ ��������������
         Me.followList += isk;
         Duplicate.moveInto(who.location);
         "<font color='lime'>�������� �������� ����� � <<tar.tdesc>>.</font> ";
         self.moveInto(nil);
      }
   }
;

FireBallLong : Combo
   desc = '�������/1�'
   ldesc = "������� �������� ����� �� ��������� ����. ������ ��� ������� ��� ����������� ����. �������� ������: <<self._numFireTimeLeft>>"
   _maxFireTimeLeft = 3 //������������ ����� �������
   _numFireTimeLeft = 3 //������� ��������
   _hitPoints = 5
   preBattleAny(who) = { 
     if (self._numFireTimeLeft > 0)
     {
        "<font color='red'>������� �������� ����� �������� ��� (-<<self._hitPoints>>).</font> ";
        Me.Hit(nil,self._hitPoints);
        self._numFireTimeLeft -= 1;
        if (self._numFireTimeLeft==0) self.moveInto(nil);
     }
   }
;

#pragma C-