////////////////////////////////

#include <ochkoGame.t>

prepareLevel3 : function {
   show_image('lift.jpg');
   "<b>* ДОБАВЛЕНО ОРУЖИЕ - ДРОБОВИК</b><br>";
   "<b>* ДОБАВЛЕН СИНТЕЗ - ПАТРОНЫ ДЛЯ ДРОБОВИКА</b><br>";
   Drobovik.moveInto(Me);
   edgeMachine.unregister;
   hotelMachine.register;
   CraftSystem.enableCraft(CRAFT_TYPE_SHOTGUN);
   global.level_play_music = 'Sara_Afonso_-_Underwater_Experience.ogg';
   stop_music_back();
   play_music_loop('Sara_Afonso_-_Underwater_Experience.ogg');
   Knife.moveInto(Me);
   Me.sel_weapon=Knife;
   NoneWeapon.moveInto(nil);
   Me.Heal;
   
   global.curr_level = 3;
   
   //добавляем с предыдущих уровней
   CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
   Pistol.moveInto(Me);
   CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
   CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
   CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
   CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
   TorsionGenerator.moveInto(Me);
   
   Statist.Prepare([cleaner_bot tramvaika wooden_door hole_kitchen reshetka_to_kitchen fen_destruct living_window skaf_main_alien zaval_alien_one help_but_alien_two luk_alien_three]);
    
   Me.travelTo(startcor_room);
}

startcor_room: room
   sdesc="Начало узкого коридора"
   lit_desc = 'Мерцающий свет галогеновой лампы под потолком позволяет разглядеть несколько дверей дальше по коридору. На стенах висят небольшие принты в рамках. Основной холл на востоке, узкий коридор продолжается на запад.'
   //запад
   west = midcor_room
   //восток
   east = {
     aresa_say('Ты хочешь встретиться с кучей неприятностей?');
     return nil;
   }
;

startcorDecoration : decoration
  location = startcor_room
  isHer = true
  desc = 'эта часть/1м помещения'
  noun = 'коридор/1м' 'потолок/1м'
  adjective = 'узкий/1пм'
;

cleaner_bot : DestructItem
   location = startcor_room
   desc = 'пылесос/1м'
   noun = 'пылесос/1м' 'робот/1м' 'шайба/1ж'
   isHim = true
   ldesc = "Отключенный робот пылесос, эдакая шайба-переросток."
;

tramvaika : DestructItem
   location = startcor_room
   desc = 'обогреватель/1м'
   noun = 'обогреватель/1м' 'трамвайка/1ж'
   adjective = 'масляная/1пж'
   isHim = true
   ldesc = "Сомнительно, что хозяева заведения будут использовать опасную масляную трамвайку! Она выглядит похоже, а внутри, как обычно, умные системы, датчики температуры и анализаторы самочувствия близко стоящих персон. Мистер, вы разозлились? Пора чуть уменьшить температуру. Госпожа, вы печальны? Немного тепла и вы будете чувствовать себя чуть лучше! "
;

galogen : decoration
   location = startcor_room
   desc = 'галогеновая/1пж лампа/1ж'
   noun = 'лампа/1ж' 'галогенка/1ж' 'свет/1м'
   adjective = 'галогеновая/1пж' 'мерцающий/1пм'
   isHer = true
   ldesc = "Жутковато выглядит. Скоро перегорит. Если не перегорит то детвора поможет ей умереть. Для нас бесполезна. "
;

doors_far : distantItem
   location = startcor_room
   desc = 'двери/2'
   ldesc = "надо подойти поближе, отсюда не разобрать. "
;

print_on_wall : decoration
   location = startcor_room
   desc = 'принт/1м'
   noun = 'принт/1м' 'фотография/1ж' 'рамка/1ж' 'стена/1ж' 'рыба/1ж' 'рыбёха/1ж'
          'принты/2' 'фотографии/2'  'рамки/2'  'стены/2'  'рыбы/2'  'рыбёхи/2'
          'постоялец/1м' 'фонарь/1м'
   isHim = true
   ldesc = "Святые угодники! На живой фотографии какой-то постоялец держит на руках рыбу, длиной метра в два и высотой около метра, головы человека совсем не видно. Устоять на ногах ровно не может, колени трясутся, но снимок сделать очень хочеться. Кажется, какая-то глубоководная рыбёха, с фонарём на голове, странно.  "
