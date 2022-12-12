//Классы комбинаций в игре
#pragma C++

////////////////////////////////////////////////
//Служебный обработчик комбинаций

//эффект от комбинаций - ложится в объект ComboEffectProcessor
//ВСЕГДА создаётся динамически, через new
//Удаляем через delEffect ComboEffectProcessor
class Effect : object
  //protected virtual:
  doEffect = {
     //TODO: определите результат эффекта в своём классе, потом необходимо удалять эффект через delete
  }
  //дективация эффектов
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
   //Добавляем спец-эффект
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
   //На любое действие обрабатываем эффект
   shootTar(who,tar,wpn,points)={self.procEffect;}
   battleWt(who)={self.procEffect;}
   battleMv(who,direction)={self.procEffect;}
;


////////////////////////////////////////////////
//НОЖ

ComboKnifeJump : Combo
   _state = 0
   _last_dir = 0
   desc = 'прыжок/1м с ножом'
   ldesc = "Если вы выберете нож, и будете двигаться вперёд к противнику в течение двух ходов подряд, то вы подскочите к ближайшему противнику и поразите его ударом ножа."
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
            //выполнение прыжка к ближайшему врагу
            who.location._pl_pos = closer_mon._pos;
            "<font color='lime'>С крионожом в руке и огромными прыжками вы настигли ближайшего по пути противника и пырнули его.</font> ";
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
   desc = 'бросок/1м ножа'
   ldesc = "Если есть противник рядом или в клетке от вас, то произойдет автоматический бросок ножа. Наносится полный урон. Осталось бросков: <<self._numActLeft>>"
   _numActLeft = 5 //сколько осталось бросков.
   preBattleAny(who) = {
      if ( who.sel_weapon == Knife )
      {
         local pos = who.location._pl_pos;
         local mon = GetMonOnPos(who.location,pos);
         if (mon == nil) mon = GetMonOnPos(who.location,pos+1);
         else if (mon == nil) mon = GetMonOnPos(who.location,pos-1);
         
         if (mon != nil)
         {
            "<font color='lime'>Ранив <<mon.vdesc>>, нож мгновенно вернулся в руку.</font> ";
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
   desc = 'криопоглощение/1мс'
   ldesc = "Если вы будете ожидать в течение двух ходов, то полученные на первом ходу повреждения на второй ход аккумулируются в здоровье. Осталось поглощений: <<self._numActLeft>>"
   _numActLeft = 3 //сколько осталось поглощений
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
            "<font color='lime'>Криопоглощение сработало, вам восстановлена часть здоровья после повреждений.</font> ";
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
        local mon = GetMonOnPos(Me.location,self.shot_pos); //TODO: избавиться от Me
        "Криоволна на позиции <<self.shot_pos>>. ";
        if (mon!=nil) mon.Hit(nil,hit_val);
     }
     else
     {
        //Убираем эффект
        "Криоволна пропала. ";
        ComboEffectProcessor.delEffect(self);
     }
  }
;

ComboKrioWave : Combo
   _wave_dir = 0
   desc = 'создание/1мс криоволны/1мс'
   ldesc = "Возникает крио-волна, которая будет идти с дальнего конца карты и продолжится до вас, нанося небольшие повреждения всем противникам."
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
     "Криоволна запущена. ";
     self.moveInto(nil);
     self.reset;
   }
;

////////////////////////////////////////////////
//ПИСТОЛЕТ

//Комбинация пристрелка 
ComboPistolPristrel : Combo
   _state = 0
   _last_tar = nil
   desc = 'пристрелка/1ж револьвером'
   ldesc = "Если вы выберете пистолет и третий раз подряд попадаете в монстра он получает точно такой же урон дополнительно."
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
         "Вы еще раз внимательно прицелились и выстрелили сразу же второй пулей по пути первой. ";
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
        local mon = GetMonOnPos(Me.location,self.shot_pos); //TODO: избавиться от Me
        "Робовыстрел на <<self.shot_pos>>. ";
        if (mon!=nil) mon.Hit(nil,hit_val);
     }
     else
     {
        //Убираем эффект
        "Робовыстрел отключен. ";
        ComboEffectProcessor.delEffect(self);
     }
  }
;

//Комбинация робовыстрел
ComboPistolRoboShot : Combo
   desc = 'робовыстрел/1м'
   ldesc = "включается режим продолжения выстрела и наносится по два повреждения до конца карты каждый ход по одному из монстров в следующих клетках."
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
     "Режим робовыстрела активирован. ";         
     self.reset;
   }
;

////////////////////////////////////////////////
//ДРОБОВИК

//Комбинация выстрел дробовика
//ComboDroboShot : Combo
//   showInList = nil
//   location = Me
//   desc = 'выстрел/1м дробовика'
//   ldesc = "Когда вы стреляете дробовиком в цель, то другие цели в этой же клетке получают урон."
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
//ТОРСИОН

