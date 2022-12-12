////////////////////////////////

prepareLevel1 : function {
   shnekoMachine.register;
   Statist.Prepare([fonar_seccont window_seccont table_seccont manipu_seccont button_seccont monitor_seccont reshetka_floor comm_floor platform_floor richag_cabin]);
   stop_music_back();
   global.level_play_music = 'Antnio_Bizarro_-_09_-_Berzerker.ogg';
   play_music_loop('Antnio_Bizarro_-_09_-_Berzerker.ogg');
   show_image('shnek.jpg');
   global.curr_level = 1;
   Me._hp = 100;
   Me.travelTo(startroom_lvl1);
}

prepareLevel1_Full : function {
    stop_music_back();
    play_music_loop('Miami_Sheriff_-_Intercept.ogg');
    show_image('med_block.jpg');
    scen_introduction_1();
    "<br><br>";
    "<i>(Для продолжения нажмите ВВОД</i>)<br>";
    input();
    "<br><br>";
    show_image('cabinet.jpg');
    scen_introduction_2();
    "<i>(Для продолжения нажмите ВВОД</i>)<br>";
    input();
    prepareLevel1();
}

//////////////////////////////////////////////

startroom_lvl1: room
   sdesc="Медицинский отсек"
   _field_size = 2
   lit_desc = {
      if (fonar_seccont.isListed == nil) return 'Внутри металлического контейнера. Над жёсткой резиновой койкой мрачно нависает узкий светодиодный фонарь. Какие-то блики в узком окне. На севере продолжение контейнера.';
      else return 'Внутри металлического контейнера. Какие-то блики в узком окне. На севере продолжение контейнера.';
   }
   out = { return self.north; }
   north = {
      if (shnekoMachine.allowMoveSecond) return contsecfloor;
      else {
        "Рано уходить. Вы недостаточно осмотрели помещение.";
        return nil;
      }
   }
   listendesc = "Слышен звук сварки снизу."
;


uproomDecoration1 : decorationNotDirect
  location = startroom_lvl1
  isHer = true
  desc = 'эта часть/1ж помещения'
  noun = 'контейнер/1м' 'продолжение/1с' 'отсек/1м' 'фургон/1м'
  adjective = 'металлический/1пм' 'медицинский/1пм'
;

fonar_seccont : item
   location = startroom_lvl1
   desc = 'светодиодный/1пм фонарь/1м'
   noun = 'фонарь/1м' 'светильник/1м' 'светодиод/1м' 'дуга/1ж' 'лампа/1ж'
   adjective = 'светодиодный/1пм' 'светящийся/1пм'
   isHim = true
   isListed = nil
   ldesc = "Светящаяся яркая дуга, длинной около полутора метров."
   doTake(actor) = {
     if (self.isListed == nil) {
        "Фонарь со скрипом оторвался, но светить не перестал. Очень хорошо, что внутри есть аккумулятор. ";
        self.isListed = true;
     }
     pass doTake;
   }
   verDoTake(actor) = {
     if (shnekoMachine.allowTakeLamp == nil) aresa_say('Тебе не кажется, что пока рано уносить с собой мебель?');
   }
;

koika_seccont : BedSimple
   location = startroom_lvl1
   desc = 'резиновая/1пж койка/1ж'
   noun = 'койка/1ж' 'кровать/1ж' 'основание/1с' 'конструкция/1ж'
   adjective = 'резиновая/1пж' 'монолитную/1пж'
   isHer = true
   ldesc = "Прочное основание койки плавно переходит в пол, образуя монолитную конструкцию."
   verDoLookunder(actor)=aresa_say('Основание койки вырастает из пола! Где там свободное пространство? О, боги, с кем приходиться работать...')
   verDoTake(actor) = {aresa_say('Ну чего, крутой мужик, никак? Видимо, хочешь свинтить и на дачу унести, ды ты хитрец.');}
;

window_seccont : Window
   location = startroom_lvl1
   desc = 'узкое/1пс окно/1с'
   noun = 'окно/1с' 'щель/1ж'
   adjective = 'узкое/1пс'
   ldesc = "В окне иногда появляются блики, видимо источник снаружи. Лучше в него заглянуть."
   haveThruLook = nil
   thrudesc = {
      self.haveThruLook = true;
      "Вы в мчащемся на полной скорости фургоне! На улице темно, хоть глаз выколи, но в редких вспышках света можно заметить небольшие деревья по краям просёлочной дороги.";
   }
   doLookin(actor)={self.thrudesc;}
   verDoShoot(actor)={aresa_say('Что толку разбивать это окно? В эту щель пролезет один твой глаз и то недалеко...');}
   verDoUnboard(actor)={self.verDoShoot(actor);}
   verDoOpen(actor)={aresa_say('Окно монолитное, его не открыть, разве что разбить...');}
