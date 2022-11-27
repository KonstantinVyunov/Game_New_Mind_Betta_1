//Игра в 21

The21Game : object
  my_deck = []
  ai_deck = []
  arr_left = []
 
//public:
 prepareGame = {
    //Подготоваливаем рабочие массивы карт
    self.my_deck = [];
    self.ai_deck = [];
    self.arr_left = self.dict_card;
 }
 
  //следующая колода
  nextDeck = {
    self.my_deck = [];
    self.my_deck += [self.getRandCardFromDeck];
    self.my_deck += [self.getRandCardFromDeck];
   
    self.ai_deck = [];
    self.ai_deck += [self.getRandCardFromDeck];
    self.ai_deck += [self.getRandCardFromDeck];
  }
  
  //Показать мою колоду
  showMyDeck = {
     self.showDeck(self.my_deck);
  }
  
  //Показать колоду соперника
  showAiDeck = {
     self.showDeck(self.ai_deck);
  }
  
  countMyDeck = {
     return self.countDeck(self.my_deck);
  }
  
  countAiDeck = {
     return self.countDeck(self.ai_deck); 
  }
 
  //Получаем случайную карту из деки
  getRandCardFromDeck = {
     local pos = rangernd(1,length(self.arr_left));
     local card = self.arr_left[pos];
     self.arr_left -= [card];
     return card;
  }

//private:
  showDeck(deck) = {
     local i,card_val_pair,card_name,card_val;
     for (i=1;i<=length(deck);i++)
     {
       card_val_pair = deck[i];
       card_name = card_val_pair[1];
       card_val = card_val_pair[2];
       "<<card_name>> (очков: <<card_val>>)<br>";
     }
  }
  
  countDeck(deck) = {
     local i,card_val_pair,card_val, summ;
     summ = 0;
     for (i=1;i<=length(deck);i++)
     {
       card_val_pair = deck[i];
       card_val = card_val_pair[2];
       summ += card_val;
     }
     return summ;
  }


dict_card = [
   [ 'шестёрка червей'   6]
   [ 'семьёрка червей'   7]
   [ 'восьмерка червей'  8]
   [ 'девятка червей'    9]
   [ 'десятка червей'   10]
   [ 'валет червей'      3]
   [ 'дама червей'       4]
   [ 'король червей'     5]
   [ 'туз червей'       11]
   
   [ 'шестёрка пик'   6]
   [ 'семьёрка пик'   7]
   [ 'восьмерка пик'  8]
   [ 'девятка пик'    9]
   [ 'десятка пик'   10]
   [ 'валет пик'      3]
   [ 'дама пик'       4]
   [ 'король пик'     5]
   [ 'туз пик'       11]
   
   [ 'шестёрка треф'   6]
   [ 'семьёрка треф'   7]
   [ 'восьмерка треф'  8]
   [ 'девятка треф'    9]
   [ 'десятка треф'   10]
   [ 'валет треф'      3]
   [ 'дама треф'       4]
   [ 'король треф'     5]
   [ 'туз треф'       11]
   
   [ 'шестёрка бубен'   6]
   [ 'семьёрка бубен'   7]
   [ 'восьмерка бубен'  8]
   [ 'девятка бубен'    9]
   [ 'десятка бубен'   10]
   [ 'валет бубен'      3]
   [ 'дама бубен'       4]
   [ 'король бубен'     5]
   [ 'туз бубен'       11]
]
 
;