;


//////////////////////////

midcor_room : room
   sdesc="Середина узкого коридора"
   lit_desc = {
      if (reshetka_to_kitchen.location == midcor_room) return 'Коридор продолжается на запад, на серой стене деревянная дверь номера, чуть правее на полу вентиляционная шахта, закрытая декоративной решеткой.';
      return 'Коридор продолжается на запад, на серой стене деревянная дверь номера, чуть правее на полу вентиляционная шахта.';
   }
   was_find_pair = nil
   enterRoom(actor) = 
   {
      if (self.was_find_pair==nil) {
         scen_lvl3_meet_pair();
         self.was_find_pair=true;
      }
      pass enterRoom;
   }
   //запад
   west = fincor_room
   //восток
   east = startcor_room
   north = {
     if (hole_kitchen.seeExit == nil) {
        aresa_say('Куда ты хочешь воткнуться в стену что-ли?');
        return nil;
     }
     //через вентиляцию
     scen_lvl3_ventil();
     return kitchen_room;
   }
;


wooden_door : fixeditem
  desc = 'деревянная/1пж дверь/1ж'
  ldesc = "По виду обычная деревянная дверь."
  location = midcor_room
  isHer = true
  verDoOpen(actor) = {aresa_say('Да она же внутри пласталевая! То же мне, декораторы хреновы, надо искать другой путь.');}
  verDoKnock(actor) = {aresa_say('Тук-тук, дверь открой, там в лесу охотник злой. Никого нет, или боятся.');}
  verDoShoot(actor) = {aresa_say('Пау-пау! Дверь убита! А нет, строители кажется её хорошо усилили, мы долго будем возиться.');}
;

fire_mon_hunt1 : SimpleFireMon
   desc = 'удивлённый/1пмо огневик/1мо'
   location = midcor_room
   isHim = true
   _pos = 5
;

fire_mon_hunt2 : SimpleFireMon
   desc = 'разозлённый/1пмо огневик/1мо'
   location = midcor_room
   isHim = true
   _pos = 4
;

hole_kitchen : LukSimple
   location = midcor_room
   desc = 'вентиляционная/1пж шахта/1ж'
   noun = 'шахта/1ж' 'дыра/1ж'
   adjective = 'вентиляционная/1пж'
   isHer = true
   seeExit = nil
   ldesc = {
      "Достаточно просторная, чтобы вы поместились. Ведет на север.";
      hole_kitchen.seeExit = true;
   }
;

reshetka_to_kitchen : EasyTake
   location = midcor_room
   desc = 'вентиляционная/1пж решетка/1ж'
   noun = 'решетка/1ж'
   adjective = 'вентиляционная/1пж'
   isHer = true
   ldesc = { 
      "Сквозь решетку виднеется проход на север.";
      hole_kitchen.seeExit = true;
   }
   verDoTake(actor) = {}
   doTake(actor) = {
      "Вы смяли решетку одним движением и откинули искорёженный металл подальше.";
      self.moveInto(nil);
   }
;

/////////////////////////

fincor_room : room
   sdesc="Конец узкого коридора"
   lit_desc = 'Коридор тут заканчивается, обратно только на восток. В этом тупике бронированная дверь в один из номеров.'
   //восток
   east = midcor_room
   out = midcor_room
;

broned_door : fixeditem
  desc = 'бронированная/1пж дверь/1ж'
  noun = 'дверь/1ж' 'номер/1м'
  ldesc = "Закрытая и защищенная дверь, слишком долго с ней возиться."
  location = fincor_room
  isHer = true
  verDoKnock(actor) = {aresa_say('Тук-тук, дверь открой, там в лесу охотник злой. Никого нет, или боятся.');}
  verDoShoot(actor) = {aresa_say('Пау-пау! Дверь убита! А нет, строители кажется её хорошо усилили, мы долго будем возиться.');}
;

///////////////////////

kitchen_room : room
   sdesc="Кухня"
   lit_desc = 'Супер-аскетичная эко-кухня. Деревянные полки в виде простых неструганных досок, на которых рядком выстроены керамические тарелки. Напротив пыльная печь. На северо-востоке проход в ванную, на северо-западе в гостиную.'
   //северо-восток
   ne = bath_room
   //северо-запад
   nw = living_room
;