;


windowDecoration : decoration
  location = startroom_lvl1
  isHim = true
  desc = 'этот объект/1м в окне'
  noun = 'блик/1м' 'блики/2' 'вспышка/1ж' 'вспышки/2' 'дерево/1с' 'деревья/2' 'дорога/1ж' 'дороги/2' 'источник/1м' 'источники/2' 'край/1м' 'края/2'
  adjective = 'редкие/2' 'просёлочная/1пж'
;


/////

contsecfloor: room
   sdesc="Отсек анализа"
   _field_size = 2
   lit_desc = {
      local text_out = 'Через круглый люк в середине помещения можно спуститься вниз. ';
      if (monitor_seccont.location == contsecfloor) text_out += 'В широкоформатном мониторе помимо биометрических данных отражается ';
      else text_out += 'Вы видите ';
      if (table_seccont.location==contsecfloor) text_out += 'столик и ';
      text_out += 'подрагивающий робот-манипулятор на противоположной стене. Медотсек на юге.';
      return text_out;
   }
   south = startroom_lvl1
   out = { return self.down; }
   down = {
     if (shnekoMachine.allowMoveDown) return mech_floor;
     else {
         "Надо еще ненадолго задержаться здесь.";
         return nil;
     }
   }
   listendesc = "Слышен звук сварки снизу."
;


uproomDecoration2 : decorationNotDirect
  location = contsecfloor
  isHer = true
  desc = 'эта часть/1ж помещения'
  noun = 'контейнер/1м' 'отсек/1м' 'фургон/1м' 'стена/1ж'
  adjective = 'анализа/1пм' 'противоположная/1пж'
;

luk_down : LukSimple
   location = contsecfloor
   desc = 'круглый/1пм люк/1м'
   isHim = true
   ldesc = "Круглый люк, ведёт куда-то вниз."
;

table_seccont : FunnyFixedItem
   location = contsecfloor
   desc = 'прозрачный/1пм столик/1м'
   noun = 'стол/1м' 'столик/1м' 'подставка/1ж'
   adjective = 'прозрачный/1пм' 'небольшой/1пм'
   isHim = true
   ldesc = "Небольшой прозрачный столик, видимо использовался как подставка под разные реагенты, свежие пятна говорят о том, что кто-то забрал всё и исчез."
   verDoLookunder(actor)=aresa_say('Ну он же прозрачный! Хоть это для тебя неочевидно, но под ним ничего нет.')
;

tableDecoration : decoration
  location = contsecfloor
  isHer = true
  desc = 'эта часть/1ж стола'
  noun = 'реагент/1м' 'реагенты/2' 'химия/1ж' 'пятно/1с' 'пятна/2'
  adjective = 'разные/2п' 'разный/1мп' 'свежие/2п' 'свежий/1пм'
;

manipu_seccont : fixeditem
   location = contsecfloor
   desc = 'подрагивающий/1пм манипулятор/1м'
   noun = 'манипулятор/1м' 'робот/1м' 'робот-манипулятор/1м' 'рука/1ж' 'гигант/1м'
   adjective = 'подрагивающий/1пм' 'железный/1пм' 'железная/1пж'
   isHim = true
   ldesc = "Выглядит так, словно под полом прячется железный гигант, а одна из его рук просто застряла и только ждёт удобного случая кого-нибудь схватить. Кажется, сейчас он находится в неком режиме сна. Кроме большой зелёной кнопки, никаких органов управления не видно."
   verDoMove(actor) = "Как только вы попытались сдвинуть манипулятор, он резко отмахнулся. Ареса стала противно хихикать."
   verDoPull(actor) = {self.verDoMove(actor);}
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoTake(actor) = {self.verDoMove(actor);}
   verDoTurnon(actor) = {button_seccont.verDoPush(actor);}
   doTurnon(actor) = {button_seccont.doPush(actor);}
;

button_seccont : Button
   location = contsecfloor
   desc = 'зелёная/1пж кнопка/1ж'
   noun = 'кнопка/1ж' 'орган/1ж'
   adjective = 'большая/1пж' 'зелёная/1пж'
   isHer = true
   ldesc = "Для запуска, выглядит не опасно."
   isTurnOn = nil
   verDoPush(actor) = {
      if (panel_cabin.isLookPanel==nil) "Не работает. Может чего-то не хватает?";
   }
   doPush(actor) = {
      self.isTurnOn = true;
      DustKiller.mustHunt = nil;
      DustKiller.moveInto(nil); //перетаскиваем сборщика здесь, чтобы он не успел сказать состояние в битве
      "Манипулятор зашумел и вытянулся. ";
      play_sound('hydraulic.ogg');
      dustkiller_broken.moveInto(contsecfloor);
   }
