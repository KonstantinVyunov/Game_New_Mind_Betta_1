////////////////////////////////

#include <threeLetterGame.t>

prepareLevel2 : function {
    show_image('eco_city.jpg');
    "<b>* ДОБАВЛЕНО ОРУЖИЕ - РЕВОЛЬВЕР</b><br>";
    "<b>* ДОБАВЛЕН СИНТЕЗ - ПАТРОНЫ ДЛЯ РЕВОЛЬВЕРА</b><br>";
    "<b>* ДОБАВЛЕН СИНТЕЗ - КРИОУСКОРИТЕЛЬ</b><br>";
    
    global.curr_level = 2;
    Me.travelTo(edgeroom);
    shnekoMachine.unregister;
    edgeMachine.register;
    //активируем револьвер и разрешаем создавать патроны
    Pistol.moveInto(Me);
    Knife.moveInto(Me);
    Me.sel_weapon=Knife;
    NoneWeapon.moveInto(nil);
    Me._hp = 100;
    CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
    CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
    global.level_play_music = 'Antnio_Bizarro_-_12_-_Across_this_River.ogg';
    stop_music_back();
    play_music_loop('Antnio_Bizarro_-_12_-_Across_this_River.ogg');
    //Разрешаем крафтить предыдущие элементы, если была загрузка
    CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
    
    Statist.Prepare([scyscreep green river edgemap tramvay_station right_side musorka kalian_home sliz_home lom firstUnblocker sadik_roofgarden rain_dron roofLiftButton secondUnblocker]);
}

/////////////////////////////

edgeroom: room
   sdesc="Зелёная окраина города"
   lit_desc = 'Небоскрёбы, стилизованные декоративным мхом и травкой, с обеих сторон обступили прозрачный тротуар, под которым, струясь, бежит небольшая речушка, обтекая валуны и клочки осоки. Пройти можно только на север.'
   north = {
     if (edgemap.wasInitTalk==nil) {
       aresa_say('Погоди, нам надо понять куда дальше идти.');
       return nil;
     }
     return secondroom;
   }
   south = {
     aresa_say('Ты хочешь снова попасть под обстрел?');
     return nil;
   }
   listendesc = "Слышно пение птиц и журчание реки."
;

scyscreep : decoration
  location = edgeroom
  desc = 'небоскрёб/1м'
  noun = 'небоскрёб/1м' 'небоскрёбы/2' 'здание/1м' 'здания/2' 'высотка/1ж' 'высотки/2' 'металл/1м' 'стекло/1с'
  adjective = 'высотное/1пм'
  isHim = true
  ldesc = "Удивительное сочетание металла, стекла и зелени! Видимо здесь люди решили компенсировать нехватку природы в других уголках планеты. "
;

green : decoration
  location = edgeroom
  desc = 'зелень/1ж'
  noun = 'зелень/1ж' 'трава/1ж' 'травка/1ж' 'валун/1м' 'валуны/2' 'камень/1м' 'камни/2' 'осока/1ж' 'мох/1м' 'клочки/2' 'стебель/1м' 'природа/1ж' 'уголки2' 'уголок/1м' 'травы/2' 'стебельки/2'
  adjective = 'зелёная/1пж' 'декоративный/1пм'
  isHer = true
  ldesc = "Трава тут повсюду! Если внимательно присмотреться, то можно заметить переплетения искусственных стебельков с натуральными. Так насаждения выглядят более эстетично и обеспечивается точечная доставка питательных веществ. "
  verDoTouch(actor) = "При прикосновении ощущается небольшая влажность, сложно отличить искуственный участок или натуральный."
;

river : decoration
  location = edgeroom
  desc = 'река/1ж'
  noun = 'река/1ж' 'речка/1ж' 'ручеек/1м' 'тротуар/1м' 'вода/1ж' 'рыба/1ж' 'рыбка/1ж' 'рыбы/2' 'рыбки/2' 'гребешки/2' 'плавники/2' 'гребешок/1м' 'плавник/1м' 'течение/1с'
  adjective = 'прозрачный/1пм' 'прозрачная/1пж' 'лазурная/1пж'
  isHer = true
  ldesc = "Течение лазурной реки завораживает, кажется невозможным воссоздать дикий уголок природы в пределах мегаполиса. Инженеры постарались сделать всё, чтобы природа была как можно ближе к человеку в этом городе. Иногда из воды высовываются красные гребешки рыбок, неспешно размахивающих плавниками. "
  verDoShoot(actor) = "Тротуар очень прочный, выдержит посадку орбитального шаттла, не обманывайтесь его прозрачностью."
;


mapDecoration : decoration
  location = edgeroom
  isHer = true
  desc = 'эта часть/1м карты'
  noun = 'ножки/2' 'ножка/1ж' 'анимация/1ж' 'объекты/2' 'объект/1м' 'мелодия/1ж' 'огоньки/2' 'огонёк/1м' 'огонь/1м' 'огни/2' 'хвост/1м' 'кабель/1м' 'хвосты/2' 'кабели/2'
  adjective = 'небольшие/2п'
;

