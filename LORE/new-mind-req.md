# Новый разум. Прорыв

*Требования к ПО. Версия 0.2*

## Платформа и язык программирования

* Язык программирования С++

* Кросс-платформенное приложение, консольное, нет зависимостей от внешних библиотек.

## Концепция

Игра представляет собой парсерный шутер. Парсерный означает, что игра должна обрабатывать введённую текстовую команду игрока. Дополнительно, существует менюшный подрежим синтеза в котором можно выбрать по пунктам что синтезировать. 

## Навигация

Существует два вида карты. Карта местности (2D), перемещение по которой выполняется командами "север, юг, запад, восток, вверх, вниз" и карта боя (1D), перемещение по которой происходит командами вперёд и назад. При появлении ГГ на одной локации с монстром карта боя включается автоматически. При этом, есть возможность уйти из текущей локации во время боя (сбежать). Также и монстр может покинуть локацию и, если герой останется один, то карата боя выключится. Основная цель - достигнуть босса уровня и победить его. Топология карты представлена в **Приложении 1**. Существует единственный центральный коридор (локации 0-9, в зеленом контуре), продвигаясь по которому игрок достигает босса (который на клетке 9). Секции коридора с 1-9 закрыты автоматическими дверями, которые открываются, когда игрок находит ключ в боковом ответвлении. Например, чтобы отпереть проход 1->2, ему необходимо из 1-й локации отправиться на северо-запад(nw) в локацию 10. При входе его встречает команда стражей (g1). После победы над ними, игрок двигается наверх (u) и попадает в локацию 13. Затем, оттуда проходит наверх (u) в локацию 15, где находиться ключ, естественно под охраной.

## Оружие

### Крио-нож

Штырь, кромка которого охлаждается до температуры, близкой к абсолютному нулю.

Эффекты (списываются автоматически, если были синтезированы):

- Прыжок. Если вы выберете нож, и будете двигаться вперёд к противнику в течение двух ходов подряд, то вы подскочите к ближайшему противнику и поразите его ударом ножа.

- Микровозврат. При ударе ножом наноситься второй удар автоматически.

- Вихрь. При попаданию ножом по противнику, нож описывает дугу в радиусе 5 клеток и поражает всех стоящих вокруг на 30% от силы основного удара.

### Роботизированный револьвер.

Старая-добрая пушка, но с более удобной управлением обоймами.

Патроны:

- Обычные

- Разрывные. Двойной урон.

- Толкатели. Отбрасывают монстра назад на 5 клеток после попадания.

- Зажигательные. Продолжают наносить урон 100% в течение последующих 4-х ходов.

## Система синтеза

Подсистема синтеза нужна чтобы генерировать из кристаллов энергии (КЭ) полезные девайсы - патроны, эффекты, лечилку.

> Вас приветствует интегрированная подсистема синтеза! Для вашего удобства работа с ней идёт в режиме диалога. Сначала выдаётся статистика по имеющимся у вас ресурсам. Выберите подходящий элемент и введите количество, синтезатор выдаст вам готовый продукт. Вы всегда сможете узнать подробнее про каждый элемент перед покупкой, просто выберите номер и перейдите в справку. Удачного пользования!
> 
> Имеется: кристаллов энергии(Э)-40. Выберите номер позиции для синтеза:
> 
> 0 - выход
> 
> 1- патроны для револьвера (Э - 10)
> 
> 2- шприц (Э - 20)
> 
> 3 - модуль прыжка (крионож) (Э - 30)
> 
> 4 - модуль микровозврата (крионож) (Э - 30)
> 
> 5 - модуль "вихрь" (крионож) (Э - 30)
> 
> 6 - разрывные патроны (Э - 30)
> 
> 7 - патроны-толкатели (Э - 30)
> 
> 8 - зажигательные патроны (Э - 30)

После выбора необходимо ввести количество, проверить хватает ли средств и пополнить их количество у героя. Количество энергии приведено для примера.

## Правила боя

1. Бой включается автоматически, если на текущей локации есть вражеские монстры. Обоснование: у нас аналог шутера, частые бои, бесшовный переход от режима боя к режиму не боя

2. Бой выключается автоматически, если на текущей локации нет вражеских монстров. Обоснование: у нас аналог шутера, частые бои, бесшовный переход от режима боя к режиму не боя

