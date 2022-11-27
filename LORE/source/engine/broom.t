// ��������� ������ ��� �������
#pragma C++


////////////////////////////////////////////////
//��������� ������ ������ ������� (��-���� ��� �������)
modify room
   /*init*/_field_size = 10 //������ ���� �����
   /*init*/_pl_pos = 0      //������� ������ �� �����
   lit_desc = '��� ��������'
   see_mon = nil //����� ��������
   ownFloor = nil //������� ������������ ���� (����������� ��������� � ���� �������)
   mayJumpOut = nil //����� �� ���������� �� �������
   ldesc = {
     "<<self.lit_desc>><br>";
     
     if (HaveMonsters(self)) {
        if (self._pl_pos > 0) "�� ������ ��������� ����� �� <<self._pl_pos>> ������, ";
        else "�� �� ������ ��������� �����, ";
        " ����� ������������ ����� �� <<self._field_size-self._pl_pos>> ������.<br>";
     }
   }
   
   enterRoom(actor) =
   {
       local i, actor_follow;
       //����������, ����� ���� �������� ����������?
       //combo_reset_deactivate(Me);
       //��� ������ ������� ������������� ������
       if (FireBallLong.isIn(Me)) {
          "������� ����� ������� � �������.";
          FireBallLong.moveInto(nil);
       }
       
       //���������� ��������������
       for (i=1;i<=length(Me.followList);i++)
       {
          actor_follow = Me.followList[i];
          //actor_follow.travelTo(self);
          actor_follow.moveInto(self);
       }
       
       //������� �������
       ComboEffectProcessor.reset;
       pass enterRoom;
   }
;

//��������� �������
/*list of Monster*/GetMonsterList : function(where) 
{
  //������ �����������
  local list = where.contents;
  local i, obj;
  local mon_list = [];
  
  for (i=1;i<=length(list);i++)
  {
     obj = list[i];
     if (isclass(obj, Monster) && !obj._isFriend) mon_list = mon_list + [obj];
  }
  
  return mon_list;
}

/*list of Monster*/GetFriendList : function(where) 
{
  //������ �����������
  local list = where.contents;
  local i, obj;
  local mon_list = [];
  
  for (i=1;i<=length(list);i++)
  {
     obj = list[i];
     if (isclass(obj, Monster) && obj._isFriend) mon_list = mon_list + [obj];
  }
  
  return mon_list;
}
//������� �������� �� �����
/*bool*/HaveMonsters : function(where) 
{
 return (length(GetMonsterList(where))>0);
}

//���������� ����� ������� � �����, �� ������ ��������
/*int*/GetDistInMonList : function(where,tar,mon_list) 
{
  local i,mon;
  if (length(mon_list)==0) return NO_DIST_TO_MONSTER;
  mon = nil;
  for (i=1;i<=length(mon_list);i++)
  {
     mon = mon_list[i];
     if (mon == tar) break;
  }
  if (mon==nil) return NO_DIST_TO_MONSTER;
  return abs(where._pl_pos - mon._pos);
}

//���������� ����� ������� � �����
/*int*/GetDist : function(where,tar) 
{
  local mon_list = GetMonsterList(where);
  return GetDistInMonList(where,tar,mon_list);
}

//���������� ����� ������� � �����, � ������ ������
/*int*/GetDistWithFriends : function(where,tar) 
{
   local mon_list = GetMonsterList(where);
   mon_list += GetFriendList(where);
   return GetDistInMonList(where,tar,mon_list);
}

//��������� ������
/*ptr*/GetCloserMonTo : function(loc, from_pos) 
{
  //�������� ��� ������ ���� �� �����
  local mon_list = GetMonsterList(loc);
  local i,mon, min_dist, curr_dist, min_mon;
  if (length(mon_list)==0) return nil;
  min_mon = nil;
  min_dist = 9999;
  for (i=1;i<=length(mon_list);i++)
  {
     mon = mon_list[i];
     curr_dist = abs(from_pos - mon._pos);
     if (curr_dist<min_dist)
     {
         min_mon = mon;
         min_dist = curr_dist;           
     }
  }
  return min_mon;
}

//��������� ������
/*ptr*/GetCloserMon : function(where) 
{
   return GetCloserMonTo(where, where._pl_pos);
}

//��������� ������ �� �����������
/*ptr*/GetCloserMonByDir : function(where,directory) 
{
  //�������� ��� ������ ���� �� �����
  local mon_list = GetMonsterList(where);
  local i,mon, min_dist, curr_dist, min_mon;
  if (length(mon_list)==0) return nil;
  min_mon = nil;
  min_dist = 9999;
  for (i=1;i<=length(mon_list);i++)
  {
     mon = mon_list[i];
     if (directory == MOVE_DIR_FORWARD) curr_dist = mon._pos - where._pl_pos;
     else curr_dist = where._pl_pos - mon._pos;
     
     if ((curr_dist >= 0) && (curr_dist<min_dist))
     {
         min_mon = mon;
         min_dist = curr_dist;           
     }
  }
  return min_mon;
}

/*ptr*/GetMonOnPos: function(where,pos) 
{
  local mon_list = GetMonsterList(where);
  local i,mon;
  if (length(mon_list)==0) return nil;
  for (i=1;i<=length(mon_list);i++)
  {
     mon = mon_list[i];
     if (mon._pos==pos) return mon;
  }
  return nil;
}

/*list*/GetMonListOnPos : function(where,pos) 
{
  local mon_list = GetMonsterList(where);
  local i,mon,res_list;
  res_list = [];
  if (length(mon_list)==0) return nil;
  for (i=1;i<=length(mon_list);i++)
  {
     mon = mon_list[i];
     if (mon._pos==pos) res_list += [mon];
  }
  return res_list;
}

  
#pragma C-