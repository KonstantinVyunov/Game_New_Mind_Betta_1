//Классы боевых объектов в игре
//Всегда создаются динамически при крафте!
#pragma C++


//enum CraftItemType {
#define CRAFT_TYPE_REVOLVER   1
#define CRAFT_TYPE_SHOTGUN    2
#define CRAFT_TYPE_LASER      3
#define CRAFT_TYPE_MED_TUBE   4
#define CRAFT_TYPE_KNIFE_JUMP 5
#define CRAFT_TYPE_KNIFE_RET  6
#define CRAFT_TYPE_KRIO_ABSORB 7
#define CRAFT_TYPE_KRIO_WALL  8
#define CRAFT_TYPE_DROP_POIS  9
#define CRAFT_TYPE_MIND  10
#define CRAFT_TYPE_PARAL  11
#define CRAFT_TYPE_DUP  12
//}

//синтезируемый объект, класс для анализа в использовании
class SyntesisItem : fixeditem
   craft_id = -1
;

HealthTube : SyntesisItem
  craft_id = CRAFT_TYPE_MED_TUBE
  isEquivalent = true
  desc = 'шприц/1м'
  noun = 'шприц/1м'
  pluraldesc = "шприцы"
  rpluraldesc = "шприцев"
  isHim=true
  healVal = 30
  ldesc = "Одноразовый автоматический шприц с лекарством при применении добавляет <<self.healVal>> единиц здоровья. Выполнен в виде небольшого цилиндра с выскакивающей иглой."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     Me._hp += self.healVal;
     if (Me._hp > 100) Me._hp = 100;
     "Здоровье увеличено.";
     Statist.SaveUseHeal(self.healVal);
     delete self;
  }
;


KnifeSpeeder : SyntesisItem
  craft_id = CRAFT_TYPE_KNIFE_JUMP
  isEquivalent = true
  desc = 'криоускоритель/1м'
  noun = 'криоускоритель/1м'
  pluraldesc = "криоускорителя"
  rpluraldesc = "криоускорителей"
  isHim=true
  ldesc = "Криоускоритель позволяет прыгнуть к противнику и нанести удар, однократно. Для этого необходимо двигаться в его сторону с ножом в руке два метра. "
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboKnifeJump.isIn(Me))
     {
         "Криоускоритель включен.";
         ComboKnifeJump.moveInto(Me);
         delete self;
     }
     else "Нельзя активировать второй такой же эффект!";
  }
;


KnifeThrower : SyntesisItem
  craft_id = CRAFT_TYPE_KNIFE_RET
  isEquivalent = true
  desc = 'микровозврат/1м'
  noun = 'микровозврат/1м'
  pluraldesc = "микровозврата"
  rpluraldesc = "микровозвратов"
  isHim=true
  ldesc = "Микровозврат позволяет бросить нож в рядом стоящего противника, это происходит автоматически. Хватает на 5 бросков."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboKnifeThrow.isIn(Me))
     {
         "Микровозврат активирован.";
         //Если уже были возвраты, то добавляем
         if (ComboKnifeThrow._numActLeft<5) ComboKnifeThrow._numActLeft += 5;
         else ComboKnifeThrow._numActLeft = 5;
         ComboKnifeThrow.moveInto(Me);
         delete self;
     }
     else "Нельзя активировать второй такой же эффект!";
  }
;


KrioAbsorber : SyntesisItem
  craft_id = CRAFT_TYPE_KRIO_ABSORB
  isEquivalent = true
  desc = 'поглощатель/1м'
  noun = 'поглощатель/1м'
  pluraldesc = "поглощателя"
  rpluraldesc = "поглощателей"
  isHim=true
  ldesc = "Поглощатель включает криопоглощение нанесённых ударов. Правда, чтобы он сработал, два хода придётся ожидать. Повреждения полученные на второй ход аккумулируются в здоровье."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboKrioAbsorb.isIn(Me))
     {
         "Поглощатель запущен.";
         ComboKrioAbsorb.moveInto(Me);
         delete self;
     }
     else "Нельзя активировать второй такой же эффект!";
  }
;


KrioWallItem : SyntesisItem
  craft_id = CRAFT_TYPE_KRIO_WALL
  isEquivalent = true
  desc = 'криостена/1ж'
  noun = 'криостена/1ж'
  pluraldesc = "криостены"
  rpluraldesc = "криостен"
  isHer=true
  ldesc = "Криостена появляется на том месте, где вы стоите. Она вырастает из небольшого зерна мгновенно."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
      local wall = new KrioWall;
      wall._hp = wall._max_hp;
      wall.travelTo(actor.location);
      wall._pos = actor.location._pl_pos;
      "Из зерна выросла ледяная стена, испещрённая трещинками. ";
      delete self;
  }
;


PoisenItem : SyntesisItem
  craft_id = CRAFT_TYPE_DROP_POIS
  isEquivalent = true
  desc = 'яд/1м'
  noun = 'яд/1м'
  pluraldesc = "яда"
  rpluraldesc = "ядов"
  isHim=true
  ldesc = "Яд в капсуле. При выстреле из торсиона вредные вещества будут действовать на жертву."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboPoisenShot.isIn(Me))
     {
         "Капсула яда заправлена в торсион.";
         ComboPoisenShot.moveInto(Me);
         delete self;
     }
     else "Нельзя установить вторую такую же капсулу!";
  }
;


MindItem : SyntesisItem
  craft_id = CRAFT_TYPE_MIND
  isEquivalent = true
  desc = 'перебежчик/1ж'
  noun = 'перебежчик/1ж'
  pluraldesc = "перебежчика"
  rpluraldesc = "перебежчиков"
  isHim=true
  ldesc = "Перебежчик - капсула для дезоринетации противника. При выстреле из торсиона жертва будет в смятении нападать на своих в течение 5-и ходов."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboMindShot.isIn(Me))
     {
         "Капсула перебежчика заправлена в торсион.";
         ComboMindShot.moveInto(Me);
         delete self;
     }
     else "Нельзя установить вторую такую же капсулу!";
  }
;


ParalizeItem : SyntesisItem
  craft_id = CRAFT_TYPE_PARAL
  isEquivalent = true
  desc = 'изоляция/1ж'
  noun = 'изоляция/1ж'
  pluraldesc = "изоляции"
  rpluraldesc = "изоляций"
  isHer=true
  ldesc = "Изоляция - капсула для остановки атаки противника. При выстреле из торсиона жертва не будет нападать в течение 3-х ходов."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboParalizeShot.isIn(Me))
     {
         "Капсула изоляции заправлена в торсион.";
         ComboParalizeShot.moveInto(Me);
         delete self;
     }
     else "Нельзя установить вторую такую же капсулу!";
  }
;


DuplicateItem : SyntesisItem
  craft_id = CRAFT_TYPE_DUP
  isEquivalent = true
  desc = 'копия/1ж'
  noun = 'копия/1ж'
  pluraldesc = "копии"
  rpluraldesc = "копий"
  isHer=true
  ldesc = "Копия Искателя. При выстреле из торсиона рядом с целью появляется дубликат Искателя, вооруженный крионожом."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboDuplicate.isIn(Me))
     {
         "Капсула копии заправлена в торсион.";
         ComboDuplicate.moveInto(Me);
         delete self;
     }
     else "Нельзя установить вторую такую же капсулу!";
  }
;


#pragma C-