3. Во время боя доступны дополнительные глаголы боя.

4. Каждая локация имеет свой размер линейного поля боя и начальное положение для игрока и монстров. Обоснование: на разных локациях можно делать разную тактическую обстановку - враги по одну сторону, окружили, бегут за героем и т.п.

5. Чтобы переместиться к концу карты, надо использовать глагол “вперёд” (синоним “дальше”). Обоснование: глагол удобен для пространственного представления перемещения и не конфликтует со сторонами света. Конец карты положительное направление и персонаж как бы уходит вдаль. 

6. Чтобы переместиться к началу карты, надо использовать глагол “назад” (синоним “ближе”). Обоснование: глагол удобен для пространственного представления перемещения и не конфликтует со сторонами света. Конец карты положительное направление и персонаж как бы подходит к началу - во весь экран.

7. Если враг приближается к герою, то выдача будет “противник подошел ближе”. Обоснование: Хоть враг идёт в противоположном направлении, для более удобного анализа ситуации говорим, что он подошел ближе. Причем, ближе имеется ввиду к главному герою.

8. Если враг отдаляется от героя, то выдача будет “противник отошел дальше”. Обоснование: Хоть враг идёт в противоположном направлении, для более удобного анализа ситуации говорим, что он отошел.

9. Разрешается проходить мимо врагов. Обоснование: если будем стопориться об врагов, то они будут тоже стопориться о нас, это сильно ограничивает разные тактики и приводит к неопредёленным ситуациям (союзник вдруг появился за спиной врага).

10. Разрешается стрелять в любого врага на карте. Обоснование: мощность оружия зависит от дальности, поэтому эффект понижения точности стрельбы учитывается. Дополнительно могут быть введены аникомбинации-штрафы, если стреляем в монстра, перед которым уже кто-то стоит.

11. Враги могут проходить мимо героя. Обоснование: аналогично п. 9

12. Если игрок попытается уйти с карты, он получает штраф в размере удара от всех монстров в ближнем бою. Не уверен, что работает... Обоснование: надо дать игроку возможность сбежать с поля боя в любом направлении, но надо делать это с наказанием, чтобы он не прыгал между локациями. Будем считать, что когда игрок сбегает, но пробегает мимо монстров и все его задевают.

13. После победы над монстром прибавляются кристаллы энергии для оперативного синтеза

## 

### Построение карты и отладка

В идеале должен быть текстовый файл (CSV) с таблицей вида для описания карты locations.csv:

```csv
id локации; описание; id-двери; id-ключа; количество стрелков; количество штурмовиков; количество огневиков; количество лутбоксов;
0; Коридор бункера. Стартовая точка. Проход идёт на север; 0; 0; 0; 0; 0; 0
1; Коридор бункера уровень 1. Проход идёт на запад к следующему уровню; 1; 0; 0; 0; 0; 0;
...
10; Начало зеленого коридора. Можно выйти на юго-восток или двинуться дальше на верх, на запад и вниз; 0; 0; 1; 0; 0; 1
...
15; Тупик под навесом. Можно выйти вниз; 0; 1; 0; 2; 0; 0
```

Получается, мы можем указать в каких локациях содержаться двери, которые открывают проход на следующий уровень (всегда id-больше предыдущего).

Отдельный файл отображает связь между идентификаторами локаций. connections.csv:

```csv
id исходной;id результата;направление
0;1;n
1;0;s
1;10;nw
10;1;se
...
```

Еще файл предназначен для установки параметров оружия, HP героя, монстров. Нужен для дальнейшего баланса.

### Расчёт очков

Очки за игру рассчитываются как суммарный нанесенный урон. 

### Порядок этапов разработки

1. Бетта 0.1 Только загрузка карты (можно урезанной) и навигация по ней.

2. Бетта 0.2 Подключение битвы и сражение и фиксированным инвентарем с каждым из типов монстров (кроме босса).

3. Бетта 0.3 Подключение синтеза, расстановка по всей карте.

4. Бетта 0.4 Подключение всех команд, добавление босса.

5. Далее до версии 1.0 доработки.

### Архитектура ПО

Самая простая архитектура - процедурно-ориентированная. Есть набор структур и массивов для хранения. Обработка по сути меняет карту.

