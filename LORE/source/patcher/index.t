/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// ��������� �� TADS 2.5.11 ������� ����� 27
// ���� ���������� ��������� 2017.10.08

// ����������� ����������� ������
#include "patcher/word_forms.t" // ����������� ���� ����
#include "patcher/equivalent_objects.t" // ����������� ��� ����������� � ����� ������������� ��������
#include "patcher/spelling.t" // ����������� ������ ������������
#include "patcher/others.t" // ������ ������������� �����������

// ����������� ������������ �����������
#include "patcher/go_in.t" // ���������� ��������� ������ ���� "���� ��" � "���� ��"

// �������������� ���������
#include "patcher/on_thou.t" // ��������� � ������ "�� ��"
//#include "patcher/on_you.t" // ��������� � ������ "�� ��"
