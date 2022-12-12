/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// ѕроверено на TADS 2.5.11 русский релиз 27
// ƒата последнего изменени€ 2017.09.04

// ѕатчим advr.t

// ¬ функции sayPrefixCount() разрешаем переменное количество аргументов
replace sayPrefixCount: function(cnt, ...)
{
 	local obj;
 	
 	if (argcount = 2) 
 	{
 		obj := getarg(2);
 	
 		if (cnt = 1)
 		{
 			"од<<ok(obj, 'ни', 'ин', 'но' ,'на')>>";
 			return;
 		}
 		else if (cnt = 2)
 		{
 			"дв<<ok(obj, 'а', 'а', 'а' ,'е')>>";
 			return;
 		}
 	}
	
	if (cnt <= 20)
		say(['один' 'два' 'три' 'четыре' 'п€ть'
			'шесть' 'семь' 'восемь' 'дев€ть' 'дес€ть'
			'одиннадцать' 'двенадцать' 'тринадцать' 'четырнадцать' 'п€тнадцать'
			'шестнадцать' 'семнадцать' 'восемнадцать' 'дев€тнадцать' 'двадцать'][cnt]);
	else
		say(cnt);
}