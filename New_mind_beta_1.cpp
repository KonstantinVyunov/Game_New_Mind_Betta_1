// New_mind_beta.1: create map, add functionality for moving around the map.

#include <Windows.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

struct Room {
	string short_desc;
	string long_desc;	// откуда брать это описание?
	int battle_size;	// откуда брать этот размер?
	Room* north;
	Room* south;
	Room* west;
	Room* east;
	Room* down;
	Room* up;
};

enum class Weapon {
	roboticRevolver,
	cryoKnife,
};

struct Hero {
	Weapon selectedWeapon;
	Room* location;
	int energy;
	int HP;
};

enum class Navigation {
	patrolling,
	standing,
	chasing,
};

enum class BattleBehavior {
	shooting_preparation,
	geting_close,
	geting_away,
	stand,
};

enum class Type {
	Stormtrooper,
	Firetrooper,
	Level_Boss,
	Shooter,
};

struct Monsters {
	int HP = 0;
	int gives_energy_crystals = 0;
	Type type;
	Room* location;
	Navigation navigation_state;
	bool is_pursuer = false;
	BattleBehavior behavor_state;
};

struct Map {
	Room rooms[53];	// размер массива равен числу комнат на крте 53?
	Room* start_room;
	Hero hero;
	Monsters monsters[];
};

////получить список всех моснтров на локации
//Monsters* getMonstersOnLocation(Room* room);
//
////обработка battle
//processBattle(hero, monsters_list) {
//	//для каждого монстра смотрим его тип и состояние
//	for (monster : monsters_list) {
//		if (monster->type == Shturmovic) {
//			//проверяем в какой стороне герой и, если не в плотную смещаемся к нему
//			//если рядом, то удар
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
//	//флаг, что необходимы дополнительные команды и действия для боевого режима
//	bool is_battle_mode_on = getMonstersOnLocation(map.hero.location);
//	
//	switch (CommandId) {
//	case CmdNorth: //хотим идти на север
//		if (map.hero.location->north) //можем ли пойти на север
//		{
//			map.hero.location = map.hero.location->north; //переходим
//			game_output = map.hero.location->ldesc; //для возврата даём описание
//		} else {
//			game_output = "Туда не пройти!"; //не можем пройти
//		}
//		break;
//		//подключаем команды, которые разрешены в боевом режиме
//	} if (is_battle_mode_on) { //проверяем, нужна ли обработка боевого режима
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