;

monitor_seccont : DestructItem
   isListed = nil
   location = contsecfloor
   desc = 'широкоформатный/1пм монитор/1м'
   noun = 'монитор/1м' 'экран/1м' 'данные/2'
   adjective = 'широкоформатный/1пм' 'стартовый'
   isHim = true
   resAmount = RESOURCE_AMOUNT_MID
   ldesc = "На мониторе отображается фигура, похожая на человеческую, ровно бегут столбики цифр со значениями."
   allowDestruct = nil
   verDoShoot(actor) = {
      if (self.allowDestruct==nil) aresa_say('Подожди разбирать монитор, надо еще изучить обстановку.');
   }
   doShoot(actor) = {
      monitorDecoration.moveInto(nil);
      pass doShoot;
   }
;


monitorDecoration : decoration
  location = contsecfloor
  isHim = true
  desc = 'этот объект/1м на мониторе'
  noun = 'фигура/1ж' 'человек/1м' 'столбик/1м' 'цифра/1ж' 'столбики/2' 'цифры/2' 'значение/1м' 'значения/2'
  adjective = 'человеческая/1пм' 'бегущие/1мп' 'свежие/2п' 'свежий/1пм'
;

/////
mech_floor: room
   sdesc="Генераторная"
   _field_size = 2
   lit_desc = { 
       if (panel_cabin.isLookPanel==nil) return 'Узкий спуск переходит в такой же узкий коридор, сдавленный рокочущими агрегатами. В нижнем углу решеткой отделено вентиляционное отверстие. Проход продолжается на юг.';
       else return 'Узкий спуск переходит в такой же узкий коридор, сдавленный рокочущими агрегатами. В нижнем углу решеткой отделено вентиляционное отверстие. Проход продолжается на юг. Рваная дыра в северной стене позволяет пройти в кабину.';
   }
   south = out_floor
   up = contsecfloor
   out = { return self.south; }
   north = {
      if (panel_cabin.isLookPanel) return cabin_shnek;
      return self.noexit;
   }
   listendesc = "Только оглушающий рёв генераторов."
;

downroomDecoration1 : decorationNotDirect
  location = mech_floor
  isHer = true
  desc = 'эта часть/1ж помещения'
  noun = 'контейнер/1м' 'отсек/1м' 'фургон/1м' 'генераторная/1ж' 'коридор/1м' 'проход/1м'
  adjective = 'узкий/1пм'
;

luk_up : LukSimple
   location = mech_floor
   desc = 'круглый/1пм люк/1м'
   isHim = true
   ldesc = "Круглый люк, ведёт куда-то вверх."
;

hole_to_cabin : LukSimple
   location = nil
   desc = 'рваная/1пж дыра/1ж'
   noun = 'дыра/1ж' 'отверстие/1с'
   adjective = 'рваная/1пж' 'неровная/1пж'
   isHer = true
   ldesc = "Неровная дыра, ведёт в кабину на севере."
;

machine_floor : decoration
   location = mech_floor
   desc = 'рокочущие/2п агрегаты/2'
   noun = 'агрегаты/2' 'машины/2' 'генератор/1м' 'рокот/1м'
   adjective = 'рокочущие/2п' 'громкие/2п'
   isThem = true
   ldesc = "Эти машины вырабатывают электричество, а может еще что-нибудь полезное."
;

reshetka_floor : EasyTake
   location = mech_floor
   desc = 'решетка/1ж'
   noun = 'решетка/1ж'
   isHer = true
   ldesc = {
      if (self.wasTaken==nil) "Решетка полностью закрывает вентиляционную трубу, диаметром несколько дециметров.";
      else "Решетка диаметром несколько дециметров";
   }
   wasTaken = nil
   verDoTake(actor) = {if (self.wasTaken) aresa_say('Хватит теребить решетку! Нашел всё что нужно.'); }
   doTake(actor) = {
      "Вы откинули решетку в сторону, за ней оказался небольшой коммуникатор.<br>";
      aresa_say('Ого, это то что нужно! Всякие умные устройства содержат полезные материалы для синтеза, ну-ка разбери его чтобы я подхватила что-нибудь ценное!');
      self.wasTaken = true;
      comm_floor.moveInto(mech_floor);
   }
;

comm_floor : DestructItem
   location = nil
   desc = 'коммуникатор/1м'
   noun = 'коммуникатор/1м' 'устройство/1с' 'вычислитель/1м'
   adjective = 'вычислительное/1пм'
   isHim = true
   ldesc = "Вычислительное устройство, по словам Аресы может содержать полезные ресурсы."