edgemap : Actor
   location = edgeroom
   desc = 'карта/1ж'
   noun = 'карта-гид/1ж' 'карта/1ж' 'гид/1м' 'стенд/1м'
   isHer = true
   ldesc = { 
   show_image('table.jpg');
   "Яркая карта города, выглядит как вертикальный стенд на ножках. На карте объекты трехмерные, с голографической анимацией, выглядят привлекательно. Ножки достаточно подвижные чтобы подстраиваться к собеседнику и давать нужный ракурс. Всем своим видом выражает готовность к общению. ";}
   actorDesc = "[|Стенд с картой поворачивается вслед за вами при любом движении./Стенд с картой раскачивается на небольших ножках в такт негромкой мелодии./На стенде с картой приветственно мигают огоньки.]"
   verDoRead(actor) = {self.verDoTalk(actor);}
   verDoSearch(actor) = {self.verDoTalk(actor);}
   verDoLookunder(actor) = {self.verDoTalk(actor);}
   verDoLookin(actor) = {self.verDoTalk(actor);}
   verDoTalk(actor) = { if (self.wasWinGame == true) "Карта тяжело вздыхает, больше ей не на что играть в слова."; }
   verDoShoot(actor) = {aresa_say('Эй, вандал! Бросай эти штучки, карта живая и дружеблюная. Давай я лучше тебя разбёрем?');}
   wasInitTalk = nil
   wasWinGame = nil
   nTry = 0
   
   
   doRead(actor) = {self.doTalk(actor);}
   doSearch(actor) = {self.doTalk(actor);}
   doLookunder(actor) = {self.doTalk(actor);}
   doLookin(actor) = {self.doTalk(actor);}
   
   doTalk(actor) = {
      local word_out,res;
      local maxTries = rangernd(10,15);
      if (self.wasInitTalk == nil)
      {
         scen_lvl2_map_talk();
         self.wasInitTalk = true;
         return;
      }
      "- Если вы подзабыли или еще не знаете правил, то я расскажу. Каждый участник игры по очереди называет слова. Слова должны состоять из трёх букв и содержать две буквы из предыдущего слова. Называют слова по очереди. Первый ход будет моим, надеюсь никто не против? Отлично. Если ты не сможешь найти слова или ошибешься, то игра заканчивается, можем конечно потом еще попробовать. Если я не смогу найти слова, то я проиграла и отдаю тебе приз. Поехали!<br>";
      ThreeLetterGame.prepareGame;
      word_out = ThreeLetterGame.getFirstWord;
      "- Моё слово: <<word_out>>";
      while (true)
      {
        local resp,res_user;
        "<br>>";
        resp=input();
        if (resp=='хуй' || resp=='бля' || resp=='хер')
        {
           "<br>- Ой ой ой! Включаются протоколы защиты детских ушей! Ничего не могу поделать, но вы получаете вот такой удар током (-5).<br>";
           Me.Hit(nil,5);
           abort;
        }
        res_user = ThreeLetterGame.checkNextWord(resp);
        
        if (length(resp)==0) {
           "- Не надо молчать, просто скажите слово.";
        }
        else if (res_user==NEXT_WORD_OK)
        {
           word_out = ThreeLetterGame.memWordAndGetOwn(resp);
           if (word_out == '')
           {
               "- Не могу ничего придумать! Ты победил, вот твои ресурсы.<br>";
               self.wasWinGame = true;
               ResourceSystem.Add('WIN_MAP_GAME',RESOURCE_AMOUNT_HIGH);
               abort;
           }
           nTry += 1;
           if (nTry < maxTries) {
               "- Принято! Моё слово: <<word_out>><br>";
           }
           else 
           {
              "- Не могу ничего придумать, как же так! Ты победил, вот твои ресурсы.<br>";
              ResourceSystem.Add('WIN_MAP_GAME',RESOURCE_AMOUNT_HIGH);
              self.wasWinGame = true;
              abort;
           }
        }
        else if (res_user==NEXT_WORD_UNKNOWN)
        {
           "- Я не припоминаю такого слова! Так, проверила в словаре, не могу его принять. Давай потом еще попробуем.";
           abort;
        }
        else if (res_user==NEXT_WORD_FAIL)
        {
           "- Так, ну слово трёхбуквенное, но оно совсем не подходит по правилам! Попробуем еще попозже...";
           abort;
        }
        else if (res_user==NEXT_WORD_LAST)
        {
           "- Ну это же моё предыдущее слово! Надо внимательно слушать правила. Потом еще поиграем...";
           abort;
        }
        else if (res_user==NEXT_WORD_ALREADY)
        {
           "- Это слово уже было! Надо потом еще разок попытаться.";
           abort;
        }
     }
   }
   
   verDoTake(actor)="Карта отстранилась со словами, что она, мол, городская собственность.";
;

/////////////////
secondroom : room
  sdesc="Остановка трамвая"
  lit_desc = 'Среди извилистой тропы чётко выступает рельсовый путь с небольшим газончиком в стороне, по всей видимости - остановка трамвая. Возле правой стены небоскрёба находится технологическая репульсорная площадка для подъема на крышу. Улица проходит с юга на север. '
  north = thirdroom
  south = edgeroom
  up = {
    if (!musorka._is_moved){
       "Сейчас вы не можете забраться на крышу.";
       return nil;
    }
    else
    {
        //Подъем на лифте
        scen_lvl2_up_lift();
        Me.travelTo(roofstart);
        //Добавляем торсион и синтез
        "<b>* ДОБАВЛЕНО ОРУЖИЕ - ТОРСИОН</b><br>";
        "<b>* ДОБАВЛЕН СИНТЕЗ - ИЗОЛЯЦИЯ</b><br>";
        CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
        TorsionGenerator.moveInto(Me);
    }
  }
  listendesc = "Сильный ветер проходит между зданий с высоким гулом."
