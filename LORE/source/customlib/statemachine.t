// STATEMACHINE.T
// VERSION: 1.1
// currState->cs

// Anton Lastochkin 2016
#pragma C++

modify global
   curr_machine = nil
;
   
////////////////////////////////////
// ����� ���������
// ���������������� ������ ������ ���������������� � �������������� ����������� �����������
class State : object
//public virtual:
	nextTurn(turn)={return nil;} //��������� ���������� ����
	enterState={return nil;}     //���� � ���������
	exitState={return nil;}      //����� �� ���������
//private:
	machine = nil //������ ���������, ��� �������� � ����������
//protected:
   //�������, ����� ������� � ���������� ���������
	nextState(st)={
	   self.machine.nextState(st);
	}
;

//������� ������ � ������� ���������:
//1. ������� ����������� ����� �� State, ������� ������ ��� ������, �������, ������������ ���������
//2. ������� ������ ������ StateMachine, ������� ��������� ��������� �� ������������ State
//3. ���������������� ������, ����� ����� register
//4. ���������� ����� ���������-���������: machine.currState.sayExit
//4. ��������� ������ ����� ������, ����� ����� unregister
class StateMachine : object
//public:
   //������� ���������
   cs = nil
   //����������� ������, ���������
   register={
     //���������� ����� ����
	 self.currTurn = 0;
	 global.curr_machine = self;
     //��������� ������
     notify(self, &nextTurn, 0);
     if (self.cs != nil)
     {
         //��������� ������
         if (self.cs.machine == nil) self.cs.machine=self;
         //���� � ���������
         self.cs.enterState;
     }
   }
   //���������� ������
   unregister={
     //������� �� ���������� ���������
	 if (self.cs != nil) self.cs.exitState;
     unnotify(self, &nextTurn );
	 global.curr_machine = nil;
   }
//protected:
   //��������� ���������� ���� ������
   nextTurn={
       if (self.cs != nil) {
        if (self.cs.machine == nil) self.cs.machine=self;
        self.cs.nextTurn(self.currTurn);
       }
	   self.currTurn = self.currTurn+1;
   }
   nextState(newState)={
      //���������� ����� ����
	  self.currTurn = 0;
      //������������� ������� ������
      if (newState.machine != nil) newState.machine = self;
	  self.cs.exitState; 
	  newState.enterState; 
	  self.cs=newState;
   }
//private:
   currTurn = 0
;


#pragma C-