;



vent_tube : decoration
   location = mech_floor
   desc = 'вентиляционная/1пж труба/1ж'
   noun = 'труба/1ж' 'отверстие/1ж'
   adjective = 'вентиляционная/1пж'
   isHer = true
   ldesc = "В отверстии находится труба, небольшого сечения, ничего необычного."
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor);}
   verDoEnterIn(actor) = { self.verDoBoard(actor);}
   verDoBoard(actor) = {aresa_say('Труба маленькая, не пролезть.');}
;

////
out_floor: room
   sdesc="Погрузочная платформа"
   _field_size = 3
   lit_desc = 'Платформа для погрузки где-то на полметра отстоит от нижней рамы. Напротив северного выхода в генераторную выделяется двустворчатая дверь наружу. '
   north = mech_floor
   block_down = nil
   out = {
      if (HaveMonsters(self)) "Вы не можете подобраться к двери, проклятые роботы мешают!"; 
      else "После нескольких попыток становится понятно, что дверь так просто не высадишь. Придётся искать другой путь.";
      return nil; 
   }
   down = {
     if (platform_floor.isFindHole == nil) return self.noexit;
     if (self.block_down == true) {
        "-Ты что, забыл как мы там пробирались? У нас уже есть проход к кабине, ходи - не хочу!";
        return nil;
     }
     return under_ramp;
   }
   listendesc = "Периодицески раздаётся сильный скрежет фургона на поворотах."
;

downroomDecoration2 : decorationNotDirect
  location = out_floor
  isHer = true
  desc = 'эта часть/1ж помещения'
  noun = 'контейнер/1м' 'отсек/1м' 'фургон/1м' 'генераторная/1ж'
  adjective = 'узкий/1пм'
;

platform_floor : fixeditem
   location = out_floor
   desc = 'погрузочная/1пж платформа/1ж'
   noun = 'платформа/1ж' 'пространство/1с' 'дыра/1ж' 'рама/1ж'
   adjective = 'погрузочная/1пж' 'свободное/1пс' 'нижняя/1пж'
   isHer = true
   isLookUnder = nil
   isFindHole = nil
   ldesc = "Тяжёлая платформа для грузов, внизу должен быть какой-то подъемный механизм. Между платформой и полом есть свободное пространство."
   verDoLookunder(actor) = {  if (HaveMonsters(self.location)) "У вас не получиться посмотреть под платформу, пока идёт бой!"; }
   doLookunder(actor) =
   {
     self.isLookUnder = true;
     if (fonar_seccont.isIn(Me)) {
        "Посветив под платформу, вы увидели незаконченный шов между лёгкой железной пластиной и рамой. От удара рукой, пластина вылетела и в образовавшейся дыре начала мелькать земля. Как только вы встали, фонарь вылетел и разбился вдребезги, к счастью, дыру видно хорошо.";
        fonar_seccont.moveInto(nil);
        self.isFindHole = true;
     }
     
     if (self.isFindHole) "Внизу есть пробитая дыра, через неё можно спуститься под днище.";
     else "Под платформой достаточно много места чтобы пролезть, однако очень темно, ничего не видно.";
   }
   verDoEnter(actor) = {"Вы уже стоите на платформе, но между ней и полом есть свободное место.";}
   verDoBoard(actor) = { self.verDoEnter(actor); }
   verDoEnterIn(actor) = { self.verDoEnter(actor);}
   verDoEnterOn(actor) = { self.verDoEnter(actor);}
   verDoMove(actor) = {aresa_say('Платформа огромная! Ты её не сдвинешь, лучше изучи подробнее, что-ли.');}
   verDoPull(actor) = {self.verDoMove(actor);}
   verDoDetach(actor) = {self.verDoMove(actor);}
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoTake(actor) = {self.verDoMove(actor);} 
;

door_floor : fixeditem
   location = out_floor
   desc = 'двустворчатая/1пж дверь/1ж'
   noun = 'дверь/1ж' 'створка/1ж' 'створки/2'
   adjective = 'двустворчатая/1пж'
   isHer = true
   ldesc = {
      if (HaveMonsters(self.location)) "Вы не можете открывать дверь, пока воюете с роботами.";
      else "Двустворчатая дверь наружу.";
   }
   verDoOpen(actor) = { "Дверь намертво заварена роботами! Надо искать другой выход.";  }
;