;

streetDecoration : decoration
  location = secondroom
  isHer = true
  desc = 'эта часть/1ж локации'
  noun = 'улица/1ж' 'город/1м'
;

ecoDecorDecoration : decoration
  location = secondroom
  isHer = true
  desc = 'эта деталь/1ж'
  noun = 'деталь/1ж' 'механизм/1м' 'архаизм/1м' 'тряска/1ж' 'стыки/2' 'стык/1м' 'поезд/1м' 'романтика/1ж' 'антиграв/1м' 'антигравы/2' 'рог/1м' 'рога/2'
  adjective = 'рогатый/1пм'
;

tramvay_station : decoration
  location = secondroom
  desc = 'остановка/1ж трамвая'
  noun = 'остановка/1ж' 'рельсы/2' 'рельс/1м' 'газончик/1м' 'газон/1м' 'трамвай/1м' 'путь/1м'
  isHer = true
  ldesc = "Кто бы мог подумать что людям захочется видеть такой архаизм в современном городе? Наверное, в рогатом механизме сделали полную имитацию тряски, ощущение стыков рельс, чтобы пассажиры могли в полной мере насладиться романтикой поезда. Не удивлюсь, если в экстренном случае включатся антигравы и трамвай перелетит встретившуюся опасность. "
;

right_side : FunnyClibDecor
  location = secondroom
  desc = 'правая/1пж стена/1ж'
  noun = 'стена/1ж' 'небоскрёб/1м' 'здание/1с' 'склон/1м' 'песок/1м'
  adjective = 'вертикальный/1пм' 'горный/1пм'
  isHer = true
  ldesc = "Интересно, мох на небоскрёбе растёт не равномерно, а с проплешинами, из которых виднеется нечто, похожее на землю с большой примесью песка. Получается что-то вроде вертикального горного склона, очень естественно. "
;

mon1 : SimpleFireMon
   desc = 'татуированный/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 5
;


mon2 : SimpleFireMon
   desc = 'грязноволосый/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 7
;


mon3 : SimpleFireMon
   desc = 'шипастый/1пмо огневик/1мо'
   location = nil
   isHim = true
   _pos = 10
;

musorka : fixeditem, surface
   desc = 'площадка/1ж'
   noun = 'площадка/1ж' 'платформа/1ж' 'основание/2' 'подъем/1м'
   adjective = 'репульсорная/1пж' 'технологическая/1пж' 'керамическое/1с'
   isHer = true
   ldesc = { 
      "Под керамическим основанием пульсируют силовые линии, площадка в исправном состоянии. Для подъема необходимо встать на гравидиск. ";
      if (lom.location!=self) " Который, почему-то, отсутствует.";
   }
   location = secondroom
   _is_moved = nil
   ioPutOn(actor, dobj) =
   {
      if (dobj == lom)
      {
         //"Вы установили гравидиск";
         lom.isfixed = true;
		 dobj.doPutOn(actor, self);
         self._is_moved = true;
         edgeMachine.startJoke = true;
      }
      else "Площадка не позволяет вам положить это.";
   }
   verDoStandon(actor) = {if (!self._is_moved) "Вы сейчас не можете встать на платформу."; }
   doStandon(actor) = { 
     //Подъем на лифте
     scen_lvl2_up_lift();
     Me.travelTo(roofstart); 
     //Добавляем торсион и синтез
     "<b>* ДОБАВЛЕНО ОРУЖИЕ - ТОРСИОН</b><br>";
     "<b>* ДОБАВЛЕН СИНТЕЗ - ИЗОЛЯЦИЯ</b><br>";
     CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
     TorsionGenerator.moveInto(Me);
   }
;

power_lines : decoration
  location = secondroom
  desc = 'силовая/1пж линия/1ж'
  noun = 'линия/1ж'
  adjective = 'силовая/1пж'
  isHer = true
  ldesc = "Пульсирующий золотом и красным, узор линий одновременно притягивает и настораживает, чувствуется мощь установки, при этом, если не всматриваться, то он очень гармонично вписывается в эко-обстановочку района. "
;

roof_far : distantItem
  location = secondroom
  desc = 'крыша/1ж'
  noun = 'крыша/1ж' 'край/1м' 'медуза/1м'
  isHer = true
  ldesc = "Край крыши люминисцирует и немного колышется на ветру. Чем-то похоже на большую медузу, опустившуюся сверху на набескрёб. Необычный дизайнерский ход."
;

//////////////

thirdroom: room
   sdesc="Конец зелёного квартала"
   lit_desc = 'Постепенно полукилометровые башни принимают истинный облик, избавившись от натиска вертикальных газонов. Первые следы крупных разрушений - кальянная неподалёку наполовину растворилась от мерзкой слизи. На севере виднеется множество летающих фигур. Вернуться можно на юг.'
   south = secondroom
   north = {
     fly_lot_demons.ldesc;
     return nil;
   }
   _field_size = 20
   _pl_pos = 10
   listendesc = "Слышно хлопанье тучи крыльев."
;