kitchenDecor : decoration
   location = kitchen_room
   isHer = true
   desc = 'эта часть/1ж кухни'
   noun = 'зазубрина/1ж' 'постоялец/1м' 'орнамент/1м' 
          'зазубрины/2'  'постояльцы/2' 'орнаменты/2' 
          'пыль/1ж' 'мясо/1ж' 'рыба/1ж' 
   adjective = 'простой/1пм' 'яркий/1пм' 'восточный/1пм'
               'простые/2п'  'яркие/2п'  'восточные/2п'
;


polka : decoration
   location = kitchen_room
   desc = 'деревянная/1пж полка/1ж'
   noun = 'полка/1ж' 'доска/1ж' 'полки/2' 'доски/2'
   adjective = 'деревянная/1пж' 'деревянные/2п'
   isHer = true
   ldesc = "Засаленная доска, вся в зазубринах. Видимо постоялец настолько вжился в образ сельского жителя, что оставлял в сыром виде мясо или рыбу на полках."
;

plates : decoration
   location = kitchen_room
   desc = 'керамические/2п тарелки/2'
   noun = 'тарелки/2' 'тарелка/1ж' 'миски/2' 'миска/1ж' 'посуда/1ж'
   isThem = true
   ldesc = "Некоторые тарелки совсем простые, другие ярко выделяются восточным орнаментом."
;

pech : fixeditem
   location = kitchen_room
   desc = 'пыльная/1пж печь/1ж'
   noun = 'печь/1ж' 'печка/1ж'
   adjective = 'пыльная/1пж'
   isHer = true
   ldesc = "Винтажная чугунная печь, вся в пыли. Дверца топки закрыта."
;

door_pech : EasyTake
   location = kitchen_room
   desc = 'дверца/1ж'
   noun = 'дверца/1ж' 'топка/1ж' 'заслонка/1ж' 'задвижка/1ж'
   isHer = true
   ldesc = "Дверца плотно закрывает топку."
   wasTaken = nil
   verDoTake(actor) = {if (self.wasTaken) aresa_say('Ты уже нашел колобка, там больше ничего нет.'); }
   doTake(actor) = {
      "Вы открыли дверцу и за ней обнаружили механический шар со ртом и глазами.<br>";
      aresa_say('Это же колобок из старинной русской сказки! Ну, что милейший, ты от бабушки ушел и от дедушки ушел, а от нас думаешь укатишься?');
      self.wasTaken = true;
      kolobok.moveInto(kitchen_room);
      "Когда Вы вытащили странную игрушку, дверца с противным скрипом медленно закрылась сама собой.<br>";
   }
;


kolobok : DestructItem
   location = nil
   resAmount = RESOURCE_AMOUNT_HIGH
   desc = 'колобок/1м'
   noun = 'колобок/1м' 'шар/1м' 'шарик/1м' 'игрушка/1ж' 'лицо/1с'
   adjective = 'механический/1пм' 'круглый/1пм' 'странная/1пж'
   isHim = true
   ldesc = "Круглое лицо, смотрит на вас хлопая глазками. Кажется, он напрочь лишился дара речи от удивления."
;

/////////////
bath_room : room
   sdesc="Ванная комната"
   lit_desc = 'Ванна в стиле лофт. Кремовая затемнённая плитка отчётливо выделяет водяные трубы, идущие к подвесной раковине. На юго-западе выход на кухню.'
   //юго-запад
   sw = kitchen_room
   out = kitchen_room
;

fen_destruct : DestructItem
   location = bath_room
   desc = 'фен/1м'
   isHim = true
   ldesc = "Предназначен для сушки волосистых участков человеческого тела. Думаете простой? Конечно нет! По крайней мере у него есть опция вызова пожарной бригады, если кто-то решил подсушить им что-то неподходящее. "
;

plitka : decoration
   location = bath_room
   desc = 'затемнённая/1пж плитка/1ж'
   noun = 'плитка/1ж' 'плитки/2'
   adjective = 'затемнённая/1пж'
   isHer = true
   ldesc = "Она такая грязкая, что на ней можно рисовать пальцами. В 3D."
;

trub : decoration
   location = bath_room
   desc = 'водяная/1пж труба/1ж'
   noun = 'труба/1ж' 'трубы/2'
   adjective = 'водяная/1пж'
   isHer = true
   ldesc = "Очень удобная конструкция. Если надо заменить сломанные трубы, не придётся разбирать всю плитку. Давайте только не будем сейчас строить из себя водопроводчиков?"