fixer1 : SpiderFixer
   desc = 'главный/1пм ремонтник/1м'
   noun = 'паук/1м' 'ремонтник/1м' 'робот/1м' 'конечность/1ж'
   adjective = 'главный/1пм' 'дергающаяся/1пж'
   isHim = true
   verDoTake(actor)={"Как вы ни пытались ухватить главного робота за дёргающуюся конечность, ничего не вышло.";}
   _pos = 3
   corpse = fixer1_broken //кто вместо него
;

fixerDecoration : decoration
  location = out_floor
  isHim = true
  desc = 'этот объект/1м у робота'
  noun = 'конечность/1ж' 'резак/1м'
  adjective = 'дергающаяся/1пж' 'плазменный/1мп'
;


fixer1_broken : DestructItem
   desc = 'железный/1пм остов/1м'
   noun = 'остов/1м' 'робот/1м' 'часть/1ж' 'конечность/1ж'
   adjective = 'железный/1пм' 'основная/1пж'
   ldesc = "Всё что осталось от бравого главного ремонтника. Хоть он бился до последнего, основная его часть в неплохом состоянии, чего нельзя сказать о разбросанных по всему контейнеру конечностях."
   isHim = true
   enegryItem = true
   enegryGive = 30
;

fixer2 : SpiderFixer
   desc = 'старший/1пм помощник/1м'
   noun = 'паук/1м' 'ремонтник/1м' 'помощник/1м' 'робот/1м'
   adjective = 'старший/1пм'
   isHim = true
   verDoTake(actor)={"Помощник начал рьяно отбиваться своим плазменным резаком и спрятался в углу, потом всё-таки вылез и решил завершить начатое...";}
   _pos = 3
;

fixer3 : SpiderFixer
   desc = 'младший/1пм сотрудник/1м'
   noun = 'паук/1м' 'ремонтник/1м' 'сотрудник/1м' 'робот/1м'
   adjective = 'младший/1пм'
   isHim = true
   verDoTake(actor)={"Младший сотрудник выдал серию писков что-то отдалённо похожее на молитву и стал защищаться резаком от такого посягательства.";}
   _pos = 3
;

////
under_ramp: room
   sdesc="Под контейнером"
   listendesc = "Только ветер завывает..."
   ldesc = {
      //Берем линии препятсвий
      local cur_line = self.getCurrentLine;
      local fut_line = self.getFutureLine;
      
      //пишем обстановку от лица игрока
      //крайне левое положение
      if (self.plX == 1) {
        "На западе вращающийся шнекоротор. ";
        if (cur_line[2]==1) " На востоке кочка. ";
        if (fut_line[1]==1) " Впереди на севере кочка! ";
      }
      else if (self.plX == 3) {
        "На востоке вращающийся шнекоротор. ";
        if (cur_line[2]==1) " На западе кочка. ";
        if (fut_line[3]==1) " Впереди на севере кочка! ";
      }
      else if (self.plX == 2) {
        "Вы по центру днища. ";
        if (cur_line[1]==1) " На западе кочка. ";
        if (cur_line[3]==1) " На востоке кочка. ";
        if (fut_line[2]==1) " Впереди на севере кочка! ";
      }
   }
   north = {
      local fut_line = self.getFutureLine;
      if (fut_line[self.plX]==1) {
        "Вы ударились об кочку и попали под вращающийся шнек на огромной скорости. ";
        die();
      }
      else {
        self.plY += 1;
        if (self.plY == self.endY) {
           return cabin_shnek;
        }
        else "Осталось метров до сцепки: <<self.endY-self.plY>>. ";
      }
      return nil;
   }
   west = {
      local cur_line = self.getCurrentLine;
      if (self.plX==1) {
        "Как только вы сдвинулись немного западнее, то вас засосало потоком во вращающийся шнек. ";
        die();
      }
      else if (cur_line[self.plX-1]==1) {
        "Вы ударились об кочку и попали под вращающийся шнек на огромной скорости. ";
        die();
      }
      else {
        self.plX-=1;
        "Вы сдвинулись западнее.";
      }
      return nil;
   }
   east = {
      local cur_line = self.getCurrentLine;
      if (self.plX==3) {
        "Как только вы сдвинулись немного восточнее, то вас засосало потоком во вращающийся шнек. ";
        die();
      }
      else if (cur_line[self.plX+1]==1) {
        "Вы ударились об кочку и попали под вращающийся шнек на огромной скорости. ";
        die();
      }
      else {
        self.plX+=1;
        "Вы сдвинулись восточнее.";
      }
      return nil;
   }
