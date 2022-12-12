////////////////////////////////

#include <ochkoGame.t>

/////////
prepareLevel4 : function {
   show_image('beach.jpg');
   hotelMachine.unregister;
   aquaMachine.register;
   if (global.is_easy==nil) {
       //"<b>* ДОБАВЛЕН СИНТЕЗ - КРИОСТЕНА</b><br>";
       "<b>* ДОБАВЛЕН СИНТЕЗ - ПЕРЕБЕЖЧИК</b><br>";
       "<b>* ДОБАВЛЕН СИНТЕЗ - КОПИЯ</b><br>";
       //CraftSystem.enableCraft(CRAFT_TYPE_KRIO_WALL);
       CraftSystem.enableCraft(CRAFT_TYPE_MIND);
       CraftSystem.enableCraft(CRAFT_TYPE_DUP);
   }
   global.level_play_music = 'David_Szesztay_-_Beach_Party.ogg';
   stop_music_back();
   play_music_loop('David_Szesztay_-_Beach_Party.ogg');
   Me.travelTo(beach_start_room);
   Knife.moveInto(Me);
   Me.sel_weapon=Knife;
   NoneWeapon.moveInto(nil);
   Me.Heal;
   
   global.curr_level = 4;
   
   Statist.Prepare([flyboard gamedeck way_aerogel chairs_bus_room massage kust_at_rock]);
   
   //добавляем с предыдущих уровней
   CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
   Pistol.moveInto(Me);
   Drobovik.moveInto(Me);
   CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
   CraftSystem.enableCraft(CRAFT_TYPE_SHOTGUN);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
   CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
   CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
   CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
   CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
   TorsionGenerator.moveInto(Me);
}

beach_start_room : room
  sdesc="Спуск к пляжу"
  lit_desc = 'Мощеная дорожка, продолжающаяся на запад, заполнена рыскающими туристами. Легкий морской бриз раскачивает флаги на длинных флагштоках. Пляж с лазурной морской водой к северу весь забит отдыхающими.'
  north = beach_rock_room
  west = beach_game_room
  listendesc = "Слышен шум волн и крики чаек, как и многочисленных туристов."
;

beachStartDecoration : decoration
  location = beach_start_room
  isHim = true
  desc = 'этот объект/1м'
  noun = 'волна/1ж' 'чайка/1ж' 'рисунок/1м'
         'волны/2'  'чайки/2'  'рисунки/2'
         'бриз/1м' 'вода/1ж' 'бетон/1м' 'волокно/1с' 'песок/1м'
  adjective = 'морской/1м' 'лазурная/1пж'
;


trap : decoration
  location = beach_start_room
  desc = 'мощеная/1пж дорожка/1ж'
  noun = 'дорожка/1ж' 'плитка/1ж' 'плитки/2' 'тротуар/1м'
  adjective = 'мощеная/1пж'
  isHer = true
  ldesc = "Симпатичные плитки из прозрачного бетона. Комбинация оптического волокна и мелкозернистого песка создают уникальный рисунок на каждой плиточке. "
;

turists : decoration
  location = beach_start_room
  desc = 'рыскающие/2п туристы/2'
  noun = 'туристы/2' 'турист/1м' 'отдыхающие/2' 'отдыхающий/1м' 'люди/2' 'человек/1м'
  adjective = 'рыскающие/2п'
  ldesc = "Туристы толкаются на дорожке, лежат на пляже, и, кажется, заполонили всё пространство. "
;


flags : decoration
  location = beach_start_room
  desc = 'флаг/1м'
  noun = 'флаг/1м' 'флагшток/1м' 'флаги/2'
  adjective = 'длинный/1пм'
  isHim = true
  ldesc = "Флаги всех государств мира стройно раскачиваются, подчеркивая международную территорию отдыха. "
;

st_beach : distantItem
  location = beach_start_room
  desc = 'пляж/1м'
  noun = 'пляж/1м'
  isHim = true
  ldesc = "Красивый пляж, люди красиво отдыхают. Ничего не скажешь. "
;

kuznec_game : DestructItem
   location = beach_start_room
   desc = 'кузнечик/1м'
   noun = 'кузнечик/1м' 'игрушка/1ж' 'робот/1м'
   isHim = true
   ldesc = "Это здоровенный кузнечик, который когда-то был детской игрушкой, но после нелёгкой судьбы и пережитых страданий совсем сломался. Неудача маркетологов. Судя по прохожим, в тренде как всегда, плюшевые мишки."
;

zaryadnik : DestructItem
   location = beach_start_room
   desc = 'зарядник/1м'
   noun = 'зарядник/1м' 'зарядное/1' 'устройство/1'
   adjective = 'масляная/1пж'
   isHim = true
   ldesc = "В теньке неподалёку притаилось зарядное устройство для разных гаджетов, с прорезями для вставки банкнот и карточек. Корпус пыльный, на индикаторе светиться ошибка. Бизнес-идея не пошла. Видимо, кафешки в округе предлагают подзарядиться бесплатно."
;


/////////

beach_game_room : room
  sdesc="Игровая зона"
  lit_desc = 'Среди всевозможных детских аттракционов, ярко выделяется один игровой стол для взрослых. Мощеная дорожка идёт с востока на запад.'
  east = beach_start_room
  west = beach_parking_room
  listendesc = "Слышен шум волн и крики чаек, как и многочисленных туристов."
;


beachGameDecoration : decoration
  location = beach_game_room
  isHim = true
  desc = 'этот объект/1м'
  noun = 'волна/1ж' 'чайка/1ж' 'рисунок/1м' 'турист/1м' 'путник/1м'  'взрослый/1м' 'светодиод/1м' 'карта/1ж'
         'волны/2'  'чайки/2'  'рисунки/2'  'туристы/2' 'путники/1м' 'взрослые/2'  'светодиоды/2' 'карты/2'
         'бриз/1м' 'вода/1ж' 'бетон/1м' 'волокно/1с' 'песок/1м'
  adjective = 'морской/1м' 'лазурная/1пж'