ecoDecorThirdDecoration : decoration
  location = thirdroom
  isHer = true
  desc = 'эта деталь/1ж'
  noun = 'соты/2' 'сота/1ж' 'окна/2' 'окно/1с' 'улей/1м' 'бизнес-центр/1м' 'бизнес-центры/2' 'магазин/1м' 'магазины/2' 'турист/1м' 'туристы/2' 'реклама/1ж' 'рекламы/2' 'этажи/2' 'этаж/1м' 'пластик/1м' 'беспорядок/1м' 'туалет/1м' 'состав/1м'
  adjective = 'шестиугольные/2п' 'шестиугольная/1пж' 'расплавившийся/1пм'
;

big_towers : FunnyClibDecor
  location = thirdroom
  desc = 'полукилометровая/1пж башня/1ж'
  noun = 'башня/1ж' 'здание/1с' 'газон/1м' 'высотка/1ж' 'небоскреб/1м'
  adjective = 'полукилометровая/1пж' 'вертикальный/1пм' 'обычная/1пм'
  isHer = true
  ldesc = "Обычная высотка. Выглядит как большой улей с шестиугольными сотами-окнами, в которых пусто. Скучающие бизнес-центры и магазины, по привычке пытаются затянуть любознательных туристов яркими рекламами."
;


kalian_home : decoration
  location = thirdroom
  desc = 'кальянная/1ж'
  noun = 'кальянная/1ж' 'кальян/1м' 'столик/1м' 'подушка/1ж'
  adjective = 'полукилометровая/1пж'
  isHer = true
  ldesc = "Восточный стиль, изысканный интерьер. В широких окнах первого этажа к низенькому столику вяло прислонились пёстрые подушки, не подозревая что случилось с соседями сверху. На втором и последующих этажах внешняя стена разъедена, в некоторых местах застыли пузыри от расплавившегося пластика. Внутри полный беспорядок. "
;

sliz_home : decoration
  location = thirdroom
  desc = 'мерзкая/1пж слизь/1ж'
  noun = 'слизь/1ж' 'кислота/1ж' 'пузыри/2' 'пузырь/1м'
  adjective = 'мерзкая/1пж'
  isHer = true
  ldesc = "Слизь по всей видимости медленно действующая кислота, выделяемая железами каких-нибудь блюющих демонов. Скорее всего обожрались фастфуда и бегом в кальянную, поплохело, до туалета не дошли и вот результат - половины здания нет. Хотя, может всё было по-другому..."
;


fly_lot_demons : decoration
  location = thirdroom
  desc = 'летающая/1пж фигура/1ж'
  noun = 'фигура/1ж' 'кислота/1ж'
  adjective = 'летающая/1пж'
  isHer = true
  ldesc = "Сколько их там! Целая армия! Деловито снуют туда-сюда, таскают шмотки. Оп, кто-то человечка потащил. В ту сторону лучше не идти, если за спиной нет ядерной артиллерии."
  verDoShoot(actor) = { aresa_say('Это тоже самое что застрелиться! Их там орды, будь благоразумен, дружище.'); }
;

mon4 : SimpleShooter
   desc = 'каменный/1пмо стрелок/1мо'
   location = nil
   isHim = true
   _pos = 20
;


mon5 : SimpleTrooper
   desc = 'кричащий/1пмо штурмовик/1мо'
   location = nil
   isHim = true
   _pos = 0
;

lom : item
   desc = 'гравидиск/1м'
   noun = 'гравидиск/1м' 'диск/1м' 'грави/1м'
   ldesc = "Диск, внешне напоминающий допотопный канализационный люк, толщиной в несколько пальцев из полимерных материалов. С одной стороны покрыт специальным составом для работы на репульсорной площадке."
   location = thirdroom
   isHim = true
   have_try = nil
   verDoTake(actor) = {
     if (HaveMonsters(self.location)) "Эти проклятые твари мешают вам взять диск!";
   }
   doTake(actor) = {
     if (!self.have_try)
     {
        self.have_try = true;
        scen_lvl2_see_demons();
        mon1.moveInto(secondroom);
        mon2.moveInto(secondroom);
        mon3.moveInto(secondroom);
        mon4.moveInto(thirdroom);
        mon5.moveInto(thirdroom);
        return;
     }
     pass doTake;
   }
   verDoStandon(actor) = {if (self.location != musorka) aresa_say('Ты чего топчешь платформу? Думаешь взлетишь на ней с любого места?'); }
   doStandon(actor) = { musorka.doStandon(actor); }
   verDoShoot(actor) = { aresa_say('Думаю, гравидиск еще пригодится, иди лучше тренируйся на кошках.'); }
;

////////////
roofstart: room
   sdesc="Крыша, над репульсором"
   lit_desc = 'Светящийся край обрамляет крышу, которая идёт кольцом в северном и восточном направлениях.'
   north = roofglass
   east = roofhigh
   _field_size = 4
   _pl_pos = 0
;

roof_near : decoration
  location = roofstart
  desc = 'крыша/1ж'
  noun = 'крыша/1ж' 'край/1м' 'ковёр/1м' 'самолёт/1м' 'медуза/1ж' 'кольцо/1с'
  adjective = 'светящийся/1пм'
  isHer = true
  ldesc = "Край крыши люминисцирует и колышется в такт ветру. Странное ощущение, как будто стоишь на ковре-самолёте, больше похожем на медузу."
;

/////////////////

roofglass: room
   sdesc="Стеклянная крыша"
   lit_desc = 'Пол в этом месте стеклянный, но непрозрачный. Можно пройти на север или на юг.'
   north = roofdarkkorner
   south = roofstart
   _field_size = 10
   _pl_pos = 2
   ownFloor = true
