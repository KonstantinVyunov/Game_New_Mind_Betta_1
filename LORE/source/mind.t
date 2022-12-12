#define USE_HTML_STATUS
#define USE_HTML_PROMPT

#define IDS_VERSION_NUM '1.5'

//билиотеки стандартные
#define GENERATOR_INCLUDED
#include <advr.t>
#include <stdr.t>
#include <errorru.t>
#include <extendr.t>
#include <generator.t>
#include <math.t>
#include "patcher/index.t"

#include <statemachine.t>
#include <tmorph.t>

#include <statist.t>
#include <api.t>
#include <monster_classes.t>
#include <weapon_classes.t>
#include <combo_classes.t>
#include <areca.t>
#include <craft_obj_classes.t>
#include <craftsystem_menu.t>
#include <verbs.t>

#include <scenario.t>
#include <main_menu.t>
#include <run_auto_verb.t>

#pragma C++



replace sleepDaemon: function(parm)
{
}

replace eatDaemon: function(parm)
{
}

replace version: object
    sdesc = {
        "\b\t<font size='+3' color='blue'><b>Новый разум. Эпизод 1.</b></font><br>";
        "<b><font size='-1' color='#7F2AFF'>Версия " ;say (IDS_VERSION_NUM);"</font></b>\b\b";
        "\b<br>";
        show_image('cover.jpg');
    } 
;

replace scoreRank: function
{
    " В сумме за "; say(global.turnsofar);
    " ход<<numok(global.turnsofar, '','а','ов')>>, вы достигли счета в ";
    say(global.score); " единиц<<numok(global.score, 'у','ы','')>>.";
}

replace introduction: function
{
}


replace init: function
{
#ifdef USE_HTML_STATUS
    /* 
     *   Мы используем HTML-стиль статусной строки -- будем уверены,
     *   что используется интерпретатор достаточно новой версии, чтобы
     *   поддерживать этот код. (Код статусной строки использует
     *   systemInfo, чтобы обнаружить, поддерживает ли интерпретатор
     *   HTML или нет -- HTML не работает правильно на версиях
     *   предшествующих 2.2.4.)
     *   
     *   We're using the adv.t HTML-style status line - make sure the
     *   run-time version is recent enough to support this code.  (The
     *   status line code uses systemInfo to detect whether the run-time
     *   is HTML-enabled or not, which doesn't work properly before
     *   version 2.2.4.)  
     */
    if (systemInfo(__SYSINFO_SYSINFO) != true
        || systemInfo(__SYSINFO_VERSION) < '2.2.4')
    {
        "\b\b\(ВНИМАНИЕ! Эта игра требует интерпретатор TADS версии
        2.2.4 или выше. Похоже, что вы используете более старую версию
        интерпретатора. Вы можете попробовать запустить эту игру, однако,
        отображение игрового экрана может не работать правильно. Если
        вы испытываете какие либо трудности, вы можете попробовать
        перейти на более новую версию интерпретатора TADS.\)\b\b";
    }
#endif

    /* выполнение общей инициализации */
    /* perform common initializations */
    commonInit();
    
    introduction();

    version.sdesc;                // показ названия и версии игры

    setdaemon(turncount, nil);         // запуск демона (deamon) счетчика ходов
    
    parserGetMe().location = startroom;     //  переместить игрока в начальную
    //Обработка здесь иначе не удаётся перенести игрока сразу в нужную ситуацию
    if (global.curr_level==1) prepareLevel1();
	else if (global.curr_level==2) prepareLevel2();
    else if (global.curr_level==3) prepareLevel3();
    else if (global.curr_level==4) prepareLevel4(); 
    
    if (parserGetMe().location==startroom) {
      parserGetMe().location.lookAround(true);  // показать игроку, где он находится
      parserGetMe().location.isseen = true;     // отметить, что локация была увидена
      scoreStatus(0, 0);                        // инициализировать отображение очков
    }
    randomize();			  // это, если нужны случайности в игре
}


replace commonInit: function
{
	"\H+"; 
    setOutputFilter(morphFilter);	
    //debugTrace(1,true);
}