;


racovina : decoration
   location = bath_room
   desc = 'подвесная/1пж раковина/1ж'
   noun = 'раковина/1ж' 'смеситель/1м' 'кран/1м' 'смесители/2' 'краны/2'
   adjective = 'подвесная/1пж' 'белая/1пж' 'классическая/1пж'
   isHer = true
   ldesc = "Белая классическая раковина, с интересными изгибами. Два отдельных смесителя под горячую и холодную воду. Англичане, блин. А русскую печь зачем тогда в номер притащили? "
;

/////////////
living_room : room
   sdesc="Гостиная"
   lit_desc = 'Стены просторной комнаты выполнены из декоративного кирпича. Двуспальная кровать приютилась возле одной из стен. Рядом с туалетным столиком затемнённое окно. На юго-востоке выход на кухню.'
   //юго-восток
   se = kitchen_room
;


bed_living : BedSimple
   location = living_room
   desc = 'кровать/1ж'
   noun = 'кровать/1ж' 'подголовник/1м' 'покрывало/1' 'подушка/1ж' 'одеяло/1'
   adjective = 'двуспальная/1пж'
   isHer = true
   ldesc = "Двуспальная кровать с высоким подголовником. Такого размера, что двоим людям можно спать хоть по диагонали. Покрывало и подушки в спокойных тонах. "
;

stolik_living : decoration
   location = living_room
   desc = 'туалетный/1пм столик/1м'
   noun = 'столик/1м' 'шкафчик/1м' 'косметика/1ж'
   isHim = true
   ldesc = "Минималистичный столик со шкафчиком для косметики. Всё-таки номер больше походит на мужской, а столик, видимо, для редко посещающих это место дам."
   verDoOpen(actor) = {"Когда вы открыли столик, то помимо косметики обнаружили много неприличных вещей, для всяких взрослых дел. Ареса издала звук, похожий на кашель. Вы поняли намёк и закрыли шкафчик.";}
;

living_window : fixeditem
  desc = 'затемнённое/1пс окно/1с'
  ldesc = "Тёмное окно, совершенно непонятно что за ним."
  location = living_room
  verDoOpen(actor) = {aresa_say('Не открывается, оно запечатано!');}
  verDoShoot(actor) = {}
  doShoot(actor) = {
    show_image('flyer.jpg');
    scen_lvl3_jump_on_car();
    Me.travelTo(car_flying_room);
  }
;

//////////
car_flying_room : room
  sdesc="На летающей машине"
  listendesc = "Рокот флаеров просто оглушает!"
  lit_desc = 'Ретро флаер, несущийся по узкой улочке подземной части водного комплекса. Места мало, требуются усилия, чтобы с него не свалиться.'
  _field_size = 3
  mayJumpOut = true
  noexit = {
    //при выходе не вовремя, умираем
    if (hotelMachine.allow_jump) {
      "Спрыгнув на крышу ангара, вы начали скатываться по ней, но недолго. Крыша под вами проломилась и упав в темноте на какую-то железяку вы потеряли сознание. <br>";
      hotelMachine.out_of_car = true;
      Me.Heal;
      scen_lvl3_in_angar();
      show_image('alien.jpg');
      return alien_main_room;
    }
    else{
        "Спрыгнув с флаера Вы просто разбились.";
        die();
        return nil;
    }
  }
;

flyerDecor : decorationNotDirect
   location = car_flying_room
   isHer = true
   desc = 'этот объект/1м'
   noun = 'флаер/1м' 'флаейр/1м' 'улочка/1м' 'улица/1м' 'машина/1ж'
          'флаеры/2' 'флаейры/2' 'улочки/2'  'улицы/2'  'машины/2'
          'комплекс/1м'   
   adjective = 'подземный/1пм' 'водный/1пм' 'спортивный/1пм' 'медленный/1пм'
;