;

stek_floor : decoration
  location = roofglass
  desc = 'стеклянный/1пм пол/1м'
  isHer = true
  ldesc = "Непрозрачная поверхность по ощущениям очень прочная, скорее всего бронированная. "
  verDoShoot(actor) = "Не льсти себе."
;

mon_roofglass1 : SimpleShooter
   desc = 'быстрый/1пм стрелок/1мо'
   location = roofglass
   isHim = true
   _pos = 10
;


mon_roofglass2 : SimpleTrooper
   desc = 'одинокий/1пм штурмовик/1мо'
   location = roofglass
   isHim = true
   _pos = 1
;


class roofUnbloker : Button
   isListed = true
   desc = 'красный/1пм рычаг/1м'
   noun = 'рычаг/1м' 'рычажок/1м'
   ldesc = "Красный рычаг с надписью \"Разблокировка лифта\". Судя по всему, ремонтники временное питание делили с лифтом."
   isHim = true
   isActivated = nil
   activate = {
     "Рычаг опустился до конца и раздался щелчок.";
     self.isActivated = true;
   }
   verDoPush(actor) = { if (self.isActivated) "Рычаг уже нажат!"; }
   doPush(actor) = { self.activate; }
;

firstUnblocker : roofUnbloker
  location = roofdarkkorner
;

mon_roofdarkkorner1 : SimpleTrooper
   desc = 'аккуратный/1пм штурмовик/1мо'
   location = nil
   isHim = true
   _pos = 0
;

//mon_roofdarkkorner2 : SimpleTrooper
//   desc = 'второй/1пмо штурмовик/1мо'
//   location = roofdarkkorner
//   isHim = true
//   _pos = 0
//;

//mon_roofdarkkorner3 : SimpleTrooper
//   desc = 'третий/1пмо штурмовик/1мо'
//   location = roofdarkkorner
//   isHim = true
//   _pos = 0
//;

///////////////////////////

roofdarkkorner: room
   sdesc="Тёмный угол"
   lit_desc = 'Этот угол крыши совсем слабо освещён, трудно что-либо разглядеть, пройти можно на восток или на юг.'
   east = roofgarden
   south = roofglass
   _field_size = 5
   _pl_pos = 5
;

///////////////////////////

roofgarden: room
   sdesc="Оранжерея на крыше"
   lit_desc = 'Этот маленький садик находится на автоматическом обеспечении, может годами стоять и цвести. Проход идёт с запада на восток.'
   east = roofelevator
   west = roofdarkkorner
   _field_size = 4
   _pl_pos = 0
;

sadik_roofgarden : decoration
   location = roofgarden
   desc = 'садик/1м'
   noun = 'садик/1м' 'сад/1м' 'огород/1м'
   adjective = 'маленький/1пм' 'небольшой/1пм'
   isHim = true
   ldesc = { if (rain_dron.location == roofgarden) "Среди этого небольшого садика можно заметить очертания поливального дрона.";
             else "Теперь совсем обычный садик, интересно, сколько он может протянуть без автоматики? Ага, сигнал неисправности мигает, через пару часов прискачет лихой ремонтник и сделает всё как было, волноваться не о чем.";
   }
;

rain_dron : DestructItem
   isListed = nil
   resAmount = RESOURCE_AMOUNT_MID
   location = roofgarden
   desc = 'поливальный/1пм дрон/1м'
   noun = 'дрон/1м' 'робот/1м'
   adjective = 'поливальный/1пм'
   isHim = true
   ldesc = "Да это же поливальный дрон! Летающая тучка с дождиком. Кажется, его давным-давно никто не включал. Милое создание, наверное припрятал что-то полезное."
;


roofLiftButton : Button
   desc = 'кнопка/1ж'
   ldesc = "Кнопка вызова лифта."
   isHer = true
   wasHitButton = nil
   location = roofelevator
   verDoPush(actor) = { if (!firstUnblocker.isActivated || !secondUnblocker.isActivated) "Не работает, кажется не активирована!"; }
   doPush(actor) = { 
      if ( self.wasHitButton == nil)
      {
         "Как только вы попытались нажать кнопку она сразу потухла. Где-то вдалеке послышался щелчок отжатого рычага и сдавленный смешок демона.";
         mon_roofdarkkorner1.moveInto(roofdarkkorner);
         firstUnblocker.isActivated = nil;
         self.wasHitButton = true;
      }
      else
      {
         edgeMachine.startJoke = nil;
         Me.Heal;
         "Вы нажали кнопку и площадка начала плавно идти вниз. Однако спокойный спуск продолжался недолго. Лифт оказался с дополнительной системой защиты! Большой круг разделился на сегменты и каждый сегмент-минилифт отодвинулся на порядочное расстояние и стал двигаться с собственной скоростью вверх-вниз в глубокой шахте. <br>";
         "- Ого, так ловят злостных нарушителей, таких как мы! Катаешься тут до посинения, пока добрая команда из лифтёра с полицейскими дронами тебя не сопроводят куда следует. Так, но мы же не обычные преступники, у нас есть суперсила! Шутка, но по крайней мере ты более устойчивый. Попробуй перепрыгнуть на соседний лифт только когда поравняешься с ним, тогда долетишь, я рассчитала. Назад возвращаться не стоит, думаю не так повезет.<br>";
         "<b>* ДОБАВЛЕН СИНТЕЗ - МИКРОВОЗВРАТ</b><br>";
         "<b>* ДОБАВЛЕН СИНТЕЗ - ПОГЛОЩАТЕЛЬ</b><br>";
         "<b>* ДОБАВЛЕН СИНТЕЗ - ЯД</b><br>";
         
         CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
         CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
         CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
         Me.travelTo(elevetorDownRoom); 
         //win();
      }
   }
