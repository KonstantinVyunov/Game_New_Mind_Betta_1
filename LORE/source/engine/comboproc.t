// ��������� ������ ��� �������
#pragma C++

////////////////////////////////////////////////
//��������� ����������
combo_reset_deactivate : function/*(who)*/;
combo_shoot_monster : function/*(who,tar,wpn,points)*/;
combo_wait : function/*(who)*/;
combo_move : function/*(who,direction)*/;


////////////////////////////////////////////////
//����������
//�����-����������, ������ ������ ����������� ��� �� ������ �����������
class Combo : fixeditem
   showInList = true //���������� � ������ ����������
   reset={} //�������� �������
   activate={self.isActive = true;} //����������� ����������
   shootTar(who,tar,wpn,points)={self.reset;}
   battleWt(who)={self.reset;}
   battleMv(who,direction)={self.reset;}
   preBattleAny(who) = {} //����� �������� ����� ������
//private:
   canDeactive = true
;

//����������� ��� ���������� � �������������� (��� ������ � ������� � �.�.)
combo_reset_deactivate : function(who)
{
   local i;
   local comb;
   local del_list = [];
   for (i=1;i<=length(who.contents);i++) if (isclass(who.contents[i],Combo)) {
      comb = who.contents[i];
      comb.reset;
      //���� ������� ����������, �� ������� ��� �� ���������.
      if (comb.canDeactive == true) del_list += [comb];
   }
   for (i=1;i<=length(del_list);i++)
   {
      del_list[i].moveInto(nil);
   }
}

combo_shoot_monster : function(who,tar,wpn,points)
{
   local i;
   local comb_list = [];
   //���������� ����� ��� ���������
   for (i=1;i<=length(who.contents);i++) 
      if (isclass(who.contents[i],Combo)) comb_list  += who.contents[i];
   
   for (i=1;i<=length(comb_list);i++) 
   {
          comb_list[i].preBattleAny(who);
          comb_list[i].shootTar(who,tar,wpn,points);
   }
}

combo_wait : function(who)
{
   local i;
   local comb_list = [];
   //���������� ����� ��� ���������
   for (i=1;i<=length(who.contents);i++) 
      if (isclass(who.contents[i],Combo)) comb_list  += who.contents[i];
      
   for (i=1;i<=length(comb_list);i++) 
   {   
      comb_list[i].preBattleAny(who);
      comb_list[i].battleWt(who);
   }
}

combo_move : function(who,direction)
{
   local i;
   local comb_list = [];
   //���������� ����� ��� ���������
   for (i=1;i<=length(who.contents);i++) 
      if (isclass(who.contents[i],Combo)) comb_list  += who.contents[i];
      
   for (i=1;i<=length(comb_list);i++) 
   {   
      comb_list[i].preBattleAny(who);
      comb_list[i].battleMv(who,direction);
   }
}

  
#pragma C-