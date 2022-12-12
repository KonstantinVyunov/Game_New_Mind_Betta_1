// Интерфейс движка для боевика
#pragma C++


////////////////////////////////////////////////
//Интерфейс класса боевой комнаты (по-идее все комнаты)
modify room
   /*init*/_field_size = 10 //размер поля битвы
   /*init*/_pl_pos = 0      //позиция игрока на карте
   lit_desc = 'НЕТ ОПИСАНИЯ'
   see_mon = nil //видел монстров
   ownFloor = nil //наличие собственного пола (стандартный пропадает в этой локации)
   mayJumpOut = nil //можно ли выпрыгнуть из комнаты
   ldesc = {
     "<<self.lit_desc>><br>";
     
     if (HaveMonsters(self)) {
        if (self._pl_pos > 0) "Вы можете отступить назад на <<self._pl_pos>> метров, ";
        else "Вы не можете отступить назад, ";
        " карта продолжается вперёд на <<self._field_size-self._pl_pos>> метров.<br>";
     }
   }
   
   enterRoom(actor) =
   {
       local i, actor_follow;
       //Определить, когда надо обнулять комбинации?
       //combo_reset_deactivate(Me);
       //При выходе убираем отрицательный эффект
       if (FireBallLong.isIn(Me)) {
          "Горящая плёнка потухла и пропала.";
          FireBallLong.moveInto(nil);
       }
       
       //Перемещаем последователей
       for (i=1;i<=length(Me.followList);i++)
       {
          actor_follow = Me.followList[i];
          //actor_follow.travelTo(self);
          actor_follow.moveInto(self);
       }
       
       //Убираем эффекты
       ComboEffectProcessor.reset;
       pass enterRoom;
   }
;

//служебные функции
/*list of Monster*/GetMonsterList : function(where) 
{
  //список содержимого
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
  //список содержимого
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
//Наличие монстров на карте
/*bool*/HaveMonsters : function(where) 
{
 return (length(GetMonsterList(where))>0);
}

//расстояние между игроком и целью, по списку монстров
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

//расстояние между игроком и целью
/*int*/GetDist : function(where,tar) 
{
  local mon_list = GetMonsterList(where);
  return GetDistInMonList(where,tar,mon_list);
}

//расстояние между игроком и целью, с учетом друзей
/*int*/GetDistWithFriends : function(where,tar) 
{
   local mon_list = GetMonsterList(where);
   mon_list += GetFriendList(where);
   return GetDistInMonList(where,tar,mon_list);
}

//Ближайший монстр
/*ptr*/GetCloserMonTo : function(loc, from_pos) 
{
  //проверка что монстр есть на карте
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

//Ближайший монстр
/*ptr*/GetCloserMon : function(where) 
{
   return GetCloserMonTo(where, where._pl_pos);
}

//Ближайший монстр по направлению
/*ptr*/GetCloserMonByDir : function(where,directory) 
{
  //проверка что монстр есть на карте
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