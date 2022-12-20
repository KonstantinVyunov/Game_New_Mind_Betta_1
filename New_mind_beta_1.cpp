// New_mind_beta.1: create map, add functionality for moving around the map.

#include <Windows.h>
#include <exception>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>

using namespace std;
using std::cout;

// Модель локации игры
struct Room {
	string short_desc = {};			// Краткое описание локации
	string long_desc = {};			// Полное описание локации
	Room* north = nullptr;			// Указатель локации на севере
	Room* south = nullptr;			// Указатель локации на юге
	Room* west = nullptr;			// Указатель локации на западе
	Room* east = nullptr;			// Указатель локации на востоке
	Room* down = nullptr;			// Указатель локации внизу
	Room* up = nullptr;				// Указатель локации вверху
	Room* north_west = nullptr;		// Указатель локации на северо-западе
	Room* south_east = nullptr;		// Указатель локации на юго-востоке
	const int battle_size = 20;		// Размер локации боя
};

// Список типов оружия
enum class Weapon {
	BareFists,			// Голые кулаки
	CryoKnife,			// Крио-нож
	RoboticRevolver,	// Роботизированный револьвер
};

// Модель главного героя
struct Hero {
	int HP = 100;									// Кол-во текущего HP ГГ
	int energy = 100;								// Кол-во текущей энергии ГГ
	Room* location = nullptr;						// Локация нахождения ГГ
	Weapon selected_Weapon = Weapon::BareFists;		// Экипированное оружие ГГ
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
	Shooter,		// Стрелок
	Stormtrooper,	// Штурмовик
	Firetrooper,	// Огневик
	LevelBoss,		// Финальный Босс Игры
};

enum class Mark { Red, Green, Blue, Dark, Orange, White, Yellow, Brown, Grey, Purple, Gold, Silver };

// Модель юнита монстра
struct Monsters {
	int HP = 0;									// Запас HP монстра
	int gives_energy_crystals = 0;				// Кол-во кристалов, получаемых после победы над монстром
	MonsterType type = {};						// Тип монстра
	Room* room = nullptr;					// Локация расположения монстра
	MonsterNavigation navigation_state = {};	// Тип поведения монстра вне боя
	bool is_pursuer = false;					// Является ли монстр преследователем
	BattleBehavior behavor_state = {};			// Тип поведения монстра в бою
	Mark mark = {};								// Отличительная метка монстра
};

