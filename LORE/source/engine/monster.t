// Интерфейс движка для боевика
#pragma C++
//#include <shootable.t>
//#include <posdesc.t>

#define MON_ACT_TYPE_WAIT  1
#define MON_ACT_TYPE_MOVE  2
#define MON_ACT_TYPE_SHOOT 3

ella2: function( obj )
{
 local gen = obj.gender;
 if (gen==3) "ли";
 else
  {
  if (gen==1) ""; else
  if (gen==2) "ла"; else "ло";
  }
} 

//Монстры
class Monster : Actor
   /*bool*/ _isFriend /*init const*/ = nil   //Дружественный, не нападает на персонажей
   /*bool*/ _isParalized = nil //Объект парализован
   /*bool*/ _isDynamic /*init const*/ = nil  //Динамически создан, после уменьшения здоровья надо уничтожить
   /*init*/ _pos = 0 //текущая позиция
   /*init*/_hp = 20
   /*init*/_gen = 0 //количество генерируемых кристаллов
   /*init*/_max_hp = 20
   attack_desc = 'попал по'
   me_attack_desc = 'попал по вам'
//public:
   /*int*/ Hp() = {return self._hp;} /*const*/
   /*void*/ Hit(who,/*int*/ points) = { //повредить на заданное количество очков
      local is_my_hit = (who==Me);
      local real_hit_points = points;
      if (points <= 0) {
         "<<ZAG(who,&sdesc)>> промахнулись по <<self.ddesc>>.<br>";
         return;
      }
      if (self._hp <= points) {
         real_hit_points = self._hp;
         self._hp = 0;
         self.SayDead(who);
         Statist.SaveBattleKill(self._max_hp);
         self.moveInto(nil);
         if (self._gen > 0) ResourceSystem.GenFromEnemy(self._gen);
         if (self._isDynamic) delete self;
      }
      else
      {
         self._hp -= points;
         self.SayHit(who,points);
      }
      Statist.SaveBattleHit(real_hit_points,is_my_hit);
    } 
   /*void*/ Heal(/*int*/ points) = { //вылечить на заданное количество очков
      local add_points = points;
      if (points <= 0) return;
      if (self._hp + points > _max_hp) add_points = _max_hp - self._hp;
      self.SayHeal(add_points);
   }
//protected:
   /*virtual void*/SayDead(who) = {
     "<font color='fuchsia'><<ZAG(self,&sdesc)>> уничтожен.</font><br>";
   }
   /*void*/SayHit(who,points) = {
     if ((who != nil) && (who == Me)) self.SayHitMe(points);
     else if (who != nil) "<font color='teal'><<ZAG(who,&sdesc)>> <<who.attack_desc>> <<dToS(self,&ddesc)>> (-<<points>>).</font><br>";
     else "<<dToS(self,&ddesc)>> (-<<points>>).";
   }
   /*virtual void*/SayHitMe(points) = {
       "<font color='teal'><<ZAG(Me,&sdesc)>> <<Me.sel_weapon.shoot_desc>> <<dToS(self,&ddesc)>> (-<<points>>).</font><br>";
   }
   /*virtual void*/SayHeal(points) = {
     "<<ZAG(self,&sdesc)>> восстановлен на <<points>>.";
   }
   //обновить логику монстра
   /*virtual void*/UpdateLogic(loc) = {}
   /*virtual MON_ACT_TYPE*/ GetActType() = {return MON_ACT_TYPE_WAIT;}
   /*virtual int*/ GetMoveDir() = {return 0;}
   /*virtual int*/ calcHit(/*int*/D)={return 0;} //вычисление урона по цели от дальности   
   /*pntr*/ GetShootTar(pl) = {
      local pl_pos, min_dist;
      local curr_tar = nil;
      local i, mon_list, mon, cdist;
      if (self._isFriend == nil)
      {
          //определяем кто ближе - игрок или монстры-союзники на карте
          pl_pos = pl.location._pl_pos;
          min_dist = GetDist(pl.location,self);
          curr_tar = pl;
          mon_list = GetFriendList(pl.location);
          for (i=1;i<=length(mon_list);i++)
          {
             mon = mon_list[i];
             cdist = abs(self._pos - mon._pos);
             if (cdist < min_dist)
             {
                min_dist = cdist;
                curr_tar = mon;
             }
          }
      }
      else
      {
         mon_list = GetMonsterList(pl.location);
         min_dist = 9999;
         for (i=1;i<=length(mon_list);i++)
         {
             mon = mon_list[i];
             cdist = abs(self._pos - mon._pos);
             if (cdist < min_dist)
             {
                min_dist = cdist;
                curr_tar = mon;
             }
          }
      }
      
      return curr_tar;
   }
   
    sayLeaving =
	{
		self.location.dispParagraph;
		"<<ZAG(self,&sdesc)>> исчез"; ella2(self); ". ";
	}
	sayArriving =
	{
		self.location.dispParagraph;
		"<<ZAG(self,&sdesc)>> появил"; saas(self); " здесь. ";
	}
;
  
#pragma C-