//private:
   getCurrentLine = {return self.pattern[self.patCurPos];}
   getFutureLine = {
      if (self.patCurPos==1) return self.pattern[7];
      return self.pattern[self.patCurPos-1];
   }
   //переход к следующему паттерну препятствий
   nextPattern = {
      local cur_line;
      if (self.patCurPos > 1) self.patCurPos -= 1;
      else self.patCurPos = 7;
      
      cur_line = self.getCurrentLine;
      if (cur_line[self.plX]==1) {
         "Вы налетели на кочку с северного направления и отлетели прямо под крутящийся шнек.";
         die();
      }
   }
   //шаблон препятсвий в виде массива (1-препятсвие, 0 - нет)
   pattern = [
     [1 0 0]
     [1 1 0]
     [1 0 0]
     [0 0 0]
     [0 1 1]
     [0 0 1]
     [0 0 0]
   ]
   plX = 2//по оси X(двигаемся перпендикулярно препятствиям)
   plY = 0//по оси Y(идём на встречу)
   patCurPos = 7
   endY = 8
;

Shnekorotor : decoration
   location = under_ramp
   desc = 'шнекоротор/1м'
   noun = 'шнекоротор/1м' 'шнек/1м'
   isHim = true
   ldesc = "Огромное вращающееся сверло. Вы успеваете разглядывать предметы на такой скорости?"
;

Kochka : decoration
   location = under_ramp
   desc = 'кочка/1ж'
   isHer = true
   ldesc = "Выпуклость земли. Особенно опасна, когда вы налетаете на неё с большой скоростью."
;

decorUnderRamp : decoration
   location = under_ramp
   desc = 'этот объект'
   noun = 'днище/1с'
;

////
cabin_shnek: room
   sdesc="Кабина шнекохода"
   isseen = true
   _field_size = 6
   lit_desc = {
     if (panel_cabin.isLookPanel==nil) return 'Низкий потолок заставляет сутулиться. Половину кабины занимает причудливая люстра, практически до пола. На лобовое стекло проецируется голографическая панель управления. ';
     else return 'Низкий потолок заставляет сутулиться. На лобовое стекло проецируется голографическая панель управления. На юге образовался сквозной пролом прямо в прицеп. ';
   }
   out = { return self.south; }
   south = {
      if (panel_cabin.isLookPanel) return mech_floor;
      return self.noexit;
   }
   listendesc = "Раздаётся звук тревоги."
;

hole_to_gener : LukSimple
   location = nil
   desc = 'пролом/1м'
   isHim = true
   ldesc = "Пролом от мега-пылесоса, ведёт в прицеп на юге."
;

door_shnek : fixeditem
   location = cabin_shnek
   desc = 'дверь/1ж'
   noun = 'дверь/1ж'
   isHer = true
   ldesc = "Эта дверь заперта, надо искать другой выход.";
;


lustra_cabin : fixeditem
   location = cabin_shnek
   desc = 'причудливая/1пж люстра/1ж'
   noun = 'люстра/1ж' 'лампа/1ж'
   adjective = 'причудливая/1пж'
   isHer = true
   ldesc = "Шар, диаметром около метра, раскачивается, прикреплённый восемью гофрированными трубами к потолку."
;

sphere_decor : decoration
   location = cabin_shnek
   desc = 'серый/1пм шар/1м'
   noun = 'шар/1м' 'страшилище/1c' 'потолок/1м'
   adjective = 'серый/1пм' 'метровый/1пм'
   isHim = true
   ldesc = "Грязного серого цвета шар, к тому же вообще не светит, кто додумался повесить сюда такую страшилищу?"
;

slang_decor : decoration
   location = cabin_shnek
   desc = 'гофрированный/1пм шланг/1м'
   noun = 'шланг/1м' 'гофра/1ж' 'труба/1ж'
          'шланги/2' 'гофры/2'   'трубы/2'
   adjective = 'гофрированный/1пм'
   isHim = true
   ldesc = "Странная гофра, вся пыльная. У водителя был странный вкус на декор."
;

panel_cabin : Window
   location = cabin_shnek
   desc = 'лобовое/1пж стекло/1ж'
   noun = 'панель/1ж' 'стекло/1ж' 'голограмма/1ж'
   adjective = 'управления/1пж' 'лобовое/1пж' 'окно/1с' 'голографическая/1пж'
   isHer = true
   isLookPanel = nil
   ldesc = {
      if (self.isLookPanel == nil)
      {
          isLookPanel = true;
      }
      "На панели вам ничего не понятно, кроме рычага экстренной остановки.";
   }
   thrudesc = "За окном ничего не видно, темно и грязно. Только ряд светлых пятен выдаёт некий город вдали."
;


window2Decoration : decoration
  location = cabin_shnek
  isHim = true
  desc = 'этот объект/1м в окне'
  noun = 'пятна/2' 'пятно/1с' 'ряд/1м' 'город/1м'
  adjective = 'светлые/2п' 'светлое/1пс'