replace die: function
{
    "\b*** ЭТО КОНЕЦ! Попытайтесь еще раз. ***\b";
    //scoreRank();
    "\bВыберите: ВОССТАНОВИТЬ сохраненную игру, начать уровень ЗАНОВО или ВЫХОД.\n";
    while (true)
    {
        local resp;

        "\nПожалуйста, введите ВОССТАНОВИТЬ, ЗАНОВО или ВЫХОД: >";
        resp = upper(input());
        resp = loweru(resp);
        if ((resp=='restore') || (resp=='восстановить') || (resp=='загрузить') )
        {
            resp = askfile('Файл для восстановления:',
                            ASKFILE_PROMPT_OPEN, FILE_TYPE_SAVE);
            if (resp == nil)
                "Загрузка не удалась. ";
            else if (restore(resp))
                "Загрузка не удалась. ";
            else
            {
                parserGetMe().location.lookAround(true);
                scoreStatus(global.score, global.turnsofar);
                abort;
            }
        }
        else if ((resp == 'restart') or (resp=='заново'))
        {
		    createRestartParam();
            scoreStatus(0, 0);
            restart(initRestartStartLevel,global.restartParam);
        }
        else if ((resp == 'exit') || (resp=='выход'))
        {
            terminate();
            quit();
            abort;
        }
    }
}

win: function
{
    "\b*** ВЫ ВЫИГРАЛИ! ***\b";
    
    "Для просмотра секретных локаций, введите код \"полигонмонстров\" в начале первого уровня. Попробуйте одолеть противников с большим количеством ресурсов и всеми синтезируемыми элементами! \b";
    
    //scoreRank();
    "\bВыберите: ВОССТАНОВИТЬ сохраненную игру, начать ЗАНОВО, ВЫХОД.\n";
    while (true)
    {
        local resp;

        "\nПожалуйста, введите ВОССТАНОВИТЬ, ЗАНОВО или ВЫХОД: >";
        resp = upper(input());
        resp = loweru(resp);
        if ((resp=='restore') || (resp=='восстановить') || (resp=='загрузить') )
        {
            resp = askfile('Файл для восстановления:',
                            ASKFILE_PROMPT_OPEN, FILE_TYPE_SAVE);
            if (resp == nil)
                "Загрузка не удалась. ";
            else if (restore(resp))
                "Загрузка не удалась. ";
            else
            {
                parserGetMe().location.lookAround(true);
                scoreStatus(global.score, global.turnsofar);
                abort;
            }
        }
        else if ((resp == 'restart') or (resp=='заново'))
        {
            scoreStatus(0, 0);
            restart();
        }
        else if ((resp == 'exit') || (resp=='выход'))
        {
            terminate();
            quit();
            abort;
        }

    }
}


modify global
   curr_level = 0
   need_move = nil
   input_mode = INPUT_MODE_FULL
   enemy_mode = ENEMY_MODE_FULL
   music_volume = 30
   sound_volume = 70
   play_battle_music = nil
   level_play_music = nil
   stop_auto_music = nil //останов боевой музыки
   restartParam = []
   is_easy = nil //(true) - лёгкий уровень сложности, nil - нормальный
;


replace turncount: function(parm)
{
   //Ничего не делаем в первой комнате
   if (Me.location==startroom) return;
   //из оригинального turncount
   incturn();
   global.turnsofar = global.turnsofar + 1;
   scoreStatus(global.score, global.turnsofar);
   if (global.need_move)
   {
      //включам флаг что игрок увидел монстров на локации
      if (Me.location.see_mon==nil) Me.location.see_mon = true;
      //нужен следующий ход (определяется действиями игрока)
      monsterTurn(Me);
   }
   
   //машина для управления музыкой
   if (global.stop_auto_music == nil) {
       if (HaveMonsters(Me.location) && (global.play_battle_music==nil))
       {
          local battle_music=['ANtarcticbreeze_-_Fighter__Extreme_Sports_.ogg' 'Plastic3_-_Extreme_Sport_Energy.ogg' 'Soundatelier_-_New_Style__Instrumental_.ogg'];
          global.play_battle_music = true;
          stop_music_back();
          play_music_loop(battle_music[rand(length(battle_music))]);
       }
       else if (!HaveMonsters(Me.location) && (global.play_battle_music==true))
       {
          global.play_battle_music = nil;
          stop_music_back();
          play_music_loop(global.level_play_music);
       }
   }
   
   //Проверка автопрохождения
   if (RunAutoVerb.run_auto == true) {
	  if (global.curr_machine != nil) global.curr_machine.nextTurn;
      RunAutoVerb.processNextCmd;
   }
}