// Список входных параметров файла locations.txt
enum class Locations {
	ID,					// ID локации
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
enum class Connections {
	IDfrom,		// ID локации "из"
	IDto,		// ID локации "в"
	Direction	// Направление перемещения
};

// Обобщающая модель игры
struct Map {
	int total_rooms_on_map = 0;				// Общее количество локаций в игре
	int total_monsters_on_map = 0;			// Общее количество монстров в игре
	Room* rooms = nullptr;					// Сводная модель описания всех локаций игры
	Room* game_start_room = nullptr;		// Локация начала игры ГГ
	Hero hero = {};							// Сводная модель описания ГГ
	Monsters* monsters = {};				// Сводная модель описания всех монстров в игре
};

// Проверка доступности исходных файлов "locations.txt" и "connections.txt".
void fileOpenCheck(ifstream& file_locations, ifstream& file_connections) {
	if (!file_locations.is_open()) {
		throw exception("File \"locations.txt\" was not found!");
	}
	if (!file_connections.is_open()) {
		throw exception("File \"connections.txt\" was not found!");
	}
	return;
}

// Функция возвращает каретку в начало читаемого файла, пропуская заголовочную строку
void setCarriageAtBegining(ifstream& file) {
	file.clear();
	file.seekg(0, ios_base::beg);
	std::string line;
	getline(file, line);
	return;
}

// Считывание файла "locations.txt", чобы узнать общее кол-во локаций на карте.
const int countRooms(ifstream &file_locations) {
	setCarriageAtBegining(file_locations);

	std::string line;
	int total_rooms_on_map = NULL;
	while (!file_locations.eof()) {
		getline(file_locations, line);
		++total_rooms_on_map;
	}
	return total_rooms_on_map;
}

// Считывание файла "locations.txt", чобы узнать общее кол-во монстров.
const int counMonsters(ifstream& file_locations) {
	setCarriageAtBegining(file_locations);

	int total_monsters_on_map = NULL;
	std::string line, box;
	vector<string> row;
	while (!file_locations.eof()) {
		getline(file_locations, line);
		stringstream inflow(line);
		while (getline(inflow, box, ';')) {
			row.push_back(box);
		}
		total_monsters_on_map += ( stoi(row[(int)Locations::NumShooters])
								 + stoi(row[(int)Locations::NumStormtrooper])
								 + stoi(row[(int)Locations::NumFiretroopers]) );
		row.clear();
	}
	return total_monsters_on_map;
}

// Генерация игровых локаций.
Room* modelRooms(Map &map, ifstream &file_locations, ifstream &file_connections) {
	map.rooms = new Room[map.total_rooms_on_map];
	vector<string> temp_line;
	string line, box;
	// Записываем Short, Long Descriptions
	setCarriageAtBegining(file_locations);
	while (!file_locations.eof()) {
		getline(file_locations, line);
		stringstream inflow(line);
		while (getline(inflow, box, ';')) {
			temp_line.push_back(box);
		}
		map.rooms[stoi(temp_line[(int)Locations::ID])].short_desc = temp_line[(int)Locations::ShortDescription];
		map.rooms[stoi(temp_line[(int)Locations::ID])].long_desc = temp_line[(int)Locations::LongDescription];
		temp_line.clear();
	}
	// Записываем Directions
	setCarriageAtBegining(file_connections);
	while (!file_connections.eof()) {
		getline(file_connections, line);
		stringstream inflow(line);
		while (getline(inflow, box, ';')) {
			temp_line.push_back(box);
		}
		if (temp_line[(int)Connections::Direction] == "n") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].north
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		else if (temp_line[(int)Connections::Direction] == "s") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].south
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		else if (temp_line[(int)Connections::Direction] == "w") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].west
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		else if (temp_line[(int)Connections::Direction] == "e") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].east
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		else if (temp_line[(int)Connections::Direction] == "u") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].up
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		else if (temp_line[(int)Connections::Direction] == "d") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].down
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		else if (temp_line[(int)Connections::Direction] == "nw") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].north_west
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		else if (temp_line[(int)Connections::Direction] == "se") {
			map.rooms[stoi(temp_line[(int)Connections::IDfrom])].south_east
				= &map.rooms[stoi(temp_line[(int)Connections::IDto])];
		}
		temp_line.clear();
	}
	return map.rooms;
}

// Генерация монстров
Monsters* modelMonsters(Map &map, ifstream &file_locations) {
	map.monsters = new Monsters[map.total_monsters_on_map];
	int arr_counter = 0;
	vector<string> temp_line;
	string line, box;

	setCarriageAtBegining(file_locations);
	while (!file_locations.eof()) {
		getline(file_locations, line);
		stringstream inflow(line);
		while (getline(inflow, box, ';')) {
			temp_line.push_back(box);
		}
		if (stoi(temp_line[(int)Locations::NumShooters]) != 0) {
			const int num_shooters = stoi(temp_line[(int)Locations::NumShooters]);
			for (int k = 0; k < num_shooters; ++k) {
				map.monsters[arr_counter].type = MonsterType::Shooter;
				map.monsters[arr_counter].room = &map.rooms[stoi(temp_line[(int)Locations::ID])];
				map.monsters[arr_counter].mark = static_cast<Mark>(k);
				++arr_counter;
			}
		}
		if (stoi(temp_line[(int)Locations::NumStormtrooper]) != 0) {
			const int num_stormtrooper = stoi(temp_line[(int)Locations::NumStormtrooper]);
			for (int k = 0; k < num_stormtrooper; ++k) {
				map.monsters[arr_counter].type = MonsterType::Stormtrooper;
				map.monsters[arr_counter].room = &map.rooms[stoi(temp_line[(int)Locations::ID])];
				map.monsters[arr_counter].mark = static_cast<Mark>(k);
				++arr_counter;
			}
		}
		if (stoi(temp_line[(int)Locations::NumFiretroopers]) != 0) {
			const int num_firetroopers = stoi(temp_line[(int)Locations::NumFiretroopers]);
			for (int k = 0; k < num_firetroopers; ++k) {
				map.monsters[arr_counter].type = MonsterType::Firetrooper;// WARNING ???
				map.monsters[arr_counter].room = &map.rooms[stoi(temp_line[(int)Locations::ID])];
				map.monsters[arr_counter].mark = static_cast<Mark>(k);
				++arr_counter;
			}
		}
		temp_line.clear();
	}
	return map.monsters;
}

