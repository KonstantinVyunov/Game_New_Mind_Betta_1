//������ ������ �������� � ����
//������ ��������� ����������� ��� ������!
#pragma C++


//enum CraftItemType {
#define CRAFT_TYPE_REVOLVER   1
#define CRAFT_TYPE_SHOTGUN    2
#define CRAFT_TYPE_LASER      3
#define CRAFT_TYPE_MED_TUBE   4
#define CRAFT_TYPE_KNIFE_JUMP 5
#define CRAFT_TYPE_KNIFE_RET  6
#define CRAFT_TYPE_KRIO_ABSORB 7
#define CRAFT_TYPE_KRIO_WALL  8
#define CRAFT_TYPE_DROP_POIS  9
#define CRAFT_TYPE_MIND  10
#define CRAFT_TYPE_PARAL  11
#define CRAFT_TYPE_DUP  12
//}

//������������� ������, ����� ��� ������� � �������������
class SyntesisItem : fixeditem
   craft_id = -1
;

HealthTube : SyntesisItem
  craft_id = CRAFT_TYPE_MED_TUBE
  isEquivalent = true
  desc = '�����/1�'
  noun = '�����/1�'
  pluraldesc = "������"
  rpluraldesc = "�������"
  isHim=true
  healVal = 30
  ldesc = "����������� �������������� ����� � ���������� ��� ���������� ��������� <<self.healVal>> ������ ��������. �������� � ���� ���������� �������� � ������������� �����."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     Me._hp += self.healVal;
     if (Me._hp > 100) Me._hp = 100;
     "�������� ���������.";
     Statist.SaveUseHeal(self.healVal);
     delete self;
  }
;


KnifeSpeeder : SyntesisItem
  craft_id = CRAFT_TYPE_KNIFE_JUMP
  isEquivalent = true
  desc = '��������������/1�'
  noun = '��������������/1�'
  pluraldesc = "��������������"
  rpluraldesc = "���������������"
  isHim=true
  ldesc = "�������������� ��������� �������� � ���������� � ������� ����, ����������. ��� ����� ���������� ��������� � ��� ������� � ����� � ���� ��� �����. "
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboKnifeJump.isIn(Me))
     {
         "�������������� �������.";
         ComboKnifeJump.moveInto(Me);
         delete self;
     }
     else "������ ������������ ������ ����� �� ������!";
  }
;


KnifeThrower : SyntesisItem
  craft_id = CRAFT_TYPE_KNIFE_RET
  isEquivalent = true
  desc = '������������/1�'
  noun = '������������/1�'
  pluraldesc = "�������������"
  rpluraldesc = "��������������"
  isHim=true
  ldesc = "������������ ��������� ������� ��� � ����� �������� ����������, ��� ���������� �������������. ������� �� 5 �������."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboKnifeThrow.isIn(Me))
     {
         "������������ �����������.";
         //���� ��� ���� ��������, �� ���������
         if (ComboKnifeThrow._numActLeft<5) ComboKnifeThrow._numActLeft += 5;
         else ComboKnifeThrow._numActLeft = 5;
         ComboKnifeThrow.moveInto(Me);
         delete self;
     }
     else "������ ������������ ������ ����� �� ������!";
  }
;


KrioAbsorber : SyntesisItem
  craft_id = CRAFT_TYPE_KRIO_ABSORB
  isEquivalent = true
  desc = '�����������/1�'
  noun = '�����������/1�'
  pluraldesc = "�����������"
  rpluraldesc = "������������"
  isHim=true
  ldesc = "����������� �������� �������������� ��������� ������. ������, ����� �� ��������, ��� ���� ������� �������. ����������� ���������� �� ������ ��� �������������� � ��������."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboKrioAbsorb.isIn(Me))
     {
         "����������� �������.";
         ComboKrioAbsorb.moveInto(Me);
         delete self;
     }
     else "������ ������������ ������ ����� �� ������!";
  }
;


KrioWallItem : SyntesisItem
  craft_id = CRAFT_TYPE_KRIO_WALL
  isEquivalent = true
  desc = '���������/1�'
  noun = '���������/1�'
  pluraldesc = "���������"
  rpluraldesc = "��������"
  isHer=true
  ldesc = "��������� ���������� �� ��� �����, ��� �� ������. ��� ��������� �� ���������� ����� ���������."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
      local wall = new KrioWall;
      wall._hp = wall._max_hp;
      wall.travelTo(actor.location);
      wall._pos = actor.location._pl_pos;
      "�� ����� ������� ������� �����, ���������� ����������. ";
      delete self;
  }
;


PoisenItem : SyntesisItem
  craft_id = CRAFT_TYPE_DROP_POIS
  isEquivalent = true
  desc = '��/1�'
  noun = '��/1�'
  pluraldesc = "���"
  rpluraldesc = "����"
  isHim=true
  ldesc = "�� � �������. ��� �������� �� �������� ������� �������� ����� ����������� �� ������."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboPoisenShot.isIn(Me))
     {
         "������� ��� ���������� � �������.";
         ComboPoisenShot.moveInto(Me);
         delete self;
     }
     else "������ ���������� ������ ����� �� �������!";
  }
;


MindItem : SyntesisItem
  craft_id = CRAFT_TYPE_MIND
  isEquivalent = true
  desc = '����������/1�'
  noun = '����������/1�'
  pluraldesc = "�����������"
  rpluraldesc = "������������"
  isHim=true
  ldesc = "���������� - ������� ��� ������������� ����������. ��� �������� �� �������� ������ ����� � �������� �������� �� ����� � ������� 5-� �����."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboMindShot.isIn(Me))
     {
         "������� ����������� ���������� � �������.";
         ComboMindShot.moveInto(Me);
         delete self;
     }
     else "������ ���������� ������ ����� �� �������!";
  }
;


ParalizeItem : SyntesisItem
  craft_id = CRAFT_TYPE_PARAL
  isEquivalent = true
  desc = '��������/1�'
  noun = '��������/1�'
  pluraldesc = "��������"
  rpluraldesc = "��������"
  isHer=true
  ldesc = "�������� - ������� ��� ��������� ����� ����������. ��� �������� �� �������� ������ �� ����� �������� � ������� 3-� �����."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboParalizeShot.isIn(Me))
     {
         "������� �������� ���������� � �������.";
         ComboParalizeShot.moveInto(Me);
         delete self;
     }
     else "������ ���������� ������ ����� �� �������!";
  }
;


DuplicateItem : SyntesisItem
  craft_id = CRAFT_TYPE_DUP
  isEquivalent = true
  desc = '�����/1�'
  noun = '�����/1�'
  pluraldesc = "�����"
  rpluraldesc = "�����"
  isHer=true
  ldesc = "����� ��������. ��� �������� �� �������� ����� � ����� ���������� �������� ��������, ����������� ���������."
  isListed = true
  verDoUse(actor) = {}
  doUse(actor)={
     if (!ComboDuplicate.isIn(Me))
     {
         "������� ����� ���������� � �������.";
         ComboDuplicate.moveInto(Me);
         delete self;
     }
     else "������ ���������� ������ ����� �� �������!";
  }
;


#pragma C-