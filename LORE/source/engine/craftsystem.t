// ��������� ������ ��� �������
#pragma C++

#define CRAFT_TYPE_MAX    100 //��������� ����� ��������� ������


customPreCraft : function()
{
  //��� ���� ��������� ��� �������
}

CraftSystem : object
   //������ ��������!
   was_first_craft = nil
   /*void*/startCraft = {
    local i;
    local crDesc;
    local rawResp;
    local cost, costCry,costAl,costSeli;
    local maxCraft = self.totalCraftItems;
    
    if (self.was_first_craft == nil)
    {
       "<i>��� ������������ ��������������� ���������� �������! ��� ������ �������� ������ � ��� ��� � ������ �������. ������� ������� ���������� �� ��������� � ��� ��������. �������� ���������� ������� � ������� ����������, ���������� ������ ��� ������� �������. �� ������ ������� ������ ��������� ��� ������ �������, ������ �������� ����� � ��������� � �������. �������� �����������!</i><br>";
       self.was_first_craft = true;
    }
    
    customPreCraft();
    
    while (true)
    {
        local resp;
        local resp2;
        local max_pay_num;
        "<br>�������: ���������� �������(�)-<<ResourceSystem.crystals>>, ��������(�)-<<ResourceSystem.aluminium>>, �������(�)-<<ResourceSystem.selicon>><br>�������� ����� ������� ��� �������:<br>\t0 - �����<br>";
        for (i=1;i<=maxCraft;i++)
        {
           crDesc = self.CraftDesc(i);
           cost = self.CraftCost(i);
           costCry = cost[1];
           costAl = cost[2];
           costSeli = cost[3];
           if (self.isCraftEnabled(i)) "\t<<i>> - <<crDesc>> (�-<<costCry>>, �-<<costAl>>, �-<<costSeli>>)<br>";
        }
    
        "<br>>";
        resp = cvtnum(input());
        if ( (resp >= 0) && (resp <= maxCraft) && (self.isCraftEnabled(resp)) )
        {
           if (resp == 0)
           {
              "����� �������.";
              return;
           }
           else
           {
              cost = self.CraftCost(resp);
              costCry = cost[1];
              costAl = cost[2];
              costSeli = cost[3];
              max_pay_num = self.MaxPayNumber(costCry,costAl,costSeli);
              if (max_pay_num == 0) {
                 "������������ �������� ��� �������. ������� �� ��������: <br>";
                 say(self.CraftFullDesc(resp));
                 "<br><br>";
              }
              else
              {
                "������� ����������, �������� <<max_pay_num>>, ��� ������� �� ��������, ������� ������ \"?\": <br>";
                ">";
                rawResp = input();
                resp2 = cvtnum(rawResp);
                if (rawResp == '?')
                {
                  "<br>";
                  say(self.CraftFullDesc(resp));
                  "<br><br>";
                }
                else if ( (resp2 > 0) && (resp2 <= max_pay_num) )
                {
                   self.PayFor(resp,resp2);
                }
                else {
                  "������������ ����������. ���������� ��� ���.";
                }
              }
           }
        }
        else
        {
           "������������ ����. ������� ����� �� 0 �� <<maxCraft>> �� ����������� �����.";
        }
    }
    
  }
  //��������� ����� ������������ ����
  /*void*/enableCraft(/*CraftItemType*/tp) = {
     if (find(self._craft_list, tp) == nil)
     {
       _craft_list += [tp];
     }
  }
  //private:
  //����������, �������� ����� ��� ���
  /*bool*/ isCraftEnabled(/*CraftItemType*/tp) = {
     if (tp==0) return true;
     return (find(self._craft_list, tp) != nil);
  }
  /*int*/ totalCraftItems = {
     local i;
     for (i=1;i<=CRAFT_TYPE_MAX;i++)
        if (self.CraftDesc(i) == '') return i-1;
        
     return CRAFT_TYPE_MAX;
  }
  
  /*int*/MaxPayNumber(cry, al, sil) = {
      local max_by_cry = 20;
      local max_by_al = 20;
      local max_by_sil = 20;
      
      if (cry>0) max_by_cry = ResourceSystem.crystals / cry;
      if (al>0) max_by_al = ResourceSystem.aluminium / al;
      if (sil>0) max_by_sil = ResourceSystem.selicon / sil;
      
      if (max_by_cry <= max_by_al && max_by_cry <= max_by_sil) return max_by_cry;
      else if (max_by_al <= max_by_cry && max_by_al <= max_by_sil) return max_by_al;
      return max_by_sil;
   }
  
  _craft_list = []
;

#pragma C-