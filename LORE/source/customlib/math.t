// MATH.T

// Anton Lastochkin 2016
#pragma C++

modify global
   isFixedRndRangeMid = nil //��� ����� ���� ����� ���������� ������������� �������� ���������� ��������� ����� (������� �� ���������)
;

//������� ��� ��������� �������������� ���������� �������� � ��������� [from;to]
rangernd:function(from,to)
{
   if (global.is_easy) return from; //��� ������ ������, ������� ����������� ����
   return rangernd_no_complex(from,to);
}

//������� ��� ��������� �������������� ���������� �������� � ��������� [from;to], ��� ����� ������ ���������
rangernd_no_complex:function(from,to)
{
   if (global.isFixedRndRangeMid) return (to+from)/2;
   if (from>=to) return from; //���� ������������ �������� ����� ������������ (��� ������), ���������� �����������
   return from+(rand(to-from+1)-1);
}

//�������� �����������, �� ������ ������/���, �� ����� ���������� ���������
//������: if (prob(50)){...}
prob : function(proc)
{
   return (rangernd(0,100)<=proc);
}

//������� ��� ��������� ������
abs:function(val)
{
   if (val<0) return -val;
   return val;
}



#pragma C-