//Комбинация ядовитая капсула
class PoisenEffect : Effect
  pois_tar = nil
  total_pos_num = 0
  doEffect = {     
     if ( pois_tar.location != nil )
     {     
        "<font color='lime'>Яд действует на <<pois_tar.rdesc>>.</font> ";
        pois_tar.Hit(nil,7);
        total_pos_num += 1;
     }
     else
     {
        //Убираем эффект после смерти
        //"Яд перестал действовать. ";
        ComboEffectProcessor.delEffect(self);
     }
  }
;

ComboPoisenShot : Combo
   desc = 'ядовитая/1пж капсула/1ж'
   ldesc = "Когда вы стреляете торсионом в цель, то объект получает урон от капсулы с ядом (3) каждый ход."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local eff = new PoisenEffect;
         eff.pois_tar = tar;
         ComboEffectProcessor.addEffect(eff);
         "<font color='lime'>Вы отравили <<tar.rdesc>>.</font> ";
         self.moveInto(nil);
      }
   }
;

//Комбинация дизориентация
class MindTrickEffect : Effect
  mind_tar = nil
  total_pos_num = 0
  doEffect = {     
     //Работет только когда есть враги
     if ( (mind_tar.location != nil) && (self.total_pos_num<=5) && (HaveMonsters(mind_tar.location)) )
     {     
        self.total_pos_num += 1;
     }
     else
     {
        //Убираем эффект
        if (mind_tar.location != nil) "<font color='lime'>Дизориентация перестала действовать.</font> ";
        mind_tar._isFriend = nil;
        ComboEffectProcessor.delEffect(self);
     }
  }
  deact = {
     mind_tar._isFriend = nil;
  }
;

ComboMindShot : Combo
   desc = 'перебежчик/1м'
   ldesc = "Когда вы стреляете торсионом в цель, то объект из-за дизориентации нападает на соседних монстров в течение пяти ходов."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local eff = new MindTrickEffect;
         eff.mind_tar = tar;
         tar._isFriend = true;
         ComboEffectProcessor.addEffect(eff);
         "<font color='lime'><<tar.sdesc>> дизоринетирован.</font> ";
         self.moveInto(nil);
      }
   }
;

//Комбинация паралич
class ParalizeEffect : Effect
  mind_tar = nil
  total_pos_num = 0
  doEffect = {     
     if ( (mind_tar.location != nil) && (self.total_pos_num<3) )
     {     
        "<font color='lime'>Изоляция продолжается (осталось ходов: <<3-self.total_pos_num>>). </font> ";
        self.total_pos_num += 1;
     }
     else
     {
        //Убираем эффект
        if (self.total_pos_num >= 3) "<font color='lime'>Изоляция перестала действовать. </font> ";
        mind_tar._isParalized = nil;
        ComboEffectProcessor.delEffect(self);
     }
  }
  deact = {
     mind_tar._isParalized = nil;
  }
;

ComboParalizeShot : Combo
   desc = 'изолятор/1м'
   ldesc = "Когда вы стреляете торсионом в цель, то объект не нападает в течение трех ходов."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local eff = new ParalizeEffect;
         eff.mind_tar = tar;
         tar._isParalized = true;
         ComboEffectProcessor.addEffect(eff);
         "<font color='lime'><<tar.sdesc>> изолирован.</font> ";
         self.moveInto(nil);
      }
   }
;

//Комбинация дубликат
ComboDuplicate : Combo
   desc = 'дубликат/1м'
   ldesc = "Когда вы стреляете торсионом в цель, то рядом с ним, образуется ваша квантовая копия, с базовым оружием - крионожом."
   shootTar(who,tar,wpn,points)={
      if ( wpn==TorsionGenerator )
      {
         local isk = new Duplicate;
		 Duplicate._hp = Duplicate._max_hp;
         Duplicate._pos = tar._pos;
         //Объект при создании добавляется в список последователей
         Me.followList += isk;
         Duplicate.moveInto(who.location);
         "<font color='lime'>Дубликат появился рядом с <<tar.tdesc>>.</font> ";
         self.moveInto(nil);
      }
   }
;

FireBallLong : Combo
   desc = 'горение/1с'
   ldesc = "Горящая нефтяная плёнка от огненного шара. Каждый ход наносит вам определённый урон. Осталось гореть: <<self._numFireTimeLeft>>"
   _maxFireTimeLeft = 3 //максимальное время горения
   _numFireTimeLeft = 3 //сколько осталось
   _hitPoints = 5
   preBattleAny(who) = { 
     if (self._numFireTimeLeft > 0)
     {
        "<font color='red'>Горящая нефтяная плёнка обжигает вас (-<<self._hitPoints>>).</font> ";
        Me.Hit(nil,self._hitPoints);
        self._numFireTimeLeft -= 1;
        if (self._numFireTimeLeft==0) self.moveInto(nil);
     }
   }
;

#pragma C-