/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// ��������� �� TADS 2.5.11 ������� ����� 27
// ���� ���������� ��������� 2017.09.04

// ������ advr.t

// � ������� sayPrefixCount() ��������� ���������� ���������� ����������
replace sayPrefixCount: function(cnt, ...)
{
 	local obj;
 	
 	if (argcount = 2) 
 	{
 		obj := getarg(2);
 	
 		if (cnt = 1)
 		{
 			"��<<ok(obj, '��', '��', '��' ,'��')>>";
 			return;
 		}
 		else if (cnt = 2)
 		{
 			"��<<ok(obj, '�', '�', '�' ,'�')>>";
 			return;
 		}
 	}
	
	if (cnt <= 20)
		say(['����' '���' '���' '������' '����'
			'�����' '����' '������' '������' '������'
			'�����������' '����������' '����������' '������������' '����������'
			'�����������' '����������' '������������' '������������' '��������'][cnt]);
	else
		say(cnt);
}