/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// Проверено на TADS 2.5.11 русский релиз 27
// Дата последнего изменения 2017.10.08

// Исправления критических ошибок
#include "patcher/word_forms.t" // Исправления форм слов
#include "patcher/equivalent_objects.t" // Исправление для отображения в сцене эквивалентных объектов
#include "patcher/spelling.t" // Исправления ошибок правописания
#include "patcher/others.t" // Прочие разноплановые исправления

// Исправление существенных недоработок
#include "patcher/go_in.t" // Добавление обработки команд типа "идти во" и "идти на"

// Функциональные изменения
#include "patcher/on_thou.t" // Обращение к игроку "на ты"
//#include "patcher/on_you.t" // Обращение к игроку "на вы"
