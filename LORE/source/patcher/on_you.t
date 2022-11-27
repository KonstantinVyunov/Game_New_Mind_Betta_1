/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// Проверено на TADS 2.5.11 русский релиз 27
// Дата последнего изменения 2017.09.05

// Патчим advr.t

// Реализуем необходимые добавления для именования игрока "на вы"
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
;
