// New_mind_beta.1: create map, add functionality for moving around the map.

#include <Windows.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

// ������ ������� ����
struct Room {
	string short_desc;				// ������� �������� �������
	string long_desc;				// ������ �������� �������
	Room* north = nullptr;			// ��������� ������� �� ������
	Room* south = nullptr;			// ��������� ������� �� ���
	Room* west = nullptr;			// ��������� ������� �� ������
	Room* east = nullptr;			// ��������� ������� �� �������
	Room* down = nullptr;			// ��������� ������� �����
	Room* up = nullptr;				// ��������� ������� ������
	const int battle_size = 20;		// ������ ������� ���
};

// ������ ����� ������
enum class Weapon {
	RoboticRevolver, //���������������� ���������
	CryoKnife,       //����-���
};

// ������ �������� �����
struct Hero {
	Weapon selected_Weapon;	// ������������� ������ ��
	Room* location;			// ������� ���������� ��
	int energy;				// ���-�� ������� ������� ��
	int HP;					// ���-�� �������� HP ��
};

// ������ ����� �������� ����������
enum class MonsterNavigation {
	Patrolling,	// �������������� - ���� �������� �� ������� ����-����� �� ����������� ���������� ?
	Standing,	// ����� �� ����� - ������ �������� �� ������ ���
	Chasing,	// ������������� - ������ ���������� ��, ��������� ���
};

// ������ ����� ��������� ����������
enum class BattleBehavior {
	ShootingPreparation,	// ��������� � ��������
	GetingClose,			// ������������ � ��
	GetingAway,				// ���������� �� ��
	Waiting,				// �������� - ���������� ��� ��� ������������ ������������� ������������
};

// ������ ����� ����������
enum class MonsterType {
	Stormtrooper,	// ���������
	Firetrooper,	// �������
	LevelBoss,		// ��������� ���� ����
	Shooter,		// �������
};

// ������ ����� ����������
struct Monsters {
	int HP = 0;									// ����� HP �������
	int gives_energy_crystals = 0;				// ���-�� ��������� ���������� ����� ������ ��� ��������
	MonsterType type = {};						// ��� �������
	Room* location = {};						// ������� ������������ �������
	MonsterNavigation navigation_state = {};	// ��� ��������� ������� ��� ���
	bool is_pursuer = false;					// �������� �� ������ ���������������
	BattleBehavior behavor_state = {};			// ��� ��������� ������� � ���
};

// ������ ������� ���������� ����� locations.txt
enum class LocationsFile {
	IDnumber,			// ID �������
	ShortDescription,	// �������� �������� �������
	LongDescription,	// ������ �������� �������
	IDdoor,				// ID-�����
	IDkey,				// ID-�����
	NumShooters,		// ���-�� ��������
	NumStormtrooper,	// ���-�� �����������
	NumFiretroopers,	// ���-�� ���������
	NumLootboxes		// ���-�� ���������
};

// ������ ������� ���������� ����� connections.txt
enum class ConnectionsFile {
	IDfrom,		// ID ������� "��"
	IDto,		// ID ������� "�"
	North,		// ����������� �� �����
	South,		// ����������� �� ��
	West,		// ����������� �� �����
	East,		// ����������� �� ������
};

// ���������� ������ ����
struct Map {
	Room* room;			// ������� ������ �������� ���� ������� ����
	Room* start_room;	// ������� ������ ���� ��			<<<--- ������� � ���� ������ ���� � ����������?
	Hero hero;			// ������� ������ �������� ��
	Monsters* monsters; // ������� ������ �������� ���� �������� � ����
};

const int countRooms() {
	int rooms_arr_length = 0;
	ifstream file_locations("locations.txt");
	if (!file_locations.is_open()) {
		cout << "Check if you have the \"locations.txt\" file within the game folder!" << endl;
	} else {
		char separation_symbol = ';';
		int counter_separation_symbol = 0;
		int counter = 0;
		while (!file_locations.eof()) {
			string word;
			file_locations >> word;
			for (const char chr : word) {
				if (chr == separation_symbol) {
					++counter_separation_symbol;
				}
			}
		}
		const int num_room_description_fields = 9;
		rooms_arr_length = (counter_separation_symbol) / num_room_description_fields;
	}
	file_locations.close();
	return rooms_arr_length;
}

Room* modelRoom(Map &map, int rooms_arr_length) {
	const int num_room_description_fields = 9;
	map.room = new Room[rooms_arr_length];
	map.monsters = new Monsters[rooms_arr_length];
	ifstream file_locations("locations.txt");
	string temp_line_reading;
	for (int i = 0; i < rooms_arr_length; ++i) {
		for (int j = 0; j < num_room_description_fields; ++j) {
			getline(file_locations, temp_line_reading, ';');
			if (static_cast<LocationsFile>(j) == LocationsFile::ShortDescription) {
				map.room[i].short_desc = temp_line_reading;
			}
			if (static_cast<LocationsFile>(j) == LocationsFile::LongDescription) {
				map.room[i].long_desc = temp_line_reading;
			}
		}
	}
	map.room->north;	// ���� ��������� ��� ������� �� connections.txt - ???
	map.room->south;	// �� ����� �������� ������� ����� ���� � ��������� ������
	map.room->west;		// �������������� ���� �������� ��� ��������� � ������������ ������ ...
	map.room->east;		//
	map.room->down;		//
	map.room->up;		//

	file_locations.close();
	return map.room;
}

Hero modelHero(Map map) {
	return map.hero;
}

Monsters* modelMonster(Map &map, int rooms_arr_length) {
	const int num_room_description_fields = 9;
	map.monsters = new Monsters[rooms_arr_length];
	ifstream file_locations("locations.txt");
	string temp_line_reading;
	for (int i = 0; i < rooms_arr_length; ++i) {
		for (int j = 0; j < num_room_description_fields; ++j) {
			getline(file_locations, temp_line_reading, ';');
			if (static_cast<LocationsFile>(j) == LocationsFile::NumShooters) {
				if (!stoi(temp_line_reading)) {
					map.monsters[i].location = &map.room[i];
					//���� ��������� ��� ������ ������������ ��� ��������� ��������.
					//���� ������ ������������ ���������� ��������?
				}
			}
			if (static_cast<LocationsFile>(j) == LocationsFile::NumStormtrooper) {
				if (!stoi(temp_line_reading)) {
					map.monsters[i].location = &map.room[i];
					//���� ��������� ��� ������ ������������ ��� ��������� ��������.
					// ���� ������ ������������ ���������� �����������?
				}
			}
			if (static_cast<LocationsFile>(j) == LocationsFile::NumFiretroopers) {
				if (!stoi(temp_line_reading)) {
					map.monsters[i].location = &map.room[i];
					//���� ��������� ��� ������ ������������ ��� ��������� ��������.
					// ���� ������ ������������ ���������� ���������?
				}
			}
		}
	}
	file_locations.close();
	return map.monsters;
}

Map createGameMap() {
	Map map{};
		const int rooms_arr_length = countRooms();
		map.room = modelRoom(map, rooms_arr_length);
		map.start_room = nullptr; // ����� ������� ������ ���� �����? ���������?
		map.hero = modelHero(map);
		map.monsters = modelMonster(map, rooms_arr_length);
	return map;
}

int main(int argc, char** argv) {
	SetConsoleCP(CP_UTF8);
	SetConsoleOutputCP(CP_UTF8);

	Map map = createGameMap();

	cout << map.room[0].short_desc << " - " << map.room[0].long_desc << endl;
	cout << map.monsters[0].location->short_desc << endl;
	
	delete[] map.room;
	delete[] map.monsters;
	return 0;
}