//////////
alien_main_room : room
  sdesc="В центре круглого зала"
  lit_desc = 'Круглый зал для совещаний. Над овальным столом висит блок мониторов. По контуру размещены проходы в различные секции. У одной из стен просторный вещевой шкафчик. Пройти можно на север, юг и наверх.'
  listendesc = "Мрачные скрипы доносятся непонятно откуда."
  north = alien_one_room
  up = alien_two_room
  south  = alien_three_room
  isSayShow = nil
  leaveRoom(actor) =
  {
     if (isSayShow == nil){
        scen_lvl3_find_robots();
        isSayShow = true;
     }
     pass leaveRoom;
  }
;

alienMainDecor : decorationNotDirect
   location = alien_main_room
   isHer = true
   desc = 'этот объект/1м'
   noun = 'пятно/1с' 'контур/1м' 'проход/1м' 'секция/1м' 'стена/1м' 
          'пятна/2'  'контуры/2' 'проходы/2' 'секции/2'  'стены/2'
          'зал/1м' 'потолок/1м' 'центр/1м'
   adjective = 'круглый/1пм' 'декоративное/1п'
;

mon_block : fixeditem
  desc = 'блок/1м'
  noun = 'блок/1м' 'монитор/1м' 'экран/1м' 'мониторы/2' 'экраны/2'
  ldesc = "Блок мониторов расположен под потолком, кольцом. Экраны находятся в углублениях, по всему контуру."
  location = alien_main_room
;

circ_table : FunnyFixedItem
  desc = 'овальный/1пм стол/1м'
  noun = 'стол/1м' 'столик/1м'
  adjective = 'овальный/1пм'
  ldesc = "Овальный стол служит для диспутов команды и просмотра рабочих материалов. В центре эффектное декоративное пятно."
  location = alien_main_room
;

skaf_main_alien : fixeditem
  desc = 'вещевой/1пм шкаф/1м'
  noun = 'шкаф/1м' 'шкафчик/1м'
  adjective = 'вещевой/1пм'
  ldesc = "Вещевой шкафчик, как будто никто им не пользовался."
  location = alien_main_room
  isOpen = nil
  isHim = true
  verDoShoot(actor) = {aresa_say('Твоя карма не улучшиться, если ты еще и шкаф разнесёшь!');}
  verDoEnter(actor) = {}
  doEnter(actor) = {self.doBoard(actor);}
  verDoBoard(actor) = {}
  doBoard(actor) = {
     if (hotelMachine.say_out_alien == nil) aresa_say('Зачем ютиться в этом шкафу, если в твоём распоряжении целый корабль! Хотя, в этом определённо что-то есть...');
     else
     {
        if (HaveMonsters(Me.location)) aresa_say('Я тебе говорила, залазь в шкаф без Чужого, иначе наш план раскроют. Разберись с ним сначала.');
        else
        {
           Statist.Show(3);
           "<i>(Для продолжения нажмите ВВОД</i>)<br>";
           input();
           scen_lvl3_in_self();
           resourceSaveToGlobal();
           prepareLevel4();
           //win();
        }
     }
  }
  verDoOpen(actor) = {}
  doOpen(actor) = {
     if (self.isOpen == nil)
     {
        "Вы открыли шкаф<br>";
        aresa_say('Хмм, никто ничего не припрятал в этом шкафу?');
        self.isOpen = true;
     }
     else
     {
        "Шкаф уже открыт.";
     }
  }
  verDoClose(actor) = {}
  doClose(actor) = {
     if (self.isOpen == nil){aresa_say('Легко закрывать закрытый шкаф, не правда ли?');}
     else {aresa_say('Ты его так долго открывал и теперь всю работу пустишь насмарку?');}
  }
;

////////

alien_one_room : room
  sdesc="Коридор с завалом"
  lit_desc = 'Длинный коридор, в конце которого завал из груды металла. Вернуться можно на юг.'
  south = alien_main_room
  listendesc = "Мрачные скрипы доносятся непонятно откуда."
;


alienOneDecor : decorationNotDirect
   location = alien_one_room
   isHer = true
   desc = 'этот объект/1м'
   noun = 'проход/1м' 'секция/1м' 'стена/1м' 
          'проходы/2' 'секции/2'  'стены/2'
          'потолок/1м'
;

broken_bot1 : DestructItem
   location = alien_one_room
   desc = 'гусеничный/1пм робот/1м'
   noun = 'робот/1м' 'гесеницы/2' 'гесеница/1ж'
   adjective = 'гусеничный/1пм'
   isHim = true
   ldesc = "Сломанный боевой робот на гусеничной платформе. Гусеницы практически полностью расплющены по полу. Такое ощущение, что его долго возили по полу и затем разорвали."
