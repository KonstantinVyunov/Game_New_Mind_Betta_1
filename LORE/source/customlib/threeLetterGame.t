//Игра на замену одной буквы в трёхбуквенном слове
//Словарь А. А. Зализняка http://www.speakrus.ru/dict/

//enum NEXT_WORD_CODES {
#define NEXT_WORD_OK 1      //слово подходит
#define NEXT_WORD_UNKNOWN 2 //неизвестное слово
#define NEXT_WORD_FAIL 3    //слово не подходит по правилам
#define NEXT_WORD_LAST 4    //слово равно предыдущему
#define NEXT_WORD_ALREADY 5 //слово уже было в употреблении
//}


//Unit-test:
//local word_out,res;
//ThreeLetterGame.prepareGame;
//word_out = ThreeLetterGame.getFirstWord;
//"Подготовлен. Первое слово: <<word_out>>.<br>";
//res = ThreeLetterGame.checkNextWord('ХРЮН');
//"Результат ХРЮН: <<res>>.<br>";
//res = ThreeLetterGame.checkNextWord('НЮХ');
//"Результат НЮХ: <<res>>.<br>";
//res = ThreeLetterGame.checkNextWord('АГУ');
//"Результат АГУ: <<res>>.<br>";
//res = ThreeLetterGame.checkNextWord('ХНА');
//"Результат ХНА: <<res>>.<br>";
//word_out = ThreeLetterGame.memWordAndGetOwn('ХНА');
//"Запомнили и выдали новое своё: <<word_out>>.<br>";
//word_out = ThreeLetterGame.memWordAndGetOwn('МАХ');
//"Выдали новое своё: <<word_out>>.<br>";
//word_out = ThreeLetterGame.memWordAndGetOwn('ГАМ');
//"Выдали новое своё: <<word_out>>.<br>";

ThreeLetterGame : object
 
 arr = []
 arr_old = []
 lastWord = 'xxx'

//public:
 prepareGame = {
    //Подготоваливаем рабочий массив слов
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
   //чтобы смещение слов не влияло на тест
   if (global.isFixedRndRangeMid) word = 'нюх';
   self.addWordToMemory(word);
   return word;
 }
 
 checkNextWord(word) = {
   local lowWord = loweru(word);
   if (lowWord == self.lastWord) {
     return NEXT_WORD_LAST;
   }
   //если нашли такое слово
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
    //запоминаем пришедшее слово
    self.addWordToMemory(word);
    //Ищем своё
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
      //Убираем по одной букве из предыдущего слова
      if (find(lastArr,let1user)) lastArr-=let1user;
      if (find(lastArr,let2user)) lastArr-=let2user;
      if (find(lastArr,let3user)) lastArr-=let3user;
      //Проверяем что осталась только одна буква в слове или вообще ни одной
      if ( length(lastArr)<=1 ) return true;
      return nil;
   }

   addWordToMemory(word) = {
      self.lastWord = word;
      self.arr -= [word];
      self.arr_old += [word];
   }
   
   
   
dict_letter_array1 = [
'аба'
'абы'
'ага'
'агу'
'азу'
'азы'
'аил'
'аир'
'акр'
'акт'
'али'
'аль'
'ант'
'ара'
'асс'
'ату'
'аул'
'аут'
'ахи'
'баз'
'бай'
'бак'
'бал'
'бар'
'бас'
'бах'
'бац'
'баш'
'бег'
'беж'
'без'
'бей'
'бек'
'бел'
'бес'
'бис'
'бит'
'бич'
'боа'
'боб'
'бог'
'бой'
'бок'
'бом'
'бон'
'бор'
'бот'
'бош'
'бра'
'бри'
'брр'
'буж'
'буй'
'бук'
'бум'
'бур'
'бут'
'бух'
'бык'
'быт'
'бэр'
'вал'
'вар'
'ваш'
'век'
'вес'
'виг'
'вид'
'вир'
'вис'
'вне'
'вод'
'воз'
'вой'
'вол'
'вон'
'вор'
'вот'
'все'
'вуз'
'вша'
'выя'
'вяз'
'гад'
'газ'
'гай'
'гак'
'гам'
'где'
'гей'
'ген'
'гид'
'гик'
'гит'
'гну'
'год'
'гой'
'гол'
'гон'
'гоп'
]

dict_letter_array2 = [
'гот'
'гуд'
'гуж'
'гул'
'дар'
'два'
'дед'
'дек'
'дёр'
'див'
'для'
'дно'
'дог'
'дож'
'док'
'дол'
'дом'
'дон'
'дот'
'дуб'
'дух'
'душ'
'дым'
'его'
'еда'
'ежа'
'еле'
'ель'
'ерш'
'еры'
'ерь'
'еще'
'ещё'
'ёра'
'ёрш'
'жар'
'жид'
'жим'
'жир'
'жом'
'жор'
'жох'
'жук'
'зав'
'зад'
'зал'
'зам'
'зги'
'зев'
'зет'
'зёв'
'зло'
'зоб'
'зов'
'зря'
'зуб'
'зуд'
'зуй'
'зык'
'ибо'
'ива'
'иго'
'идо'
'иды'
'иже'
'изо'
'икс'
'или'
'иль'
'имя'
'инк'
'ион'
'иск'
'ишь'
'йог'
'йод'
'йот'
'как'
'кал'
'кап'
'кат'
'кеб'
'кед'
'кий'
'кик'
'кил'
'кит'
'код'
'кой'
'кок'
'кол'
'ком'
'кон'
'кот'
'кош'
'кто'
'куб'
'кум'
'кун'
'кур'
]

