// Интерфейс движка для боевика
#pragma C++

class Weapon : fixeditem
   isListed = true
   _bullets = 0 //сколько патронов
   shortdesc = 'КРАТКО'
   isCloseCombat = nil
   verDoTake(actor) = {self.verDoSelect(actor);}
   doTake(actor) = {self.doSelect(actor);}
   verDoSelect(actor) = {if (actor.sel_weapon == self) "Это оружие уже выбрано!";}
   doSelect(actor) = {
      actor.sel_weapon = self;
      "Новое оружие: <<self.sdesc>>";
   }
   verIoShootWith(actor) = {} //разрешаем верификатор в thing
   shoot_desc = 'выстрелили по' //Вы 
   shoot_sound = [] //звуки выстрелов
//public:
   /*int*/ calcHit(/*int*/D)={return 0;}   
;

//Оружие-заглушка для вычисления комбинаций с моснтрами
MonsterStubWeapon : Weapon
;
  
#pragma C-