;

richag_cabin : Button
   desc = 'рычаг/1м'
   noun = 'рычаг/1м' 'стоп/1м' 'стоп-рычаг/1м' 'стоп-кран/1м' 'кран/1м' 'рычаги/2'
   adjective = 'красно-жёлтый/1пм' 'красный/1пм' 'жёлтый/1пм'
   isHim = true
   ldesc = "Красно-жёлтый рычаг экстренной остановки."
   verDoPush(actor)={
     if (HaveMonsters(cabin_shnek)) "Вам мешает дернуть за рычаг спрут-пылесос!";
   }
   
   doPush(actor)={
      //переходим на следующий левел
      Statist.Show(1);
      "<i>(Для продолжения нажмите ВВОД</i>)<br>";
	  input();
      show_image('near_city.jpg');
      scen_lvl1_final();
      "<i>(Для продолжения нажмите ВВОД</i>)<br>";
	  input();
      resourceSaveToGlobal();
      prepareLevel2();
   }
;


////////////////////////////////////
// Машина состояний для сцены шнекохода
shnekoMachine : StateMachine
   lastSt = 0
   st = 0
   lastStoryTurn = 0
   tmLookUnder = 0
   nextTurn={
     if ((self.currTurn >= 0) && (self.st == 0)) {
        scen_lvl1_meetings();
        self.st = 1;
     } else if (self.st == 1) {
         aresa_say('Так, иди, там в окошко посмотри, пока я занята.');
         "<br><b>(наберите \"посмотреть в окно\")</b>";
         self.st = 2;
     } else if ((self.st == 2) && (window_seccont.haveThruLook==true)) {
         "<br>";
         aresa_say('Пожалуй, нам надо выбираться отсюда. Базы я скачала, успела про тебя немного прочитать. Буду тебя звать Иск, сокращение от названия твоего проекта. Вообщем, ты поможешь мне, я тебе и разбежимся, лады?');
         "<br><b>(наберите \"идти на север или просто север\")</b>";
         self.allowMoveSecond = true;
         self.st = 3;
     } else if ((self.st == 3) && (Me.location==contsecfloor)) {
        "<br>";
        aresa_say('Я смотрю, тебя еще не ввели в курс дела по вооружениям. Пять лет в учебке, видимо, всякие каменюки изучал и химические процессы, а нам тут может придётся и повоевать немного. Итак, слава богам, твой полиморфный экзоскелет позволяет вытворять отпадные вещи! Я активирую первое вооружение - крионож. Остальные я активирую по мере готовности, ты сам можешь их внимательно изучить в дальнейшем. Нож предназначен для борьбы в ближнем бою, достаточно тяжёлый чтобы вскрыть какую-нибудь обнаглевшую консервную банку. Вытащи его.');
        "<br><b>(наберите \"выбрать крионож\")</b>";
        Knife.moveInto(Me);
        self.st = 4;
     } else if ((self.st == 4) && (Me.sel_weapon==Knife) && (Me.location==contsecfloor)) {
        "<br>";
        aresa_say('Так, пора освоиться с оружием. Что-бы придумать, что-бы придумать. Есть! Вот тот прозрачный столик, пусть он будет твоим противником! Я чуть подкорректирую коды безопасности, потому что оружие разрешается применять только против прямых угроз. Так, тут еще местный манипулятор перепрошью, чтобы мог нам подсобить в экстренной ситуации. Отвлеклась, ты глянь, какой у нас грозный столик, да просто зверский, давай, прикончи его!');
        "<br><b>(наберите \"осмотреться\", затем \"ударить столик\")</b>";
        NoneWeapon.moveInto(nil);
        table_seccont.moveInto(nil);
        table_seccont_mon.moveInto(contsecfloor);
        self.st = 5;
     }
     else if ((self.st == 5) && (contsecfloor._pl_pos!=table_seccont_mon._pos)) {
        "<br>";
        aresa_say('Ага. Далековато, надо подойти, чтобы оказаться рядом со столиком. Потом убей его!');
        "<br><b>(наберите \"вперед\", чтобы приблизиться)</b>";
        self.st = 6;
     }
     else if ((self.st == 6) && (table_seccont_mon.location==nil)) {
        "<br>";
        aresa_say('Ты сделал это! О мой герой! Теперь пора разведывать дальше этот грузовичок. Если что, сможешь разобраться с несколькими посудомоечными машинами.');
        self.st = 61;
        self.allowMoveDown = true;
     }
     else if ((self.st == 61) && (Me.location==mech_floor)) {
       "<br>";
       aresa_say('Хотела тебе сказать, что я полностью подключилась к твоей системе синтеза, ты всё равно сам не смог бы её управлять. Она может создавать разные полезные штуки, буквально из всего подряд. Я смогла её настроить на энерго кристаллы, пласталь и кремний. Поищи чего-нибудь в этом помещении, как только я обнаружу ресурсы, сразу их захвачу.');
       self.st = 7;
       monitor_seccont.allowDestruct = true;
     }
     else if ((self.st == 7) && (Me.location==out_floor)) {
        "<br>";
        scen_lvl1_spiders();
        self.st = 8;
        fixer1.moveInto(out_floor);
        fixer2.moveInto(out_floor);
        fixer3.moveInto(out_floor);
     }
     else if ((self.st == 8) && (!HaveMonsters(out_floor))) {
        "<br>";
        fixerDecoration.moveInto(nil);
        aresa_say('С ними мы разделались, отлично. Кажется от главного осталась неплохая часть! Надо попробовать её разобрать, в таких активных роботах может находиться материал для синтеза кристаллов энергии. У живых существ, я успеваю собирать энергию, прямо на лету!');
        if (ResourceSystem.aluminium > 0) {
             aresa_say('После разборки, ты сможешь синтезировать небольшую порцию лекарства, попробуй.');
             "<br>";
        }
        else
        {
            aresa_say('После разборки, ты мог бы синтезировать небольшую порцию лекарства, но не нашел кое-чего в генераторной, поищи там а потом попробуй синтезировать.');
            "<br>";
        }
        "<b>(наберите \"синтез\" далее выберите шприц и укажите количество, чтобы применить её введите \"использовать шприц\" или просто \"использовать\" и найдите по номеру)</b>";
        self.st = 9;
        CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
     }
     else if ((self.st == 9) && (platform_floor.isLookUnder)) {
        "<br>";
        aresa_say('Отлично, там может что-то быть. Давай найдем где-нибудь фонарик или свечку накрайняк. Ты кстати не куришь?');
        self.allowTakeLamp = true;
        self.st = 10;
     }
     else if ((self.st == 10) && (platform_floor.isFindHole)) {
        "<br>";
        aresa_say('Выход есть! Пора поговорить с водителем.');
        "<br><b>(рекомендуем сохраниться перед продолжением)</b>";
        self.st = 11;
     }
     else if ((self.st == 11) && (Me.location == under_ramp)) {
        scen_lvl1_under_shneko();
        self.st = 12;
     }
     else if ((self.st == 12) && (Me.location == cabin_shnek)) {
        scen_lvl1_in_shneko();
        self.st = 13;
     }
     else if ((self.st == 13) && (panel_cabin.isLookPanel == true)) {
          scen_lvl1_dustsocker();
          //Добавляем рычаг, монстра и убираем декор
          richag_cabin.moveInto(cabin_shnek);
          lustra_cabin.moveInto(nil);
          slang_decor.moveInto(nil);
          sphere_decor.moveInto(nil);
          DustKiller.travelTo(cabin_shnek);
          DustKiller.mustHunt = true;
          out_floor.block_down = true; //нельзя спускаться вниз после перехода
          hole_to_cabin.moveInto(mech_floor);
          hole_to_gener.moveInto(cabin_shnek);
          self.st = 14;
     }
     else if ((self.st == 14) && (button_seccont.isTurnOn) ) {
        scen_lvl1_kick_vacuum();
        button_seccont.isTurnOn = nil;
        self.st = 15;
     }
     
     //Когда под днищем, то смещаем паттерн
     if (Me.location==under_ramp) {
       under_ramp.nextPattern;
       under_ramp.ldesc;
     }
     
     //всегда двигаем пылесоса к игроку, во время его наступления
     if (DustKiller.mustHunt)
     {
        if (DustKiller.location != Me.location)
        {
           DustKiller.travelTo(Me.location);
        }
     }
     
     //Подсказка посмотреть под платформу
     if ((self.st == 9) && (!platform_floor.isLookUnder) && (global.is_easy))
     {
        self.tmLookUnder += 1;
        //Выдаём после 10 хода и каждые 10 ходов
        if (self.tmLookUnder >= 10 && (self.tmLookUnder % 10==0)) {
          aresa_say('Посмотри под платформу!');
        }
     }
     
     //Если произошло изменение состояния, запоминаем ход, для дёргания игрока
     if (self.lastSt != self.st)
     {
        self.lastSt = self.st;
        self.lastStoryTurn = self.currTurn;
     }
     self.currTurn = self.currTurn+1;
   }
//Выходы
   allowMoveSecond = nil //разрешено идти в следующую комнату
   allowMoveDown = nil   //разрешено спускаться вниз
   allowTakeLamp = nil   //разрешено брать лампу
;