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

// Модель типов оружия - урон <<-------------------------- пока здесь будем хранить базовый урон 
struct WeaponDamage {
	const int cryoknife = 4;
	const int robotic_revolver = 8;
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
	int HP = NULL;								// Запас HP монстра
	int gives_energy_crystals = NULL;			// Кол-во кристалов, получаемых после победы над монстром
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
	int total_rooms_on_map = NULL;			// Общее количество локаций в игре
	int total_monsters_on_map = NULL;		// Общее количество монстров в игре
	Room* rooms = nullptr;					// Сводная модель описания всех локаций игры
	Room* game_start_room = nullptr;		// Локация начала игры ГГ
	Hero hero = {};							// Сводная модель описания ГГ
	Monsters* monsters = nullptr;			// Сводная модель описания всех монстров в игре
	WeaponDamage weapon_damage;				// Базовый уроний оружки
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
	int overall_monster_counter = 0;
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
				map.monsters[overall_monster_counter].type = MonsterType::Shooter;
				map.monsters[overall_monster_counter].HP = 10;
				map.monsters[overall_monster_counter].gives_energy_crystals = 4;
				map.monsters[overall_monster_counter].room = &map.rooms[stoi(temp_line[(int)Locations::ID])];
				map.monsters[overall_monster_counter].mark = static_cast<Mark>(k);
				++overall_monster_counter;
			}
		}
		if (stoi(temp_line[(int)Locations::NumStormtroopers]) != 0) {
			const int num_stormtrooper = stoi(temp_line[(int)Locations::NumStormtroopers]);
			for (int k = 0; k < num_stormtrooper; ++k) {
				map.monsters[overall_monster_counter].type = MonsterType::Stormtrooper;
				map.monsters[overall_monster_counter].HP = 30;
				map.monsters[overall_monster_counter].gives_energy_crystals = 6;
				map.monsters[overall_monster_counter].room = &map.rooms[stoi(temp_line[(int)Locations::ID])];
				map.monsters[overall_monster_counter].mark = static_cast<Mark>(k);
				++overall_monster_counter;
			}
		}
		if (stoi(temp_line[(int)Locations::NumFiretroopers]) != 0) {
			const int num_firetroopers = stoi(temp_line[(int)Locations::NumFiretroopers]);
			for (int k = 0; k < num_firetroopers; ++k) {
				map.monsters[overall_monster_counter].type = MonsterType::Firetrooper;// WARNING, WHY ???
				map.monsters[overall_monster_counter].HP = 10;
				map.monsters[overall_monster_counter].gives_energy_crystals = 5;
				map.monsters[overall_monster_counter].room = &map.rooms[stoi(temp_line[(int)Locations::ID])];
				map.monsters[overall_monster_counter].mark = static_cast<Mark>(k);
				++overall_monster_counter;
			}
		}
		temp_line.clear();
	}
	return map.monsters;
}

