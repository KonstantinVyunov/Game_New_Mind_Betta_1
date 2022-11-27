// New_mind_beta.1: create map, add functionality for moving around the map.

#include <Windows.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

struct Room {
	string short_desc;
	string long_desc;	// ������ ����� ��� ��������?
	int battle_size;	// ������ ����� ���� ������?
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
	Room rooms[53];	// ������ ������� ����� ����� ������ �� ���� 53?
	Room* start_room;
	Hero hero;
	Monsters monsters[];
};

////�������� ������ ���� �������� �� �������
//Monsters* getMonstersOnLocation(Room* room);
//
////��������� battle
//processBattle(hero, monsters_list) {
//	//��� ������� ������� ������� ��� ��� � ���������
//	for (monster : monsters_list) {
//		if (monster->type == Shturmovic) {
//			//��������� � ����� ������� ����� �, ���� �� � ������� ��������� � ����
//			//���� �����, �� ����
//		}
//	}
//}
//
////��������� game_loop
//
//string game_loop(string input, Map& map) {
//	string game_output;
//	
//	CommandId, CommandArg = parse_input(input);
//
//	//����, ��� ���������� �������������� ������� � �������� ��� ������� ������
//	bool is_battle_mode_on = getMonstersOnLocation(map.hero.location);
//	
//	switch (CommandId) {
//	case CmdNorth: //����� ���� �� �����
//		if (map.hero.location->north) //����� �� ����� �� �����
//		{
//			map.hero.location = map.hero.location->north; //���������
//			game_output = map.hero.location->ldesc; //��� �������� ��� ��������
//		} else {
//			game_output = "���� �� ������!"; //�� ����� ������
//		}
//		break;
//		//���������� �������, ������� ��������� � ������ ������
//	} if (is_battle_mode_on) { //���������, ����� �� ��������� ������� ������
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