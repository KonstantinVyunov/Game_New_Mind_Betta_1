// Интерфейс статиста
#pragma C++

modify thing
   doInspect(actor) =
   {
      if (find(Statist.vis_list,self))
      {
         Statist.vis_list -= [self];
         Statist.vis_curr += 1;
      }
      self.ldesc;
   }
;

//Конвертация числа в шестнадцатеричный вид для 2-хбайтных значений
dec2hex2byte : function(val)
{
  local hi, lo;
  local dict = '0123456789ABCDEF';
  local str_res;
  if (val<0) val = -val;
  if (val > 255) val = 255; //защита от ошибки
  hi = val/16;
  lo = val%16;
  str_res = substr(dict,hi+1,1) + substr(dict,lo+1,1);
  return str_res;
}

Statist : object
  //public:
  vis_list = [] //список объектов, которые необходимо увидеть
  vis_max = 0
  vis_curr = 0
  //Подготовка уровня
  /*void*/ Prepare(new_item_list) = {
     self.vis_list = new_item_list;
     self.vis_max = length(new_item_list);
     self.vis_curr = 0;
     
     self._alum=0;
     self._crystal=0;
     self._selicon = 0;
     
     self._nhit = 0;
     self._nhit_indir = 0;
     self._score_kills = 0;
     self._anti_score_heal = 0;
  }
  /*void*/ Show(lvl_num) = {
    local lvl_score = 0;
    local discover_perc = 0;
    local lev_letter = '';
    if (lvl_num==1) lev_letter = 'C';
    else if (lvl_num==2) lev_letter = 'L';
    else if (lvl_num==3) lev_letter = 'D';
    else if (lvl_num==4) lev_letter = 'X';
    "<br>НАЧАЛО СТАТИСТИКИ<br>";
    "<b>Статистика по уровню <<lvl_num>>: </b><br>";
    if (global.is_easy) "Сложность: лёгкая<br>";
    else "Сложность: нормальная<br>";
    if ( (self.vis_curr == 0) || (self.vis_max==0) ) "Исследовано деталей уровня: 0%<br>";
    else {
       discover_perc = (self.vis_curr*100)/self.vis_max;
       "Исследовано деталей уровня: <<discover_perc>>%<br>";
    }
    "Собрано кристаллов: <<self._crystal>>, пластали:<<self._alum>>, кремния:<<self._selicon>><br>";
    "Прямого урона в бою: <<self._nhit>><br>";
    "Косвенного урона в бою: <<self._nhit_indir>><br>";
    "Очков за битву: <<self._score_kills>><br>";
    "Штраф за лечение: <<self._anti_score_heal>><br>";
    //вычисляем счет уровня (сколько исследовано+очки за убитых+за ресурсы+за косвенный урон-лечилки)
    lvl_score = discover_perc + self._score_kills + self._nhit_indir + self._alum*5 + self._selicon*10 - self._anti_score_heal;
    "Всего ходов (не влияет на очки): <<global.turnsofar>><br>";
    "Счёт за уровень: <<lvl_score>><br>";
    incscore(lvl_score);
    
    "Общий счет игры: <<global.score>><br>";
    if (!global.is_easy)
    {
        local crc_steps = abs(global.turnsofar) % 255;//Кодируем количество ходов
        local crc_steps_coded = dec2hex2byte(crc_steps); //hex-вид
        local crc_total_points = (global.score + 1) % 255;//Кодируем всего очков+1 (для разбежки)
        local crc_total_coded = dec2hex2byte(crc_total_points); //hex-вид
        local crc_details = discover_perc % 255;//Кодируем процент исследований
        local crc_details_coded = dec2hex2byte(crc_details); //hex-вид
        local crc_curr_points = abs(lvl_score) % 255;//Кодируем текущее количество очков
        local crc_points_coded = dec2hex2byte(crc_curr_points); //hex-вид
        "Проверочный номер: <<lev_letter>><<crc_steps_coded>><<crc_total_coded>><<crc_details_coded>><<crc_points_coded>><<lvl_num>><br>";
    }
    "КОНЕЦ СТАТИСТИКИ<br>";
  }
  //Запоминает количество ресурсов
  /*void*/SaveRes(num_alu,num_cry,num_seli) = {
      self._selicon += num_seli;
      self._alum += num_alu;
      self._crystal += num_cry;
  }
  
  /*void*/SaveBattleKill(max_life) = {
     //в 10 р меньше количества жизней у противника
     self._score_kills += max_life/10;
  }
  
  /*void*/SaveUseHeal(heal_val) = {
     //в 3р меньше величины увеличения здоровья
     self._anti_score_heal += heal_val/3;
  }
  
  /*void*/SaveBattleHit(tot_hit,is_direct) = {
     if (is_direct) self._nhit += tot_hit;
     else self._nhit_indir += tot_hit;
  }
  
  //private:
  _alum=0
  _crystal=0
  _selicon = 0
  _nhit = 0
  _nhit_indir = 0
  _score_kills = 0
  _anti_score_heal = 0
;

#pragma C-