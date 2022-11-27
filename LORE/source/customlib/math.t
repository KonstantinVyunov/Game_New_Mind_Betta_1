// MATH.T

// Anton Lastochkin 2016
#pragma C++

modify global
   isFixedRndRangeMid = nil //дл€ теста игры можно установить фиксированное значени€ генератора случайных чисел (среднее из диапазона)
;

//‘ункци€ дл€ получени€ целочисленного случайного значени€ в диапазоне [from;to]
rangernd:function(from,to)
{
   if (global.is_easy) return from; //дл€ лЄгкого уровн€, наносим минимальный урон
   return rangernd_no_complex(from,to);
}

//‘ункци€ дл€ получени€ целочисленного случайного значени€ в диапазоне [from;to], без учета уровн€ сложности
rangernd_no_complex:function(from,to)
{
   if (global.isFixedRndRangeMid) return (to+from)/2;
   if (from>=to) return from; //если максимальное значение равно минимальному (или ошибка), возвращаем минимальное
   return from+(rand(to-from+1)-1);
}

//проверка веро€тности, на выходе истина/лож, на входе количество процентов
//пример: if (prob(50)){...}
prob : function(proc)
{
   return (rangernd(0,100)<=proc);
}

//‘ункци€ дл€ получени€ модул€
abs:function(val)
{
   if (val<0) return -val;
   return val;
}



#pragma C-