;


trap2 : decoration
  location = beach_game_room
  desc = 'мощеная/1пж дорожка/1ж'
  noun = 'дорожка/1ж' 'плитка/1ж'
  adjective = 'мощеная/1пж'
  isHer = true
  ldesc = "Симпатичные плитки из прозрачного бетона. Комбинация оптического волокна и мелкозернистого песка создают уникальный рисунок на каждой плиточке. "
;

attractor : decoration
  location = beach_game_room
  desc = 'аттракцион/1м'
  noun = 'аттракцион/1м' 'карусель/1ж' 'каруселька/1ж' 'лошадка/1ж' 'лошадь/1ж' 
         'аттракционы/2' 'карусели/2'  'карусельки/2'  'лошадки/2'  'лошади/2'
         'ребятня/1ж' 'дети/2'
  isHim = true
  ldesc = "Всяческие карусельки, лошадки, заполненные ребятней. "
;

replace customPreCraft : function()
{
   if (gamedeck.giveMoney==true) {
       aresa_say('Вот дьявол! Этот поганый стол, нас облапошил! Пока он передавал нам липовые кристаллы, он стащил все наши ресурсы! Если бы не было столько народу, то разнесли бы его вклочья!');
       ResourceSystem._alum = 0;
       ResourceSystem._crystal = 0;
       ResourceSystem._selicon = 0;
       gamedeck.giveMoney=nil;
   }
}

gamedeck : Actor
   location = beach_game_room
   desc = 'карточный/1пм столик/1м'
   noun = 'столик/1м' 'стол/1м'
   adjective = 'карточный/1пм'
   isHim = true
   ldesc = "Карточный столик с колодами предлагает азартным путникам развлечься. "
   actorDesc = "[|Карточный столик важно тасует карты./Карточный столик поворачивается ко взрослым, подмигивая светодиодом./На карточном столике карты бегают друг за другом.]"
   verDoTalk(actor) = { if (self.nTry >= 3) "Столик не обращает на вас никакого внимания и ждёт следующего клиента."; }
   nTry = 0
   giveMoney = nil
   
   
   doTalk(actor) = {
      local st=0, money, my_num, ai_num;
      "- Итак, уважаемый путник! Сыграем в 21 по новым правилам? Это очень просто. Сначала вы делаете ставку энергокристаллами и далее по правилам игры. Если вы хотите узнать их точнее, просто скажите! Начинаааем? Вы почувствовали, как Ареса тревожно зыркнула на вас. <br>";
      if (ResourceSystem.crystals<1) {
        "- Ой, к сожалению, у вас нет кристаллов! Приходите как их раздобудете.";
        abort;
      }
      while (true)
      {
        local resp,res_user;
        if (st==0) "(наберите \"правила\", для выдачи инструкций или \"старт\" для начала, всё остальное считается окончанием диалога)";
        if (st==1) "Введите вашу ставку от 1 до <<ResourceSystem.crystals>> кристаллов.";
        if (st==2) "Добавить карту или открываемся? (\"добавить\", \"открыть\")";
        "<br>>";
        resp=input();        
        if (st==0)
        {
            if (resp == 'правила') {
               "- Сдатчик (банкир) является столом. Стоимость карт в очках: туз — 11 очков; король — 4 очка; дама — 3 очка; валет — 2 очка; остальные карты по своему номиналу. Колода тщательно тасуется, далее игрок получает две карты. Сдатчик сдаёт себе две карты и последнюю карту вскрывает, показывая вам. Первый ход принадлежит игроку слева от банкира. Игрок называет ставку, на которую он хочет сыграть в данном туре, но которая не превышает сумму кристаллов, которые находятся у него. Например у вас 10 кристаллов. Игрок говорит: «Иду на 5» и просит одну карту у банкира. Если игроку не хватает очков, чтобы набрать 21 очко, то он просит ещё карту. Игрок, который набирает 21 очко, сразу становиться победителем и забирает из банка свой выигрыш. Если игрок набрал более 21 очка, то он обязан заплатить долг в банк. Игрок, который набирает больше всего очков, выигрывает. Если число очков одинаковое, то ставки, сделанные игроками, возвращаются им обратно. Игрок, который проиграл, кладет в банк свой проигрыш и игра продолжается. Отыгранные карты после каждого игрока, банкир кладёт сверху колоды рубашкой вверх, далее берёт себе снизу карту и продолжает игру.";
            }
            else if (resp == 'старт')
            {
              st=1;
              The21Game.nextDeck;
            }
            else
            {
               "- До новых встреч!";
               abort;
            }
        }
        else if (st==1)
        {
           money = cvtnum(resp);
           if (money > 0 && money <= ResourceSystem.crystals)
           {
              st=2;
              "Ваши карты:<br>";
              The21Game.showMyDeck;
           }
           else
           {
              "- Введите правильную ставку!";
           }
        }
        else if (st==2)
        {
           local was_end = nil;
           if (resp == 'добавить')
           {
             The21Game.my_deck += [The21Game.getRandCardFromDeck];
             was_end = true;
           }
           else if (resp == 'открыть')
           {
             was_end = true;
           }
           else
           {
              "- Непонятно, еще разок!";
           }
           
           //Обработка финала
           if (was_end)
           {
              self.nTry += 1;
              my_num = The21Game.countMyDeck;
              ai_num = The21Game.countAiDeck;
              if (my_num>21)
              {
                 "- У вас перебор! Деньги переходят столику.";
                 ResourceSystem.Pay(0,money,0);
              }
              else if (ai_num>21)
              {
                 "- У столика перебор! Вы получаете выигрыш.";
                 self.giveMoney = true;
                 ResourceSystem.GenFromEnemy(money);
              }
              else if (my_num==ai_num)
              {
                 "- Ничья! Все остаются при своём.";
              }
              else if (my_num<ai_num)
              {
                 "- Вы проиграли! Ваши деньги теперь наши! Всего хорошего.";
                 ResourceSystem.Pay(0,money,0);
              }
              else if (my_num>ai_num)
              {
                 "- Неужели вы победили! Придется смириться.";
                 self.giveMoney = true;
                 ResourceSystem.GenFromEnemy(money);
              }
              "Ваши карты:<br>";
              The21Game.showMyDeck;
              "Карты стола:<br>";
              The21Game.showAiDeck;
              
              if (self.nTry >= 3) "- Неплохо поиграли! Я пожалуй переключюсь на других клиентов.";
              
              abort;
           }
        }
     }
   }
