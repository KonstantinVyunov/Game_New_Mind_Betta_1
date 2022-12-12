// Интерфейс движка для боевика
#pragma C++

//enum RESOURCE_AMOUNT {
#define RESOURCE_AMOUNT_LOW  0
#define RESOURCE_AMOUNT_MID  1
#define RESOURCE_AMOUNT_HIGH 2
//}
#define ALWAYS_ADD_RES ""

//Элемент, разрушаемый, используется для синтеза
class DestructItem : fixeditem
   //Энергетический элемент
   enegryItem = nil
   //количество энергии при разборке
   enegryGive = 0
   //количество доступных ресурсов
   resAmount = RESOURCE_AMOUNT_LOW
   //всегда видим, когда обнаружили
   isListed = true
   verDoShoot(actor) = {if (HaveMonsters(Me.location)) "Вы не можете разбирать, пока здесь есть враги!"; }
   doShoot(actor) = {
      "Вы разобрали <<self.sdesc>>. ";
      if (self.enegryItem == nil) ResourceSystem.Add(ALWAYS_ADD_RES,self.resAmount);
      else ResourceSystem.GenFromEnemy(self.enegryGive);
      self.moveInto(nil);
   }
;

//Для быстрой загрузки в начале уровня
modify global
  _temp_alum = 0
  _temp_crystal = 0
  _temp_selicon = 0
;

//Сохранить ресурсы в глобальную облать
resourceSaveToGlobal : function()
{
   global._temp_alum = ResourceSystem._alum;
   global._temp_crystal = ResourceSystem._crystal;
   global._temp_selicon = ResourceSystem._selicon;
}

//Загрузить ресурсы из глобальной области в спец класс
resourceLoadFromGlobal : function(global_curr)
{
   ResourceSystem._alum = global_curr._temp_alum;
   ResourceSystem._crystal = global_curr._temp_crystal;
   ResourceSystem._selicon = global_curr._temp_selicon;
}

//Система ресурсов
ResourceSystem : object
  //public:
  aluminium() = {return self._alum;}   //пласталь
  crystals() = {return self._crystal;} //кристаллы энергии
  selicon() = {return self._selicon;}  //кремний
  //генерировать кристаллы из врага
  /*void*/GenFromEnemy(num) = {
       if (num>0) {
           "<font color='green'><b>Синтезировано <<num>> кристаллов энергии!</b></font><br>";
           self._crystal+=num;
           Statist.SaveRes(0,num,0);
       }
  }
  /*void*/ HaveId(/*string*/id) = {
    return (find(self._added_list, id) != nil);
  }
  //Добавляет ресурсы через генератор, с определённым id, чтобы не повторялось
  /*void*/ Add(/*string*/id,/*RESOURCE_AMOUNT*/amount) = {
    local num_alu;
    local num_seli;
    local i, obj;

    //Только если уже не добавили данный ресурс или он добавляется всегда
    if ((id == ALWAYS_ADD_RES) || (find(self._added_list, id) == nil))
    {
       local diff_coef = 1;
       //Для лёгкого уровня увеличиваем коэффициент при разборе
       if (global.is_easy==true) diff_coef = 2;

       self._added_list += [id];
       if (amount == RESOURCE_AMOUNT_LOW)
       {
          num_alu = rangernd_no_complex(2,4)*diff_coef;
          num_seli = rangernd_no_complex(2,3)*diff_coef;
       }
       else if (amount == RESOURCE_AMOUNT_MID)
       {
          num_alu = rangernd_no_complex(4,9)*diff_coef;
          num_seli = rangernd_no_complex(3,5)*diff_coef;
       }
       else if (amount == RESOURCE_AMOUNT_HIGH)
       {
          num_alu = rangernd_no_complex(8,16)*diff_coef;
          num_seli = rangernd_no_complex(5,10)*diff_coef;
       }
       
       "<font color='green'>Собрано пластали: <<num_alu>>, кремния: <<num_seli>></font><br>";
       self._selicon += num_seli;
       self._alum += num_alu;
       Statist.SaveRes(num_alu,0,num_seli);
    }
  }
  //Оплатить. Возвращает true, если сделака прошла, nil в противном случае
  /*bool*/Pay(num_alu,num_cry,num_seli) = {
    if ( (num_alu <= self._alum) && (num_cry <= self._crystal) && (num_seli <= self._selicon) )
    {
       self._selicon -= num_seli;
       self._alum -= num_alu;
       self._crystal -= num_cry;
       return true;
    }
    return nil;
  }
  //private:
  _alum=0
  _crystal=0
  _selicon = 0
  _added_list = []
;

#pragma C-