;

mon_roofelevator1 : SimpleShooter
   sdesc = "тихий стрелок"
   rdesc = "тихого стрелка"
   ddesc = "тихому стрелку"
   vdesc = "тихого стрелка"
   tdesc = "тихим стрелком"
   pdesc = "тихому стрелку"
   noun = 'тихий' 'тихого' 'тихим' 'тихому' 'стрелок'
   location = roofelevator
   isHim = true
   _pos = 4
;

mon_roofelevator2 : SimpleFireMon
   desc = 'зеленоглазый/1пмо огневик/1мо'
   location = roofelevator
   isHim = true
   _pos = 2
;

///////////////////////////

roofelevator: room
   sdesc="Лифт"
   lit_desc = 'Площадка лифта с кнопкой на стене. Идти можно на запад или на юг.'
   west = roofgarden
   south = roofmaterials
   _field_size = 4
   _pl_pos = 0
;

ploshadka_lifta : fixeditem
  location = roofelevator
  desc = 'площадка/1ж'
  noun = 'площадка/1ж' 'лифт/1м'
  ldesc = "Площадка огромная, круглая, около четырёх метров в диаметре. Вы сейчас стоите на ней."
  verDoBoard(actor) = { self.verDoSiton(actor); }
  verDoStandon(actor) = { self.verDoSiton(actor); }
  verDoSiton(actor) = {aresa_say('Мы уже стоим на площадке, зачем тебе садиться на неё?');}
  verDoLieon(actor) = {aresa_say('Устал стоять на площадке? Или думаешь легче перенесёшь перегрузку при спуске вниз?');}
;


///////////////////////////

roofmaterials: room
   sdesc="Ремонтируемая часть"
   lit_desc = 'Такое ощущение, что строители начали ремонт, затем побросали инструменты и убежали. Пробраться можно с юга на север.'
   north = roofelevator
   south = roofadvert
   _field_size = 8
   _pl_pos = 0
;

mon_roofmaterials1 : SimpleShooter
   desc = 'отважный/1пмо стрелок/1мо'
   location = roofmaterials
   isHim = true
   _pos = 6
;

//mon_roofmaterials2 : SimpleShooter
//   desc = 'второй/1пмо стрелок/1мо'
//   location = roofmaterials
//   isHim = true
//   _pos = 6
//;

//mon_roofmaterials3 : SimpleShooter
//   desc = 'третий/1пмо стрелок/1мо'
//   location = roofmaterials
//   isHim = true
//   _pos = 6
//;

instruments_all : decoration
   location = roofmaterials
   desc = 'инструменты/2'
   noun = 'инструменты/2' 'инструмент/1м'
   isThem = true
   ldesc = "Ну молотков и пил тут не увидишь. Зато есть пневматические строительные ходули, парочка корпусов экзоскелетов и портативный фрезеровальный станок."
;

hoduli_instr : decoration
   location = roofmaterials
   desc = 'пневматические/2п ходули/2'
   noun = 'ходули/2'
   isThem = true
   ldesc = "Небольшой каркас с пневмоустановкой и креплением для ног. Для вас бесполезен."
;

exzo_instr : decoration
   location = roofmaterials
   desc = 'экзоскелет/1м'
   noun = 'экзоскелет/1м' 'корпус/1м'
   isHim = true
   ldesc = "Корпус без электроники, видимо гибкая электроника у строителей была прямо в спецовках. Неинтересный объект."
;

stanok_instr : decoration
   location = roofmaterials
   desc = 'фрезеровальный/1пм станок/1м'
   isHim = true
   ldesc = "Для быстрого выпиливания подручных материалов. Сделан из дешевых материалов и бесполезен для синтеза, к сожалению."
;

secondUnblocker : roofUnbloker
  location = roofadvert
;

///////////////////////////

roofadvert: room
   sdesc="Большая реклама"
   lit_desc = 'Этот угол крыши ярко освещён, над головой огромная неоновая вывеска спиртного напитка. Здание идёт с запада на север.'
   north = roofmaterials
   west = roofhigh
   _field_size = 4
   _pl_pos = 0
;

reklama : FunnyClibDecor
   location = roofadvert
   desc = 'неоновая/1пж реклама/1ж'
   noun = 'реклама/1ж' 'вывеска/1ж' 'напиток/1м'
   adjective = 'неоновая/1пж' 'огромная/1пж' 'спиртной/1пм'
   isHer = true
   ldesc = "Реклама про трёх друзей, которые решают кто пойдет за очередной бутылкой. В других городах запрещена реклама алкоголя, а тут чуть ли не на каждом углу. "
   verDoShoot(actor) = {aresa_say('Ты лучше дорисуй что-нибудь, как в старые добрые времена.');}
;

///////////////////////////

roofhigh: room
   sdesc="Возвышенность"
   lit_desc = 'Это сторона крыши самая высокая, отсюда можно увидеть центр города весь в огнях, а также часть переулка под вами. Можно спуститься на запад или на восток.'
   east = roofadvert
   west = roofstart
   _field_size = 4
   _pl_pos = 0