```plantuml
struct Room {
    Хранит все данные по комнате
   ---
    * string desc (короткое описание, на первых версиях можно не делать)
    * string ldesc (длинное описание)
    * int battle_size (размер поля битвы)
    * Room* north (указатель на комнату к северу, далее аналогично)
    * Room* south
    * Room* west
    * Room* east
    * Room* up
    * Room* down
}


struct Map {
   Хранит все параметры карты
   ---
   * Room rooms[] (массив со всеми комнатами)
   * Room* startRoom (начальная комната для персонажа)
   * Hero hero (ГГ)
   * Monter monsters[] (массив со всеми монстрами)
}


struct Hero {
  ГГ
  ---
  * int HP
  * int energy (сколько кристаллов энергии насобирал)
  * selectedWeapon
  * room* location (в какой комнате сейчас)
}


struct Monter {
  Плохиш
  ---
  * int HP
  * int energy (сколько кристаллов энергии отдаст после поражения)
  * type (тип монсрюги - штурмовик, и так далее)
  * room* location
  * nav_state (тип навигации `статичный`, `по маршруту`, `преследователь`)
  * bool is_terminator (после встречи с героем, начигаем его преследовать до победного)
  * state (очень важный параметр - боевое состояние, 
например сейчас стоит, движется к герою, от героя, 
готовиться стрелять)
}

Map --> Room
Map --> Hero 
Map --> Monter 
```

Псевдокод главной функции:

```cpp
int main()
{
    Map map;
    //1. Считывание комнат из файла locations.csv, заполнение map.rooms в части описаний.
    //пока можно заменить коснтантами
    //id комнаты - просто позиция в массиве, напрямую в структуры не кладётся
    //параллельно надо заполнять массив с монстрами и давать указатель на текущую комнату
    //2. Считывание направлений из connections.csv, заполнение map.rooms в части указателей

    //3. Основной цикл игры
    while(true)
    {
       cin >> user_inpout;
       std::string res = game_loop(user_inpout, map);
       cout << res;
    }
}
```

Основной цикл обработки следующий:

```cpp
std::string game_loop(std::string input, Map& map)
{
    //функция парсит строку и переводит текст в id команды и её строковый аргумент, может отстусвовать
    CommandId, CommandArg = parse_input(input);
    //флаг, что необходимы дополнительные команды и действия для боевого режима
    bool is_battle_mode = getMonstersOnLocation(map.hero.location);
    std::string output;
    switch(CommandId)
    {
       case CmdNorth: //хотим идти на север
           if (map.hero.location->north) //можем ли пойти на север
           {
                map.hero.location = map.hero.location->north; //переходим
                output = map.hero.location->ldesc; //для возврата даём описание
           }
           else //не можем пройти
           {
               output = "Туда не пройти!"
           }
       break;
       //подключаем команды, которые разрешены в боевом режиме
      ...
    }
    //проверяем, нужна ли обработка боевого режима
    if (is_battle_mode)
    {
        processBattle(map.hero,getMonstersOnLocation(map.hero.location))
    }
    //после обработки ввода пользователя, надо выполнить обновление монстров на карте, они могут перемещаться. Кто-то в режиме боя, кто-то ползает по карте
    //на выходе мы получаем строку от их действий (если они что-то выполнили, например вошли в комнату к герою)
    output += updateMonsters()
    return output;
}
```

После смерти монстра, его локация становиться 0, его дальше не обслуживаем.

Обслуживание боевого режима:

```cpp
//получить список всех моснтров на локации
Monsters* getMonstersOnLocation(Room* room)
//обработка битвы
processBattle(hero, monsters_list)
{
    //для каждого монстра смотрим его тип и состояние
    for (monster : monsters_list)
    {
       if (monster->type == Shturmovic)
       {
           //проверяем в какой стороне герой и, если не в плотную смещаемся к нему
           //если рядом, то удар
       }
    }
}
```

Дополнительные функции, которые получат урон для данного типа оружия в диапазоне.





## Приложение 1. Карта местности

