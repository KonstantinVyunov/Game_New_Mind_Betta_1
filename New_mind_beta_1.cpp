// New_mind_beta.1: create map, add functionality for moving around the map.

#include <Windows.h>
#include <exception>
#include <iostream>
#include <fstream>
#include <vector>
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
	Room* north_west = nullptr;		// указатель локации на северо-западе
	Room* south_east = nullptr;		// указатель локации на юго-востоке
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
	Patrolling,	// Патрулирование - враг движется по локации взад-вперёд или по определённой траектории ?
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
	Room* location = NULL;						// Локация расположения монстра
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
	Direction	// Направление
};

// Обобщающая модель игры
struct Map {
	Room* room;				// Сводная модель описания всех локаций игры
	Room* game_start_room;	// Локация начала игры ГГ
	Hero hero;				// Сводная модель описания ГГ
	Monsters* monsters;		// Сводная модель описания всех монстров в игре
};

void fileOpenCheck(ifstream& file_locations, ifstream& file_connections) {
	if (!file_locations.is_open()) {
		throw exception("File \"locations.txt\" was not found!");
	}
	if (!file_connections.is_open()) {
		throw exception("File \"connections.txt\" was not found!");
	}
	return;
}

const int countRooms(ifstream& file_locations) {
	const int num_of_reading_block = 9; // each line has 9 blocks of reading
	int counter_reading_block = 0;
	char separation_symbol = ';';
	string reading_block;
	while (!file_locations.eof()) {
		getline(file_locations, reading_block, separation_symbol);
		++counter_reading_block;
	}
	const int rooms_arr_length = (counter_reading_block / num_of_reading_block);
	//cout << counter_reading_block <<  " - " << rooms_arr_length << endl;
	file_locations.close();
	return rooms_arr_length;
}

// Question: не получается корректно передать аргументами ifstream &file_locations, ifstream &file_connections!!!
// происходит чтение пустых полей ...

Room* modelRoom(Map &map, int rooms_arr_length /*, ifstream &file_locations, ifstream &file_connections*/) {
	const int num_of_location_fields = 9; // each location line has 9 blocks of reading
	const int num_of_connection_fields = 3; // each connection line has 3 blocks of reading
	map.room = new Room[rooms_arr_length];
	map.monsters = new Monsters[100]; // Let's take an array of 100 units.

	ifstream file_locations("locations.txt"); //Help needed: хочется получать из ургументов функции
	vector<string> temp_line_location;
	string temp_location_field;
	int monsters_counter = 0;
	for (int i = 0; i < rooms_arr_length; ++i) {
		for (int j = 0; j < num_of_location_fields; ++j) {
			getline(file_locations, temp_location_field, ';');
			temp_line_location.push_back(temp_location_field);
		}
		map.room[i].short_desc	= temp_line_location[(int)LocationsFile::ShortDescription];
		map.room[i].long_desc	= temp_line_location[(int)LocationsFile::LongDescription];

		//СЧИТЫВАЕМ И ЗАПИСЫВАЕМ МОНСТРОВ
		//HELP NEEDED: Монстры очевидно записываются в массив некоректно по индексу и типу монстра.
		if (stoi(temp_line_location[(int)LocationsFile::NumShooters]) != 0)
		{
			const int num_shooters = stoi(temp_line_location[(int)LocationsFile::NumShooters]);
			//cout << "Shooters: " << num_shooters << endl;
			for (int k = 0; k < num_shooters; ++k) {
				map.monsters[k].type = MonsterType::Shooter;
				//cout << (int)map.monsters[k].type << endl;
				map.monsters[k].location = &map.room[i];
				++monsters_counter;
			}
		}
		if (stoi(temp_line_location[(int)LocationsFile::NumStormtrooper]) != 0)
		{
			const int num_stormtrooper = stoi(temp_line_location[(int)LocationsFile::NumStormtrooper]);
			//cout << "Stormtrooper: " << num_stormtrooper << endl;
			for (int k = 0; k < num_stormtrooper; ++k) {
				map.monsters[k].type = MonsterType::Stormtrooper;
				//cout << (int)map.monsters[k].type << endl;
				map.monsters[k].location = &map.room[i];
				++monsters_counter;
			}
		}
		if (stoi(temp_line_location[(int)LocationsFile::NumFiretroopers]) != 0)
		{
			const int num_firetroopers = stoi(temp_line_location[(int)LocationsFile::NumFiretroopers]);
			//cout << "Firetroopers: " << num_firetroopers << endl;
			for (int k = 0; k < num_firetroopers; ++k) {
				map.monsters[k].type = MonsterType::Firetrooper;
				//cout << (int)map.monsters[k].type << endl;
				map.monsters[k].location = &map.room[i];
				++monsters_counter;
			}
		}
		temp_line_location.clear();
	}
	cout << "Monsters in total: " << monsters_counter << endl;
	//Help needed: хочется получать из ургументов функции
	ifstream file_connections("connections.txt");
	vector<string> temp_line_connection;
	string temp_connection_field;

	while (!file_connections.eof()) {
		for (int j = 0; j < num_of_connection_fields; ++j) {
			getline(file_connections, temp_connection_field, ';');
			temp_line_connection.push_back(temp_connection_field);
		}
		if (temp_line_connection[(int)ConnectionsFile::Direction] == "n")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].north
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		} 
		else if (temp_line_connection[(int)ConnectionsFile::Direction] == "s")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].south
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		}
		else if (temp_line_connection[(int)ConnectionsFile::Direction] == "w")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].west
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		}
		else if (temp_line_connection[(int)ConnectionsFile::Direction] == "e")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].east
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		}
		else if (temp_line_connection[(int)ConnectionsFile::Direction] == "u")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].up
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		}
		else if (temp_line_connection[(int)ConnectionsFile::Direction] == "d")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].down
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		}
		else if (temp_line_connection[(int)ConnectionsFile::Direction] == "nw")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].north_west
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		}
		else if (temp_line_connection[(int)ConnectionsFile::Direction] == "se")
		{
			map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDfrom])].south_east
				= &map.room[stoi(temp_line_connection[(int)ConnectionsFile::IDto])];
		}
		temp_line_connection.clear();
	}

	file_locations.close();
	file_connections.close();
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