//Проиграть музыку в фоновом канале, с настроенной громкостью музыки
play_music : function(file){
   local sound_str;
   sound_str = '<SOUND SRC="../res/' + file + '" LAYER=BACKGROUND VOLUME=' + cvtstr(global.music_volume) + ' >';
   say(sound_str);
}

play_sound : function(file){
   local sound_str;
   sound_str = '<SOUND SRC="../res/' + file + '" LAYER=FOREGROUND VOLUME=' + cvtstr(global.sound_volume) + ' >';
   say(sound_str);
}

//Проиграть музыку в фоновом канале, с настроенной громкостью музыки, в цикле
play_music_loop : function(file){
   local sound_str;
   sound_str = '<SOUND SRC="../res/' + file + '" LAYER=BACKGROUND VOLUME=' + cvtstr(global.music_volume) + ' REPEAT=LOOP>';
   say(sound_str);
}

//Остановить фоновую музыку
stop_music_back : function(){
   say('<SOUND CANCEL=BACKGROUND>');
}

//Показать изображение
show_image : function(file){
   local sound_str = '<br><IMG SRC="../res/' + file + '"><br>';
   say(sound_str);
}

aresa_say : function(text){
  "<i>—<<text>></i><br>";
}

modify thing
  verDoShoot(actor) = {"Не сработает. Попробуйте по-другому.";}
  verDoShootWith(actor, iobj) = {"Для нападения используйте форму: ударить \<кого\> или стрелять в \<кого\>. Будет использоваться текущее выбранное оружие.";}
  verDoUse(actor) = {"Вы можете использовать только синтезируемые предметы.";}
  verDoChmok(actor) = {aresa_say('Ты куда целоваться лезешь? А ну цыц!');}
  verDoClean(actor) = {aresa_say('Уборку будешь в отпуске изучать, не будем тратить время.');}
;

modify Monster
   verDoShoot(actor) = {
      if (actor.sel_weapon.isCloseCombat)
      {
         if (actor.location._pl_pos!=self._pos){
            "У вас оружие ближнего боя, на таком расстоянии не попасть!";
         }
      }
      else if (actor.sel_weapon._bullets<=0)
      {
         "<br>Недостаточно патронов!<br>";
      }
   }
   doShoot(actor) = {
      if (shootMonster(actor,self) == nil)
      {
         "<br>Нет возможности выстрелить!<br>";
      }
   }
   actorDesc =
   {
        local dist = self._pos - self.location._pl_pos;
        if (self.location.see_mon == true)
        {
            if (HaveMonsters(self.location)) {
                if (dist>0) "На <<dist>> метров впереди Вас <<glok(self,'находишься')>> <<self.sdesc>> ";
                else if (dist<0) "на <<-dist>> метров позади Вас <<glok(self,'находишься')>> <<self.sdesc>> ";
                else "Рядом <<glok(self,'находишься')>> <<self.sdesc>> ";
                " (<<self._hp>>).";
            }
            else
            {
               "Здесь <<glok(self,'находишься')>> <<self.sdesc>>.";
            }
        }
   }
;

printFullPrompt: function()
{
   local sel_prn = Me.sel_weapon.shortdesc;
    
   if (Me.sel_weapon.isCloseCombat==true) "\bЖИЗНЬ: <<Me._hp>>, ОРУЖИЕ: <<sel_prn>>";
   else "\bЖИЗНЬ: <<Me._hp>>, ОРУЖИЕ: <<sel_prn>> (<<Me.sel_weapon._bullets>>)";
}

replace commandPrompt: function(code)
{   
    if (global.input_mode == INPUT_MODE_LITE) {
       "\b&gt;";
    }
    else if (global.input_mode == INPUT_MODE_FULL) {
        printFullPrompt();
        "&gt;";
	}
}

