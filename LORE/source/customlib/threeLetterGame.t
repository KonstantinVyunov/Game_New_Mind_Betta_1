//���� �� ������ ����� ����� � ������������ �����
//������� �. �. ��������� http://www.speakrus.ru/dict/

//enum NEXT_WORD_CODES {
#define NEXT_WORD_OK 1      //����� ��������
#define NEXT_WORD_UNKNOWN 2 //����������� �����
#define NEXT_WORD_FAIL 3    //����� �� �������� �� ��������
#define NEXT_WORD_LAST 4    //����� ����� �����������
#define NEXT_WORD_ALREADY 5 //����� ��� ���� � ������������
//}


//Unit-test:
//local word_out,res;
//ThreeLetterGame.prepareGame;
//word_out = ThreeLetterGame.getFirstWord;
//"�����������. ������ �����: <<word_out>>.<br>";
//res = ThreeLetterGame.checkNextWord('����');
//"��������� ����: <<res>>.<br>";
//res = ThreeLetterGame.checkNextWord('���');
//"��������� ���: <<res>>.<br>";
//res = ThreeLetterGame.checkNextWord('���');
//"��������� ���: <<res>>.<br>";
//res = ThreeLetterGame.checkNextWord('���');
//"��������� ���: <<res>>.<br>";
//word_out = ThreeLetterGame.memWordAndGetOwn('���');
//"��������� � ������ ����� ���: <<word_out>>.<br>";
//word_out = ThreeLetterGame.memWordAndGetOwn('���');
//"������ ����� ���: <<word_out>>.<br>";
//word_out = ThreeLetterGame.memWordAndGetOwn('���');
//"������ ����� ���: <<word_out>>.<br>";

ThreeLetterGame : object
 
 arr = []
 arr_old = []
 lastWord = 'xxx'

//public:
 prepareGame = {
    //��������������� ������� ������ ����
    self.arr = [];
    self.arr_old = [];
    self.arr += self.dict_letter_array1;
    self.arr += self.dict_letter_array2;
    self.arr += self.dict_letter_array3;
    self.arr += self.dict_letter_array4;
    self.arr += self.dict_letter_array5;
    self.arr += self.dict_letter_array6;
 }
 
 getFirstWord = {
   local pos = rangernd(1,length(self.arr));
   local word = self.arr[pos];
   //����� �������� ���� �� ������ �� ����
   if (global.isFixedRndRangeMid) word = '���';
   self.addWordToMemory(word);
   return word;
 }
 
 checkNextWord(word) = {
   local lowWord = loweru(word);
   if (lowWord == self.lastWord) {
     return NEXT_WORD_LAST;
   }
   //���� ����� ����� �����
   if (find(self.arr,lowWord)!=nil)
   {
      if ( self.isWordCorrect(lowWord, self.lastWord)==true )
      {
         return NEXT_WORD_OK;
      }
      else 
      {
         return NEXT_WORD_FAIL;
      }
   }
   else if (find(self.arr_old,lowWord)!=nil) {
      return NEXT_WORD_ALREADY;
   }
   return NEXT_WORD_UNKNOWN;
 }
 
 memWordAndGetOwn(inWord) = {
    local i,cur_word;
    local out_word = '';
    local have1,have2,have3;
    local word = loweru(inWord);
    //���������� ��������� �����
    self.addWordToMemory(word);
    //���� ���
    for (i=1;i<=length(self.arr);i++)
    {
       cur_word = self.arr[i];
       
       if ( self.isWordCorrect(cur_word, word)==true )
       {
          out_word = cur_word;
          self.addWordToMemory(out_word);
          break;
       }
    }
    
    return out_word;
 }
//private:
   isWordCorrect(userWord, lastWord) = {
      local let1user = substr(userWord,1,1);
      local let2user = substr(userWord,2,1);
      local let3user = substr(userWord,3,1);
      
      local let1last = substr(lastWord,1,1);
      local let2last = substr(lastWord,2,1);
      local let3last = substr(lastWord,3,1);
      local lastArr = [let1last let2last let3last];
      //������� �� ����� ����� �� ����������� �����
      if (find(lastArr,let1user)) lastArr-=let1user;
      if (find(lastArr,let2user)) lastArr-=let2user;
      if (find(lastArr,let3user)) lastArr-=let3user;
      //��������� ��� �������� ������ ���� ����� � ����� ��� ������ �� �����
      if ( length(lastArr)<=1 ) return true;
      return nil;
   }

   addWordToMemory(word) = {
      self.lastWord = word;
      self.arr -= [word];
      self.arr_old += [word];
   }
   
   
   
dict_letter_array1 = [
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
]

dict_letter_array2 = [
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
]

dict_letter_array3 = [
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
'��'
'��'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
]

dict_letter_array4 = [
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'��'
]

dict_letter_array5 = [
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
]

dict_letter_array6 = [
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
'���'
]

;