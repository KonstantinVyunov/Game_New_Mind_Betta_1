// ARECA.T
// Автомат сюжетной линии и общения с Аресой
#pragma C++

//Ареса
Areca : fixeditem
  desc = 'Ареса/1жо'
  noun = 'Ареса/1жо' 'браслет/1м'
  isHer=true
  location = Me
  ldesc = "Элегантный браслет из композитных материалов, с гравировкой в виде изящной жещины. Кажется, она иногда мне подмигивает небольшим светодиодом."
  isListed = true
  talkdesc = aresa_say('Поговорить? Это я с радостью! Только вот я сама придумаю тему для беседы.')
  actorAction(v, d, p, i) = { aresa_say('Тоже мне, командир нашелся! Все вы мужики такие. Дашь слабинку, а они поматросят и бросят!'); exit;}
  //Стандартные реакции
  verDoPush(actor) = aresa_say('Как тебе не стыдно толкать бедную женщину!')
  verDoAttachTo(actor, iobj) = aresa_say('Я бы не хотела, чтобы меня куда-то крепили. Разве что к другому симпатичному браслету.')
  verIoAttachTo(actor) = aresa_say('Я бы не хотела, чтобы меня куда-то крепили. Разве что к другому симпатичному браслету.')
  verDoDetach(actor) = aresa_say('Давай лучше тебе что-нибудь открепим?')
  verDoDetachFrom(actor, iobj) = aresa_say('Давай лучше тебе что-нибудь открепим?')
  verIoDetachFrom(actor) = aresa_say('Давай лучше тебе что-нибудь открепим?')
  verDoWear(actor) = aresa_say('Ты же меня уже надел! Вернее, я сама. Ну ты понял.')
  verDoTake(actor) = aresa_say('Меня брать можно только в жёны. Ты меня уже с собой таскаешь. ')
  verDoDrop(actor) = aresa_say('Я тебе выброшу! Я тебя сама сейчас выброшу!')
  verDoUnwear(actor) = aresa_say('Я так просто не дамся! Нечего меня снимать.')
  verIoPutIn(actor) = aresa_say('В меня уже ничего не влезет. Если только капелька винца. ')
  verDoPutIn(actor, io) = aresa_say('Я тебе не безделушка, чтобы меня можно было просто положить в <<self.itselfdesc>>!')
  verIoPutOn(actor) = aresa_say('Ты что сдурел? На меня такое класть нельзя!')
  verDoPutOn(actor, io) = aresa_say('Я не буду туда ложиться!')
  verIoTakeOff(actor) = self.verDoUnwear(actor)
  verDoTakeOff(actor, io) = self.verDoUnwear(actor)
  verIoPlugIn(actor) = aresa_say('Давай, подключай меня изверг. Что же еще тебе делать с бедным браслетиком. ')
  verDoPlugIn(actor, io) = aresa_say('Давай, подключай меня изверг. Что же еще тебе делать с бедным браслетиком. ')
  verIoUnplugFrom(actor) = aresa_say('Это что-то новенькое. Как это ты меня будешь отключать от того, к чему я не подключена?')
  verDoUnplugFrom(actor, io) =aresa_say('Это что-то новенькое. Как это ты меня будешь отключать от того, к чему я не подключена?')
  verDoLookunder(actor) = aresa_say('Ты мне хочешь залезть под платье?! Бесстыдник!')
  verDoInspect(actor) = aresa_say('Изучать меня вздумал? Я не такая простая, как кажется.')
  verDoRead(actor) = aresa_say('Читай меня как книгу, ну читай! Ой, увлеклась, извините!')
  verDoLookbehind(actor) = aresa_say('А за мною тишина, полость, полная огня...')
  verDoTurn(actor) = aresa_say('Не нарывайся! А то я сейчас тебя буду поворачивать.')
  verDoTurnWith(actor, io) = aresa_say('Я же не бездушная совсем! Меня нельзя повернуть этим!')
  verDoTurnOn(actor, io) = aresa_say('Включить меня можно только умными разговорами на вечные женские темы.')
  verIoTurnOn(actor) = aresa_say('Биб-бип. Шутка! Я уже включена и не могу остановиться!')
  verDoTurnon(actor) = aresa_say('Биб-бип. Шутка! Я уже включена и не могу остановиться!')
  verDoTurnoff(actor) = aresa_say('Меня так легко найти, но трудно потерять. А выключить вообще невозможно!')
  verDoScrew(actor) = aresa_say('От винта!')
  verDoScrewWith(actor, iobj) = aresa_say('Не можешь привинтить? Может помочь? ')
  verIoScrewWith(actor)=aresa_say('Не можешь привинтить? Может помочь? ')
  verDoUnscrew(actor) = aresa_say('Слушай, может у тебя голова отвинчивается, проверим?')
  verDoUnscrewWith(actor, iobj) = aresa_say('Слушай, может у тебя голова отвинчивается, проверим?')
  verIoUnscrewWith(actor) = aresa_say('Слушай, может у тебя голова отвинчивается, проверим?')
  verIoAskAbout(actor) = {}
  ioAskAbout(actor, dobj) ={	dobj.doAskAbout(actor, self);	}
  verDoAskAbout(actor, io) =	aresa_say('Я не могу отвечать на такой вопрос. Тем более в таком состоянии. ')
  verIoTellAbout(actor) = {}
  ioTellAbout(actor, dobj) ={	dobj.doTellAbout(actor, self);}
  verDoTellAbout(actor, io) = aresa_say('Не надо мне такого рассказывать! Я знаю вещи и похлеще. ')
  verDoTalk(actor)={}
  verDoUnboard(actor) = aresa_say('Мне даже сложно представить как с меня будешь слезать... Больное воображение, наверное.')
  verDoAttackWith(actor, io) = aresa_say('Нападать на меня вздумал? Ну я тебе устрою! Потом. Как-нибудь. Лет через двадцать. ')
  verIoAttackWith(actor) = aresa_say('Жалко нельзя никого сразить моеми едкими шуточками!')
  verDoEat(actor) = aresa_say('Фу! Я не вкусная. Нечего на меня смотреть голодными глазами! ')
  verDoDrink(actor) = aresa_say('Ну это ты придумал здорово! А ничего что я еще не расстаяла от твоих ухаживаний?')
  verDoGiveTo(actor, io) = aresa_say('Меня нельзя передаривать! Ты так со всеми подругами обращаешься?')
  verDoPull(actor) = aresa_say('Что вы у меня хотели оттянуть? Мой наряд, между прочим, искусно вырезан из метеорита! ')
  verDoThrowAt(actor, io) = aresa_say('Целься! Кстати, забыла предупредить, улечу я вместе со всей рукой...')
  verIoThrowAt(actor) = aresa_say('Целься! Кстати, забыла предупредить, улечу я вместе со всей рукой...')
  verIoThrowTo(actor) = aresa_say('Целься! Кстати, забыла предупредить, улечу я вместе со всей рукой...')
  verDoThrowTo(actor, io) = aresa_say('Целься! Кстати, забыла предупредить, улечу я вместе со всей рукой...')
  verDoThrow(actor) = aresa_say('Я тебе выброшу! Совсем недавно познакомились, а уже меня бросает! Хам.')
  verDoShowTo(actor, io) = aresa_say('Ну что, я классная?')
  verIoShowTo(actor) = aresa_say('Ну что, я классная?')
  verDoClean(actor) = aresa_say('Ого! Прогресс видимо дошёл и до твоего села! Можно я запишусь на следущий приём?')
  verDoCleanWith(actor, io) = aresa_say('Ну не знаю, не очень бы хотелось, чтобы ты меня чистил этим.')
  verDoMove(actor) = aresa_say('Я никуда не слезу.')
  verDoMoveTo(actor, io) = aresa_say('Меня ты не сдвинешь. Так-то.')
  verIoMoveTo(actor) = aresa_say('Меня ты не сдвинешь. Так-то.')
  verDoMoveWith(actor, io) = aresa_say('Меня ты не сдвинешь. Так-то.')
  verIoMoveWith(actor) = aresa_say('Меня ты не сдвинешь. Так-то.')
  verIoSearchIn( actor ) = aresa_say('Тебя наверное  интересует тот жаркий огонь, что пылает в моей груди? Не дождешься!')
  verDoSearchIn( actor, iobj ) = aresa_say('Тебя наверное  интересует тот жаркий огонь, что пылает в моей груди? Не дождешься!')
  verDoTypeOn(actor, io) = aresa_say('Набери мою маму, скажи чтобы за мной не приезжала.')
  verDoShoot(actor) = aresa_say('Я уже сломана. От переизбытка чувств.')
  verDoAskFor(actor,io)=aresa_say('Меня нельзя ни о чем просить! Я же обычная девочка!')
  verIoAskFor(actor)=aresa_say('Меня нельзя ни о чем просить! Я же обычная девочка!')
  verDoAskOneFor(actor, iobj)=aresa_say('Меня нельзя ни о чем просить! Я же обычная девочка!')
  verIoAskOneFor(actor)=aresa_say('Меня нельзя ни о чем просить! Я же обычная девочка!')
  genMoveDir = aresa_say('Я только с пьяну смогу разобрать, куда ты меня тащишь!')
  verDoSearch(actor) = aresa_say('Обыскать меня собрался! Беззащитную девушку! Бесстыжий!')
  verDoListenTo(actor)=aresa_say('Правильно, ко мне надо прислушиваться. И почаще. ')
  verDoSmell(actor)=aresa_say('К сожалению, парфюм у меня прошлого сезона. Стоп, позапрошлого. ')
  verDoTouch(actor)=aresa_say('Ой, щекотно! Не надо так быстро. Мы же не столько лет знакомы! ')
  verDoBoard(actor) = aresa_say('На мне ты далеко не уедешь. Это я тебе гарантирую.')
  verDoChmok(actor) = aresa_say('Ого, как приятно что вы меня цените! Почаще пожалуйста, а то так я совсем запылюсь...')
;

#pragma C-