;

zaval_alien_one : fixeditem
  desc = 'завал/1м'
  noun = 'завал/1м' 'груда/1ж' 'куча/1ж' 'металл/1м' 'железяка/1ж' 'железяки/2'
  ldesc = "Куча железяк, перегораживающих проход в другие секции."
  location = alien_one_room
  tryOpen = nil
  isHim = true
  verDoShoot(actor) = {}
  doShoot(actor) = {
     aresa_say('Завал слишком большой, его не разобрать, придётся искать другой выход!');
     self.tryOpen = true;
  }
;

/////////

alien_two_room : room
  sdesc="Рубка"
  lit_desc = 'Командный пункт, стандартный кокпит. Кнопка вызова экстренной помощи оживлённо пульсирует. Спуститься можно вниз. '
  listendesc = "Мрачные скрипы доносятся непонятно откуда."
  down = alien_main_room
;


alienTwoDecor : decorationNotDirect
   location = alien_two_room
   isHer = true
   desc = 'этот объект/1м'
   noun = 'проход/1м' 'секция/1м' 'стена/1м' 'провод/1м'
          'проходы/2' 'секции/2'  'стены/2'  'провода/2'
          'пункт/1м' 'кокпит/1м'
   adjective = 'стандартный/1мо' 'командный/1мо'
;

broken_bot2 : DestructItem
   location = alien_two_room
   desc = 'поломанный/1пм медробот/1м'
   noun = 'медробот/1м' 'робот/1м' 'медбот/1м' 'медроб/1м' 'половина/1ж'
   adjective = 'гусеничный/1пм'
   isHim = true
   ldesc = "Две половины медроба по прежнему скреплены мерзким склизким проводом. Правая нога почти полностью растворилась."
;

help_but_alien_two : Button
  desc = 'кнопка/1ж'
  isHer = true
  ldesc = "Моргающая жёлтым кнопка вызова помощи."
  location = alien_two_room
  tryOpen = nil
  verDoPush(actor) = {}
  doPush(actor) = {
     aresa_say('Кнопка не работает! Система вызова не в порядке. Придётся искать что-то другое.');
     self.tryOpen = true;
  }
;

/////////

alien_three_room : room
  sdesc="Секция аналитики"
  lit_desc = 'Вдоль обеих стен тесно расположены рабочие места. В углу комнаты квадратный люк. Выход на севере.'
  north = alien_main_room
  listendesc = "Мрачные скрипы доносятся непонятно откуда."
;

alienThreeDecor : decorationNotDirect
   location = alien_two_room
   isHer = true
   desc = 'этот объект/1м'
   noun = 'проход/1м' 'секция/1м' 'стена/1м' 'угол/1м'
          'проходы/2' 'секции/2'  'стены/2'  'углы/2'
          'пункт/1м' 'кокпит/1м'
   adjective = 'стандартный/1мо' 'командный/1мо'
;

workplace : decoration
   location = alien_three_room
   desc = 'рабочее/1пс место/1с'
   noun = 'место/1с'
   adjective = 'рабочее/1пм'
   ldesc = "Пыльное рабочее место - только декорация. Если внимательно присмотреться - оно никак не подключено."
;

broken_bot3 : DestructItem
   location = alien_three_room
   desc = 'разобраный/1пм сферобот/1м'
   noun = 'робот/1м' 'сферобот/1м' 'сфера/1ж' 'шар/1м'
   adjective = 'разобраный/1пм'
   isHim = true
   ldesc = "Корпус сферического робота разобран, а внутренности разбросаны по всей комнате."
;

luk_alien_three : LukSimple
  desc = 'квадратный/1пм люк/1м'
  ldesc = "Технологический люк, может быть, соединяет с другой секцией."
  location = alien_three_room
  tryOpen = nil
  isHim = true
  verDoShoot(actor) = {aresa_say('Не, его только если открывать.');}
  verDoBoard(actor) = {aresa_say('Ты не можешь пролезть в закрытый люк, мой чёрный принц!');}
  verDoOpen(actor) = {}
  doOpen(actor) = {
     aresa_say('Заварен! Да что же делать? Придётся искать еще выходы.');
     self.tryOpen = true;
  }
;


