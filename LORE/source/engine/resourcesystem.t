// ��������� ������ ��� �������
#pragma C++

//enum RESOURCE_AMOUNT {
#define RESOURCE_AMOUNT_LOW  0
#define RESOURCE_AMOUNT_MID  1
#define RESOURCE_AMOUNT_HIGH 2
//}
#define ALWAYS_ADD_RES ""

//�������, �����������, ������������ ��� �������
class DestructItem : fixeditem
   //�������������� �������
   enegryItem = nil
   //���������� ������� ��� ��������
   enegryGive = 0
   //���������� ��������� ��������
   resAmount = RESOURCE_AMOUNT_LOW
   //������ �����, ����� ����������
   isListed = true
   verDoShoot(actor) = {if (HaveMonsters(Me.location)) "�� �� ������ ���������, ���� ����� ���� �����!"; }
   doShoot(actor) = {
      "�� ��������� <<self.sdesc>>. ";
      if (self.enegryItem == nil) ResourceSystem.Add(ALWAYS_ADD_RES,self.resAmount);
      else ResourceSystem.GenFromEnemy(self.enegryGive);
      self.moveInto(nil);
   }
;

//��� ������� �������� � ������ ������
modify global
  _temp_alum = 0
  _temp_crystal = 0
  _temp_selicon = 0
;

//��������� ������� � ���������� ������
resourceSaveToGlobal : function()
{
   global._temp_alum = ResourceSystem._alum;
   global._temp_crystal = ResourceSystem._crystal;
   global._temp_selicon = ResourceSystem._selicon;
}

//��������� ������� �� ���������� ������� � ���� �����
resourceLoadFromGlobal : function(global_curr)
{
   ResourceSystem._alum = global_curr._temp_alum;
   ResourceSystem._crystal = global_curr._temp_crystal;
   ResourceSystem._selicon = global_curr._temp_selicon;
}

//������� ��������
ResourceSystem : object
  //public:
  aluminium() = {return self._alum;}   //��������
  crystals() = {return self._crystal;} //��������� �������
  selicon() = {return self._selicon;}  //�������
  //������������ ��������� �� �����
  /*void*/GenFromEnemy(num) = {
       if (num>0) {
           "<font color='green'><b>������������� <<num>> ���������� �������!</b></font><br>";
           self._crystal+=num;
           Statist.SaveRes(0,num,0);
       }
  }
  /*void*/ HaveId(/*string*/id) = {
    return (find(self._added_list, id) != nil);
  }
  //��������� ������� ����� ���������, � ����������� id, ����� �� �����������
  /*void*/ Add(/*string*/id,/*RESOURCE_AMOUNT*/amount) = {
    local num_alu;
    local num_seli;
    local i, obj;

    //������ ���� ��� �� �������� ������ ������ ��� �� ����������� ������
    if ((id == ALWAYS_ADD_RES) || (find(self._added_list, id) == nil))
    {
       local diff_coef = 1;
       //��� ������ ������ ����������� ����������� ��� �������
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
       
       "<font color='green'>������� ��������: <<num_alu>>, �������: <<num_seli>></font><br>";
       self._selicon += num_seli;
       self._alum += num_alu;
       Statist.SaveRes(num_alu,0,num_seli);
    }
  }
  //��������. ���������� true, ���� ������� ������, nil � ��������� ������
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