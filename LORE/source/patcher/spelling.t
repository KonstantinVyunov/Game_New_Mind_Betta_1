/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// ��������� �� TADS 2.5.11 ������� ����� 27
// ���� ���������� ��������� 2017.10.01

// ������ advr.t

// ���������� ��������������� ������ � ��������� ��������� ������ ����� (��������� ������)
// ����� �������������� ������������ �������� (��� ������) � ����� ��������������� � ������������� �� ������� ��������

modify moveNEVerb
	verb = '������� ��' '������� ��' '��������� ��' '��������� ������������'
		'��������� ������-������'
	sdesc = "������� �� ������-������"
;

modify moveNWVerb
	verb = '������� ��' '������� ��' '��������� ��' '��������� �����������'
		'��������� ������-�����'
	sdesc = "������� �� ������-�����"
;

modify moveSEVerb
	verb = '������� ��' '������� ��' '��������� ��' '��������� ���������'
		'��������� ���-������'
	sdesc = "������� �� ���-������"
;

modify moveSWVerb
	verb = '������� ��' '��������� ��' '��������� ��������'
		'��������� ���-�����'
	sdesc = "������� �� ���-�����"
;

modify neVerb
	verb = '����� ������-������' '������-������' '�� ������-������' '��' '�� ��' '����� ��' 
			'���� ������-������' '����� ������-������' '����� ��' '��� ������-������'
		'������������' '�� ������������' '���� ������������' '��� ������������' '����� ������������'
	sdesc = "���� �� ������-������"
;

modify nwVerb
	verb = '����� �����������' '����� ��' '������-�����' '��' '�� ��' '����� ��' '���� ��' 
			'���� ������-�����' '����� ������-�����' '����� ��' '��� ������-�����'
		'�����������' '�� �����������' '���� �����������' '��� �����������'
	sdesc = "���� �� ������-�����"
;

modify seVerb
	verb = '���-������' '����� ���-������' '����� ��' '��' '�� ��' '����� ��'  '���� ��' 
			'����� ���-������' '����� ��' '���� ���-������' '��� ���-������'
		'���������' '�� ���������' '���� ���������' '��� ���������' '����� ���������'
	sdesc = "���� �� ���-������"
;

modify swVerb
	verb = '��' '����� ���-�����' '���-�����' '�� ��' '�� ���-�����' '����� ��' '���� ��' 
		'����� ���-�����' '��� ���-�����' '����� ��'
		'��������' '�� ��������' '���� ��������' '��� ��������' '����� ��������'
	sdesc = "���� �� ���-�����"
;

// ���������� �������� � ������ ������� � ������������� � ��� ������ �� ���� RTADS
modify HelpVerb
	action(actor) = {
		"\t\b<b>��� � ��� ������?</b>\b
			\t���������� ����������� ���� �� ����� �������� ����� � ������ ��
			�������, ������� �� ������ ���������.\b
 
			\t������� ����� ��������� �������� �������������� ����� ���
			�������������� ����������, � �������� ����� �������� �������� �
			��������������� ������. �� �������, ���� �������, ����
			�����������. ���������� ���������� ������.\b\b
 
			��������:\b
 
			\t\"<i>�����������</i>\" (��� ������ \"<i>�</i>\")\n
			\t\"<i>��������� ����� �����</i>\" (��� \"<i>� �����
			�����</i>\")\n
			\t\"<i>���� �� ��</i>\" (��� \"<i>�</i>\")\n
			\t\"<i>����� ����</i>\"\n
			\t\"<i>���������</i>\" (��� ������ \"<i>�</i>\")\n
			\t\"<i>������� ����� ������</i>\"\n
			\t\"<i>������� �����</i>\"\n
			\t\"<i>�����, ������ �����</i>\"\n
			\t\"<i>���������� \"������\" �� ����������</i>\"\n
			\t� �.�.\b
 
			<b>������ ��������� �������:</b>\b
 
			\t\"<i>���������\"</i>, \"<i>������������</i>\" - ��������� �����
			����������� ����\n
			\t\"<i>�����</i>\" - ����� ����� �� ����\n
			\t\"<i>������</i>\" - �������\n
			\t\"<i>�����</i>\" - ������ ���� ���� (����) � ����\n
			\t\"<i>��������</i>\" - ���������� ������� ����\n
			\t\"<i>����</i>\" - ������� �������� � ������� ��������\n
			\t\"<i>������</i>\" - �������� ��������� �������\n
			\t\"<i>������</i>\" - �������� ������ ����\n
			\t\"<i>������</i>\" - ������ ���� ������\n
			\t\"<i>�������</i>\" (\"<i>������</i>\") - ������ ����������� 
			������ �������� �������. � \"�������\" ������ ��� ������ ����� 
			� ������� ����� ����������� �� ������.\n
			\t\"<i>������</i>\" - ��������� ��� �������� ������ (���� ����-��
			��� �� ��������)\n";
		
		if (systemInfo(__SYSINFO_SYSINFO) != true
				|| systemInfo(__SYSINFO_VERSION) > '2.5.7')
			"\t\"<i>��</i>\" - ��������� ��������� ����������� ��������� �
			��������� �������� ����� ��� ���������� �����\n";
			
		"\t\"<i>������</i>\" (��� ������ \"<i>�</i>\") - ��������� ���������
			�������\n\b
 
			\t�������������� ���������� ����� ����� �� �����
			<<displayLink( 'http://rtads.org',
			'http://rtads.org' )>>.\n\b
			 
			\t�� ������������ ������� ��������� ������ ����. ���� �� ��� ����� ��� ������ ����� ��������� ��������, ������ ������������ RTADS �� ������
			<<displayLink( 'mailto:rtads@mail.ru', 'rtads@mail.ru' )>>.\b
 
			\t������ ��� �������� ����!\n\b";
			abort;
	}
;