// ��������� ��������
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

//����������� ����� � ����������������� ��� ��� 2-�������� ��������
dec2hex2byte : function(val)
{
  local hi, lo;
  local dict = '0123456789ABCDEF';
  local str_res;
  if (val<0) val = -val;
  if (val > 255) val = 255; //������ �� ������
  hi = val/16;
  lo = val%16;
  str_res = substr(dict,hi+1,1) + substr(dict,lo+1,1);
  return str_res;
}

Statist : object
  //public:
  vis_list = [] //������ ��������, ������� ���������� �������
  vis_max = 0
  vis_curr = 0
  //���������� ������
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
    "<br>������ ����������<br>";
    "<b>���������� �� ������ <<lvl_num>>: </b><br>";
    if (global.is_easy) "���������: �����<br>";
    else "���������: ����������<br>";
    if ( (self.vis_curr == 0) || (self.vis_max==0) ) "����������� ������� ������: 0%<br>";
    else {
       discover_perc = (self.vis_curr*100)/self.vis_max;
       "����������� ������� ������: <<discover_perc>>%<br>";
    }
    "������� ����������: <<self._crystal>>, ��������:<<self._alum>>, �������:<<self._selicon>><br>";
    "������� ����� � ���: <<self._nhit>><br>";
    "���������� ����� � ���: <<self._nhit_indir>><br>";
    "����� �� �����: <<self._score_kills>><br>";
    "����� �� �������: <<self._anti_score_heal>><br>";
    //��������� ���� ������ (������� �����������+���� �� ������+�� �������+�� ��������� ����-�������)
    lvl_score = discover_perc + self._score_kills + self._nhit_indir + self._alum*5 + self._selicon*10 - self._anti_score_heal;
    "����� ����� (�� ������ �� ����): <<global.turnsofar>><br>";
    "���� �� �������: <<lvl_score>><br>";
    incscore(lvl_score);
    
    "����� ���� ����: <<global.score>><br>";
    if (!global.is_easy)
    {
        local crc_steps = abs(global.turnsofar) % 255;//�������� ���������� �����
        local crc_steps_coded = dec2hex2byte(crc_steps); //hex-���
        local crc_total_points = (global.score + 1) % 255;//�������� ����� �����+1 (��� ��������)
        local crc_total_coded = dec2hex2byte(crc_total_points); //hex-���
        local crc_details = discover_perc % 255;//�������� ������� ������������
        local crc_details_coded = dec2hex2byte(crc_details); //hex-���
        local crc_curr_points = abs(lvl_score) % 255;//�������� ������� ���������� �����
        local crc_points_coded = dec2hex2byte(crc_curr_points); //hex-���
        "����������� �����: <<lev_letter>><<crc_steps_coded>><<crc_total_coded>><<crc_details_coded>><<crc_points_coded>><<lvl_num>><br>";
    }
    "����� ����������<br>";
  }
  //���������� ���������� ��������
  /*void*/SaveRes(num_alu,num_cry,num_seli) = {
      self._selicon += num_seli;
      self._alum += num_alu;
      self._crystal += num_cry;
  }
  
  /*void*/SaveBattleKill(max_life) = {
     //� 10 � ������ ���������� ������ � ����������
     self._score_kills += max_life/10;
  }
  
  /*void*/SaveUseHeal(heal_val) = {
     //� 3� ������ �������� ���������� ��������
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