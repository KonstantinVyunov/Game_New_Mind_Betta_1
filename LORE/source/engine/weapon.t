// ��������� ������ ��� �������
#pragma C++

class Weapon : fixeditem
   isListed = true
   _bullets = 0 //������� ��������
   shortdesc = '������'
   isCloseCombat = nil
   verDoTake(actor) = {self.verDoSelect(actor);}
   doTake(actor) = {self.doSelect(actor);}
   verDoSelect(actor) = {if (actor.sel_weapon == self) "��� ������ ��� �������!";}
   doSelect(actor) = {
      actor.sel_weapon = self;
      "����� ������: <<self.sdesc>>";
   }
   verIoShootWith(actor) = {} //��������� ����������� � thing
   shoot_desc = '���������� ��' //�� 
   shoot_sound = [] //����� ���������
//public:
   /*int*/ calcHit(/*int*/D)={return 0;}   
;

//������-�������� ��� ���������� ���������� � ���������
MonsterStubWeapon : Weapon
;
  
#pragma C-