////////////////////////////////////
// Машина состояний для карты аквазона
hotelMachine : StateMachine
   st = 0
   st_list = 0
   delay_mon_add = 0
   next_mon_pos = 1
   car_wait_time = 0
   allow_jump = nil
   out_of_car = nil
   say_out_alien = nil
   hunt_list = []
   delay_alien_come = 0
   //next_mon_list = [fire_mon_hunt3 fire_mon_hunt4 king_mon_1 fire_mon_hunt5 king_mon_2 fire_mon_hunt6 king_mon_3 king_mon_4 fire_mon_hunt7 king_mon_5 king_mon_6 fire_mon_hunt8 king_mon_7 fire_mon_hunt9 king_mon_8 fire_mon_hunt10 king_mon_9 king_mon_10]
   next_mon_list = [fire_mon_hunt3 fire_mon_hunt4 king_mon_1 fire_mon_hunt5 king_mon_2 fire_mon_hunt6  fire_mon_hunt7 fire_mon_hunt8 fire_mon_hunt9 fire_mon_hunt10]
   next_mon_list2 = [king_mon_3 king_mon_4 king_mon_5 king_mon_6]
   
   allHuntersTravel(loc)={
     local i;
     //всех кого не убили, двигаем
     for (i=1;i<=length(self.hunt_list);i++)
     {
        if (self.hunt_list[i].location != nil) self.hunt_list[i].travelTo(loc);
     }
   }
   
   nextTurn={
     local i;
     //начинаем слежку за героем и добавляем чудищ, потихоньку
     if (midcor_room.isseen && self.st == 0) {
        self.hunt_list += [fire_mon_hunt1 fire_mon_hunt2];
        self.st = 1;
     }
     else if (self.st == 1) //бегают за чубриком
     {
        if (self.out_of_car==true) 
        {
           self.st = 2;
        }
        else
        {
            //всех кого не убили, двигаем
            self.allHuntersTravel(Me.location);
            //Добавляем нового
            self.delay_mon_add += 1;
            //Частота добавления чудиков
            if (self.st_list == 0)
            {
                if (self.delay_mon_add == 5) {
                   if (self.next_mon_pos <= length(self.next_mon_list))
                   {
                       local mon = self.next_mon_list[self.next_mon_pos];
                       mon.travelTo(Me.location);
                       self.hunt_list += [mon];
                       self.next_mon_pos += 1;
                   }
                   else
                   {
                      //переходим ко второй фазе - ожидание
                      self.st_list = 1; 
                   }
                   self.delay_mon_add = 0;
                }
            }
            else if (self.st_list == 1)
            {
               aresa_say('Фух! Кажется, отбились. Есть время изучить обстановку.');
               self.st_list = 2;
            }
        }
     }
     else if (self.st == 2) //Охота чужого
     {
        //Перешли наверх
        if (Me.location == beach_start_room)
        {
           self.st = 3;
        }
        if (Alien.location == nil) {
           self.delay_alien_come += 1;
           if (self.delay_alien_come == 6) {
             "[|Слышен скрип металла неподалёку./Где-то рядом капнула слюна./Повеяло холодом./Вы ощущаете чьё-то присутствие.]";
             if (global.is_easy) aresa_say('Надо найти все выходы отсюда!');
           }
           else if (self.delay_alien_come == 7) {
              Alien.travelTo(Me.location);
           }
        }
        else
        {
          if (Alien._hp < 30) { //мало жизней - сваливаем
             self.delay_alien_come = 0;
             Alien.moveInto(nil);
             Alien._hp = Alien._max_hp;
             "<br>Чужой исчез!<br>";
          }
          else if (Alien.location != Me.location) //Двигаем за героем, если скачет
          {
             Alien.travelTo(Me.location);
          }
        }
        
        //Проверка всё ли открыли
        if ( (Me.location == alien_main_room) && 
             (zaval_alien_one.tryOpen) &&
             (help_but_alien_two.tryOpen) &&
             (luk_alien_three.tryOpen) &&
             (self.say_out_alien == nil))
        {
           "<br>";
           aresa_say('У меня появилась мысль! Если мы на каком-то телешоу, то когда мы пропадём с их датчиков движения и скрытых камер, они должны будут проверить наше состояние ведь так? Слушай, надо залезть в шкаф, я в это время вырублю свет и тебя ненадолго отключу, чтобы нас ничто не выдало, они сами к нам спустятся, и мы сможем выбраться! Только чтобы никаких ксеноморфов у тебя над душой не стояло, понял? Выполняй, солдат!');
           self.say_out_alien = true;
        }
     }
     
     //На машине летим
     if (Me.location == car_flying_room) {
       self.car_wait_time += 1;
       if (self.car_wait_time == 1) {
          "<br>Флаер стремительно опускается на нижние уровни переулка.<br>";
          self.allHuntersTravel(startcor_room);
          //Добавляем царских стрелков
          self.hunt_list += self.next_mon_list2;
          for (i=1;i<=length(self.next_mon_list2);i++) {
             local mon = self.next_mon_list2[i];
             mon.travelTo(startcor_room);
          }
       }
       else if (self.car_wait_time == 2) {
          "<br>Водитель флаера заметил вас и выполнил бочку, чтобы вас стряхнуть. В плотном потоке вам удалось схватиться за летящий рядом спортивный флаер.<br>";
          car_flying_room.lit_desc = 'Спортивный Флаер поднимается вверх к шлюзу.';
       }
       else if (self.car_wait_time == 3) {
          self.allHuntersTravel(startcor_room);
          "<br>Флаер накренился перпендикулярно земле, как вы не пытались удержаться, вы всё равно отцепились и попали на старый драндулет с дедушкой-водителем..<br>";
          car_flying_room.lit_desc = 'Старый медленный флаер.';
       }
       else if (self.car_wait_time == 4) {
          "<br>Вы начинаете приближаться к некоему полю.<br>";
       }
       if (self.car_wait_time == 9)
       {
          aresa_say('Я вижу мы пролетаем недалеко от большого ангара, спрыгивай с машины!');
          self.allow_jump = true;
       }
       else if (self.car_wait_time > 10)
       {
         "Флаер сделал резкий поворот под девяносто градусов и Вы упали с большой высоты.";
         die();
       }
     }
     
     self.currTurn = self.currTurn+1;
   }