modify Me
  sdesc = "вы"
  rdesc = "вас"
  ddesc = "вам"
  vdesc = "вас"
  tdesc = "вами"
  pdesc = "вас"
  isHim = nil
  isThem = true
  lico = 2
  fmtYou = "вы"
  fmtToYou = 'вам'
  fmtYour = 'вас'
  fmtYours = 'ваши'
  fmtYouve = 'вас'
  fmtWho = 'вы'
  fmtMe = 'себя'
  noun = 'себя' 'вы' 'вас' 'вам' 'вами' 'вам#d' 'вами#t'
  isOnBeach = nil
  ldesc = { 
    if (self.isOnBeach) {
       show_image('tourist.jpg');
       scen_main_hero_beach();
    }
    else{
       show_image('myself.jpg');
       scen_main_hero(); 
    }
  }
  followList = []
  sel_weapon = NoneWeapon
  _hp = 100
  Heal = {
    "Здоровье восстановлено.";
    self._hp = 100;
  }
  verDoTouch(actor) = { aresa_say('Хватит бесстыдничать при мне!'); }
  /*void*/ Hit(who,/*int*/ points) = { //повредить героя на заданное количество очков
      if (points <= 0) {
         if (global.enemy_mode == ENEMY_MODE_FULL && who!=nil) "<<ZAG(who,&sdesc)>> промахнулся по вам.<br>";
         else if (global.enemy_mode == ENEMY_MODE_SHORT && who!=nil) "0.";
         return;
      }
      if (self._hp <= points) {
         self._hp = 0;
         die();
      }
      else
      {
         self._hp -= points;
         if (global.enemy_mode == ENEMY_MODE_FULL && who!=nil) "<font color='maroon'><<ZAG(who,&sdesc)>> <<who.me_attack_desc>> (-<<points>>).</font><br>";
         else if (global.enemy_mode == ENEMY_MODE_SHORT && who!=nil) "<<points>>.";
         
      }
    }
   actorAction(verb, dobj, prep, iobj) = 
   {
        if ( ( verb.issysverb == true) || ( verb.no_mon_turn == true ) ) {
            global.need_move = nil;
        }
        else
        {
           global.need_move = true;
        }
        
        
        //Запрещаем забираться куда-то если враги в комнате
        if ( ( verb == boardVerb) || ( verb == sitVerb ) || ( verb == lieVerb ) || ( verb == standOnVerb ) ) {
            if (HaveMonsters(Me.location))
            {
               "Пока здесь враги, вы не можете этого сделать!";
               exit;
            }
        }
   }
   verDoShoot(actor)={aresa_say('Какие нездоровые у тебя наклонности, буду знать.');}
;

//Если у локации есть собственный пол, то стандартный исчезает в начальную комнату
modify theFloor
   location =
   {
        if (parserGetMe().location == self)
            return self.sitloc;
        else if ( (parserGetMe().location != nil) && (parserGetMe().location.ownFloor == true) )
            return startroom;
        else
            return parserGetMe().location;
   }
   verDoSiton(actor) = {aresa_say('Сейчас не время рассиживаться!');}
   verDoLie(actor) = {aresa_say('Сейчас не время валяться где-попало!');}
;

bodyDecoration : decoration, floatingItem
  location = {return parserGetMe().location; }
  locationOK = true
  isHer = true
  desc = 'часть/1ж вашего тела'
  noun = 'тело/1с' 'глаз/1м' 'глаза/2' 'рот/1м' 'нос/1м' 'уши/2' 'рука/1ж' 'нога/1ж' 'руки/2' 'ноги/2' 'волосы/2' 'одежда/1ж' 'кожа/1ж' 'мышцы/2' 'грудь/1ж' 'таз/1м' 'спина/1ж' 'мембрана/1ж'
;

////////////////////////////////
//класс кнопка-рычаг, переопределять только doPush, verDoPush, остальное от них пляшет
class Button : fixeditem
   verDoPull(actor)={self.verDoPush(actor);}
   verDoMove(actor)={self.verDoPush(actor);}
   verDoTurn(actor)={self.verDoPush(actor);}
   verDoTurnon(actor)={self.verDoPush(actor);}
   verDoTurnoff(actor)={self.verDoPush(actor);}
   verDoSwitch(actor)={self.verDoPush(actor);}
   verDoPutdown(actor)={self.verDoPush(actor);}
   verDoShoot(actor)={aresa_say('Вместо того чтобы использовать по назначению, ты думаешь как бы разнести вещь в дребезги? Смелый ход, жалко только недальновидный...');}
   
   doPull(actor)={self.doPush(actor);}
   doMove(actor)={self.doPush(actor);}
   doTurn(actor)={self.doPush(actor);}
   doTurnon(actor)={self.doPush(actor);}
   doTurnoff(actor)={self.doPush(actor);}
   doSwitch(actor)={self.doPush(actor);}
   doPutdown(actor)={self.doPush(actor);}
;

//класс окна для удобного использования, заполнить только thrudesc для того, чтобы посмотреть что за окном
class Window : fixeditem, seethruItem
   doLookin(actor)={self.thrudesc;}
;