dict_letter_array3 = [
'кус'
'кут'
'куш'
'лаг'
'лад'
'лаж'
'лаз'
'лай'
'лак'
'лал'
'лан'
'лев'
'леи'
'лей'
'лек'
'лен'
'лес'
'лещ'
'лея'
'лёд'
'лён'
'лёт'
'лже'
'лик'
'лис'
'лиф'
'лоб'
'лов'
'лог'
'лом'
'лот'
'лох'
'луб'
'луг'
'лук'
'луч'
'лье'
'люб'
'люд'
'люк'
'ляд'
'лях'
'маг'
'маз'
'май'
'мак'
'мат'
'мах'
'мга'
'меж'
'мел'
'мех'
'меч'
'мёд'
'миг'
'мим'
'мир'
'миф'
'мой'
'мол'
'мор'
'мот'
'мох'
'муж'
'мул'
'мыс'
'мыт'
'мэр'
'мяу'
'мяч'
'над'
'нар'
'наш'
'нет'
'неф'
'низ'
'ниц'
'нож'
'нок'
'ном'
'нос'
'нут'
'нэп'
'нюх'
'оба'
'обо'
'ого'
'ода'
'одр'
'око'
'она'
'они'
'оно'
'опт'
'орт'
'оса'
'ост'
'ось'
'ото'
'охи'
]

dict_letter_array4 = [
'очи'
'паж'
'паз'
'пай'
'пак'
'пал'
'пан'
'пар'
'пас'
'пат'
'паф'
'пах'
'пек'
'пес'
'пёс'
'пик'
'пим'
'пир'
'пли'
'под'
'пол'
'поп'
'пот'
'при'
'про'
'пря'
'пуд'
'пук'
'пул'
'пуп'
'пуф'
'пух'
'пыж'
'пыл'
'пых'
'пэр'
'раб'
'рад'
'раж'
'раз'
'рай'
'рак'
'рез'
'рей'
'рея'
'рёв'
'ржа'
'рис'
'риф'
'ров'
'рог'
'род'
'рой'
'рок'
'рол'
'ром'
'рот'
'рцы'
'рык'
'рым'
'рюш'
'ряд'
'ряж'
'сад'
'саж'
'саз'
'сак'
'сам'
'сан'
'сап'
'сев'
'сей'
'сет'
'сём'
'сиг'
'сие'
'сип'
'сок'
'сом'
'сон'
'сор'
'сот'
'соя'
'сто'
'суд'
'сук'
'суп'
'сын'
'сыр'
'сыч'
'сэр'
'сяк'
'сям'
'таз'
'так'
'тал'
'там'
'тат'
'тем'
'тёс'
]

dict_letter_array5 = [
'тик'
'тип'
'тир'
'тис'
'тиф'
'тля'
'той'
'ток'
'тол'
'том'
'тон'
'топ'
'тор'
'тот'
'три'
'тсс'
'туз'
'тук'
'тун'
'тур'
'тут'
'туф'
'туш'
'туя'
'тык'
'тыл'
'тын'
'тюк'
'тяж'
'тяп'
'увы'
'угу'
'уда'
'удэ'
'уже'
'ужо'
'уза'
'узы'
'унт'
'ура'
'усы'
'уха'
'ухо'
'уши'
'уют'
'фаг'
'фай'
'фал'
'фас'
'фат'
'фен'
'фес'
'фея'
'фён'
'фок'
'фол'
'фон'
'фот'
'фри'
'фру'
'фря'
'фуй'
'фук'
'фут'
'хаз'
'хам'
'хан'
'хап'
'хек'
'хер'
'хна'
'хны'
'ход'
'хон'
'хоп'
'хор'
'хук'
'цап'
'цеж'
'цеп'
'цех'
'цок'
'цоп'
'цуг'
'цук'
'цыц'
'чад'
'чай'
'чал'
'чан'
'час'
'чей'
'чек'
'чем'
'чех'
'чёс'
'чёт'
'чиж'
'чий'
'чик'
]

dict_letter_array6 = [
'чин'
'чих'
'чох'
'что'
'чуб'
'чум'
'чур'
'шаг'
'шар'
'шах'
'шеф'
'шея'
'шик'
'шип'
'шиш'
'шов'
'шок'
'шум'
'шут'
'щец'
'щип'
'щит'
'щуп'
'щур'
'эва'
'эге'
'эка'
'экю'
'эль'
'эму'
'эра'
'эрг'
'эре'
'эрл'
'эст'
'это'
'эфа'
'эхо'
'юит'
'юла'
'юра'
'юрк'
'юрт'
'явь'
'яга'
'язь'
'яко'
'яма'
'ямб'
'ярд'
'ярл'
'ярь'
'ять'
]

;