;

//Дополнительные огневики
fire_mon_hunt3 : SimpleFireMon
   desc = 'старый/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 3
;

fire_mon_hunt4 : SimpleFireMon
   desc = 'тёмный/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 2
;

fire_mon_hunt5 : SimpleFireMon
   desc = 'весёлый/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 2
;

fire_mon_hunt6 : SimpleFireMon
   desc = 'уродливый/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 1
;

fire_mon_hunt7 : SimpleFireMon
   desc = 'жирный/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 3
;

fire_mon_hunt8 : SimpleFireMon
   desc = 'жующий/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 2
;

fire_mon_hunt9 : SimpleFireMon
   desc = 'трясущийся/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 1
;

fire_mon_hunt10 : SimpleFireMon
   desc = 'кровожадный/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 0
;

king_mon_1 : KingShooter
  desc = 'царский/1пмо стрелок/1мо'
  location = nil
  isHim = true
  _pos = 3
;

king_mon_2 : KingShooter
  desc = 'коронованный/1пмо стрелок/1мо'
  location = nil
  isHim = true
  _pos = 2
;

king_mon_3 : KingShooter
  desc = 'первый/1пмо заместитель/1мо'
  location = nil
  isHim = true
  _pos = 1
;

king_mon_4 : KingShooter
  desc = 'старший/1пмо руководитель/1мо'
  location = nil
  isHim = true
  _pos = 0
;

king_mon_5 : KingShooter
  desc = 'таинственный/1пмо лидер/1мо'
  location = nil
  isHim = true
  _pos = 3
;

king_mon_6 : KingShooter
  desc = 'важный/1пмо чиновник/1мо'
  location = nil
  isHim = true
  _pos = 2
;

king_mon_7 : KingShooter
  desc = 'дипломат/1мо'
  location = nil
  isHim = true
  _pos = 1
;


king_mon_8 : KingShooter
  desc = 'приближённый/1пмо старейшина/1мо'
  location = nil
  isHim = true
  _pos = 0
;


king_mon_9 : KingShooter
  desc = 'верховный/1пмо судья/1мо'
  location = nil
  isHim = true
  _pos = 0
;


king_mon_10 : KingShooter
  desc = 'правая/1пмо рука/1мо'
  location = nil
  isHim = true
  _pos = 0
;