// Генерация и отслеживание модели Главного Героя.
Hero modelHero(Map &map) {
	//map.hero.HP = функция, записывающая новое HP ГГ;
	//map.hero.energy = функция, записывающая новое POW ГГ;
	//map.hero.selected_Weapon = функция, записывающая экипированое оружие ГГ;
	//map.hero.location = функция, записывающая новую локацию ГГ;
	return map.hero;
}

// Генерация и отслеживание всей игровой карты.
Map createGameMap(ifstream &file_locations, ifstream& file_connections) {
	Map map{};
	map.total_rooms_on_map = countRooms(file_locations);
	map.total_monsters_on_map = counMonsters(file_locations);
	map.rooms = modelRooms(map, file_locations, file_connections);
	map.monsters = modelMonsters(map, file_locations);

	file_locations.close();
	file_connections.close();
	
	map.game_start_room = &map.rooms[0];
	map.hero = modelHero(map);

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
		return EXIT_FAILURE;
	}

	Map map = createGameMap(file_locations, file_connections);

	// Пробуем ходить по карте
	if (1) {
		string command;
		cout << map.game_start_room->long_desc << endl;
		while (cout << "Enter command: ", cin >> command and command != "x") {
			
		}
	}

	// Вспомогательная часть проверки карты
	if (0) {
		cout << "Всего игровых локаций на карте: ";
		cout << map.total_rooms_on_map << endl;

		cout << "Всего монстров на карте: ";
		cout << map.total_monsters_on_map << endl;

		cout << "\nСТАРТОВАЯ ЛОКАЦИЯ:\n";
		cout << map.game_start_room->long_desc << endl;

		cout << "\nЧИТАЕМ ЛОКАЦИИ:\n";
		for (int i = 0; i < map.total_rooms_on_map; ++i) {
			cout << (i + 1) << " - " << map.rooms[i].short_desc << "; " << map.rooms[i].long_desc << "; ";
			if (map.rooms[i].north != NULL) {
				cout << "n-" << map.rooms[i].north << "; ";
			}
			if (map.rooms[i].north_west != NULL) {
				cout << "n_w-" << map.rooms[i].north_west << "; ";
			}
			if (map.rooms[i].south != NULL) {
				cout << "s-" << map.rooms[i].south << "; ";
			}
			if (map.rooms[i].south_east != NULL) {
				cout << "s_e-" << map.rooms[i].south_east << "; ";
			}
			if (map.rooms[i].west != NULL) {
				cout << "w-" << map.rooms[i].west << "; ";
			}
			if (map.rooms[i].east != NULL) {
				cout << "e-" << map.rooms[i].east << "; ";
			}
			if (map.rooms[i].up != NULL) {
				cout << "u-" << map.rooms[i].up << "; ";
			}
			if (map.rooms[i].down != NULL) {
				cout << "d-" << map.rooms[i].down << "; ";
			}
			cout << map.rooms[i].battle_size << endl;
		}

		cout << "\nЧИТАЕМ МОНСТРОВ:\n";
		for (int i = 0; i < map.total_monsters_on_map; ++i) {
			cout << (i + 1)
				<< " - "
				<< static_cast<int>(map.monsters[i].type)
				<< " - "
				<< static_cast<int>(map.monsters[i].mark)
				<< " = "
				<< map.monsters[i].room
				<< endl;
		}
	}
	
	delete[] map.rooms;
	delete[] map.monsters;
	return EXIT_SUCCESS;
}