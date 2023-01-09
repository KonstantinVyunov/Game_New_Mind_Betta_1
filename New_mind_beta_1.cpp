// New_mind_beta.1: create map, add functionality for moving around the map.

#include <windows.h>
#include <exception>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>

using namespace std;
using std::cout;

const int FIELDS_IN_LINE = 9; // A line in the file Locations.txt.

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
	int HP = NULL;				// Кол-во текущего HP ГГ
	int energy = NULL;			// Кол-во текущей энергии ГГ
	Room* location = nullptr;	// Локация нахождения ГГ
	Weapon selected_Weapon;		// Экипированное оружие ГГ
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
	Room* room = nullptr;						// Локация расположения монстра
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
	NumStormtroopers,	// Кол-во штурмовиков
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
	Monsters* monsters = nullptr;			// Сводная модель описания всех монстров в игре
};

// Проверка доступности исходных файлов "locations.txt" и "connections.txt".
void fileOpenCheck(ifstream& file_locations, ifstream& file_connections) {
	if (!file_locations.is_open()) {
		throw std::exception("File \"locations.txt\" was not found!");
	}
	if (!file_connections.is_open()) {
		throw std::exception("File \"connections.txt\" was not found!");
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

// Считывание файла "locations.txt", чобы узнать общее кол-во (строк = локаций) на карте.
const int countRooms(ifstream &file_locations) {
	setCarriageAtBegining(file_locations);

	std::string line;
	int total_rooms_on_map = NULL;
	while (!file_locations.eof()) {
		getline(file_locations, line);
		if (!line.empty()) {
			++total_rooms_on_map;
		}
	}
	return total_rooms_on_map;
}

// Считывание файла "locations.txt", чобы узнать общее кол-во монстров.
const int countMonsters(ifstream& file_locations) {
	int total_monsters_on_map = NULL;
	std::string line, box;
	vector<string> temp_line;

	setCarriageAtBegining(file_locations);
	while (!file_locations.eof()) {
		getline(file_locations, line);
		if (!line.empty()) {
			stringstream inflow(line);
			while (getline(inflow, box, ';')) {
				temp_line.push_back(box);
			}
			if (temp_line.size() == FIELDS_IN_LINE) {
				total_monsters_on_map += (stoi(temp_line[(int)Locations::NumShooters])
										+ stoi(temp_line[(int)Locations::NumStormtroopers])
										+ stoi(temp_line[(int)Locations::NumFiretroopers]));
			}
			temp_line.clear();
		}
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
		if (stoi(temp_line[(int)Locations::NumStormtroopers]) != 0) {
			const int num_stormtrooper = stoi(temp_line[(int)Locations::NumStormtroopers]);
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
				map.monsters[arr_counter].type = MonsterType::Firetrooper;// WARNING, WHY ???
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
	map.hero.HP = 100;								// HP ГГ;
	map.hero.energy = 100;							// энергия ГГ;
	map.hero.selected_Weapon = Weapon::BareFists;	// экипированое оружие ГГ;
	map.hero.location = map.game_start_room;		// месторасположение ГГ;
	return map.hero;
}

// Генерация и отслеживание всей игровой карты.
Map createGameMap(ifstream &file_locations, ifstream& file_connections) {
	Map map{};

	map.total_rooms_on_map = countRooms(file_locations);
	map.total_monsters_on_map = countMonsters(file_locations);
	map.rooms = modelRooms(map, file_locations, file_connections);
	map.monsters = modelMonsters(map, file_locations);

	file_locations.close();
	file_connections.close();
	
	map.game_start_room = &map.rooms[0];
	map.hero = modelHero(map);

	return map;
}

// Добавление маркеров монстрам
string getMonsterMark(Mark monster_mark) {
	string mark;
	if (monster_mark == Mark::Red) { mark = "Red"; }
	else if (monster_mark == Mark::Green) { mark = "Green"; }
	else if (monster_mark == Mark::Blue) { mark = "Blue"; }
	else if (monster_mark == Mark::Dark) { mark = "Dark"; }
	else if (monster_mark == Mark::Orange) { mark = "Orange"; }
	else if (monster_mark == Mark::White) { mark = "White"; }
	else if (monster_mark == Mark::Yellow) { mark = "Yellow"; }
	else if (monster_mark == Mark::Brown) { mark = "Brown"; }
	else if (monster_mark == Mark::Grey) { mark = "Grey"; }
	else if (monster_mark == Mark::Purple) { mark = "Purple"; }
	else if (monster_mark == Mark::Gold) { mark = "Gold"; }
	else if (monster_mark == Mark::Silver) { mark = "Silver"; }
	return mark;
}

enum class Commands { unknown, north, south, west, east, northwest, northeast, southwest, southeast, up, down };

// Парсинг команд игрока
Commands parceUserInput(std::string& user_inpout) {
	Commands command{};
	if (user_inpout == "north" || user_inpout == "n") {
		command = Commands::north;
	}
	else if (user_inpout == "south" || user_inpout == "s") {
		command = Commands::south;
	}
	else if (user_inpout == "west" || user_inpout == "w") {
		command = Commands::west;
	}
	else if (user_inpout == "east" || user_inpout == "e") {
		command = Commands::east;
	}
	else if (user_inpout == "northwest" || user_inpout == "nw") {
		command = Commands::northwest;
	}
	else if (user_inpout == "northeast" || user_inpout == "ne") {
		command = Commands::northeast;
	}
	else if (user_inpout == "southwest" || user_inpout == "sw") {
		command = Commands::southwest;
	}
	else if (user_inpout == "southeast" || user_inpout == "se") {
		command = Commands::southeast;
	}
	else if (user_inpout == "up" || user_inpout == "u") {
		command = Commands::up;
	}
	else if (user_inpout == "down" || user_inpout == "d") {
		command = Commands::down;
	} else {
		command = Commands::unknown;
	}
	return command;
}

/*перемещение ГГ по карте*/
//void runOverMap(Map& map) {
//	string command;
//	while (cout << "Выберите направление: ", cin >> command && command != "x") { // x - exit
//		if (command == "n" || command == "north" || command == "с" || command == "север") {
//			if (map.hero.location->north != nullptr) {
//				map.hero.location = map.hero.location->north;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						if (map.monsters[i].type == MonsterType::Shooter) {
//							cout << "Shooter(" << getMonsterMark(map.monsters[i].mark) << ") | ";
//						}
//						else if (map.monsters[i].type == MonsterType::Stormtrooper) {
//							cout << "Stormtrooper(" << getMonsterMark(map.monsters[i].mark) << ") | ";
//						}
//						else if (map.monsters[i].type == MonsterType::Firetrooper) {
//							cout << "Firetrooper(" << getMonsterMark(map.monsters[i].mark) << ") | ";
//						}
//						else if (map.monsters[i].type == MonsterType::LevelBoss) {
//							cout << "Boss";
//						}
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else if (command == "s" || command == "south") {
//			if (map.hero.location->south != nullptr) {
//				map.hero.location = map.hero.location->south;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						cout << (int)map.monsters[i].type << ' ';
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else if (command == "w" || command == "west") {
//			if (map.hero.location->west != nullptr) {
//				map.hero.location = map.hero.location->west;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						cout << (int)map.monsters[i].type << ' ';
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else if (command == "e" || command == "east") {
//			if (map.hero.location->east != nullptr) {
//				map.hero.location = map.hero.location->east;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						cout << (int)map.monsters[i].type << ' ';
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else if (command == "d" || command == "down") {
//			if (map.hero.location->down != nullptr) {
//				map.hero.location = map.hero.location->down;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						cout << (int)map.monsters[i].type << ' ';
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else if (command == "u" || command == "up") {
//			if (map.hero.location->up != nullptr) {
//				map.hero.location = map.hero.location->up;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						cout << (int)map.monsters[i].type << ' ';
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else if (command == "nw" || command == "north-west") {
//			if (map.hero.location->north_west != nullptr) {
//				map.hero.location = map.hero.location->north_west;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						cout << (int)map.monsters[i].type << ' ';
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else if (command == "se" || command == "south-east") {
//			if (map.hero.location->south_east != nullptr) {
//				map.hero.location = map.hero.location->south_east;
//				cout << map.hero.location->short_desc << ' ' << map.hero.location->long_desc << endl;
//				cout << "Встречаем: ";
//				for (int i = 0; i < map.total_monsters_on_map; ++i) {
//					if (map.hero.location == map.monsters[i].room) {
//						cout << (int)map.monsters[i].type << ' ';
//					}
//				}
//				cout << endl;
//			}
//			else {
//				cout << "Не могу пройти туда!" << endl;
//			}
//		}
//		else {
//			cout << "Неизвестное направление!\n(Используйте n, s, e, w, nw, se)" << endl;
//		}
//	}
//	updateMap(map);
//	return;
//}

// Обновление Монстров в конце хода ГГ
void updateMonsters(Map &map) {

	return;
}

// Получение массива монстров в одной локации с ГГ
Monsters* getMonstersInRoom(Map& map) {
	int arr_length = 0;
	for (int i = 0; i < map.total_rooms_on_map; ++i) {
		if (map.monsters[i].room == map.hero.location) {
			++arr_length;
		}
	}
	Monsters* monsters_pack = new Monsters[arr_length];
	for (int i = 0; i < map.total_rooms_on_map; ++i) {
		if (map.monsters[i].room == map.hero.location) {
			monsters_pack[--arr_length] = map.monsters[i];
		}
	}
	return monsters_pack;
}

// Получение метки монстра
std::string printMarker(Mark marker) {
	if (marker == Mark::Red) {
		return " (красный)";
	}
	else if (marker == Mark::Green) {
		return " (зелёный)";
	}
	else if (marker == Mark::Blue) {
		return " (синий)";
	}
	else if (marker == Mark::Dark) {
		return " (чёрный)";
	}
	else if (marker == Mark::Orange) {
		return " (оранжевый)";
	}
	else if (marker == Mark::White) {
		return " (белый)";
	}
	else if (marker == Mark::Yellow) {
		return " (жёлтый)";
	}
	else if (marker == Mark::Brown) {
		return " (коричневый)";
	}
	else if (marker == Mark::Grey) {
		return " (серый)";
	}
	else if (marker == Mark::Purple) {
		return " (сиреневый)";
	}
	else if (marker == Mark::Gold) {
		return " (золотой)";
	}
	else if (marker == Mark::Silver) {
		return " (серебряный)";
	}
	else {
		return "non color";
	}
}

string printEncounteredMonsters(Hero& hero, Monsters* monster_in_room) {
	string monster_description;
	for (int i = 0; i < 10; ++i) {
		if (monster_in_room[i].room == hero.location) {
			if (monster_in_room[i].type == MonsterType::Shooter) {
				monster_description += "стрелок" + printMarker(monster_in_room[i].mark) + '\n';
			}
			if (monster_in_room[i].type == MonsterType::Stormtrooper) {
				monster_description += "штурмовик" + printMarker(monster_in_room[i].mark) + '\n';
			}
			if (monster_in_room[i].type == MonsterType::Firetrooper) {
				monster_description += "огневик" + printMarker(monster_in_room[i].mark) + '\n';
			}
		}
	}
	return monster_description;
}

void processBattle(Hero& hero, Monsters* monsters_in_room) {
	cout << "\nВКЛЮЧЁН БОЕВОЙ РЕЖИМ!\nВстречен противник:\n";
	cout << printEncounteredMonsters(hero, monsters_in_room) << endl;
	return;
}

// я правильно понимаю, что один цикл сосотоит из:
// - ход ГГ,
// - ход Монстров,
// - возможные события игры?
std::string game_loop(std::string& user_inpout, Map& map) {
	std::string output;
	Commands command = parceUserInput(user_inpout);

	switch (command) {
		case (Commands::north):
			if (map.hero.location->north) {
				map.hero.location = map.hero.location->north;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::south):
			if (map.hero.location->south) {
				map.hero.location = map.hero.location->south;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::east):
			if (map.hero.location->east) {
				map.hero.location = map.hero.location->east;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::west):
			if (map.hero.location->west) {
				map.hero.location = map.hero.location->west;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::northwest):
			if (map.hero.location->north_west) {
				map.hero.location = map.hero.location->north_west;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::southeast):
			if (map.hero.location->south_east) {
				map.hero.location = map.hero.location->south_east;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::up):
			if (map.hero.location->up) {
				map.hero.location = map.hero.location->up;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::down):
			if (map.hero.location->down) {
				map.hero.location = map.hero.location->down;
				output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				output = "Туда не пройти!";
			} break;
		case (Commands::unknown):
			cout << "Неизвестная команда!" << endl;
			output = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			break;
	}

	Monsters* monsters_in_room = getMonstersInRoom(map);
	bool is_battle_mode = monsters_in_room;

	// Есть ли команды доступные только в боевом режиме?
	if (is_battle_mode == true) { // <<-- Почему-то пока всегда true, надо разобраться.
		// Здесь непонятно как и что выводить для склейки.
		// string = processBattle(); так? - результатом должна быть тоже строка?
		processBattle(map.hero, monsters_in_room);
	}

	// string = updateMonsters(); ? результатом должна быть тоже строка?
	updateMonsters(map);

	return output;
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

	cout << map.game_start_room->short_desc << ' ' << map.game_start_room->long_desc << endl;

	std::string user_inpout;
	std::string game_output;
	bool game_continue = true;

	while (game_continue) {
		cout << "Введеите команду: ";
		cin >> user_inpout;
		game_output = game_loop(user_inpout, map);
		cout << game_output << endl;

		// Пока будем завершать игру через гибель ГГ
		if (map.hero.HP == 0) {
			game_continue = false;
			cout << "ГГ погиб!" << endl;
		}
	}
	cout << "\n=== G A M E  O V E R ===\n" << endl;

	delete[] map.rooms;
	delete[] map.monsters;
	return EXIT_SUCCESS;
}