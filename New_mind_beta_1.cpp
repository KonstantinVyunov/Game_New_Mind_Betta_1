// New_mind_beta.1: create map, add functionality for moving around the map.

#include <Windows.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

// Модель локации игры
struct Room {
	string short_desc;				// краткое описание локации
	string long_desc;				// полное описание локации
	Room* north = nullptr;			// указатель локации на севере
	Room* south = nullptr;			// указатель локации на юге
	Room* west = nullptr;			// указатель локации на западе
	Room* east = nullptr;			// указатель локации на востоке
	Room* down = nullptr;			// указатель локации внизу
	Room* up = nullptr;				// указатель локации вверху
	const int battle_size = 20;		// размер локации боя
};

// Список типов оружия
enum class Weapon {
	RoboticRevolver, //роботизированный револьвер
	CryoKnife,       //крио-нож
};

// Модель главного героя
struct Hero {
	Weapon selected_Weapon;	// экипированное оружие ГГ
	Room* location;			// локация нахождения ГГ
	int energy;				// кол-во текущей энергии ГГ
	int HP;					// кол-во текущего HP ГГ
};

// Список типов движения противника
enum class MonsterNavigation {
	Patrolling,	// Патрулирование - враг движется по локации взад-вперёд по определённой траектории ?
	Standing,	// Стоит на месте - монстр статичен до начала боя
	Chasing,	// Преследование - монстр преследует ГГ, навязывая бой
};

// Список типов поведения противника
enum class BattleBehavior {
	ShootingPreparation,	// Готовится к стрельбе
	GetingClose,			// Приближается к ГГ
	GetingAway,				// Отдаляется от ГГ
	Waiting,				// Выжидает - пропускает ход для приобритения тактичекского преимущества
};

// Список типов противника
enum class MonsterType {
	Stormtrooper,	// Штурмовик
	Firetrooper,	// Огневик
	LevelBoss,		// Финальный Босс Игры
	Shooter,		// Стрелок
};

// Модель юнита противника
struct Monsters {
	int HP = 0;									// Запас HP монстра
	int gives_energy_crystals = 0;				// Кол-во кристалов получаемых после победы над монстром
	MonsterType type = {};						// Тип монстра
	Room* location = {};						// Локация расположения монстра
	MonsterNavigation navigation_state = {};	// Тип поведения монстра вне боя
	bool is_pursuer = false;					// Является ли монстр преследователем
	BattleBehavior behavor_state = {};			// Тип поведения монстра в бою
};

// Список входных параметров файла locations.txt
enum class LocationsFile {
	IDnumber,			// ID локации
	ShortDescription,	// Короткое описание локации
	LongDescription,	// Полное описание локации
	IDdoor,				// ID-двери
	IDkey,				// ID-ключа
	NumShooters,		// Кол-во стрелков
	NumStormtrooper,	// Кол-во штурмовиков
	NumFiretroopers,	// Кол-во огневиков
	NumLootboxes		// Кол-во лутбоксов
};

// Список входных параметров файла connections.txt
enum class ConnectionsFile {
	IDfrom,		// ID локации "из"
	IDto,		// ID локации "в"
	North,		// Направление на север
	South,		// Направление на юг
	West,		// Направление на запад
	East,		// Направление на восток
};

// Обобщающая модель игры
struct Map {
	Room* room;			// Сводная модель описания всех локаций игры
	Room* start_room;	// Локация начала игры ГГ			<<<--- Имеется в виду начало игры с сохранения?
	Hero hero;			// Сводная модель описания ГГ
	Monsters* monsters; // Сводная модель описания всех монстров в игре
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
	map.room->north;	// пока непонятно как считать из connections.txt - ???
	map.room->south;	// из одной начально локации ведут пути в несколько других
	map.room->west;		// соответственно надо понимать как считывать и распределять строки ...
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
					//пока непонятно как должны записываться все параметры монстров.
					//куда должно записываться количество Стрелков?
				}
			}
			if (static_cast<LocationsFile>(j) == LocationsFile::NumStormtrooper) {
				if (!stoi(temp_line_reading)) {
					map.monsters[i].location = &map.room[i];
					//пока непонятно как должны записываться все параметры монстров.
					// куда должно записываться количество Штурмовиков?
				}
			}
			if (static_cast<LocationsFile>(j) == LocationsFile::NumFiretroopers) {
				if (!stoi(temp_line_reading)) {
					map.monsters[i].location = &map.room[i];
					//пока непонятно как должны записываться все параметры монстров.
					// куда должно записываться количество Огневиков?
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
		map.start_room = nullptr; // Какая локация должна быть здесь? Стартовая?
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