//класс для удобного открытия, взятия, полезного действия, переопределяем verDoTake и doTake, выполняется однократно
class EasyTake : fixeditem
   verDoOpen(actor)={self.verDoTake(actor);}
   verDoPull(actor)={self.verDoTake(actor);}
   verDoMove(actor)={self.verDoTake(actor);}
   verDoTurn(actor)={self.verDoTake(actor);}
   verDoPush(actor)={self.verDoTake(actor);}
   verDoDetach(actor)={self.verDoTake(actor);}
   verDoUnscrew(actor) = {self.verDoTake(actor);}
   
   doOpen(actor)={self.doTake(actor);}
   doPull(actor)={self.doTake(actor);}
   doMove(actor)={self.doTake(actor);}
   doTurn(actor)={self.doTake(actor);}
   doPush(actor)={self.doTake(actor);}
   doDetach(actor) = {self.doTake(actor);}
   doUnscrew(actor) = {self.doTake(actor);}
;

//Простой люк, который всегда в открытом состоянии, и через который надо проходить по направлениям
class LukSimple : fixeditem
   verDoOpen(actor) = {"<<ZAG(self,&sdesc)>> уже открыт.";}
   verDoClose(actor) = {"<<ZAG(self,&sdesc)>> нельзя закрыть.";}
   verDoBoard(actor) = {"Просто введите направление, куда ведет <<dToS(self,&sdesc)>>.";}
   verDoEnter(actor) = { self.verDoBoard(actor); }
   verDoEnterOn(actor) = { self.verDoBoard(actor); }
   verDoEnterIn(actor) = { self.verDoBoard(actor); }
;

//Простая кровать, которая не даёт полежать или посидеть
class BedSimple : EasyTake
    verDoBoard(actor) = { self.verDoSiton(actor); }
	verDoStandon(actor) = { self.verDoSiton(actor); }
	verDoSiton(actor) = {aresa_say('Эй, здоровяк, сейчас не время отдыхать, насидеться успеешь.');}
	verDoLieon(actor) = {aresa_say('Ну давай, плюхнись! Тебе еще и сказку рассказать? Размечтался!');}
    verDoTake(actor) = {aresa_say('Ты не хочешь заняться более полезными вещами, чем тягать всякий хлам?');}
;

//Забавный фиксированный предмет с колкими замечаниями по разным манипуляциям
class FunnyFixedItem : fixeditem
    verDoTalk(actor)={aresa_say('Ты обалдел? Разговаривать непойми с чем, когда рядом есть прекрасный собеседник.');}
    verDoMove(actor) = {aresa_say('Ну-ну, перестановщик. Давай может и грузчиком станешь?');}
	verDoPull(actor) = {self.verDoMove(actor);}
	verDoDetach(actor) = {self.verDoMove(actor);}
	verDoPush(actor) = {self.verDoMove(actor);}
	verDoTake(actor) = {aresa_say('Собрался брать? А куда потащишь? Лучше не трогай.');}
	verDoDrop(actor) = {aresa_say('Некрасиво разбрасываться вещами!');}
	verDoThrow(actor) = {self.verDoDrop(actor);}
    verDoStandon(actor) = {aresa_say('Знаешь, ты мне напомнил одного безбашенного гусара, который пытался всё куда-то залезть и учудить. Но мы же с тобой серьёзные ребята, правда?');}
    verDoSiton(actor) = {self.verDoStandon(actor);}
	doThrow(actor) = { self.doDrop(actor); }
;

//Забавный декор на который могут пытаться залезть
class FunnyClibDecor : decoration
    verDoClimb(actor) = { aresa_say('Дорогой Кинг-Конг. В нашем мире давно придумали лифты и лестницы.'); }
    verDoBoard(actor) = { self.verDoClimb(actor); }
	verDoStandon(actor) = { self.verDoClimb(actor); }
;

//Декорация с сообщением о непрямом управлении
class decorationNotDirect: fixeditem
	ldesc = {ZAG(self,&sdesc);" не используется напрямую. ";} //ет
	dobjGen(a, v, i, p) =
	{
		if (v <> inspectVerb && v<>osmVerb)
		{
			"<<ZAG(self, &sdesc)>> не используется напрямую. ";
			exit;
		}
	}
	iobjGen(a, v, d, p) =
	{
		{"<<ZAG(self,&sdesc)>> не используется напрямую. ";}
		exit;
	}
;

////////////////////////////////
#include <level1.t>
#include <level2.t>
#include <level3.t>
#include <level4.t>

#include <level_tech.t>