// Генерация и отслеживание модели Главного Героя.
Hero modelHero(Map &map) {
	map.hero.HP = NULL;								// HP ГГ;
	map.hero.energy = NULL;							// энергия ГГ;
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
string addMonsterMark(Mark monster_mark) {
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

enum class Commands {
	backward,	// движение назад в бою
	down,		// перемещение по карте вниз
	east,		// перемещение по карте на запад
	forward,	// движение вперёд в бою
	help,		// получить описание доступных команд
	hit,		// нанести удар крионожом
	inspect,	// осмотреть себя/противника/локацию
	knife,		// вооружить ГГ крионожом
	north,		// перемещение по карте на север
	northeast,	// перемещение по карте на северо-восток
	northwest,	// перемещение по карте на северо-запад
	revolver,	// вооружить ГГ роботизированным револьвером
	shoot,		// выстрелить из роботизированного револьвера
	south,		// перемещение по карте на юг
	southeast,	// перемещение по карте на юго-восток
	southwest,	// перемещение по карте на юго-запад
	unknown,	// получена неизвестная команда
	up,			// перемещение по карте вверх
	wait,		// пропуск хода ГГ
	west		// перемещение по карте на восток
};

std::string printHelp() {
	return ("ПОМОЩЬ:\n"
			"помощь(help) - выводит все доступные команды,\n"
			"север(n) - двигаться на север\n"
			"юг(s) - двигаться на юг\n"
			"запад(w) - двигаться на запад\n"
			"восток(e) - двигаться на восток\n"
			"северо-запад(nw) - двигаться на северо-запад\n"
			"северо-восток(ne) - двигаться на северо-восток\n"
			"юго-запад(sw) - двигаться на юго-запад\n"
			"юго-восток(se) - двигаться на юго-восток\n"
			"вверх(u) - двигаться вверх\n"
			"вниз(d) - двигаться вниз\n"
			"нож(k) - экипировать крионож\n"
			"револьвер(r) - экипировать роботизированный револьвер\n"
			"ударить(h) \"ударить синего\" - ударить крионожом\n"
			"выстрелить(sh) \"выстрелить в синего\" - выстрелить из роботизированного револьвера\n"
			"назад(bwd) - продвинуться назад\n"
			"вперёд(fwd) - продвинуться вперёд\n"
			"пропустить(wt) - ждать/пропустить ход\n"
			"осмотреть(i) \"осмотреть себя\" - осмотреть себя/противника/локацию\n");
}

// Разбиение команды игрока на составные слова
std::vector<std::string> splitUserInput(std::string& user_input) {
	std::vector<std::string> split_user_input;
	std::string word;

	stringstream inflow(user_input);
	while (getline(inflow, word, ' ')) {
		split_user_input.push_back(word);
	}
	return split_user_input;
}

// Парсинг команд игрока
pair<Commands, std::vector<std::string>> parceUserInput(std::string& user_input) {

	std::vector<std::string> words = splitUserInput(user_input);

	Commands command{};
	std::vector<std::string> command_object{};

	if (!words.empty()) {
		if (words[0] == "north" || words[0] == "n") {
			command = Commands::north;
		}
		else if (words[0] == "south" || words[0] == "s") {
			command = Commands::south;
		}
		else if (words[0] == "west" || words[0] == "w") {
			command = Commands::west;
		}
		else if (words[0] == "east" || words[0] == "e") {
			command = Commands::east;
		}
		else if (words[0] == "northwest" || words[0] == "nw") {
			command = Commands::northwest;
		}
		else if (words[0] == "northeast" || words[0] == "ne") {
			command = Commands::northeast;
		}
		else if (words[0] == "southwest" || words[0] == "sw") {
			command = Commands::southwest;
		}
		else if (words[0] == "southeast" || words[0] == "se") {
			command = Commands::southeast;
		}
		else if (words[0] == "up" || words[0] == "u") {
			command = Commands::up;
		}
		else if (words[0] == "down" || words[0] == "d") {
			command = Commands::down;
		}
		else if (words[0] == "knife" || words[0] == "k") {
			command = Commands::knife;
		}
		else if (words[0] == "revolver" || words[0] == "r") {
			command = Commands::revolver;
		}
		else if (words[0] == "shoot" || words[0] == "sh") {
			command = Commands::shoot;
			if (words.size() >= 3) {
				command_object = { words[1], words[2] }; // <<----------------------------
			}
			else if (words.size() == 2) {
				command_object = { words[1] }; // <<----------------------------
			}
			else if (words.size() == 1) {
				command_object = {}; // <<----------------------------
			}
		}
		else if (words[0] == "hit" || words[0] == "h") {
			command = Commands::hit;
			if (words.size() >= 3) {
				command_object = { words[1], words[2] }; // <<----------------------------
			}
			else if (words.size() == 2) {
				command_object = { words[1] }; // <<----------------------------
			}
			else if (words.size() == 1) {
				command_object = {}; // <<----------------------------
			}
		}
		else if (words[0] == "forward" || words[0] == "fwd") {
			command = Commands::forward;
		}
		else if (words[0] == "backward" || words[0] == "bwd") {
			command = Commands::backward;
		}
		else if (words[0] == "wait" || words[0] == "wt") {
			command = Commands::wait;
		}
		else if (words[0] == "inspect" || words[0] == "i") {
			command = Commands::inspect;
			if (words.size() >= 2) {
				command_object = { words[1] }; // <<----------------------------
			}
			else if (words.size() == 1) {
				command_object = {}; // <<----------------------------
			}
		}
		else if (words[0] == "help") {
			command = Commands::help;
		}
		else {
			command = Commands::unknown;
		}
	} else {
		command = Commands::unknown;
	}
	return { command, command_object };
}

// Обновление Монстров в конце хода ГГ
std::string updateMonstersMovement(Map &map) {
	std::string mosters_info;
	// здесь надо отслеживать перемещение монстров в соседние локации
	return mosters_info;
}

// Получение массива монстров в одной локации с ГГ
vector<Monsters*> getMonstersInRoom(Map& map) {
	vector<Monsters*> monsters_in_room;
	for (size_t i = 0; i < map.total_rooms_on_map; ++i) {
		if (map.monsters[i].room == map.hero.location) {
			monsters_in_room.push_back(&map.monsters[i]);
		}
	}
	return monsters_in_room;
}

// Выведение метки монстра на печать
std::string getMonsterMarker(Mark marker) {
	if (marker == Mark::Red) {
		//return "красный";
		return "red";
	} else if (marker == Mark::Green) {
		//return "зелёный";
		return "green";
	} else if (marker == Mark::Blue) {
		//return "синий";
		return "blue";
	} else if (marker == Mark::Dark) {
		//return "чёрный";
		return "black";
	} else if (marker == Mark::Orange) {
		//return "оранжевый";
		return "orange";
	} else if (marker == Mark::White) {
		//return "белый";
		return "white";
	} else if (marker == Mark::Yellow) {
		//return "жёлтый";
		return "yellow";
	} else if (marker == Mark::Brown) {
		//return "коричневый";
		return "brown";
	} else if (marker == Mark::Grey) {
		//return "серый";
		return "grey";
	} else if (marker == Mark::Purple) {
		//return "сиреневый";
		return "purple";
	} else if (marker == Mark::Gold) {
		//return "золотой";
		return "gold";
	} else if (marker == Mark::Silver) {
		//return "серебряный";
		return "silver";
	} else {
		return "non color";
	}
}

// Выведение типа монстра на печать
std::string getMonsterType(MonsterType type) {
	if (type == MonsterType::Shooter) {
		//return "стрелок";
		return "shooter";
	}
	else if (type == MonsterType::Stormtrooper) {
		//return "штурмовик";
		return "stormtrooper";
	}
	else if (type == MonsterType::Firetrooper) {
		//return "огневик";
		return "firetrooper";
	}
	else {
		return "босс подземелья";
	}
}

// Последовательное выведение на печать всего пака монстров в локации
string printEncounteredMonsters(vector<Monsters*> monsters_in_room) {
	string monsters_description;
	for (const auto& monster : monsters_in_room) {
		monsters_description += (getMonsterMarker(monster->mark) + ' ' + getMonsterType(monster->type)) + " - (" + to_string(monster->HP) + " HP)\n";
	}
	return monsters_description;
}

std::string processBattle(Hero& hero, vector<Monsters*> monsters_in_room) {
	std::string battle_info;
	battle_info = "\nВКЛЮЧЁН БОЕВОЙ РЕЖИМ!\nВстречен противник:\n" + printEncounteredMonsters(monsters_in_room);
	return battle_info;
}

std::string game_loop(std::string& user_inpout, Map& map) {
	std::string location_info;
	std::string hero_info;
	std::string battle_info;
	std::string mosters_info;

	// Проверяем включён ли боевой режим до получения команд - важно для обработки боевых команд!
	vector<Monsters*> monsters_in_room = getMonstersInRoom(map);
	bool is_battle_mode = monsters_in_room.size();

	pair<Commands, std::vector<std::string>> command = parceUserInput(user_inpout);

	switch (command.first) {
		case (Commands::help):
			return printHelp();
		case (Commands::unknown):
			return "Неизвестная команда! Используйте команду help, чтобы посмотреть все доступные команды!";
		case (Commands::north):
			if (map.hero.location->north) {
				map.hero.location = map.hero.location->north;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::south):
			if (map.hero.location->south) {
				map.hero.location = map.hero.location->south;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::east):
			if (map.hero.location->east) {
				map.hero.location = map.hero.location->east;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::west):
			if (map.hero.location->west) {
				map.hero.location = map.hero.location->west;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::northwest):
			if (map.hero.location->north_west) {
				map.hero.location = map.hero.location->north_west;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::southeast):
			if (map.hero.location->south_east) {
				map.hero.location = map.hero.location->south_east;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::up):
			if (map.hero.location->up) {
				map.hero.location = map.hero.location->up;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::down):
			if (map.hero.location->down) {
				map.hero.location = map.hero.location->down;
				location_info = (map.hero.location->short_desc + ' ' + map.hero.location->long_desc);
			} else {
				return "Туда не пройти!";
			} break;
		case (Commands::inspect):
			if (!command.second.empty()) {
				if (command.second[0] == "yourself" || command.second[0] == "hero") {
					hero_info = ("HP = " + to_string(map.hero.HP) + "\nEnergy = " + to_string(map.hero.energy));
				} else if (is_battle_mode == true) {
					bool check_of_presence = false;
					for (const auto& monster : monsters_in_room) {
						if (command.second[0] == getMonsterMarker(monster->mark)) {
							hero_info = "Проводим беглый осмотр: " + to_string(monster->HP) + " HP";
							check_of_presence = true;
						}
					}
					if (check_of_presence == false) {
						return "Ошибка ввода цели - в списке нет подходящей.";
					}
				}
			}
			else {
				hero_info = map.hero.location->short_desc + ' ' + map.hero.location->long_desc;
			}
			break;
		// смена оружия мгновенна или считается ходом?
		case (Commands::knife):
			map.hero.selected_Weapon = Weapon::CryoKnife;
			return "Вы взяли в руки крионож! Вооружён - значит опасен!";
			break;
		// смена оружия мгновенна или считается ходом?
		case (Commands::revolver):
			map.hero.selected_Weapon = Weapon::RoboticRevolver;
			return "Вы взяли в руки револьвер! Теперь вы гроза Дикого Запада!";
			break;
		case (Commands::hit):
			if (is_battle_mode) {
				if (map.hero.selected_Weapon == Weapon::CryoKnife) {
					if (command.second.empty()) {
						return "Цель не указана. Выберите противника.";
					} else {
						bool check_of_presence = true;
						for (const string& object : command.second) {
							for (const auto& monster : monsters_in_room) {
								if (object == getMonsterType(monster->type) || object == getMonsterMarker(monster->mark)) {
									monster->HP -= map.weapon_damage.cryoknife;
									hero_info = "Проводим атаку крионожом!";
									check_of_presence = false;
								}
							}
						}
						if (check_of_presence == true) {
							return "Ошибка ввода цели - в списке нет подходящей.";
						}
					}
				} else {
					return "Нож не экипирован.";
				}
			} else {
				return "Поблизости нет врагов.";
			}
			break;
		case (Commands::shoot):
			if (is_battle_mode) {
				if (map.hero.selected_Weapon == Weapon::RoboticRevolver) {
					if (command.second.empty()) {
						return "Цель не указана. Выберите противника.";
					} else {
						bool check_of_presence = true;
						for (const string& object : command.second) {
							for (const auto& monster : monsters_in_room) {
								if (object == getMonsterType(monster->type) || object == getMonsterMarker(monster->mark)) {
									monster->HP -= map.weapon_damage.robotic_revolver;
									hero_info = "Стреляем из роботизированного револьвера!";
									check_of_presence = false;
								}
							}
						}
						if (check_of_presence == true) {
							return "Ошибка ввода цели - в списке нет подходящей.";
						}
					}
				} else {
					return "Револьвер не экипирован.";
				}
			} else {
				return "Поблизости нет врагов.";
			}
			break;
		case (Commands::wait):
			battle_info = "Пропускаем ход.";
			break;
		case (Commands::forward):
			std::cout << "Команда в разработке!" << std::endl;
			break;
		case (Commands::backward):
			std::cout << "Команда в разработке!" << std::endl;
			break;
	}

	// Проверяем наличие монстров в новой локации после перемещения:
	// есть - печатаем список, нет - не печатаем.
	monsters_in_room = getMonstersInRoom(map);
	is_battle_mode = monsters_in_room.size();

	// ПОКА НЕПОНЯТНО КАК ТОЧНО ДОЛЖНА РАБОТАТЬ processBattle() 
	if (is_battle_mode == true) {
		battle_info = processBattle(map.hero, monsters_in_room);
	}

	mosters_info = updateMonstersMovement(map);

	std::string output = location_info + hero_info + battle_info + mosters_info;

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

	map.hero.HP = 100;
	map.hero.energy = 40;
	map.hero.selected_Weapon = Weapon::BareFists;

	cout << map.game_start_room->short_desc << ' ' << map.game_start_room->long_desc << endl;

	std::string user_inpout;
	std::string game_output;
	bool game_continue = true;

	while (game_continue) {
		cout << "Введеите команду: ";
		getline(cin, user_inpout);
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