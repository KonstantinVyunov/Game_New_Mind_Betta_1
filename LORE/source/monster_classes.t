//Классы существ
#pragma C++

//Стрелок (аналог зомби в DOOM)
class SimpleShooter : Monster
   _hp = 10
   _max_hp = 10
   _is_wait = nil
   _gen = 20
   ldesc = "Обычный стрелок. Никуда не ходит, только стреляет и иногда ожидает. Самая сильная атака на средней дистанции, плох на дальней и близкой, правда мало жизни. Иногда может восстановить своё здоровье. Урон: 3-15. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'попал стрелой по вам'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //с вероятностью 30% меняем тактику ходить в одну сторону, другую или стрелять
      if ( rangernd(1,10) <= 3 ) {
         if (self._is_wait == true) self._is_wait = nil;
         else self._is_wait = true;
      }
      
      //С определённой долей вероятности можем увеличить себе здоровье
      if (( rangernd(1,10) <= 3 ) && (self._hp < self._max_hp) && (global.is_easy==nil))
      {
         "<br><<self.sdesc>> восстановил здоровье.<br>";
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

//Царский стрелок
class KingShooter : Monster
   _hp = 60
   _max_hp = 60
   _is_wait = nil
   _gen = 50
   ldesc = "Царский стрелок. На голове что-то похожее на корону. Никуда не ходит, только стреляет и ожидает. Очень толстый. В них также почти нет никакой полезной энергии. Одинаковая атака на всех дистанциях, правда, не очень большая, скорее всего высокий пост заставил их лениться в практике стрельбы. Урон: 3-10. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'попал стрелой по вам'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //то стреляем, то ждем
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

//Штурмовик
class SimpleTrooper : Monster
   _hp = 30
   _max_hp = 30
   _last_move = nil
   _curr_dir = 0
   _gen = 30
   ldesc = "Обычный штурмовик. Всегда двигается на Вас, сражается только врукопашную. Иногда может в ярости перекинуть вас в дальний конец карты. Среднее количество жизни и низкая атака. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'ударил вас'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //Если рядом с нами нет персонажа, то идём к нему
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
      else
      {
         //С определённой долей вероятности уносим игрока в другой конец карты
         if (( rangernd(1,10) <= 3 ) && (self._pos != loc._field_size) && (global.is_easy==nil) )
         {
            "<br><<ZAG(self,&sdesc)>> могучим ударом откинул вас в конец карты и подбежал.<br>";
            self._pos = loc._field_size;
            loc._pl_pos = loc._field_size;
         }
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //На одной клетке с героем, выносим его
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

//Огневик
class SimpleFireMon : Monster
   _is_move = nil //сейчас движение
   _curr_dir = MOVE_DIR_FORWARD //текущее движение
   _hp = 10
   _max_hp = 10
   _gen = 10
   ldesc = "Обычный огневик. Бродит туда-сюда и переодически отстреливается. Может выпустить нефтяной шар, который будет гореть на жертве какое-то время. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'попал огненным шаром по вам'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //с вероятностью 30% меняем тактику ходить в одну сторону, другую или стрелять
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
         //если уперлись в тупик, то идём обратно
         if ( (self._curr_dir==MOVE_DIR_FORWARD) && (self._pos == loc._field_size) ) self._curr_dir = MOVE_DIR_BACKWARD;
         else if ( (self._curr_dir==MOVE_DIR_BACKWARD) && (self._pos == 0) ) self._curr_dir = MOVE_DIR_FORWARD; 
      }
      
      //Стреляем огненным шаром с нефтяной плёнкой
      if ( rangernd(1,10) <= 3 && (global.is_easy==nil) ) {
         "<br><<ZAG(self,&sdesc)>> выпустил по вам огненный шар из нефти!<br>";
         if (!FireBallLong.isIn(Me)) FireBallLong.moveInto(Me);
         //обновляем урон от шара
         FireBallLong._numFireTimeLeft = FireBallLong._maxFireTimeLeft;
         //выполняем урон сразу же
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
//Союзники
class KrioWall : Monster
   _hp = 10
   _max_hp = 10
   _isFriend = true
   _isDynamic = true
   _live_count = 0
   sdesc = "криостена"
   rdesc = "криостену"
   ddesc = "криостене"
   vdesc = "криостену"
   tdesc = "криостеной"
   pdesc = "криостене"
   noun = 'криостена' 'криостену' 'криостене' 'криостеной'
   isHer = true
   ldesc = "Криостена. Просто стит на месте и может защитить от выстрелов. Разрушается через 10 раундов. Жизней: <<self._hp>>/<<self._max_hp>>."
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      self._live_count++;
      if (self._live_count > 10){
        self.moveInto(nil);
        "Криостена распалась. ";
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
   pluraldesc = "дубликата"
   rpluraldesc = "дубликатов"
   sdesc = "дубликат"
   rdesc = "дубликату"
   ddesc = "дубликату"
   vdesc = "дубликат"
   tdesc = "дубликатом"
   pdesc = "дубликату"
   noun = 'дубликат' 'дубликату' 'дубликатом'
   isHim = true
   ldesc = "Дубликат искателя. Подходит к противнику и атакует с помощью крионожа. Жизней: <<self._hp>>/<<self._max_hp>>."
   
   need_attack=true
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      local closerMon = GetCloserMonTo(loc,self._pos);    
      
      //Если рядом с нами нет монстра, то идем к нему
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
        //Убираем из плавающего списка, при смерти
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
   desc = 'прозрачный/1пм столик/1м'
   noun = 'стол/1м' 'столик/1м'
   adjective = 'прозрачный/1пм' 'небольшой/1пм'
   isHim = true
   ldesc = "Небольшой прозрачный столик. Прочность: <<self._hp>>/<<self._max_hp>>."
   _hp = 1
   _max_hp = 1
   _pos = 2
;

//Паук-ремонтник
class SpiderFixer : Monster
   _hp = 10
   _max_hp = 10
   _last_move = nil
   _curr_dir = 0
   _gen = 0
   corpse = nil
   ldesc = "Агрессивный паук-ремонтник. Очень недоволен, что его отвлекают от работы. Всегда двигается на Вас, наносит небольшой урон строительным инструментом. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'порезал вас'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //Если рядом с нами нет персонажа, то идём к нему
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //дополнительно, может ждать случайным образом
     //На одной клетке с героем, выносим его
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
     "<font color='fuchsia'><<ZAG(self,&sdesc)>> уничтожен.</font><br>";
     if (self.corpse != nil) self.corpse.moveInto(Me.location); //перемещаем на его место трупика
   }
;

//Пылесос-уничтожитель
DustKiller : Monster
   _hp = 9000
   _max_hp = 9000
   _curr_state = 0
   _last_loc = nil
   _gen = 0
   mustHunt = nil
   desc = 'пылесборщик/1пм'
   noun = 'пылесос/1м' 'пылесборщик/1м' 'спрут/1м' 'астросборшик/1м' 'сборшик/1м'
   isHim = true
   ldesc = {
      show_image('duster.jpg');
      "Специальный агрегат для сбора и уничтожения опасных частиц на освоенных астероидах. Этот в перепрограммированном варианте сначала собирает пыль и мелкие обломки, а затем струёй направляет в противника. Прочность: <<self._hp>>/<<self._max_hp>>.";
   }
   me_attack_desc = 'выстрелил мусором по вам'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //Логика - всегда следуем за персонажем, находимся рядом
      //self.location = Me.location;
      self._pos = loc._pl_pos;
      //Обновляем атакующее состояние - до выдува.
      self._curr_state += 1;
      //Сообщаем о его действиях
      if (self._curr_state == 1) "Пылесборщик втягивает в себя окружающую пыль и мелкие предметы.";
      else if (self._curr_state == 3) { "Cборщик переключает режимы, готовится к выдуву."; play_sound('vacuum.ogg');}
      
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
   desc = 'сломанный/1пм пылесборщик/1пм'
   noun = 'пылесос/1м' 'пылесборщик/1м' 'спрут/1м' 'астросборшик/1м'
   adjective = 'сломанный/1пм'
   ldesc = "Вышедший из строя специальный агрегат для сбора и уничтожения опасных частиц на освоенных астероидах, некогда пытавшийся вас застрелить мелким мусором. Эх,а вы могли-бы подружиться."
   isHim = true
   enegryItem = true
   enegryGive = 50
;


lifter_gost : Monster
   desc = 'призрачный/1пм лифтёр/1м'
   noun = 'лифтёр/1м'
   adjective = 'призрачный/1пм'
   isHim = true
   ldesc = "Прочность: <<self._hp>>/<<self._max_hp>>."
   _hp = 1
   _max_hp = 1
   _pos = 0
;

//electro_cocon : Monster
//   desc = 'электрический/1пм кокон/1м'
//   noun = 'кокон/1м' 'электрококон/1м'
//   adjective = 'электрический/1пм'
//   isHim = true
//   ldesc = "Этот электрококон явно не к добру. Лучше как следует подготовиться, прежде чем из него что-то появиться. Прочность: <<self._hp>>/<<self._max_hp>>."
//   _hp = 1000
//   _max_hp = 1000
//   _pos = 10
//;

//Призрачная дама
LifterLady : Monster
   location = lifterroom
   _hp = 100
   _max_hp = 100
   _curr_state = 0
   _gen = 50
   _pos = 10
   desc = 'призрачная/1пжо дама/1жо'
   noun = 'дама/1жо' 'женщина/1жо' 'леди/1жо' 'дамочка/1жо' 'чудо-женщина/1жо'
   adjective = 'призрачная/1пжо'
   isHer = true
   ldesc = "Приятный точёный силует обтягивает строгий костюм, с расшитыми рукавами и воротником. Она была бы очень милой, если бы не полупрозрачная кожа и лёгкое синеватое сияние лица. Всё время атакует и никуда не двигается. Периодически может наносить сверхестественный урон, надо готовиться. Жизнь: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'ударила вас током'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //Обновляем атакующее состояние - до выдува.
      self._curr_state += 1;
      //Сообщаем о его действиях
      if (self._curr_state == 2) "Дамочка начинает копить силы.";
      else if (self._curr_state == 3) { "Кажется, чудо-женщина приготовилась к мощному удару!"; play_sound('highvoltage.ogg'); }
      
      if (self._curr_state==5) self._curr_state=1;
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     return MON_ACT_TYPE_SHOOT;
   }
   /*virtual int*/ calcHit(/*int*/D) = {
      if (self._curr_state == 4) {
         if  (global.is_easy==nil) return rangernd(50,60);
         else return 20; //для легкого дама послабее
      }
      else return rangernd(2,6);
   }
;

//Чужой
Alien : Monster
   location = nil
   _hp = 100
   _max_hp = 100
   _last_move = nil
   _curr_dir = 0
   _gen = 60
   sdesc = "чужой"
   rdesc = "чужого"
   ddesc = "чужому"
   vdesc = "чужого"
   tdesc = "чужим"
   pdesc = "чужому"
   noun = 'чужой/1мо' 'чужого' 'чужому' 'чужим' 'чужому#d' 'чужим#t' 'ксеноморф/1мо'
   isHim = true
   ldesc = "Чужой. Прямо как ксеноморф из фильма. Это двуногая прямоходящая особь, способная быстро перемещаться на четырёх конечностях, его организм состоит как из органических, так и неорганических соединений и представляет собой синтез кремниево-металлической и углеродной структуры. Как только увидит вас, быстро настигает и пытает, после сильного повреждения сбегает и залечивает раны. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'укусил вас'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //Если рядом с нами нет персонажа, то идём к нему
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //На одной клетке с героем, выносим его
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

//Супер-штурмовик
class HardTrooper : Monster
   _hp = 80
   _max_hp = 80
   _last_move = nil
   _curr_dir = 0
   _gen = 40
   ldesc = "Тяжелый штурмовик. Всегда двигается на Вас, сражается только ближним боем. Много жизни и средняя атака. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'ударил вас'
   
   //обновить логику монстра
   /*void*/UpdateLogic(loc) = {
      //Если рядом с нами нет персонажа, то идём к нему
      if ( self._pos != loc._pl_pos)
      {
        if (self._pos < loc._pl_pos) self._curr_dir = MOVE_DIR_FORWARD;
        else self._curr_dir = MOVE_DIR_BACKWARD;
        
        if (self._last_move==true) self._last_move=nil;
        else self._last_move=true;
      }
   }
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //На одной клетке с героем, выносим его
     if (self._pos == self.location._pl_pos) return MON_ACT_TYPE_SHOOT;
     else if (self._last_move == true) {
        //Когда ждет, и пытаются мимо пробежать - стукнем
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
   desc = 'напуганный/1пмо мальчик/1мо'
   noun = 'мальчик/1мо' 'пацан/1мо' 'ребенок/1мо'
   adjective = 'напуганный/1пмо' 'маленький/1пмо'
   isHim = true
   ldesc = "Напуганный мальчик. Не понимает что происходит и двигается хаотично, надо его защитить. Жизней: <<self._hp>>/<<self._max_hp>>."
   _hp = 20
   _max_hp = 20
   _pos = 2
   _isFriend = true
   /*virtual MON_ACT_TYPE*/ GetActType() = {
     //На одной клетке с героем, выносим его
     if (rangernd(1,3)==1)  return MON_ACT_TYPE_WAIT;
     return MON_ACT_TYPE_MOVE;
   }
   /*virtual int*/ GetMoveDir() = {
      if (rangernd(1,2)==1) return MOVE_DIR_FORWARD;
      return MOVE_DIR_BACKWARD;
   }
;


fishUdilshik : Monster
   desc = 'удильщик/1м'
   noun = 'удильщик/1м' 'рыба-удильщик/1м' 'черт/1м'
   adjective = 'морской/1пм'
   isHim = true
   ldesc = "Жуткая глубоководная рыба, со страшными челюстями и фонарём над головой. Этот образец явно перерос оригинала и может яростно выскакивать из воды для укуса. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'укусил вас'
   _hp = 70
   _max_hp = 70
   _pos = 0
   _gen = 40
   _is_atk = nil
   /*void*/UpdateLogic(loc) = {
     if (_is_atk == nil) "Морской чёрт готовится напасть!<br>";
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
   desc = 'плащеносная/1пж акула/1ж'
   noun = 'акула/1ж'
   adjective = 'плащеносная/1пм'
   isHer = true
   ldesc = "Огромная морская змея с мордой акулы. Во время нападения изгибает своё тело и делает бросок вперёд. Жизней: <<self._hp>>/<<self._max_hp>>."
   me_attack_desc = 'набросилась на вас'
   _hp = 70
   _max_hp = 70
   _pos = 0
   _gen = 40
   _is_atk = nil
   /*void*/UpdateLogic(loc) = {
     if (_is_atk == nil) "Акула изгибается перед броском!<br>";
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