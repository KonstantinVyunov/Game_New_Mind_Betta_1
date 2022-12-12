// лассы боевых объектов в игре
#pragma C++


modify CraftSystem
  //////// ƒобавл€етс€ дл€ нового оружи€ /////////////// 
   
  /*string*/CraftDesc(/*CraftItemType*/tp) = {
      local desc_str = '';
      switch(tp)
      {
         case CRAFT_TYPE_REVOLVER:   desc_str = 'патроны дл€ револьвера'; break;
         case CRAFT_TYPE_SHOTGUN:    desc_str = 'патроны дл€ дробовика'; break;
         case CRAFT_TYPE_LASER:      desc_str = 'батаре€ к ондул€тору'; break;
         case CRAFT_TYPE_MED_TUBE:   desc_str = dToS(HealthTube,&sdesc); break;
         case CRAFT_TYPE_KNIFE_JUMP: desc_str = dToS(KnifeSpeeder,&sdesc); break;
         case CRAFT_TYPE_KNIFE_RET:   desc_str = dToS(KnifeThrower,&sdesc); break;
         case CRAFT_TYPE_KRIO_ABSORB: desc_str = dToS(KrioAbsorber,&sdesc); break;
         case CRAFT_TYPE_KRIO_WALL: desc_str = dToS(KrioWallItem,&sdesc); break;
         case CRAFT_TYPE_DROP_POIS: desc_str = dToS(PoisenItem,&sdesc); break;
         case CRAFT_TYPE_MIND: desc_str = dToS(MindItem,&sdesc); break;
         case CRAFT_TYPE_PARAL: desc_str = dToS(ParalizeItem,&sdesc); break;
         case CRAFT_TYPE_DUP: desc_str = dToS(DuplicateItem,&sdesc); break;
      }
      return desc_str;
   }
   
    /*string*/CraftFullDesc(/*CraftItemType*/tp) = {
      local desc_str = '';
      switch(tp)
      {
         case CRAFT_TYPE_REVOLVER:   desc_str = 'пополн€емый боезапас дл€ соответствующего оружи€'; break;
         case CRAFT_TYPE_SHOTGUN:    desc_str = 'пополн€емый боезапас дл€ соответствующего оружи€'; break;
         case CRAFT_TYPE_LASER:      desc_str = 'пополн€емый боезапас дл€ соответствующего оружи€'; break;
         case CRAFT_TYPE_MED_TUBE:   desc_str = dToS(HealthTube,&ldesc); break;
         case CRAFT_TYPE_KNIFE_JUMP: desc_str = dToS(KnifeSpeeder,&ldesc); break;
         case CRAFT_TYPE_KNIFE_RET:   desc_str = dToS(KnifeThrower,&ldesc); break;
         case CRAFT_TYPE_KRIO_ABSORB: desc_str = dToS(KrioAbsorber,&ldesc); break;
         case CRAFT_TYPE_KRIO_WALL: desc_str = dToS(KrioWallItem,&ldesc); break;
         case CRAFT_TYPE_DROP_POIS: desc_str = dToS(PoisenItem,&ldesc); break;
         case CRAFT_TYPE_MIND: desc_str = dToS(MindItem,&ldesc); break;
         case CRAFT_TYPE_PARAL: desc_str = dToS(ParalizeItem,&ldesc); break;
         case CRAFT_TYPE_DUP: desc_str = dToS(DuplicateItem,&ldesc); break;
      }
      return desc_str;
   }
   
   /*array*/CraftCost(/*CraftItemType*/tp) = {
      local costArr = [/*cry*/0 /*al*/0 /*sil*/0];
      switch(tp)
      {
         case CRAFT_TYPE_REVOLVER: costArr = [1 0 0]; break;
         case CRAFT_TYPE_SHOTGUN:  costArr = [2 0 0]; break;
         case CRAFT_TYPE_LASER:    costArr = [20 0 0]; break;
         case CRAFT_TYPE_MED_TUBE: costArr = [20 1 0]; break;
         case CRAFT_TYPE_KNIFE_JUMP: costArr = [5 2 1]; break;
         case CRAFT_TYPE_KNIFE_RET: costArr =  [7 0 0]; break;
         case CRAFT_TYPE_KRIO_ABSORB: costArr = [7 2 0]; break;
         case CRAFT_TYPE_KRIO_WALL: costArr = [4 0 1]; break;
         case CRAFT_TYPE_DROP_POIS: costArr = [20 1 1]; break;
         case CRAFT_TYPE_MIND: costArr =  [20 2 2]; break;
         case CRAFT_TYPE_PARAL: costArr = [30 3 3]; break;
         case CRAFT_TYPE_DUP: costArr =   [40 5 5]; break;
      }
      return costArr;
   }
   
   /*void*/PayFor(tp,num) = {
      local costArr = self.CraftCost(tp);
      local costCry = costArr[1];
      local costAl = costArr[2];
      local costSeli = costArr[3];
      local obj,i;
      if (ResourceSystem.Pay(costAl*num,costCry*num,costSeli*num)==true)
      {
         switch(tp){
             case CRAFT_TYPE_REVOLVER: Pistol._bullets+=num; break;
             case CRAFT_TYPE_SHOTGUN:  Drobovik._bullets+=num; break;
             case CRAFT_TYPE_LASER:    Laser._bullets+=num; break;
             case CRAFT_TYPE_MED_TUBE: 
                for (i=1;i<=num;i++) {
                    obj=new HealthTube; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_KNIFE_JUMP: 
                for (i=1;i<=num;i++) {
                    obj=new KnifeSpeeder; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_KNIFE_RET: 
                for (i=1;i<=num;i++) {
                    obj=new KnifeThrower; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_KRIO_ABSORB: 
                for (i=1;i<=num;i++) {
                    obj=new KrioAbsorber; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_KRIO_WALL: 
                for (i=1;i<=num;i++) {
                    obj=new KrioWallItem; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_DROP_POIS: 
                for (i=1;i<=num;i++) {
                    obj=new PoisenItem; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_MIND: 
                for (i=1;i<=num;i++) {
                    obj=new MindItem; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_PARAL: 
                for (i=1;i<=num;i++) {
                    obj=new ParalizeItem; 
                    obj.moveInto(Me); }
                break;
             case CRAFT_TYPE_DUP: 
                for (i=1;i<=num;i++) {
                    obj=new DuplicateItem; 
                    obj.moveInto(Me); }
                break;
         }
         "√отово!";
      }
      else "—интез не удалс€, попробуйте ввести другое количество.";
   }
;

#pragma C-