```plantuml
@startuml
digraph Foo {
0 [color="green", level=1, pos=1, type=mainline];
1 [color="green", level=2, pos=2, type=mainline];
2 [color="green", level=2, pos=3, type=mainline];
10 [allowed_dirs="west north south", color="gray", guards=1, label="10 g1", pos=1, room_style=3, type=branch];
11 [allowed_dirs="down up north south east", color="gray", pos=1, room_style=3, type=branch];
12 [allowed_dirs="west down north south east", color="gray", pos=1, room_style=3, type=branch];
13 [allowed_dirs="north south east", color="gray", pos=1, room_style=3, type=branch];
14 [allowed_dirs="west down up north south", color="gray", pos=1, room_style=3, type=branch];
15 [allowed_dirs="west up north south east", color="gray", key_defender=1, label="15 key1", pos=1, room_style=3, type=branch];
3 [color="green", level=2, pos=4, type=mainline];
16 [allowed_dirs="west up south east", color="gray", guards=1, label="16 g1", pos=2, room_style=5, type=branch];
17 [allowed_dirs="west down up north south", color="gray", pos=2, room_style=5, type=branch];
18 [allowed_dirs="west down up north east", color="gray", pos=2, room_style=5, type=branch];
19 [allowed_dirs="down up south", color="gray", key_defender=2, label="19 key2", pos=2, room_style=5, type=branch];
20 [allowed_dirs="down north south east", color="gray", pos=2, room_style=5, type=branch];
21 [allowed_dirs="west down up north east", color="gray", pos=2, room_style=5, type=branch];
4 [color="green", level=2, pos=5, type=mainline];
22 [allowed_dirs="west up east", color="gray", guards=1, label="22 g1", pos=3, room_style=5, type=branch];
23 [allowed_dirs="west up south east", color="gray", pos=3, room_style=5, type=branch];
24 [allowed_dirs="west down north south", color="gray", pos=3, room_style=5, type=branch];
25 [allowed_dirs="down north east", color="gray", key_defender=2, label="25 key2", pos=3, room_style=5, type=branch];
26 [allowed_dirs="west down up east", color="gray", pos=3, room_style=5, type=branch];
5 [color="green", level=3, pos=6, type=mainline];
27 [allowed_dirs="west down up east", color="gray", guards=1, label="27 g1", pos=4, room_style=1, type=branch];
28 [allowed_dirs="west up", color="gray", pos=4, room_style=1, type=branch];
29 [allowed_dirs="west north south east", color="gray", pos=4, room_style=1, type=branch];
30 [allowed_dirs="down north south", color="gray", key_defender=2, label="30 key2", pos=4, room_style=1, type=branch];
31 [allowed_dirs="down up east", color="gray", pos=4, room_style=1, type=branch];
6 [color="green", level=3, pos=7, type=mainline];
32 [allowed_dirs="west down up north", color="gray", guards=1, label="32 g1", pos=5, room_style=1, type=branch];
33 [allowed_dirs="west east", color="gray", pos=5, room_style=1, type=branch];
34 [allowed_dirs="west down up south", color="gray", key_defender=3, label="34 key3", pos=5, room_style=1, type=branch];
35 [allowed_dirs="down south east", color="gray", pos=5, room_style=1, type=branch];
36 [allowed_dirs="up north east", color="gray", pos=5, room_style=1, type=branch];
7 [color="green", level=3, pos=8, type=mainline];
37 [allowed_dirs="down up north south east", color="gray", guards=2, label="37 g2", pos=6, room_style=3, type=branch];
38 [allowed_dirs="west down up", color="gray", pos=6, room_style=3, type=branch];
39 [allowed_dirs="west down up east", color="gray", pos=6, room_style=3, type=branch];
40 [allowed_dirs="west down south east", color="gray", key_defender=3, label="40 key3", pos=6, room_style=3, type=branch];
41 [allowed_dirs="west down up north east", color="gray", pos=6, room_style=3, type=branch];
42 [allowed_dirs="west up north south east", color="gray", pos=6, room_style=3, type=branch];
8 [color="green", level=4, pos=9, type=mainline];
43 [allowed_dirs="west down up south east", color="gray", guards=2, label="43 g2", pos=7, room_style=5, type=branch];
44 [allowed_dirs="west up north", color="gray", pos=7, room_style=5, type=branch];
45 [allowed_dirs="down north south east", color="gray", key_defender=4, label="45 key4", pos=7, room_style=5, type=branch];
46 [allowed_dirs="down up south east", color="gray", pos=7, room_style=5, type=branch];
47 [allowed_dirs="west down up north south", color="gray", pos=7, room_style=5, type=branch];
48 [allowed_dirs="west down up north east", color="gray", pos=7, room_style=5, type=branch];
9 [color="green", level=4, pos=10, type=mainline];
49 [allowed_dirs="west up north", color="gray", guards=2, label="49 g2", pos=8, room_style=5, type=branch];
50 [allowed_dirs="down north south east", color="gray", key_defender=4, label="50 key4", pos=8, room_style=5, type=branch];
51 [allowed_dirs="up south east", color="gray", pos=8, room_style=5, type=branch];
52 [allowed_dirs="west down up north south", color="gray", pos=8, room_style=5, type=branch];
53 [allowed_dirs="west down north south east", color="gray", pos=8, room_style=5, type=branch];
0 -> 1  [direction=north, label=n];
1 -> 0  [direction=south, label=s];
1 -> 2  [direction=east, label=e];
1 -> 10  [direction=nw, label=nw];
2 -> 1  [direction=west, label=w];
2 -> 3  [direction=north, label=n];
2 -> 16  [direction=nw, label=nw];
10 -> 11  [direction=east, label=e];
10 -> 12  [direction=down, label=d];
10 -> 13  [direction=up, label=u];
10 -> 1  [direction=se, label=se];
11 -> 10  [direction=west, label=w];
12 -> 10  [direction=up, label=u];
13 -> 10  [direction=down, label=d];
13 -> 14  [direction=west, label=w];
13 -> 15  [direction=up, label=u];
14 -> 13  [direction=east, label=e];
15 -> 13  [direction=down, label=d];
3 -> 2  [direction=south, label=s];
3 -> 4  [direction=east, label=e];
3 -> 22  [direction=nw, label=nw];
16 -> 20  [direction=down, label=d];
16 -> 21  [direction=north, label=n];
16 -> 2  [direction=se, label=se];
17 -> 19  [direction=east, label=e];
18 -> 19  [direction=south, label=s];
19 -> 17  [direction=west, label=w];
19 -> 18  [direction=north, label=n];
19 -> 20  [direction=east, label=e];
20 -> 16  [direction=up, label=u];
20 -> 19  [direction=west, label=w];
21 -> 16  [direction=south, label=s];
4 -> 3  [direction=west, label=w];
4 -> 5  [direction=north, label=n];
4 -> 27  [direction=nw, label=nw];
22 -> 23  [direction=south, label=s];
22 -> 25  [direction=down, label=d];
22 -> 26  [direction=north, label=n];
22 -> 3  [direction=se, label=se];
23 -> 22  [direction=north, label=n];
23 -> 24  [direction=down, label=d];
24 -> 23  [direction=up, label=u];
24 -> 25  [direction=east, label=e];
25 -> 22  [direction=up, label=u];
25 -> 24  [direction=west, label=w];
25 -> 26  [direction=south, label=s];
26 -> 22  [direction=south, label=s];
26 -> 25  [direction=north, label=n];
5 -> 4  [direction=south, label=s];
5 -> 6  [direction=east, label=e];
5 -> 32  [direction=nw, label=nw];
27 -> 28  [direction=south, label=s];
27 -> 31  [direction=north, label=n];
27 -> 4  [direction=se, label=se];
28 -> 27  [direction=north, label=n];
28 -> 29  [direction=down, label=d];
28 -> 30  [direction=east, label=e];
28 -> 31  [direction=south, label=s];
29 -> 28  [direction=up, label=u];
29 -> 30  [direction=down, label=d];
30 -> 28  [direction=west, label=w];
30 -> 29  [direction=up, label=u];
30 -> 31  [direction=east, label=e];
31 -> 27  [direction=south, label=s];
31 -> 28  [direction=north, label=n];
31 -> 30  [direction=west, label=w];
6 -> 5  [direction=west, label=w];
6 -> 7  [direction=east, label=e];
6 -> 37  [direction=nw, label=nw];
32 -> 33  [direction=south, label=s];
32 -> 36  [direction=east, label=e];
32 -> 5  [direction=se, label=se];
33 -> 32  [direction=north, label=n];
33 -> 34  [direction=south, label=s];
33 -> 35  [direction=down, label=d];
33 -> 36  [direction=up, label=u];
34 -> 33  [direction=north, label=n];
34 -> 35  [direction=east, label=e];
35 -> 33  [direction=up, label=u];
35 -> 34  [direction=west, label=w];
35 -> 36  [direction=north, label=n];
36 -> 32  [direction=west, label=w];
36 -> 33  [direction=down, label=d];
36 -> 35  [direction=south, label=s];
7 -> 6  [direction=west, label=w];
7 -> 8  [direction=north, label=n];
7 -> 43  [direction=nw, label=nw];
37 -> 38  [direction=west, label=w];
37 -> 6  [direction=se, label=se];
38 -> 37  [direction=east, label=e];
38 -> 39  [direction=north, label=n];
38 -> 40  [direction=south, label=s];
39 -> 38  [direction=south, label=s];
39 -> 41  [direction=north, label=n];
40 -> 38  [direction=north, label=n];
40 -> 42  [direction=up, label=u];
41 -> 39  [direction=south, label=s];
42 -> 40  [direction=down, label=d];
8 -> 7  [direction=south, label=s];
8 -> 9  [direction=east, label=e];
8 -> 49  [direction=nw, label=nw];
43 -> 44  [direction=north, label=n];
43 -> 7  [direction=se, label=se];
44 -> 43  [direction=south, label=s];
44 -> 45  [direction=down, label=d];
44 -> 46  [direction=east, label=e];
45 -> 44  [direction=up, label=u];
45 -> 47  [direction=west, label=w];
46 -> 44  [direction=west, label=w];
46 -> 48  [direction=north, label=n];
47 -> 45  [direction=east, label=e];
48 -> 46  [direction=south, label=s];
9 -> 8  [direction=west, label=w];
49 -> 50  [direction=east, label=e];
49 -> 51  [direction=south, label=s];
49 -> 53  [direction=down, label=d];
49 -> 8  [direction=se, label=se];
50 -> 49  [direction=west, label=w];
50 -> 51  [direction=up, label=u];
51 -> 49  [direction=north, label=n];
51 -> 50  [direction=down, label=d];
51 -> 52  [direction=west, label=w];
52 -> 51  [direction=east, label=e];
53 -> 49  [direction=up, label=u];
}
@enduml
```