;

/////////

beach_parking_room : room
  sdesc="Стоянка флаеров"
  lit_desc = 'Яркие флаеры расставлены как попало, люди торопились на отдых. Пузатый автобус с бледно-розовыми стенками греется на солнце в ожидании гуляющих туристов. Пройти по набережной можно на восток.'
  east = beach_game_room
  listendesc = "Слышен шум волн и крики чаек, как и многочисленных туристов."
;

beachParkingDecoration : decoration
  location = beach_parking_room
  isHim = true
  desc = 'этот объект/1м'
  noun = 'волна/1ж' 'чайка/1ж' 'рисунок/1м' 'турист/1м' 'путник/1м'  'взрослый/1м' 'подросток/1м' 'экзепляр/1м'
         'волны/2'  'чайки/2'  'рисунки/2'  'туристы/2' 'путники/1м' 'взрослые/2'  'подростки/2'  'экзепляры/1м'
         'люди/2' 'бриз/1м' 'вода/1ж' 'бетон/1м' 'волокно/1с' 'песок/1м' 'толпа/1ж' 'толпы/2' 'море/1с'
  adjective = 'морской/1м' 'лазурная/1пж'
;

stand_flyer : decoration
  location = beach_parking_room
  desc = 'яркий/1пм флайер/1м'
  noun = 'флайер/1м' 'флаер/1м' 'флайеры/2' 'флаеры/2'
  isHim = true
  ldesc = "Типичное транспортное средство среднего класса. Здесь наверное множество арендованных экзепляров, судя по визгливым толпам подростков, выскакивающих из них и мчащихся к морю."
;

