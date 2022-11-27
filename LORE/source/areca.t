// ARECA.T
// ������� �������� ����� � ������� � ������
#pragma C++

//�����
Areca : fixeditem
  desc = '�����/1��'
  noun = '�����/1��' '�������/1�'
  isHer=true
  location = Me
  ldesc = "���������� ������� �� ����������� ����������, � ����������� � ���� ������� ������. �������, ��� ������ ��� ����������� ��������� �����������."
  isListed = true
  talkdesc = aresa_say('����������? ��� � � ��������! ������ ��� � ���� �������� ���� ��� ������.')
  actorAction(v, d, p, i) = { aresa_say('���� ���, �������� �������! ��� �� ������ �����. ���� ��������, � ��� ���������� � ������!'); exit;}
  //����������� �������
  verDoPush(actor) = aresa_say('��� ���� �� ������ ������� ������ �������!')
  verDoAttachTo(actor, iobj) = aresa_say('� �� �� ������, ����� ���� ����-�� �������. ����� ��� � ������� ������������ ��������.')
  verIoAttachTo(actor) = aresa_say('� �� �� ������, ����� ���� ����-�� �������. ����� ��� � ������� ������������ ��������.')
  verDoDetach(actor) = aresa_say('����� ����� ���� ���-������ ��������?')
  verDoDetachFrom(actor, iobj) = aresa_say('����� ����� ���� ���-������ ��������?')
  verIoDetachFrom(actor) = aresa_say('����� ����� ���� ���-������ ��������?')
  verDoWear(actor) = aresa_say('�� �� ���� ��� �����! ������, � ����. �� �� �����.')
  verDoTake(actor) = aresa_say('���� ����� ����� ������ � ���. �� ���� ��� � ����� ��������. ')
  verDoDrop(actor) = aresa_say('� ���� �������! � ���� ���� ������ �������!')
  verDoUnwear(actor) = aresa_say('� ��� ������ �� �����! ������ ���� �������.')
  verIoPutIn(actor) = aresa_say('� ���� ��� ������ �� ������. ���� ������ �������� �����. ')
  verDoPutIn(actor, io) = aresa_say('� ���� �� ����������, ����� ���� ����� ���� ������ �������� � <<self.itselfdesc>>!')
  verIoPutOn(actor) = aresa_say('�� ��� ������? �� ���� ����� ������ ������!')
  verDoPutOn(actor, io) = aresa_say('� �� ���� ���� ��������!')
  verIoTakeOff(actor) = self.verDoUnwear(actor)
  verDoTakeOff(actor, io) = self.verDoUnwear(actor)
  verIoPlugIn(actor) = aresa_say('�����, ��������� ���� ������. ��� �� ��� ���� ������ � ������ �����������. ')
  verDoPlugIn(actor, io) = aresa_say('�����, ��������� ���� ������. ��� �� ��� ���� ������ � ������ �����������. ')
  verIoUnplugFrom(actor) = aresa_say('��� ���-�� ���������. ��� ��� �� ���� ������ ��������� �� ����, � ���� � �� ����������?')
  verDoUnplugFrom(actor, io) =aresa_say('��� ���-�� ���������. ��� ��� �� ���� ������ ��������� �� ����, � ���� � �� ����������?')
  verDoLookunder(actor) = aresa_say('�� ��� ������ ������� ��� ������?! ����������!')
  verDoInspect(actor) = aresa_say('������� ���� �������? � �� ����� �������, ��� �������.')
  verDoRead(actor) = aresa_say('����� ���� ��� �����, �� �����! ��, ���������, ��������!')
  verDoLookbehind(actor) = aresa_say('� �� ���� ������, �������, ������ ����...')
  verDoTurn(actor) = aresa_say('�� ���������! � �� � ������ ���� ���� ������������.')
  verDoTurnWith(actor, io) = aresa_say('� �� �� ��������� ������! ���� ������ ��������� ����!')
  verDoTurnOn(actor, io) = aresa_say('�������� ���� ����� ������ ������ ����������� �� ������ ������� ����.')
  verIoTurnOn(actor) = aresa_say('���-���. �����! � ��� �������� � �� ���� ������������!')
  verDoTurnon(actor) = aresa_say('���-���. �����! � ��� �������� � �� ���� ������������!')
  verDoTurnoff(actor) = aresa_say('���� ��� ����� �����, �� ������ ��������. � ��������� ������ ����������!')
  verDoScrew(actor) = aresa_say('�� �����!')
  verDoScrewWith(actor, iobj) = aresa_say('�� ������ ����������? ����� ������? ')
  verIoScrewWith(actor)=aresa_say('�� ������ ����������? ����� ������? ')
  verDoUnscrew(actor) = aresa_say('������, ����� � ���� ������ �������������, ��������?')
  verDoUnscrewWith(actor, iobj) = aresa_say('������, ����� � ���� ������ �������������, ��������?')
  verIoUnscrewWith(actor) = aresa_say('������, ����� � ���� ������ �������������, ��������?')
  verIoAskAbout(actor) = {}
  ioAskAbout(actor, dobj) ={	dobj.doAskAbout(actor, self);	}
  verDoAskAbout(actor, io) =	aresa_say('� �� ���� �������� �� ����� ������. ��� ����� � ����� ���������. ')
  verIoTellAbout(actor) = {}
  ioTellAbout(actor, dobj) ={	dobj.doTellAbout(actor, self);}
  verDoTellAbout(actor, io) = aresa_say('�� ���� ��� ������ ������������! � ���� ���� � �������. ')
  verDoTalk(actor)={}
  verDoUnboard(actor) = aresa_say('��� ���� ������ ����������� ��� � ���� ������ �������... ������� �����������, ��������.')
  verDoAttackWith(actor, io) = aresa_say('�������� �� ���� �������? �� � ���� ������! �����. ���-������. ��� ����� ��������. ')
  verIoAttackWith(actor) = aresa_say('����� ������ ������ ������� ����� ������ ���������!')
  verDoEat(actor) = aresa_say('��! � �� �������. ������ �� ���� �������� ��������� �������! ')
  verDoDrink(actor) = aresa_say('�� ��� �� �������� �������! � ������ ��� � ��� �� ��������� �� ����� ����������?')
  verDoGiveTo(actor, io) = aresa_say('���� ������ ������������! �� ��� �� ����� ��������� �����������?')
  verDoPull(actor) = aresa_say('��� �� � ���� ������ ��������? ��� �����, ����� ������, ������� ������� �� ���������! ')
  verDoThrowAt(actor, io) = aresa_say('������! ������, ������ ������������, ����� � ������ �� ���� �����...')
  verIoThrowAt(actor) = aresa_say('������! ������, ������ ������������, ����� � ������ �� ���� �����...')
  verIoThrowTo(actor) = aresa_say('������! ������, ������ ������������, ����� � ������ �� ���� �����...')
  verDoThrowTo(actor, io) = aresa_say('������! ������, ������ ������������, ����� � ������ �� ���� �����...')
  verDoThrow(actor) = aresa_say('� ���� �������! ������ ������� �������������, � ��� ���� �������! ���.')
  verDoShowTo(actor, io) = aresa_say('�� ���, � ��������?')
  verIoShowTo(actor) = aresa_say('�� ���, � ��������?')
  verDoClean(actor) = aresa_say('���! �������� ������ ����� � �� ������ ����! ����� � �������� �� �������� ����?')
  verDoCleanWith(actor, io) = aresa_say('�� �� ����, �� ����� �� ��������, ����� �� ���� ������ ����.')
  verDoMove(actor) = aresa_say('� ������ �� �����.')
  verDoMoveTo(actor, io) = aresa_say('���� �� �� ��������. ���-��.')
  verIoMoveTo(actor) = aresa_say('���� �� �� ��������. ���-��.')
  verDoMoveWith(actor, io) = aresa_say('���� �� �� ��������. ���-��.')
  verIoMoveWith(actor) = aresa_say('���� �� �� ��������. ���-��.')
  verIoSearchIn( actor ) = aresa_say('���� ��������  ���������� ��� ������ �����, ��� ������ � ���� �����? �� ���������!')
  verDoSearchIn( actor, iobj ) = aresa_say('���� ��������  ���������� ��� ������ �����, ��� ������ � ���� �����? �� ���������!')
  verDoTypeOn(actor, io) = aresa_say('������ ��� ����, ����� ����� �� ���� �� ���������.')
  verDoShoot(actor) = aresa_say('� ��� �������. �� ����������� ������.')
  verDoAskFor(actor,io)=aresa_say('���� ������ �� � ��� �������! � �� ������� �������!')
  verIoAskFor(actor)=aresa_say('���� ������ �� � ��� �������! � �� ������� �������!')
  verDoAskOneFor(actor, iobj)=aresa_say('���� ������ �� � ��� �������! � �� ������� �������!')
  verIoAskOneFor(actor)=aresa_say('���� ������ �� � ��� �������! � �� ������� �������!')
  genMoveDir = aresa_say('� ������ � ����� ����� ���������, ���� �� ���� ������!')
  verDoSearch(actor) = aresa_say('�������� ���� ��������! ����������� �������! ���������!')
  verDoListenTo(actor)=aresa_say('���������, �� ��� ���� ��������������. � ������. ')
  verDoSmell(actor)=aresa_say('� ���������, ������ � ���� �������� ������. ����, ������������. ')
  verDoTouch(actor)=aresa_say('��, �������! �� ���� ��� ������. �� �� �� ������� ��� �������! ')
  verDoBoard(actor) = aresa_say('�� ��� �� ������ �� ������. ��� � ���� ����������.')
  verDoChmok(actor) = aresa_say('���, ��� ������� ��� �� ���� ������! ������ ����������, � �� ��� � ������ ��������...')
;

#pragma C-