## Приложение 2. Команды игры

| Команда (список однотипных команд)                                                                                            | Пример                        | Описание                                                                                                                                                                     |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| север(с), юг(ю), запад(з), восток(в), северо-запад(сз), северо-восток(св), юго-запад(юз), юго-восток(юв), вверх(вв), вниз(вн) | >с                            | переводит ГГ в новую локацию. Если такого направления нет, необходимо сообщить - "вы не можете пройти в этом направлении"                                                    |
| вперед(вп), назад(нз)                                                                                                         | >вп                           | Перемещает персонажа в рядом стоящую клетку во время боя.                                                                                                                    |
| ждать (ж)                                                                                                                     | >ж                            | Пропускает ход, при                                                                                                                                                          |
| осмотреть (осм, о)                                                                                                            | >о себя <br>>о синего <br> >о | Осматривает себя (показывает характеристи хп, количество боеприпасов, ресурсов). Осматривает монстра - показывает его описание. Осматривает локацию - повторяет её описание. |
| уколоть(укол)                                                                                                                 | >уколоть себя                 | Прибавляет HP ГГ из синтезированной лечилки                                                                                                                                  |
| нож, пистолет(револьвер)                                                                                                      | >выбрать нож                  | если во фразе встречается оружие, то всегда его выбираем, при этом оповещаем игрока, что новое оружие выбрано.                                                               |
| удар                                                                                                                          | >ударить синего               | если во фразе есть "удар", затем надо смотреть часть имени монстра. Работает, когда выбран нож.                                                                              |
| стрелять                                                                                                                      | >застрелить синего            | если есть "стрел", то затем надо смотреть часть имени монстра. Работает, когда выбран револьвер.                                                                             |
| патроны(обойма)                                                                                                               | >патроны разрывные            | выбор типа патронов, если уже были синтезированы.                                                                                                                            |
| открыть                                                                                                                       | >открыть бокс                 | если есть "откры", то затем смотрим название лутбокса на локации. Для всего остального - ошибка                                                                              |
| синтез                                                                                                                        | >синтез                       | открывает меню синтеза                                                                                                                                                       |
| помощь (справка)                                                                                                              | >помощь                       | выдаёт список команд                                                                                                                                                         |
| супержизнь, супероружие, открытьвсе, стопрандом                                                                               | >супержизнь                   | чит-коды для отладки, много хп, оружия и всё открыто. Также можно выключить рандом.                                                                                          |