;


center_far : distantItem
  location = roofhigh
  desc = 'центр/1м'
  noun = 'центр/1м' 'город/1м' 'пейзаж/1м'
  isHim = true
  ldesc = "Завораживающий пейзаж. Медленно поворачивающиеся здания мегаполиса, летающие гигантские деревья в прозрачных колбах, лишь малая доля всего многообразия. Строители явно преуспели в сочетании зелёных насаждений и динамичной архитектуры. Явных разрушений не видно, город захватили очень аккуратно. "
;

center_farDecoration : decoration
  location = roofhigh
  isHer = true
  desc = 'эта часть/1ж пейзажа'
  noun = 'здание/1м' 'дерево/1с' 'колба/1ж' 'архитектура/1ж'
         'здания/2' 'деревья/2'  'колбы/2'
          
  adjective = 'завораживающий/1пм' 'гигантские/2п'
;

pereulok_far : distantItem
  location = roofhigh
  desc = 'переулок/1м'
  isHim = true
  ldesc = "Кажется, туда слетелись демоны по соседству. К счастью, они нас пока не обнаружили. "
;


ant_roofhigh : DestructItem
   location = roofhigh
   desc = 'антенный/1пм блок/1м'
   noun = 'блок/1м' 'антенна/1ж'
   adjective = 'антенный/1пм'
   isHim = true
   ldesc = "Антенный блок, с кучей контроллеров и пласталевых компонентов. "
;

///////////////////////////

elevatorDecor : decorationNotDirect
  location = elevetorDownRoom
  isHim = true
  desc = 'этот объект/1м'
  noun = 'лифт/1м' 'лифты/2' 'механизм/1м' 'механизмы/2' 'площадка/1ж' 'уровень/1м' 'шахта/1ж' 'шахты/2' 'сегмент/1ж' 'сегменты/2'
  adjective = 'скоростной/1пм' 'скоростные/2п' 'расплавившийся/1пм' 'западный/1пм' 'восточный/1пм'
;

elevatorLifter : distantItem
  location = elevetorDownRoom
  isHim = true
  ldesc = "Он очень далёко, нельзя толком рассмотреть."
  desc = 'лифтёр/1м'
  noun = 'лифтёр/1м' 'призрак/1м' 'лифтёр-призрак/1м'
  adjective = 'призрачный/1пм'
;

elevetorDownRoom : room
   sdesc="На скоростном лифте"
   listendesc = "Слышен тяжелый звук лифтового механизма."
   ldesc = {
      local curr_lvl = self.liftLvlCurr[self.currLift];
      local pos1 = self.liftLvlCurr[1]; 
      local pos2 = self.liftLvlCurr[2]; 
      local pos3 = self.liftLvlCurr[3]; 
      if (self.currLift == 1) "Вы на уровне <<curr_lvl>>. Западный лифт на уровне <<pos2>>.";
      else if (self.currLift == 2) "Вы на уровне <<curr_lvl>>. Западный лифт на уровне <<pos3>>. Восточный лифт на уровне <<pos1>>. ";
      else if (self.currLift == 3) "Вы на уровне <<curr_lvl>>. Восточный лифт на уровне <<pos2>>. Площадка на первом уровне.";
      //"(<<pos1>>, <<pos2>>, <<pos3>>).";
   }
   mayJumpOut = true
   isseen = true
   currLift = 1
   totLift = 3
   liftLvlCurr =[ 5  5  3]     //текущий уровень
   liftLvlMax = [ 6  7  4]     //максимальная глубина погружения лифта
   liftLvlMin = [ 3  4  1]     //минимальная глубина погружения лифта
   liftLvlDir = [ 1  0  1]    //направление движение лифта
   //запад
   out = {
     return self.west;
   }
   west = {
      local curr_lvl = self.liftLvlCurr[self.currLift];
      if ( self.currLift == 3 )
      {
         if (curr_lvl==1)
         {
            scen_lvl2_see_madam();
            show_image('dama.jpg');
            edgeMachine.startHit = nil;
            Me.travelTo(lifterroom);
         }
         else
         {
            "Вы промахнулись мимо платформы нижнего этажа.";
            die();
         }
      }
      else 
      {
         local next_lvl = self.liftLvlCurr[self.currLift+1];
         if (curr_lvl==next_lvl)
         {
            "Вы перепрыгнули на другой лифт!";
            self.currLift+=1;
         }
         else
         {
           "Вы промахнулись мимо лифта и упали в шахту!";
           die();
         }
      }
      return nil;
   }
   //восток
   east = {
      local curr_lvl = self.liftLvlCurr[self.currLift];
      if ( self.currLift == 1 )
      {
         "Вы промахнулись мимо платформы верхнего этажа. Падение было долгим...";
         die();
      }
      else 
      {
         local next_lvl = self.liftLvlCurr[self.currLift-1];
         if (curr_lvl==next_lvl)
         {
            "Вы перепрыгнули на другой лифт!";
            self.currLift-=1;
         }
         else
         {
           "Вы промахнулись мимо лифта и упали в шахту!";
           die();
         }
      }
      return nil;
   }
   down={aresa_say('Как ты пролезешь вниз?'); return nil;}
   up={aresa_say('Тут никак не залезть наверх!'); return nil;}
;

//////////////
//Комната лифтера

