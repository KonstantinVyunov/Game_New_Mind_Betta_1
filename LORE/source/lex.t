//������
#pragma C++


/////////////////////////////////////////////////////////////////
///////////������� ��������
//������� �� ����, ��� ����������
iskWhenHitTemplate: lexicon
    use_templ = nil
	phrases = [
	  '���� ���� ������� �������� ����� �����������, ����� ����� ������, ��� ������.'
	  '����� �������, ���� ������ ��������������� �� ��������� �������.'
      '�� ������ �����������, �� ���� �� �������� ����������.'
	]
;

//��������� ���� ����� ������, ��� ����������
iskBeforeActTemplates: lexicon
    use_templ = nil
	phrases = [
	'�� ��� ��� ����������� ������� ���������� ����� ����������.'
	'����� ������ ������� ������� ������ ������ ��������.'
	'�� ������� �������� �������, ����� ������� � ����� ��������� ����.'
	]
;

/////////////////////////////////////////////////////////////////
///////////������� ������
//���������
//��������� �� ��������, mon-����������, tar - ��������
robotRemTemplatesPerson: lexicon
    use_templ = true
	phrases = [
	'zmon_im ���������� � ����� ������� �� ����� ����� ����.'
	'zmon_im ����� ����������� � �������� � ���� ����� ����� ������.'
    ]
;

//������ �������� ��������� ����� ���������, mon - ��� ��� �������� ��� ��������
robotRemBeforeActTemplates: lexicon
    use_templ = true
	phrases = [
	'����� ������� ���������� �������� ����� zmon_ro.'
    'zmon_im ������� �������� �� ����������� � ��������� �����.'
	]
;