Map createGameMap(ifstream &file_locations, ifstream& file_connections) {
	Map map = {};
	const int rooms_arr_length = countRooms(file_locations);
	map.room = modelRoom(map, rooms_arr_length /*, file_locations, file_connections*/);//see line 125
	map.game_start_room = &map.room[0];
	map.hero = modelHero(map);
	map.monsters = modelMonster(map, rooms_arr_length);
	return map;
}

int main(int argc, char** argv) {
	SetConsoleCP(CP_UTF8);
	SetConsoleOutputCP(CP_UTF8);

	ifstream file_locations("locations.txt");
	ifstream file_connections("connections.txt");
	try{
		fileOpenCheck(file_locations, file_connections);
	}
	catch (const exception& error) {
		cerr << "Error: " << error.what() << endl;
		return -1; // Error code - no initial database files.
	}

	Map map = createGameMap(file_locations, file_connections);

	cout << "\nСТАРТОВАЯ ЛОКАЦИЯ:\n";
	cout << map.game_start_room->long_desc << endl;

	cout << "\nЧИТАЕМ ЛОКАЦИИ:\n";
	for (int i = 0; i < 31; ++i) {
		cout << map.room[i].short_desc << "; " << map.room[i].long_desc << "; ";
			if (map.room[i].north != NULL) {
				cout << "n-" << map.room[i].north << "; ";
			}
			if (map.room[i].north_west != NULL) {
				cout << "n_w-" << map.room[i].north_west << "; ";
			}
			if (map.room[i].south != NULL) {
				cout << "s-" << map.room[i].south << "; ";
			}
			if (map.room[i].south_east != NULL) {
				cout << "s_e-" << map.room[i].south_east << "; ";
			}
			if (map.room[i].west != NULL) {
				cout << "w-" << map.room[i].west << "; ";
			}
			if (map.room[i].east != NULL) {
				cout << "e-" << map.room[i].east << "; ";
			}
			if (map.room[i].up != NULL) {
				cout << "u-" << map.room[i].up << "; ";
			}
			if (map.room[i].down != NULL) {
				cout << "d-" << map.room[i].down << "; ";
			}
			cout << map.room[i].battle_size << endl;
	}
	cout << "\nЧИТАЕМ МОНСТРОВ:\n";
	for (int i = 0; i < 20; ++i) {
		cout << (int)map.monsters[i].type << " - " << map.monsters[i].location << endl;
	}
	
	delete[] map.room;
	delete[] map.monsters;
	return 0;
}