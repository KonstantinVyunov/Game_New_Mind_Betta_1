#pragma C++

RunAutoVerb: sysverb
	verb = 'runauto'
	sdesc = "runauto"
    full_cmd_list = []
    curr_pos = 1
    run_auto = nil
    processNextCmd={
       while (self.curr_pos < length(self.full_cmd_list))
       {
 		  local curr_cmd = self.full_cmd_list[self.curr_pos];
		  if (substr(curr_cmd,1,1)=='>') {
			  self.curr_pos += 1;
              self.processCmd(curr_cmd);
			  return;
		  }
		  self.curr_pos += 1;
       }
    }
    processCmd(curr_cmd)={
		//�������� ������ �����
		curr_cmd = substr(curr_cmd,2,length(curr_cmd)-1);
	    "<br>><<curr_cmd>><br>";
		//��������� ������� ���������������
		parserReplaceCommand(curr_cmd);
    }
	action(actor) = {
       self.curr_pos = 1;
       self.full_cmd_list = [];
       self.full_cmd_list += self.cmd_list1;
       self.full_cmd_list += self.cmd_list2;
       self.full_cmd_list += self.cmd_list3;
       self.full_cmd_list += self.cmd_list4;
       self.full_cmd_list += self.cmd_list5;
       "���������� �������.<br>";
       self.run_auto = true;
    }
    cmd_list1 = [
'=== �������-0 ==='
'*** ������� ���� ***'
'>��������'
'>� ����'
'>� ����'
'>���������� � ����'
'>�'
'>������� �������'
'>��'
'>��'
'>������� ������'
'>��'
'*** ������ ���� ***'
'>������� �������'
'>�'
'>����� ��'
'>��������� ������������'
'>�'
'>�'
'>��'
'>��'
'>��'
'>�������'
'>�������'
'>�������'
'>�������'
'>�������'
'>�������'
'>�������'
'>�'
'>��������� ������'
'>������'
'>4'
'>1'
'>0'
'>������'
'>0'
'>���������� ��� ���������'
'>�'
'>��'
'>�'
'>����� �����'
'>�'
'>��'
'>�'
'>���������� ��� ���������'
'>����'
'*** ��� ������ ***'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'*** ������ � ������� �� ��������***'
'>� ������'
'>� ������'
'>���������� � ����'
'>������ �� �����'
'>� ������'
'>�'
'>� ����'
'>��'
'>������ �� ������'
'>����� ��'
'>��������� ������������'
'>��'
'>�'
'>������ �� �����'
'>'
]
cmd_list2 = [
'>'
'=== �������-1 ==='
'>�'
'>�'
'*** ���� � ������ ***'
'>���������� � ������'
'>���������� � ������'
'>���'
'>���'
'>���'
'>���'
'>���'
'>���'
'>���'
'>���'
'>���'
'>���'
'>���'
'>���'
'>����� ��'
'>������'
'>1'
'>10'
'>0'
'>������� ���������'
'>�'
'>� ��������'
'>�'
'*** �������� �� ���������***'
'>����� ����'
'>��'
'>��'
'>��'
'>��'
'>��������'
'>��������'
'>��'
'>��'
'>��'
'>��'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>������ �� ����'
'>����� ���'
'>������'
'>1'
'>10'
'>5'
'>1'
'>0'
'>������ �� �����'
'>������'
'>4'
'>4'
'>'
'>������������ �����'
'>������'
'>1'
'>5'
'>'
'*** �������� � ����������***'
'>�'
'>��������'
'>��'
'>��'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
''
'>�������� ���� �� ��������'
'>� ��������'
'>������� ����'
'>������������ �����'
'>������������ �����'
'>������ �� ����'
'*** �������***'
'>� �����'
'>�'
'>��������'
'>��������'
'>��������'
'>������� ���'
'>� ���������� ���'
'>�������� � ���������� ���'
'>�'
'>�������'
'>�������'
'>�������'
'>������ �� �����'
'>�'
'>�������'
]
cmd_list3 = [
'>�������'
'>�������'
'>� �����'
'>��������� ������������'
'>������'
'>4'
'>2'
'>0'
'>������������ �����'
'>������������ �����'
'>������� ���������'
'>�'
'>��������'
'>��������'
'>��������'
'>������ ������'
'>�'
'>��������'
'>��������'
'>��������'
'>�'
'>��������'
'>��������'
'>������ �� �����'
'>������'
'>4'
'>2'
'>0'
'>������������ �����'
'>������������ �����'
'>�'
'>�'
'>������ ������'
'>�'
'>�'
'>������ �� �����'
'>�'
'>� �������� ����'
'>��������� �������'
'>��������'
'>� �����'
'>�'
'>�'
'>�'
'>�'
'>��������'
'>��������'
'>��������'
'>��������'
'>����� ��'
'>������ �� �����'
'>�'
'>�'
'>������� ���'
'>������ ������'
'*** ����� ***'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>�'
'>������'
'>5'
'>1'
'>6'
'>1'
'>7'
'>1'
'>'
'>������������ �����������'
'>������������ ��������������'
'>������������ ������������'
'>�'
'>�'
'>�'
'>������������ �����'
'>�'
'*** ���������� ���� ***'
'>��'
'>��'
'>�'
'>�'
'>�������'
'>�������'
'>�'
'>�'
'>�������'
'>�������'
'>�'
'>�'
'>�������'
'>�������'
'>�'
'>'
'>'
]
cmd_list4 = [
'=== �������-2 ==='
'>������� ��������'
'>������'
'>2'
'>20'
'>'
'>��������� �������'
'>��������� ���������'
'>�'
'*** ����� �� ��������� ***'
'>��������'
'>��������'
'>�'
'>�'
'>����� �������'
'>��������� �����'
'>�'
'>��'
'>��������'
'>��������� ���'
'>������'
'>4'
'>5'
'>'
'>������������ �����'
'>��'
'>��'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>������'
'>4'
'>2'
'>0'
'>������� ����'
'>�'
'>������������ �����'
'>�'
'>������������ �����'
'>�'
'>�'
'>�'
'>�'
'>�'
'*** ����� ***'
'>�'
'>��������� �����'
'>�'
'>�'
'>������� ���'
'>�'
'>��'
'>������ �� ������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��'
'>������� �������'
'>����� � ����'
'>'
'*** ���� �� �������� ***'
'>� ����'
'>������'
'>2'
'>10'
'>'
'>�'
'>���������� �� ��������'
'>�������'
'>�����'
'>5'
'>�������'
'>���������� �� ��������'
'>�����'
'>5'
'>��������'
'>���������� �� ��������'
'>�����'
'>5'
'>�������'
'>���������� �� ��������'
'>�'
'>�'
'>�'
'>�'
'>�'
'>������ �� ��������'
'>�'
'>�'
'>�'
'>�'
'>�'
'>����� � �������'
]
cmd_list5 = [
'>�����'
'>�'
'*** �������� � ������� ***'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>��������'
'>������'
'>4'
'>3'
'>'
'>������������ �����'
'>������������ �����'
'>������'
'>2'
'>10'
'>'
'>�����'
'*** �������� � ��������� � �������� �������� ***'
'>��������'
'>��������'
'>��������'
'>�'
'>�'
'>��������'
'>��������'
'>��������'
'>�'
'>�'
'>�'
'>�'
'>�'
'*** ������ �������� � ���� ***'
'>�'
'>�'
'>�'
'>�'
'>�'
'>������'
'>4'
'>4'
'>'
'>������������ �����'
'>������������ �����'
'>������������ �����'
'>������'
'>2'
'>20'
'>'
'>������ �� ��������'
'*** ������ �� ��������� ***'
'>��������'
'>��������'
'>�'
'>��'
'>�'
'>��������'
'>������������ �����'
'>������������ �����'
'>��'
'>��'
'>�'
'>�'
'>�������� ��������'
'>�'
'>��������'
'>��'
'>��'
'>��������'
'>�'
'>�'
'>��������'
'>��������'
'>�'
'*** ����� ***'
]

;