// New_mind_beta.1: create map, add functionality for moving around the map.

#include <Windows.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

//Ћокаци€ игры
struct Room {
	string short_desc;
	string long_desc;	// откуда брать это описание? -из файла locations.txt
	int battle_size;	// откуда брать этот размер? -—тавить константой, пока 20
	Room* north;
	Room* south;
	Room* west;
	Room* east;
	Room* down;
	Room* up;
};

//-Ћучше названи€ в перечислении с большой буквы
enum class Weapon {
	roboticRevolver, //роботизированный револьвер
	cryoKnife,       //крио нож
};

//ћодель геро€
struct Hero {
	Weapon selectedWeapon;
	Room* location;
	int energy;
	int HP;
};

//ћодель движени€ врагов
//-прокомментируй как расшыфровываютс€ типы и ожидаемое поведение
enum class MonsterNavigation {
	patrolling, 
	standing,
	chasing,
};

//—тиль перечислений надо выбрать один, тут snake_case
enum class BattleBehavior {
	shooting_preparation,
	geting_close,
	geting_away,
	stand,
};

enum class MonsterType {
	Stormtrooper,
	Firetrooper,
	Level_Boss,
	Shooter,
};

struct Monsters {
	int HP = 0; 
	int gives_energy_crystals = 0;
	MonsterType type;
	Room* location;
	MonsterNavigation navigation_state;
	bool is_pursuer = false;
	BattleBehavior behavor_state;
};

struct Map {
	Room* rooms;	// размер массива равен числу комнат на крте 53?//-сделай динамическим
	Room* start_room;
	Hero hero;
	Monsters* monsters; //-динамический массив
};

////получить список всех моснтров на локации
//Monsters* getMonstersOnLocation(Room* room);
//
////обработка battle
//processBattle(hero, monsters_list) {
//	//дл€ каждого монстра смотрим его тип и состо€ние
//	for (monster : monsters_list) {
//		if (monster->type == Shturmovic) {
//			//провер€ем в какой стороне герой и, если не в плотную смещаемс€ к нему
//			//если р€дом, то удар
//		}
//	}
//}
//
////обработка game_loop
//
//string game_loop(string input, Map& map) {
//	string game_output;
//	
//	CommandId, CommandArg = parse_input(input);
//
//	//флаг, что необходимы дополнительные команды и действи€ дл€ боевого режима
//	bool is_battle_mode_on = getMonstersOnLocation(map.hero.location);
//	
//	switch (CommandId) {
//	case CmdNorth: //хотим идти на север
//		if (map.hero.location->north) //можем ли пойти на север
//		{
//			map.hero.location = map.hero.location->north; //переходим
//			game_output = map.hero.location->ldesc; //дл€ возврата даЄм описание
//		} else {
//			game_output = "“уда не пройти!"; //не можем пройти
//		}
//		break;
//		//подключаем команды, которые разрешены в боевом режиме
//	} if (is_battle_mode_on) { //провер€ем, нужна ли обработка боевого режима
//			processBattle(map.hero, getMonstersOnLocation(map.hero.location));
//	}
//	game_output += updateMonsters();
//
//	return game_output;
//}


Map createGameMap() {
	Map map;
	ifstream file("locations.txt");
	if (!file.is_open()) {
		cout << "File is not found!" << endl;
	} else {
		string line, word;
		while (!file.eof()) { 
			//тут не так, надо посчитать сколько строчек и создать динамический массив такого размера
			//мы заранее не знаем, сколько комнат
			for (int i = 0; i < sizeof(map.rooms) / sizeof(map.rooms[0]); ++i) {
				//for (int j = 0; j < 15; ++j) {
					file >> word;
					line += (word + ' ');
				//}
				map.rooms[i].short_desc = line;
			}
		}
		cout << line;
	}
	return map;
}

int main(int argc, char** argv) {
	SetConsoleCP(CP_UTF8);
	SetConsoleOutputCP(CP_UTF8);
	Map map = createGameMap();
	cout << map.rooms[0].short_desc << endl;
	
	string user_input;
	string game_output;
	//bool continue_game = true;
	string continue_game;
	while (cin >> continue_game && continue_game != "q") {
		//cin >> user_input;
		//game_output = game_loop(user_input, map);
		//cout << game_output;
	}

	return 0;
}