## Приложение 3. Характеристики персонажей (defaults)

**ГГ**. HP=100, КЭ=40.

"Вы выглядите как трехметровый гигант, вместо волос и одежды - голая плоть, без гендерных признаков. Кожа сверхпрочная, состоит из алмазных наностержней, которые, переплетаясь, выделяют темный переливающийся рельеф мышц. Толстый мускульный слой прикрывает искусственные органы, сосредоточенные в области груди. Ваши глаза - два черных алмаза, скрывающих мощную оптическую систему и искусственный разум. Оружие находится прямо в теле в районе таза, закрытое прочной мембраной. Часть спины отведена под синтезируемые предметы также закрыта мембраной и позволяет быстро их доставать. Декоративный рот и нос сделаны из эстетических соображений, для редких контактов с людьми."

 **Стрелок**

HP=10, КЭ=4, Обычный стрелок. Никуда не ходит, только стреляет и иногда ожидает. Самая сильная атака на средней дистанции, плох на дальней и близкой, правда мало жизни. Иногда может восстановить своё здоровье. Урон: 3-15.

```
calcHit(D) = {
      if (D<=3) return rangernd(5,15);
      else if (D<10) return rangernd(3,5);
      return rangernd(3,5);
}
```

**Штурмовик**

hp = 30,  КЭ=6 Обычный штурмовик. Всегда двигается на Вас, сражается только врукопашную. Иногда может в ярости перекинуть вас в дальний конец карты. Среднее количество жизни и низкая атака. Удар:

