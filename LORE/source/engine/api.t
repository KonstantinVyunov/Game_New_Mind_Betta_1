// Интерфейс движка для боевика
#pragma C++

#include <globaldefs.t>
#include <monster.t>
#include <broom.t>
#include <weapon.t>
#include <comboproc.t>
#include <craftsystem.t>
#include <resourcesystem.t>


////////////////////////////////////////////////
//Интерфейсы методов боевого движка
//Возвращаемое значение true - требуется ход NPC

//Выстрелить в монстра
/*bool*/shootMonster : function/*(pl,tar)*/;
//Ожидание в бою
/*bool*/battleWait : function/*(pl)*/;
//Перемещение в бою
/*bool*/battleMove : function/*(pl,direction)*/;
//Ход монстров
/*void*/monsterTurn : function/*(pl)*/;

///////////////////////////////////////////////
//Реализация методов
shootMonster : function(pl,tar) {
   //получаем дальность до цели
   local curr_dist =  GetDistWithFriends(pl.location,tar);
   local pure_hit_points;
   if ( ( (pl.sel_weapon._bullets > 0) && (pl.sel_weapon.isCloseCombat==nil) ) || (pl.sel_weapon.isCloseCombat==true) )
   {
       if (length(pl.sel_weapon.shoot_sound)>0) play_sound(pl.sel_weapon.shoot_sound[rand(length(pl.sel_weapon.shoot_sound))]);
       if (curr_dist == NO_DIST_TO_MONSTER) { "API ERROR: no monster on map!"; return nil;}
       //Рассчитываем урон
       pure_hit_points = pl.sel_weapon.calcHit(curr_dist);
       tar.Hit(pl,pure_hit_points);
       //Обработка комб
       if (tar.location != nil) combo_shoot_monster(pl,tar,pl.sel_weapon,pure_hit_points);
       if ( (pl.sel_weapon._bullets > 0) && (pl.sel_weapon.isCloseCombat==nil) ) pl.sel_weapon._bullets -= 1;
       return true;
   }
   return nil;
}

battleWait : function(pl) {
   //Обработка комб
   combo_wait(pl);
   return true;
}

battleMove : function(pl,direction) {
   local pos_pl = pl.location._pl_pos;
   local f_size = pl.location._field_size;
   if (direction==MOVE_DIR_FORWARD)
   {
      if (pos_pl < f_size) {
         pl.location._pl_pos += 1;
         //Обработка комб
         combo_move(pl,direction);
         return true;
      }
      else
      {
         "Вы достигли конца карты, вперёд нельзя.";
      }
   }
   else if (direction==MOVE_DIR_BACKWARD)
   {
      if (pos_pl > 0) {
         pl.location._pl_pos -= 1;
         //Обработка комб
         combo_move(pl,direction);
         return true;
      }
      else
      {
         "Вы достигли начала карты, назад нельзя.";
      }
   }
   else
   {
      "API ERROR:  unknown direction!";
   }
   
   return nil;
}

monsterTurn : function(pl)
{
   local mon_list = GetMonsterList(pl.location);
   local i,mon, act, move_dir, tar, curr_dist, pure_hit_points;
   local pl_loc = pl.location._pl_pos;
   if (length(mon_list)>0)
   {
       //Приглашение для краткого режима
       if (global.enemy_mode == ENEMY_MODE_SHORT) "<br>БОЙ: ";
       //Если есть враги, то друзья тоже будут ходить
       mon_list += GetFriendList(pl.location);
       for (i=1;i<=length(mon_list);i++)
       {
          mon = mon_list[i];
          //Если грохнули кого-то то не обрабатываем его действия
          if (mon.location==nil) continue;
          mon.UpdateLogic(pl.location);
          if (mon.location==nil) continue;
          act = mon.GetActType;
          //Если идёт паралич, то всегда будет выжидать
          if (mon._isParalized) act = MON_ACT_TYPE_WAIT;
          if (act==MON_ACT_TYPE_WAIT)
          {
             combo_wait(mon);
             if (global.enemy_mode == ENEMY_MODE_FULL) "<font color='gray'><<ZAG(mon,&sdesc)>> выжидает. </font><br>";
             else if (global.enemy_mode == ENEMY_MODE_SHORT) "Ж.";
          }
          else if (act==MON_ACT_TYPE_MOVE)
          {
             move_dir = mon.GetMoveDir;
             if (move_dir == MOVE_DIR_FORWARD)
             {
                mon._pos += 1;
                if (mon._pos > pl_loc)
                {
                   if (global.enemy_mode == ENEMY_MODE_FULL) "<font color='gray'><<ZAG(mon,&sdesc)>> отошел дальше от Вас.</font> <br>";
                   else if (global.enemy_mode == ENEMY_MODE_SHORT) "Н.";
                }
                else
                {
                   if (global.enemy_mode == ENEMY_MODE_FULL) "<font color='gray'><<ZAG(mon,&sdesc)>> подошел ближе к Вам. </font><br>";
                   else if (global.enemy_mode == ENEMY_MODE_SHORT) "В.";
                }
             }
             else if (move_dir == MOVE_DIR_BACKWARD)
             {
                if (mon._pos > 0)
                {
                   mon._pos -= 1;
                   if (mon._pos >= pl_loc)
                   {
                        if (global.enemy_mode == ENEMY_MODE_FULL) "<font color='gray'><<ZAG(mon,&sdesc)>> подошел ближе к Вам. </font><br>";
                        else if (global.enemy_mode == ENEMY_MODE_SHORT) "В.";
                   }
                   else
                   {
                        if (global.enemy_mode == ENEMY_MODE_FULL) "<font color='gray'><<ZAG(mon,&sdesc)>> отошел дальше от Вас. </font><br>";
                        else if (global.enemy_mode == ENEMY_MODE_SHORT) "Н.";
                   }
                }
             }
             else {
               "API ERROR:  unknown mon move direction!";
             }
          }
          else if (act==MON_ACT_TYPE_SHOOT)
          {
             tar = mon.GetShootTar(pl);
             if (tar != nil)
             {
                curr_dist =  GetDist(pl.location,mon);
                if (curr_dist == NO_DIST_TO_MONSTER) { "API ERROR: no monster on map!"; return;}
                //Рассчитываем урон
                pure_hit_points = mon.calcHit(curr_dist);
                tar.Hit(mon,pure_hit_points);
                //Обработка комб
                combo_shoot_monster(mon,tar,MonsterStubWeapon,pure_hit_points);
             }
             else{
               "API ERROR:  none tar when shoot!";
             }
          }
       }//end for
       //Стройная выдача описаний, после движения монстров
       if (global.enemy_mode == ENEMY_MODE_FULL)
       {
           for (i=1;i<=length(mon_list);i++)
           {
              mon = mon_list[i];
              if (mon.location != nil)
              {          
                 //Описываем, где он сейчас
                 mon.actorDesc; 
                 "<br>";
              }
           }
       }
   }//length(mon_list)>0
}
  
#pragma C-