/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// Проверено на TADS 2.5.11 русский релиз 27
// Дата последнего изменения 2017.09.04

// Патчим advr.t

// Реализуем необходимые добавления для именования игрока "на ты"
modify Me
	sdesc = "ты"
	rdesc = "тебя"
	ddesc = "тебе"
	vdesc = "тебя"
	tdesc = "тобой"
	pdesc = "тебе"
	isHim = true
	lico = 2
	fmtYou = "ты"
	fmtToYou = 'тебе'
	fmtYour = 'тебя'
	fmtYours = 'твои'
	fmtYouve = 'тебя'
	fmtWho = 'ты'
	fmtMe = 'тебя'
	noun = 'себя' 'ты' 'тебя' 'тебе' 'тобою' 'тебе#d' 'тобою#t' 'тобой' 'тобой#t'
;