```
calcHit(D) = {
if (D==0) return rangernd(2,4);
}
```

**Огневик**

hp = 10, gen = 5. Обычный огневик. Бродит туда-сюда и периодически отстреливается. Может выпустить нефтяной шар, который будет гореть на жертве какое-то время

Логика работы:

```
//с вероятностью 30% меняем тактику ходить в одну сторону, другую или стрелять
      if ( rangernd(1,10) <= 3 ) {
         if (self._is_move == true) {
            self._is_move = nil;
         }
         else {
            self._is_move = true;
            self._curr_dir = rangernd(MOVE_DIR_FORWARD,MOVE_DIR_BACKWARD);
         }
      }

      if (self._is_move) {      
         //если уперлись в тупик, то идём обратно
         if ( (self._curr_dir==MOVE_DIR_FORWARD) && (self.pos == loc._field_size) ) self._curr_dir = MOVE_DIR_BACKWARD;
         else if ( (self._curr_dir==MOVE_DIR_BACKWARD) && (self.pos == 0) ) self._curr_dir = MOVE_DIR_FORWARD; 
      }

      //Стреляем огненным шаром с нефтяной плёнкой
      if ( rangernd(1,10) <= 3 && (global.is_easy==nil) ) {
         "<br><<ZAG(self,&sdesc)>> выпустил по вам огненный шар из нефти!<br>";
         if (!FireBallLong.isIn(Me)) FireBallLong.moveInto(Me);
         //обновляем урон от шара
         FireBallLong._numFireTimeLeft = FireBallLong._maxFireTimeLeft;
         //выполняем урон сразу же
         FireBallLong.preBattleAny(Me);
      }
    ...  
   calcHit(/*int*/D) = {
      if (D<=3) return rangernd(8,12);
      else if (D<6) return rangernd(5,8);
      return rangernd(0,1);
   } 
```

**Босс уровня** - взбесившаяся приставка, типа денди.

Не спрашивай почему такой, народ очень хотел. 

HP=200, есть ближняя и дальняя атака. Атакует периодически, но мощно, всякими мелкими запчастями. Иногда может телепортиться в другую часть карты. Аналог пылесос из предыдущей части:

```
//Логика - всегда следуем за персонажем, находимся рядом

      //Обновляем атакующее состояние - до выстрела.
      self._curr_state += 1;
      //Сообщаем о его действиях
      if (self._curr_state == 1) "Пылесборщик втягивает в себя окружающую пыль и мелкие предметы.";
      else if (self._curr_state == 3) { "Cборщик переключает режимы, готовится к выдуву."; play_sound('vacuum.ogg');}
```