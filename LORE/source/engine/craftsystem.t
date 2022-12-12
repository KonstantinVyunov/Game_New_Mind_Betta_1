// Интерфейс движка для боевика
#pragma C++

#define CRAFT_TYPE_MAX    100 //Предельно число элементов крафта


customPreCraft : function()
{
  //Тут своя обработка для синтеза
}

CraftSystem : object
   //Начать крафтить!
   was_first_craft = nil
   /*void*/startCraft = {
    local i;
    local crDesc;
    local rawResp;
    local cost, costCry,costAl,costSeli;
    local maxCraft = self.totalCraftItems;
    
    if (self.was_first_craft == nil)
    {
       "<i>Вас приветствует интегрированная подсистема синтеза! Для вашего удобства работа с ней идёт в режиме диалога. Сначала выдаётся статистика по имеющимся у вас ресурсам. Выберите подходящий элемент и введите количество, синтезатор выдаст вам готовый продукт. Вы всегда сможете узнать подробнее про каждый элемент, просто выберите номер и перейдите в справку. Удачного пользования!</i><br>";
       self.was_first_craft = true;
    }
    
    customPreCraft();
    
    while (true)
    {
        local resp;
        local resp2;
        local max_pay_num;
        "<br>Имеется: кристаллов энергии(Э)-<<ResourceSystem.crystals>>, пласталь(П)-<<ResourceSystem.aluminium>>, кремний(К)-<<ResourceSystem.selicon>><br>Выберите номер позиции для синтеза:<br>\t0 - выход<br>";
        for (i=1;i<=maxCraft;i++)
        {
           crDesc = self.CraftDesc(i);
           cost = self.CraftCost(i);
           costCry = cost[1];
           costAl = cost[2];
           costSeli = cost[3];
           if (self.isCraftEnabled(i)) "\t<<i>> - <<crDesc>> (Э-<<costCry>>, П-<<costAl>>, К-<<costSeli>>)<br>";
        }
    
        "<br>>";
        resp = cvtnum(input());
        if ( (resp >= 0) && (resp <= maxCraft) && (self.isCraftEnabled(resp)) )
        {
           if (resp == 0)
           {
              "Сеанс окончен.";
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
                 "Недостаточно ресурсов для покупки. Справка по элементу: <br>";
                 say(self.CraftFullDesc(resp));
                 "<br><br>";
              }
              else
              {
                "Введите количество, максимум <<max_pay_num>>, для справки по элементу, введите символ \"?\": <br>";
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
                  "Неправильное количество. Попробуйте еще раз.";
                }
              }
           }
        }
        else
        {
           "Некорректный ввод. Введите число от 0 до <<maxCraft>> из разрешенных полей.";
        }
    }
    
  }
  //Разрешаем крафт определённого типа
  /*void*/enableCraft(/*CraftItemType*/tp) = {
     if (find(self._craft_list, tp) == nil)
     {
       _craft_list += [tp];
     }
  }
  //private:
  //Определяем, доступен крафт или нет
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