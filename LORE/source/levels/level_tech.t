////////////////////////////////

healAndMoveToLoc : function(mon,loc)
{
   //лечим
   mon._hp=mon._max_hp;
   //переносим
   mon.travelTo(loc);
}

cheatPoligon: deepverb
	verb = 'полигонмонстров'
	sdesc = "полигонмонстров"
    action(actor) =
	{
       "<br>Перенос на полигон с монстрами! Идёт подготовка.<br>";
       //Отключаем все машины состояний
       shnekoMachine.unregister;
       edgeMachine.unregister;
       hotelMachine.unregister;
       aquaMachine.unregister;
       //Переносим и оздоравливаем монстров
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
       
       //Настраиваем себя и оружие
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
   sdesc="Техно коридор"
   _field_size = 2
   lit_desc = 'В этом коридоре можно отработать применение оружия и тактику. Декораций нет, триггеров на монстрах тоже. Двигаться можно далее на север (на юг обратно). Чем дальше, тем сложнее монстры. В следующем коридоре на севере столик и три ремонтника. На юге банда царских стрелков.'
   north = tech_room_1
   south = tech_room_10
;

tech_room_1: room
   sdesc="Три ремонтника и столик"
   lit_desc = 'Ранее - начало техно коридора. Далее - три огневика. '
   south = tech_room_start
   north = tech_room_2
;

tech_room_2: room
   sdesc="Три огневика"
   lit_desc = 'Ранее - ремонтники со столиком. Далее - стрелок, штурмовик и два огневика. '
   south = tech_room_1
   north = tech_room_3
;

tech_room_3: room
   sdesc="Стрелок, штурмовик и огневики"
   lit_desc = 'Ранее - три огневика. Далее - призрачная дама. '
   south = tech_room_2
   north = tech_room_4
;

tech_room_4: room
   sdesc="Призрачная дама"
   lit_desc = 'Ранее - стрелок, штурмовик и огневики. Далее - два царских стрелка и три огневика. '
   south = tech_room_3
   north = tech_room_5
;

tech_room_5: room
   sdesc="Царские стрелки и огневики"
   lit_desc = 'Ранее - призрачная дама. Далее - чужой. '
   south = tech_room_4
   north = tech_room_6
;

tech_room_6: room
   sdesc="Чужой"
   lit_desc = 'Ранее - царские стрелки с огневиками. Далее - шварц и сталлоне. '
   south = tech_room_5
   north = tech_room_7
;

tech_room_7: room
   sdesc="Шварц и сталлоне"
   lit_desc = 'Ранее - чужой. Далее - рыбы. '
   south = tech_room_6
   north = tech_room_8
;

tech_room_8: room
   sdesc="Рыбы"
   lit_desc = 'Ранее - шварц и сталлоне. Далее - пылесос. '
   south = tech_room_7
   north = tech_room_9
;

tech_room_9: room
   sdesc="Робот-пылесос"
   lit_desc = 'Ранее - рыбы. Далее - начальство с флаера. '
   south = tech_room_8
   north = tech_room_10
;

tech_room_10: room
   sdesc="Начальство"
   lit_desc = 'Ранее - робот-пылесос. Далее - начальная комната. '
   south = tech_room_9
   north = tech_room_start
;