lifterroom: room
   sdesc="Ретро-парадная"
   lit_desc = 'Стилизованное под старину помещение начинается с металлических створок дверей лифта. Просветы между рейками инкрустированы декоративной мозаикой. Блестящий мраморный пол уходит дальше на север, огибая величественные колонны по бокам прохода. '
   north = {
      if (HaveMonsters(lifterroom)) aresa_say('Хотелось бы, но эта призрачная дама, вряд ли нас пропустит.');
      else
      {
         Statist.Show(2);
         "<i>(Для продолжения нажмите ВВОД</i>)<br>";
	     input();
         scen_lvl2_final();
         "<i>(Для продолжения нажмите ВВОД</i>)<br>";
	     input();
         resourceSaveToGlobal();
         prepareLevel3();
         return startcor_room;
         //win();
      }
   }
;

liftRoomNonDirectDecor : decorationNotDirect
  location = lifterroom
  isHer = true
  desc = 'эта часть/1ж помещения'
  noun = 'парадная/1ж' 'помещение/1с'
  adjective = 'ретро/1пм' 'стилизованое/1пм'
;

liftDecor : decoration
   location = lifterroom
   isHer = true
   desc = 'эта часть/1ж парадной'
   noun = 'створка/1ж' 'дверь/1ж' 'рейка/1ж' 'колонна/1ж' 'мозаика/1ж' 'просвет/1м' 'колонна/1м' 'бок/1м' 
          'створки/2'  'двери/2'  'рейки/2' 'колонны/2'  'мозайки/2' 'просветы/2'   'колонны/2'  'бока/2' 
          'лифт/1м' 'проход/1м' 'старина/1ж'
   adjective = 'металлическая/1пж' 'инкрустированая/1пж' 'декоративная/1пж' 'блестящий/1пм' 'мраморный/1пм' 'величественный/1пм' 'величественные/2'
;


/////////////
////////////////////////////////////
// Машина состояний для сцены шнекохода
edgeMachine : StateMachine
   lastSt = 0
   st = 0
   lastStoryTurn = 0
   lastUserLoc = nil
   stateWithMon = 0
   startHit = nil
   startJoke = nil
   nextTurn={
     if ((self.currTurn >= 0) && (self.st == 0)) {
        self.st = 1;
        Me.Heal;
     }
     else if (self.st >= 1 && self.st < 3 && (Me.location==elevetorDownRoom))
     {
       //переходим к следующему состоянию, чтобы убавлять жизнь
       self.st += 1;
     }
     else if (self.st == 3 && (Me.location==elevetorDownRoom))
     {
        //переходим к следующему состоянию, чтобы убавлять жизнь
        aresa_say('Вот дьявол! По нам кто-то стреляет, кажется лифтёр-призрак. Давай добирайся до третьего лифта и на первом этаже сойдешь, потом найдем и догоним гадёныша!');
        self.startHit = true;
        self.st = 10;
     }
       
     //Когда подвинули, то начинаем отслеживать монстров с игроком
     if (self.startJoke)
     {
       if ( (Me.location == self.lastUserLoc) && (HaveMonsters(Me.location)) )
       {
          local mon_list, new_loc,i;
          self.stateWithMon += 1;
          if (self.stateWithMon==3)
          {
             //перемещаем монстров из локации в следующую
             mon_list = GetMonsterList(Me.location);
              
             if      (Me.location == roofstart) new_loc=roofglass;
             else if (Me.location == roofglass) new_loc=roofgarden;
             else if (Me.location == roofgarden) new_loc=roofdarkkorner;
             else if (Me.location == roofdarkkorner) new_loc=roofhigh;
             else if (Me.location == roofhigh) new_loc=roofelevator;
             else if (Me.location == roofelevator) new_loc=roofmaterials;
             else if (Me.location == roofmaterials) new_loc=roofadvert;
             else if (Me.location == roofadvert) new_loc=roofstart;
             else new_loc = Me.location;

             for (i=1;i<=length(mon_list);i++)
             {
                mon_list[i].travelTo(new_loc);
                mon_list[i]._pos = 0;
             }
             "<br>[|-Гады сбежали!/-Демоны унесли ноги!/-Куда смылись?]<br>";
             self.stateWithMon = 0;
          }
       }
       else
       {
          self.stateWithMon = 0;
       }
     }
     
     if (Me.location==elevetorDownRoom)
     {
        local i;
        for (i=1;i<=elevetorDownRoom.totLift;i++)
        {
           local cur_lvl = elevetorDownRoom.liftLvlCurr[i];
           if (elevetorDownRoom.liftLvlDir[i]==1) {
              cur_lvl += 1;
              //уперлись в вверх
              if (cur_lvl==elevetorDownRoom.liftLvlMax[i]) {
                 elevetorDownRoom.liftLvlDir[i] = 0;
              }
           }
           else if (elevetorDownRoom.liftLvlDir[i]==0) {
              cur_lvl -= 1;
              //уперлись в низ
              if (cur_lvl==elevetorDownRoom.liftLvlMin[i]) {
                 elevetorDownRoom.liftLvlDir[i] = 1;
              }
           }
           
           elevetorDownRoom.liftLvlCurr[i] = cur_lvl;
        }
        elevetorDownRoom.ldesc;
     }
     
     if (self.startHit==true)
     {
       Me.Hit(lifter_gost,rangernd(0,3));
     }
     
     
     self.lastUserLoc = Me.location;
     
     self.currTurn = self.currTurn+1;
   }
;