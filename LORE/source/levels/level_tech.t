////////////////////////////////

healAndMoveToLoc : function(mon,loc)
{
   //�����
   mon._hp=mon._max_hp;
   //���������
   mon.travelTo(loc);
}

cheatPoligon: deepverb
	verb = '���������������'
	sdesc = "���������������"
    action(actor) =
	{
       "<br>������� �� ������� � ���������! ��� ����������.<br>";
       //��������� ��� ������ ���������
       shnekoMachine.unregister;
       edgeMachine.unregister;
       hotelMachine.unregister;
       aquaMachine.unregister;
       //��������� � ������������� ��������
       healAndMoveToLoc(fixer1,tech_room_1);
       healAndMoveToLoc(fixer2,tech_room_1);
       healAndMoveToLoc(fixer3,tech_room_1);
       healAndMoveToLoc(table_seccont_mon,tech_room_1);
       
       healAndMoveToLoc(mon1,tech_room_2);
       healAndMoveToLoc(mon2,tech_room_2);
       healAndMoveToLoc(mon3,tech_room_2);
       
       healAndMoveToLoc(mon4,tech_room_3);
       healAndMoveToLoc(mon5,tech_room_3);
       healAndMoveToLoc(mon_roofelevator2,tech_room_3);
       healAndMoveToLoc(fire_mon_hunt1,tech_room_3);
       
       healAndMoveToLoc(LifterLady,tech_room_4);
       
       healAndMoveToLoc(king_mon_1,tech_room_5);
       healAndMoveToLoc(king_mon_2,tech_room_5);
       healAndMoveToLoc(fire_mon_hunt7,tech_room_5);
       healAndMoveToLoc(fire_mon_hunt8,tech_room_5);
       
       healAndMoveToLoc(Alien,tech_room_6);
       
       healAndMoveToLoc(shwartzMonster,tech_room_7);
       healAndMoveToLoc(stalloneMonster,tech_room_7);
       
       healAndMoveToLoc(fishUdilshik,tech_room_8);
       healAndMoveToLoc(plashShark,tech_room_8);
       
       healAndMoveToLoc(DustKiller,tech_room_9);
       
       healAndMoveToLoc(king_mon_1,tech_room_10);
       healAndMoveToLoc(king_mon_2,tech_room_10);
       healAndMoveToLoc(king_mon_3,tech_room_10);
       healAndMoveToLoc(king_mon_4,tech_room_10);
       healAndMoveToLoc(king_mon_5,tech_room_10);
       //healAndMoveToLoc(king_mon_6,tech_room_10);
       //healAndMoveToLoc(king_mon_7,tech_room_10);
       //healAndMoveToLoc(king_mon_8,tech_room_10);
       //healAndMoveToLoc(king_mon_9,tech_room_10);
       //healAndMoveToLoc(king_mon_10,tech_room_10);
       
       //����������� ���� � ������
       NoneWeapon.moveInto(nil);
       Knife.moveInto(Me);
       Pistol.moveInto(Me);
       Drobovik.moveInto(Me);
       TorsionGenerator.moveInto(Me);
       CraftSystem.enableCraft(CRAFT_TYPE_MED_TUBE);
       CraftSystem.enableCraft(CRAFT_TYPE_REVOLVER);
       CraftSystem.enableCraft(CRAFT_TYPE_SHOTGUN);
       CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_JUMP);
       CraftSystem.enableCraft(CRAFT_TYPE_KNIFE_RET);
       CraftSystem.enableCraft(CRAFT_TYPE_KRIO_ABSORB);
       CraftSystem.enableCraft(CRAFT_TYPE_KRIO_WALL);
       CraftSystem.enableCraft(CRAFT_TYPE_DROP_POIS);
       CraftSystem.enableCraft(CRAFT_TYPE_MIND);
       CraftSystem.enableCraft(CRAFT_TYPE_PARAL);
       CraftSystem.enableCraft(CRAFT_TYPE_DUP);
       
       ResourceSystem._alum = 1000;
       ResourceSystem._crystal = 1000;
       ResourceSystem._selicon = 1000;
       
       Me.sel_weapon = Knife;
       Me.travelTo(tech_room_start);
    }
;


tech_room_start: room
   sdesc="����� �������"
   _field_size = 2
   lit_desc = '� ���� �������� ����� ���������� ���������� ������ � �������. ��������� ���, ��������� �� �������� ����. ��������� ����� ����� �� ����� (�� �� �������). ��� ������, ��� ������� �������. � ��������� �������� �� ������ ������ � ��� ����������. �� ��� ����� ������� ��������.'
   north = tech_room_1
   south = tech_room_10
;

tech_room_1: room
   sdesc="��� ���������� � ������"
   lit_desc = '����� - ������ ����� ��������. ����� - ��� ��������. '
   south = tech_room_start
   north = tech_room_2
;

tech_room_2: room
   sdesc="��� ��������"
   lit_desc = '����� - ���������� �� ��������. ����� - �������, ��������� � ��� ��������. '
   south = tech_room_1
   north = tech_room_3
;

tech_room_3: room
   sdesc="�������, ��������� � ��������"
   lit_desc = '����� - ��� ��������. ����� - ���������� ����. '
   south = tech_room_2
   north = tech_room_4
;

tech_room_4: room
   sdesc="���������� ����"
   lit_desc = '����� - �������, ��������� � ��������. ����� - ��� ������� ������� � ��� ��������. '
   south = tech_room_3
   north = tech_room_5
;

tech_room_5: room
   sdesc="������� ������� � ��������"
   lit_desc = '����� - ���������� ����. ����� - �����. '
   south = tech_room_4
   north = tech_room_6
;

tech_room_6: room
   sdesc="�����"
   lit_desc = '����� - ������� ������� � ����������. ����� - ����� � ��������. '
   south = tech_room_5
   north = tech_room_7
;

tech_room_7: room
   sdesc="����� � ��������"
   lit_desc = '����� - �����. ����� - ����. '
   south = tech_room_6
   north = tech_room_8
;

tech_room_8: room
   sdesc="����"
   lit_desc = '����� - ����� � ��������. ����� - �������. '
   south = tech_room_7
   north = tech_room_9
;

tech_room_9: room
   sdesc="�����-�������"
   lit_desc = '����� - ����. ����� - ���������� � ������. '
   south = tech_room_8
   north = tech_room_10
;

tech_room_10: room
   sdesc="����������"
   lit_desc = '����� - �����-�������. ����� - ��������� �������. '
   south = tech_room_9
   north = tech_room_start
;