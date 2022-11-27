/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// Проверено на TADS 2.5.11 русский релиз 27
// Дата последнего изменения 2017.10.08

// Патчим advr.t

// Добавляем обработку конструкций "идти во" и "идти на", плюс несколько синонимов ля повелительного наклонения
modify inVerb
	verb = 'войти' 'идти внутрь' 'внутрь' 'иди внутрь' 'войди' 'зайти' 'зайти внутрь' 'зайди внутрь'
		'войти в' 'войти во' 'войти на' 'зайти в' 'зайти во' 'зайти на' 'взойти' 'взойти на' 'идти в' 'идти во' 'идти на'
		'войди в' 'войди во' 'войди на' 'зайди в' 'зайди во' 'зайди на' 'взойди' 'взойди на' 'иди в' 'иди во' 'идина' 'выйти в' 'выйди в' 'выйти во' 'выйди во' 'выйти на' 'выйди на' 'идти по' 'иди по' 'идти к' 'иди к' 'подойти к' 'подойди к' 'идти ко' 'иди ко' 'подойти ко' 'подойди ко'
;