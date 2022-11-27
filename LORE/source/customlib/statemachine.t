// STATEMACHINE.T
// VERSION: 1.1
// currState->cs

// Anton Lastochkin 2016
#pragma C++

modify global
   curr_machine = nil
;
   
////////////////////////////////////
// Класс состояния
// Пользовательский объект должен пронаследоваться и переопределить необходимые обработчики
class State : object
//public virtual:
	nextTurn(turn)={return nil;} //обработка следующего хода
	enterState={return nil;}     //Вход в состояние
	exitState={return nil;}      //Выход из состояния
//private:
	machine = nil //машина состояний, для перехода к следующему
//protected:
   //Вызвать, чтобы перейти к следующему состоянию
	nextState(st)={
	   self.machine.nextState(st);
	}
;

//Порядок работы с машиной состояний:
//1. Сделать производный класс от State, создать методы для входов, выходов, обработчиков переходов
//2. Создать объект класса StateMachine, указать начальное состояние от производного State
//3. Зарегистрировать машину, через метод register
//4. Обращаться через состояние-интерфейс: machine.currState.sayExit
//4. Отключить машину после работы, через метод unregister
class StateMachine : object
//public:
   //Текущее состояние
   cs = nil
   //регистрация машины, включение
   register={
     //Сбрасываем номер хода
	 self.currTurn = 0;
	 global.curr_machine = self;
     //Запускаем демона
     notify(self, &nextTurn, 0);
     if (self.cs != nil)
     {
         //Установка машины
         if (self.cs.machine == nil) self.cs.machine=self;
         //Вход в состояние
         self.cs.enterState;
     }
   }
   //отключение машины
   unregister={
     //Выходим из последнего состояния
	 if (self.cs != nil) self.cs.exitState;
     unnotify(self, &nextTurn );
	 global.curr_machine = nil;
   }
//protected:
   //Обработка следующего шага машины
   nextTurn={
       if (self.cs != nil) {
        if (self.cs.machine == nil) self.cs.machine=self;
        self.cs.nextTurn(self.currTurn);
       }
	   self.currTurn = self.currTurn+1;
   }
   nextState(newState)={
      //Сбрасываем номер хода
	  self.currTurn = 0;
      //Устанавливаем текущую машину
      if (newState.machine != nil) newState.machine = self;
	  self.cs.exitState; 
	  newState.enterState; 
	  self.cs=newState;
   }
//private:
   currTurn = 0
;


#pragma C-