autobus : fixeditem
   location = beach_parking_room
   desc = 'автобус/1м'
   ldesc = "Большой автобус, принимает любого пассажира когда тот попытается войти."
   
   verDoOpen(actor) = {"<<ZAG(self,&sdesc)>> уже открыт.";}
   verDoClose(actor) = {"<<ZAG(self,&sdesc)>> нельзя закрыть.";}
   verDoBoard(actor) = {}
   doBoard(actor) = {
      //Мы забрались в автобус, как раз в тот момент, как качки собирались уйти
      if (shwartz.location == Me.location)
      {
         shwartz.moveInto(nil);
         stallone.moveInto(nil);
         shwartzMonster.travelTo(bus_room);
         stalloneMonster.travelTo(bus_room);
         aquaMachine.st = 5;
         aquaMachine.num_steps_guys = 0;
         aquaMachine.is_lead_guys = nil;
         //возвращаем наш облик
         Me.isOnBeach = nil;
         "<br>Ареса сбросила маскировку, чтобы не отвлекала в сражении.<br>";
      }
      Me.travelTo(bus_room);
   }
   verDoEnter(actor) = { self.verDoBoard(actor); }
   doEnter(actor) = { self.doBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   doEnterOn(actor) = { self.doBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
   doEnterIn(actor) = { self.doBoard(actor); }
;


/////////

bus_room : room
  sdesc="Внутри автобуса"
  lit_desc = 'Мягкие аэрогелевые кресла вросли в пол и расположены в шахматном порядке вдоль основного коридора.'
  out = {
     if (HaveMonsters(self)) {
        aresa_say('Ты собрался линять? Ну уж нет, ввязался в драку, разбирайся.');
        return nil;
     }
     else {
        //Если выходим, когда качки еще на пляже где-то
        if (shwartz.location != nil) return beach_parking_room;
        if ( (shwartzMonster.location == nil) && (stalloneMonster.location == nil) )
        {
            //Включаем необходимость защиты мальчика
            aquaMachine.have_protect_boy = true;
            show_image('mother.jpg');
            scen_lvl4_out_bus();
            global.level_play_music = 'The_Pandoras_-_01_-_Haunted_Beach_Party.ogg';
            stop_music_back();
            play_music_loop('The_Pandoras_-_01_-_Haunted_Beach_Party.ogg');
            return beach_parking_room2;
        }
        else return beach_parking_room;
     }
  }
  _field_size = 4
;

beachBusDecoration : decoration
  location = bus_room
  isHim = true
  desc = 'этот объект/1м'
  noun = 'субстанция/1ж' 'коридор/1м'
  adjective = 'пластилиновая/1ж'
;


chairs_bus_room : decoration
  location = bus_room
  desc = 'аэрогелевое/1п кресло/1с'
  noun = 'кресло/1с' 'кресла/2'
  adjective = 'мягкое/1пс' 'мягкие/2п'
  ldesc = "Кресло вытягивается из пола, некой пластилиновой субстанцией. Пассажиру должно быть очень комфортно."
  verDoSiton(actor)={aresa_say('Не время рассиживаться!');}
;


shwartzMonster : HardTrooper
   location = nil
   desc = 'Шварценнегер/1мо'
   noun = 'шварценнегер/1м' 'арнольд/1м' 'арни/1м' 'шварц/1м' 'качок/1м'
   isHim = true
   _pos = 3
;

stalloneMonster : HardTrooper
   location = nil
   desc = 'Сталлоне/1мо'
   noun = 'сталлоне/1м' 'сильвестр/1м' 'слай/1м' 'качок/1м'
   isHim = true
   _pos = 3
;

/////////

beach_rock_room : room
  sdesc="Скала на берегу"
  lit_desc = 'Небольшая горка с одиноким кустарником почти дотянулась до плескающейся воды. Дуга песчаного пляжа продолжается на запад, вернуться к мощеной набережной можно на юг.'
  south = beach_start_room
  west = beach_main_room
  listendesc = "Слышен шум волн и крики чаек, как и многочисленных туристов."
;

beachRockDecoration : decoration
  location = beach_rock_room
  isHim = true
  desc = 'этот объект/1м'
  noun = 'волна/1ж' 'чайка/1ж' 'турист/1м' 'путник/1м'  'взрослый/1м'
         'волны/2'  'чайки/2'  'туристы/2' 'путники/1м' 'взрослые/2' 
         'люди/2' 'бриз/1м' 'бетон/1м' 'волокно/1с' 'набережная/1ж'
  adjective = 'морской/1м' 'лазурная/1пж' 'песчаного/1пм'
;

kust_at_rock : decoration
  location = beach_rock_room
  desc = 'одинокий/1пм кустарник/1м'
  noun = 'кустарник/1м' 'куст/1м' 'гора/1ж' 'горка/1ж' 'крона/1ж' 'скала/1ж'
  adjective = 'одинокий/1пм' 'низенький/1пм'
  isHim = true
  ldesc = "Низенький куст, крона очень широкая и практически параллельная земле. Идеал японских художников."
  verDoEnter(actor) = { self.verDoBoard(actor); }
  verDoEnterOn(actor) = { self.verDoBoard(actor);}
  verDoEnterIn(actor) = { self.verDoBoard(actor);}
  verDoBoard(actor) = {aresa_say('Прятаться в кустах - не наш метод, товарищ.');}
;

water_at_rock : decoration
  location = beach_rock_room
  desc = 'плескающаяся/1пм вода/1ж'
  noun = 'вода/1ж' 'море/1'
  adjective = 'плескающаяся/1пм'
  isHer = true
  ldesc = "Светло-зелёная вода, на которой образуются белые гребешки и тут же исчезают. Удивительно, как смогли люди сделать искуственное море?"
;

sander_at_rock : decoration
  location = beach_rock_room
  desc = 'песчаный/1пм пляж/1м'
  noun = 'пляж/1м' 'дуга/1ж' 'песок/1м'
  adjective = 'песчаный/1пм'
  isHim = true
  ldesc = "Кристалльно чистый белый песок, наверное, с Мальдив."
;


trap_r : decoration
  location = beach_rock_room
  desc = 'мощеная/1пж дорожка/1ж'
  noun = 'дорожка/1ж' 'плитка/1ж'
  adjective = 'мощеная/1пж'
  isHer = true
  ldesc = "Симпатичные плитки из прозрачного бетона. Комбинация оптического волокна и мелкозернистого песка создают уникальный рисунок на каждой плиточке. "
;

/////////

beach_main_room : room
  sdesc="Песчаный пляж"
  lit_desc = 'Основная часть местного курорта. Дети плескаются в воде, строят песчаные крепости, взрослые лениво наблюдают за ними лёжа в тени под зонтиками. Несколько роскошных дам принимают солнечные ванны. На западе причал, к востоку скала на побережье.'
  east = beach_rock_room
  west = beach_pirs_room
;

beachMainDecoration : decoration
  location = beach_main_room
  isHim = true
  desc = 'этот объект/1м'
  noun = 'волна/1ж' 'чайка/1ж' 'турист/1м' 'путник/1м'  'взрослый/1м' 'крепость/1м' 'зонтик/1м' 'дама/1ж' 'ванна/1ж' 'пятерня/1ж' 'клиент/1м'
         'волны/2'  'чайки/2'  'туристы/2' 'путники/1м' 'взрослые/2'  'крепости/2'  'зонтики/2' 'дамы/2'  'ванны/2'  'пятерни/2'  'клиенты/2'
         'люди/2' 'бриз/1м' 'бетон/1м' 'волокно/1с' 'набережная/1ж' 'модуль/1м' 'брызги/2' 'дети/2' 'дам/2' 
         'клиентка/1ж' 'клиентки/2'
  adjective = 'морской/1м' 'лазурная/1пж' 'силиконовые/2п' 'эмоциональный/1пм'
;

beach_items : decoration
  location = beach_main_room
  desc = 'лежак/1м'
  noun = 'лежак/1м' 'зонтик/1м'
  isHim = true
  ldesc = "Лежаки и зонтики, совсем обычные, неужели руководство сэкономило на продвинутых вариантах или народу нравится?"
;

water_at_main : decoration
  location = beach_main_room
  desc = 'вода/1ж'
  noun = 'вода/1ж' 'море/1'
  adjective = 'плескающаяся/1пм'
  isHer = true
  ldesc = "Светло-зелёная вода, на которой образуются белые гребешки и тут же исчезают. Много отдыхающих, почти нет свободного места."
;

sander_at_main : decoration
  location = beach_main_room
  desc = 'песчаный/1пм пляж/1м'
  noun = 'пляж/1м' 'дуга/1ж' 'песок/1м'
  adjective = 'песчаный/1пм'
  isHim = true
  ldesc = "Кристалльно чистый белый песок, наверное с Мальдив."
;

massage : Actor
   location = beach_main_room
   desc = 'массажист/1м'
   noun = 'массажист/1м' 'робот/1м' 'робот-массажист/1м'
   isHim = true
   adjective = 'массажный/1пм' 'бюджетный/1пм'
   ldesc = "Бюджетный массажный робот по первому зову начинает мять своих жерт. Ну или царапать. Зависит от того, когда поледний раз у него меняли стёршиеся силиконовые пятерни. Судя по его поведению эмоциональный модуль давно переполнен и требует перезагрузки. Выглядит как такой бочёнок к руками-манипуляторами, передвигается аккуратно, чтобы никого не задеть."
   actorDesc = "[|Масажный робот нервно вздрагивает от попадания брызг./Недовольная клиентка требует, чтобы робот еще раз промассировал спину./Робот-массажист нервно размазывает масло по спине отдыхающей полной даме./Массажист поскрипывая ковыляет к следующему клиенту.]"
   verDoTalk(actor) = {aresa_say('Этот паренёк неразговорчив, для нас бесполезен.');}
   verDoShoot(actor) = {}
   doShoot(actor)={
      "Как только вы попытались разобрать робота, у него сработала специальная защита и вас ударило небольшим разрядом тока (-5). Судя по его гримасе, хоть что-то за сегодня его обрадовало.";
      Me.Hit(nil,5);
   }
;

/////////

beach_pirs_room : room
  sdesc="Причал"
  lit_desc = 'Уходящая в воду дорожка из аэрогеля, подсвечивается всякий раз как по ней ступают босые ноги смельчаков, решивших прокатится на гидроцикле. Флайборд, привязанный к причалу, плавно раскачивается на волнах. Основной пляж на востоке.'
  east = beach_main_room
  listendesc = "Слышен шум волн и крики чаек, как и многочисленных туристов."
;

beachPirsDecoration : decoration
  location = beach_pirs_room
  isHim = true
  desc = 'этот объект/1м'
  noun = 'волна/1ж' 'чайка/1ж' 'турист/1м' 'путник/1м'  'взрослый/1м' 'крепость/1м' 'зонтик/1м' 'дама/1ж' 'ванна/1ж' 'пятерня/1ж' 'клиент/1м' 'смельчак/1м'
         'волны/2'  'чайки/2'  'туристы/2' 'путники/1м' 'взрослые/2'  'крепости/2'  'зонтики/2' 'дамы/2'  'ванны/2'  'пятерни/2'  'клиенты/2' 'смельчаки/2'
         'люди/2' 'бриз/1м' 'бетон/1м' 'волокно/1с' 'набережная/1ж' 'брызги/2'
  adjective = 'морской/1м' 'лазурная/1пж'
;

way_aerogel : decoration
  location = beach_pirs_room
  desc = 'дорожка/1ж'
  noun = 'дорожка/1ж' 'аэрогель/1м' 'причал/1м' 'матрица/1ж'
  adjective = 'светящаяся/1пж'
  isHer = true
  ldesc = "При касании ног встроенная в материал светопроводящая матрица создаёт на поверхности цветные эффекты. Ночью они более романтичные, днём - яркие."
;


flyboard : fixeditem
   location = beach_pirs_room
   desc = 'флайборд/1м'
   noun = 'флайборд/1м' 'гидроцикл/1м' 'доска/1ж'
   ldesc = "Глянцевая серебристая доска, метра три в длину, за фазой разгона над волнами следует фаза плавного спуска на воду и петляние по волнам."
   verDoBoard(actor) = {aresa_say('Ого, смотри, как напряглись те мальчики! Так просто не угонишь этот аппарат.');}
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
   verDoStandon(actor) = { self.verDoBoard(actor); }
   verDoTake(actor) = { self.verDoBoard(actor); }
;

shwartz : Actor
   location = beach_pirs_room
   desc = 'Шварценнегер/1мо'
   noun = 'шварценнегер/1м' 'арнольд/1м' 'арни/1м' 'шварц/1м' 'качок/1м'
   isHim = true
   ldesc = "Этот качок как две капли воды похож на легендарного киноактёра в молодости."
   actorDesc = "[|Шварценнегер смотрит на вас исподлобья./Арни что-то шепчет на ухо Сталлоне./Арнольд поигрывает мышцами торса.]"
   verDoTalk(actor) = {aresa_say('Тебе не кажется что он не больно разговорчив, да и ты тоже?');}
   verDoShoot(actor) = {aresa_say('Мысль хорошая, но здесь столько людей, ты себя сразу демаскируешь. Надо найти укромное место и разобраться с ними.');}
   verDoMove(actor) = "Верзила так уставился на вас, что у вас пропали всяческие мысли его задевать."
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoPull(actor) = {self.verDoMove(actor);}
;

stallone : Actor
   location = beach_pirs_room
   desc = 'Сталлоне/1мо'
   noun = 'сталлоне/1м' 'сильвестр/1м' 'слай/1м' 'качок/1м'
   isHim = true
   ldesc = "Этот качок - вылитый Сталлоне."
   actorDesc = "[|Сильвестр кивает Арнольду./Сталлоне смотрит в небо./Сталлоне старается не глядеть в вашу сторону.]"
   verDoTalk(actor) = {aresa_say('Нет, с ним разговор не склеится, я тебе гарантирую.');}
   verDoShoot(actor) = {aresa_say('Думаешь правильно, вот только как ты начнешь их гасить при стольких людях, никто не обрадуется, будет паника, жертвы, надо найти подходящее место и расправиться с ними.');}
   verDoMove(actor) = "Верзила так уставился на вас, что у вас пропали всяческие мысли его задевать."
   verDoPush(actor) = {self.verDoMove(actor);}
   verDoPull(actor) = {self.verDoMove(actor);}
;


/////////

beach_start_room2 : room
  sdesc="Спуск к пляжу"
  lit_desc = 'Мощеная дорожка продолжается на запад. Пляж на севере.'
  north = beach_rock_room2
  west = beach_game_room2
;

trap_r2 : decoration
  location = beach_start_room2
  desc = 'мощеная/1пж дорожка/1ж'
  noun = 'дорожка/1ж' 'плитка/1ж'
  adjective = 'мощеная/1пж'
  isHer = true
  ldesc = "Плитки из прозрачного бетона, сейчас не так интересны. "
;

st_beach2 : distantItem
  location = beach_start_room2
  desc = 'пляж/1м'
  noun = 'пляж/1м'
  isHim = true
  ldesc = "Красивый пляж, люди красиво отдыхают. Ничего не скажешь. "
;

/////////

beach_game_room2 : room
  sdesc="Игровая зона"
  lit_desc = 'Опустевшие детские аттракционы. Дорожка продолжается с востока на запад.'
  east = beach_start_room2
  west = beach_parking_room2
  _pl_pos = 3
;

fallen_game_table : DestructItem
   location = beach_game_room2
   desc = 'карточный/1пм столик/1м'
   noun = 'столик/1м' 'стол/1м'
   adjective = 'карточный/1пм'
   isHim = true
   ldesc = "Карточный столик почти не узнать. Теперь он лежит на боку. Одна пара ног отвалилась, другая дёргается в судорогах. В центре зияет дыра, по краям которой искрятся пучки оголённых проводов."
;

trap_r3 : decoration
  location = beach_game_room2
  desc = 'мощеная/1пж дорожка/1ж'
  noun = 'дорожка/1ж' 'плитка/1ж'
  adjective = 'мощеная/1пж'
  isHer = true
  ldesc = "Плитки из прозрачного бетона, сейчас не так интересны. "
;

attractor2 : decoration
  location = beach_game_room2
  desc = 'аттракцион/1м'
  noun = 'аттракцион/1м'
  isHim = true
  ldesc = "Всяческие карусельки, лошадки ни одного ребёнка. "
;

simple_mon_hunt_boy4 : SimpleShooter
   desc = 'отчаянный/1пмо стрелок/1мо'
   location = beach_game_room2
   isHim = true
   _pos = 0
;

simple_mon_hunt_boy5 : SimpleShooter
   desc = 'страдающий/1пмо стрелок/1мо'
   location = beach_game_room2
   isHim = true
   _pos = 5
;

/////////

beach_parking_room2 : room
  sdesc="Стоянка флаеров"
  lit_desc = 'Искорёженные флаеры разбросаны вокруг кратера в том месте, где был автобус. Набережная идёт на восток.'
  east = beach_game_room2
  _pl_pos = 3
;

stand_flyer2 : decoration
  location = beach_parking_room2
  desc = 'сломанный/1пм флайер/1м'
  noun = 'флайер/1м' 'мать/1ж'
  adjective = 'искорёженный/1пм' 'сломанный/1пм'
  isHim = true
  ldesc = "За одним из сломанных флаеров прячется мать ребенка, от страха она не может выбежать, а только кричит."
;


simple_mon_hunt_boy1 : SimpleShooter
   desc = 'торопливый/1пмо стрелок/1мо'
   location = beach_parking_room2
   isHim = true
   _pos = 5
;

simple_mon_hunt_boy2 : SimpleShooter
   desc = 'хихикающий/1пмо стрелок/1мо'
   location = beach_parking_room2
   isHim = true
   _pos = 4
;


simple_mon_hunt_boy3 : SimpleShooter
   desc = 'седой/1пмо стрелок/1мо'
   location = beach_parking_room2
   isHim = true
   _pos = 3
;

/////////

beach_rock_room2 : room
  sdesc="Скала на берегу"
  lit_desc = 'Небольшая горка с кустарником. Дуга песчаного пляжа продолжается на запад, вернуться к мощеной набережной можно на юг.'
  south = beach_start_room2
  west = beach_main_room2
;

kust_at_rock2 : decoration
  location = beach_rock_room2
  desc = 'одинокий/1пм кустарник/1м'
  noun = 'кустарник/1м' 'куст/1м' 'гора/1ж' 'горка/1ж'
  adjective = 'одинокий/1пм' 'низенький/1пм'
  isHim = true
  ldesc = "Низенький куст, крона очень широкая и практически параллельная земле. "
;

water_at_rock2 : decoration
  location = beach_rock_room2
  desc = 'плескающаяся/1пм вода/1ж'
  noun = 'вода/1ж' 'море/1'
  adjective = 'плескающаяся/1пм'
  isHer = true
  ldesc = "Светло-зелёная вода, на которой образуются белые гребешки и тут же исчезают. Удивительно, как смогли люди сделать искуственное море?"
;

sander_at_rock2 : decoration
  location = beach_rock_room2
  desc = 'песчаный/1пм пляж/1м'
  noun = 'пляж/1м' 'дуга/1ж' 'песок/1м'
  adjective = 'песчаный/1пм'
  isHim = true
  ldesc = "Кристалльно чистый белый песок, наверное с Мальдив."
;


trap_r22 : decoration
  location = beach_rock_room2
  desc = 'мощеная/1пж дорожка/1ж'
  noun = 'дорожка/1ж' 'плитка/1ж'
  adjective = 'мощеная/1пж'
  isHer = true
  ldesc = "Плитки из прозрачного бетона."
;

/////////

beach_main_room2 : room
  sdesc="Песчаный пляж"
  lit_desc = 'Основная часть местного курорта. Поваленные лежаки и сломанные зонтики. На западе причал, к востоку скала на побережье.'
  east = beach_rock_room2
  west = beach_pirs_room2
;

beach_items2 : decoration
  location = beach_main_room2
  desc = 'лежак/1м'
  noun = 'лежак/1м' 'зонтик/1м'
  isHim = true
  ldesc = "Лежаки и зонтики поломаны и валяются где попало."
;

massage2 : DestructItem
   location = beach_main_room2
   desc = 'сломанный/1пмо массажист/1мо'
   noun = 'массажист/1мо' 'робот/1м' 'робот-массажист/1м'
   isHim = true
   adjective = 'сломанный/1пмо' 'массажный/1пм' 'бюджетный/1пм'
   ldesc = "Сломанный массажный робот, кажется обрёл долгожданный покой..."
;

/////////

beach_pirs_room2 : room
  sdesc="Причал"
  lit_desc = 'Уходящая в воду дорожка вся передёргивается от попавших в неё выстрелов. К причалу привязан флайборд. Основной пляж на востоке.'
  east = beach_main_room2
;

way_aerogel2 : decoration
  location = beach_pirs_room2
  desc = 'дорожка/1ж'
  noun = 'дорожка/1ж' 'аэрогель/1м' 'причал/1м'
  adjective = 'светящаяся/1пж' 'дергающаяся/1пж'
  isHer = true
  ldesc = "Алгоритм работы сломался после нескольких попаданий, теперь дорожка мерцает случайным образом."
;

flyboard2 : fixeditem
   location = beach_pirs_room2
   desc = 'флайборд/1м'
   noun = 'флайборд/1м' 'гидроцикл/1м' 'доска/1ж'
   ldesc = "Глянцевая серебристая доска, метра три в длину, за фазой разгона над волнами следует фаза плавного спуска на воду и петляние по волнам."
   verDoBoard(actor) = {}
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
   verDoStandon(actor) = { self.verDoBoard(actor); }
   doBoard(actor) = {
      global.stop_auto_music = true;
      stop_music_back();
      play_music_loop('Julius_Nox_-_Giulio_s_Page_-_Tortoise.ogg');
      scen_lvl4_meet_fish();
      show_image('fish.jpg');
      Me.travelTo(beach_run_room);
   }
   doEnter(actor) = { self.doBoard(actor); }
   doEnterOn(actor) = { self.doBoard(actor); }
   doEnterIn(actor) = { self.doBoard(actor); }
   doStandon(actor) = { self.doBoard(actor); }
;

/////////

//Разновидности команд от Аресы
#define CMD_MOVE_STAY  0
#define CMD_MOVE_UP    1
#define CMD_MOVE_DOWN  2
#define CMD_MOVE_NORTH 3
#define CMD_MOVE_SOUTH 4
#define CMD_MOVE_WEST  5
#define CMD_MOVE_EAST  6
#define TEXT_OK_MOVE  'Вы увернулись от волны.<br>'
#define TEXT_BAD_MOVE 'Вы врезались в волну, а когда вы упали в воду, вас уже поджидали...'

beach_run_room : room
  sdesc="Погоня на флайборде"
  lit_desc = 'Вы летите на большой скорости, стена из брызг почти полностью закрывает обзор.'
  ok_last_move = true
  processNextMove = {
     local currRow = self.move_list[self.curr_move_id];
     local currMv = currRow[1];
     //Всё хорошо, идём дальше
     if ( (self.ok_last_move == true) || (currMv==CMD_MOVE_STAY) )
     {
        self.curr_move_id += 1;
        if (self.curr_move_id > length(self.move_list))
        {
           Statist.Show(4);
           "<i>(Для продолжения нажмите ВВОД</i>)<br>";
           input();
           //Финальная сценка только для нормального уровня сложности
           if (global.is_easy==nil) {
               show_image('final.jpg');
               stop_music_back();
               play_music_loop('pornophonique_-_rock_n_roll_hall_of_fame.ogg');
               scen_lvl4_final();
           }
           else
           {
              "<br>К сожалению, на лёгком уровне недоступна финальная сценка, попробуйте пройти игру на нормальной сложности! :) <br>";
           }
           win();
        }
        else
        {
           local nextRow = self.move_list[self.curr_move_id];
           local nextMv = nextRow[1];
     
           if (nextMv==CMD_MOVE_STAY) aresa_say('Никуда не двигай борд.');
           else if (nextMv==CMD_MOVE_UP) aresa_say('Двигай борд наверх!');
           else if (nextMv==CMD_MOVE_DOWN) aresa_say('Ниже бери!');
           else if (nextMv==CMD_MOVE_WEST) aresa_say('Немного западнее!');
           else if (nextMv==CMD_MOVE_EAST) aresa_say('Направь восточнее!');
           else if (nextMv==CMD_MOVE_NORTH) aresa_say('Возьми севернее!');
           else if (nextMv==CMD_MOVE_SOUTH) aresa_say('Давай южнее!');
        }
        self.ok_last_move = nil;
     }
     else
     {
       say(TEXT_BAD_MOVE);
       die();
     }
  }
  haveUdilshik = {
     local currRow = self.move_list[self.curr_move_id];
     return currRow[2];
  }
  haveShark = {
     local currRow = self.move_list[self.curr_move_id];
     return currRow[3];
  }
  curr_move_id = 1
  //список движаний и появлений врагов
  move_list = [
     //движение       удильщик  акула
     [CMD_MOVE_STAY     nil     nil  ]
     [CMD_MOVE_STAY     true    nil  ]
     [CMD_MOVE_STAY     true    nil  ]
     [CMD_MOVE_STAY     nil     true ]
     [CMD_MOVE_UP       nil     true ]
     [CMD_MOVE_NORTH    nil     nil  ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     nil     true ]
     [CMD_MOVE_STAY     nil     nil  ]
     [CMD_MOVE_DOWN     true    nil  ]
     [CMD_MOVE_DOWN     true    nil  ]
     [CMD_MOVE_WEST     nil     true ]
     [CMD_MOVE_EAST     true    true ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     true    nil  ]
     [CMD_MOVE_STAY     nil     nil  ]
     [CMD_MOVE_UP       nil     nil  ]
     [CMD_MOVE_UP       nil     nil  ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_WEST     true    true ]
     [CMD_MOVE_SOUTH    true    true ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     true    true ]
     [CMD_MOVE_STAY     true    true ]
  ]
  
  checkMoveDir(way) = {
    local currRow = self.move_list[self.curr_move_id];
    local currMv = currRow[1];
    //проверка правильного направления
    if (currMv==way) {
       say(TEXT_OK_MOVE);
       self.ok_last_move = true;
    }
    else
    {
       say(TEXT_BAD_MOVE);
       die();
    }
    return nil;
  }
  north = {return self.checkMoveDir(CMD_MOVE_NORTH);}
  south = {return self.checkMoveDir(CMD_MOVE_SOUTH);}
  west = {return self.checkMoveDir(CMD_MOVE_WEST);}
  east = {return self.checkMoveDir(CMD_MOVE_EAST);}
  up = {return self.checkMoveDir(CMD_MOVE_UP);}
  down = {return self.checkMoveDir(CMD_MOVE_DOWN);}
;

////////////////////////////////////
// Машина состояний для карты аквазона
aquaMachine : StateMachine
   st = 0
   num_steps_guys = 0
   is_lead_guys = nil
   have_protect_boy = nil
   boy_start_turn = 0
   boy_walk_with_isk = nil

   nextTurn={
     local i;
     if (self.st== 0)
     {
       The21Game.prepareGame;
       Me.isOnBeach = true;
       self.st = 1;
     }
     else if (self.st == 1 && (Me.location==beach_pirs_room))
     {
       scen_lvl4_meet_kach();
       self.st = 4;
     }
     
     //Автомат перемещения качков по пляжу
     if ( self.st == 4 )
     {
         if ( Me.location == beach_pirs_room )
         {
            self.is_lead_guys=true;
            self.num_steps_guys = 0;
         }
         else if (self.num_steps_guys >= 8) //время слежения за героем
         {
            if (shwartz.location != beach_pirs_room) {
                "Качкам надоело следить за вами и они вернулись к причалу.";
                shwartz.moveInto(beach_pirs_room);
                stallone.moveInto(beach_pirs_room);
            }
            self.is_lead_guys=nil;
            self.num_steps_guys = 0;
         }
         
         if (self.is_lead_guys)
         {
            if (shwartz.location != Me.location) {
                shwartz.travelTo(Me.location);
                stallone.travelTo(Me.location);
            }
            self.num_steps_guys += 1;
         }
     }
     else if (self.st == 5 && self.have_protect_boy)
     {
        //Перемещаем мальчика в парковочную зону
        loneBoy.travelTo(beach_parking_room2);
        self.st = 6;
        self.boy_start_turn = self.currTurn;
     }
     else if (self.st==6)
     {
        //мальчик убегает через 3 хода в игровую зону
        if (self.currTurn-self.boy_start_turn>=3){
           self.st = 7;
           self.boy_start_turn = self.currTurn;
           loneBoy.travelTo(beach_game_room2);
           aresa_say('Мальчик убежал, давай за ним!');
        }
     }
     else if (self.st==7)
     {
        //мальчик убегает через 3 хода к кустам
        if (self.currTurn-self.boy_start_turn>=3){
           self.st = 8;
           loneBoy.travelTo(beach_rock_room2);
        }
     }
     else if (self.st==8 && Me.location==beach_rock_room2)
     {
        //мы нашли мальчика
        self.st = 9;
        self.boy_walk_with_isk = true;
        aresa_say('Кажется, он понял, что нам можно доверять. Теперь надо его вернуть мамочке.');
     }
     else if (self.st==9 && Me.location==beach_parking_room2)
     {
        //привели к маме
        scen_lvl4_save_child();
        self.st = 10;
        self.boy_walk_with_isk = nil;
        self.have_protect_boy = nil;
        loneBoy.moveInto(nil);
     }
     
     if (self.boy_walk_with_isk) {
        if (Me.location != loneBoy.location) loneBoy.travelTo(Me.location);
     }
     
     if (self.have_protect_boy && loneBoy._hp<=0)
     {
        "Вы не смогли защитить мальчика.<br>";
        die();
     }
     
     if ( Me.location == beach_run_room )
     {
        if (self.have_protect_boy) {
           "<br>Всё напрасно, ведь Вы не смогли защитить мальчика.<br>";
           die();
        }
        
        beach_run_room.processNextMove;
        //выпрыгивание рыб на ГГ
        if (fishUdilshik._hp > 0 && beach_run_room.haveUdilshik && fishUdilshik.location != beach_run_room)
        {
           fishUdilshik.travelTo(beach_run_room);
        }
        else if (fishUdilshik._hp > 0 && !beach_run_room.haveUdilshik && fishUdilshik.location == beach_run_room)
        {
           fishUdilshik.travelTo(beach_parking_room2);
        }
        
        if (plashShark._hp > 0 && beach_run_room.haveShark && plashShark.location != beach_run_room)
        {
           plashShark.travelTo(beach_run_room);
        }
        else if (plashShark._hp > 0 && !beach_run_room.haveShark && plashShark.location == beach_run_room)
        {
           plashShark.travelTo(beach_parking_room2);
        }
     }
     
     self.currTurn = self.currTurn+1;
   }
;