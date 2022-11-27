//���� � 21

The21Game : object
  my_deck = []
  ai_deck = []
  arr_left = []
 
//public:
 prepareGame = {
    //��������������� ������� ������� ����
    self.my_deck = [];
    self.ai_deck = [];
    self.arr_left = self.dict_card;
 }
 
  //��������� ������
  nextDeck = {
    self.my_deck = [];
    self.my_deck += [self.getRandCardFromDeck];
    self.my_deck += [self.getRandCardFromDeck];
   
    self.ai_deck = [];
    self.ai_deck += [self.getRandCardFromDeck];
    self.ai_deck += [self.getRandCardFromDeck];
  }
  
  //�������� ��� ������
  showMyDeck = {
     self.showDeck(self.my_deck);
  }
  
  //�������� ������ ���������
  showAiDeck = {
     self.showDeck(self.ai_deck);
  }
  
  countMyDeck = {
     return self.countDeck(self.my_deck);
  }
  
  countAiDeck = {
     return self.countDeck(self.ai_deck); 
  }
 
  //�������� ��������� ����� �� ����
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
       "<<card_name>> (�����: <<card_val>>)<br>";
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
   [ '������� ������'   6]
   [ '�������� ������'   7]
   [ '��������� ������'  8]
   [ '������� ������'    9]
   [ '������� ������'   10]
   [ '����� ������'      3]
   [ '���� ������'       4]
   [ '������ ������'     5]
   [ '��� ������'       11]
   
   [ '������� ���'   6]
   [ '�������� ���'   7]
   [ '��������� ���'  8]
   [ '������� ���'    9]
   [ '������� ���'   10]
   [ '����� ���'      3]
   [ '���� ���'       4]
   [ '������ ���'     5]
   [ '��� ���'       11]
   
   [ '������� ����'   6]
   [ '�������� ����'   7]
   [ '��������� ����'  8]
   [ '������� ����'    9]
   [ '������� ����'   10]
   [ '����� ����'      3]
   [ '���� ����'       4]
   [ '������ ����'     5]
   [ '��� ����'       11]
   
   [ '������� �����'   6]
   [ '�������� �����'   7]
   [ '��������� �����'  8]
   [ '������� �����'    9]
   [ '������� �����'   10]
   [ '����� �����'      3]
   [ '���� �����'       4]
   [ '������ �����'     5]
   [ '��� �����'       11]
]
 
;