/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// Проверено на TADS 2.5.11 русский релиз 27
// Дата последнего изменения 2017.09.05

// Патчим advr.t

// Исправляем неправильное использование yoa() вместо iao()

// Сразу две ошибки и во втором случае вместе с исправлением формы глагола "может" для множественного числа
modify doorway
	verDoLock(actor) =
	{
		if (self.islocked)
			{"Он"; iao(self);" уже заперт"; yao(self); "! ";}
		else if (not self.islockable)
			{"Он"; iao(self);" не <<self.isThem ? "могут" : "может">> быть заперт"; yao(self); ". ";}
		else if (self.isopen)
			"<<ZAG(actor,&ddesc)>> придётся сначала закрыть <<self.vdesc>>. ";
	}
;

modify doorway
	verDoUnlock(actor) =
	{
		if (not self.islocked)
	  { "Он"; iao(self); " не заперт"; yao(self); "! "; }
	}
;

modify doorway
	verDoUnlockWith(actor, io) =
	{
		if (not self.islocked)
			{"Он"; iao(self);" не заперт"; yao(self); "! ";}
		if (self.islocked) if (self.mykey = nil)
			"<<ZAG(actor,&ddesc)>> ничем не удастся отпереть <<self.itobjdesc>>. ";
	}
;

modify openable
	doOpen(actor) =
	{
		if (itemcnt(self.contents))
		{
			"Открыв "; self.vdesc; ", %You% обнаружил"; iao(actor);" <<listcont(self)>>. ";
		}
		else
			{"Открыт"; yao(self); ". ";}
		self.isopen := true;
	}
;

// Исправляем неправильное использование ioa() вместо yao()
// Сразу две ошибки и в первом случае вместе с исправлением формы глагола "может" для множественного числа
modify dialItem
	ldesc =
	{
		"<<ZAG(self,&sdesc)>> <<self.isThem ? "могут" : "может">> быть установлен<<yao(self)>> на величины от
		<< self.minsetting >> до << self.maxsetting >>.
		<<ZAG(self,&sdesc)>> сейчас установлен<<yao(self)>> на << self.setting >>. ";
	}
;

// Исправляем окончания через ella для актёров немужского рода при отперании двери без ключа
modify doorway
	doUnlock(actor) =
	{
		if (self.mykey = nil)
		{
			"<<ZAG(actor,&sdesc)>> отпер"; if (actor.gender!=1) ella(actor);  " <<self.vdesc>>. "; 
			self.setIslocked(nil);
		}
		else
			askio(withPrep);
	}
;

// Патчим errorru.t

// Исправляем чтение "хочешь" во множественном числе
replace parseAskobjActor: function(a, v, ...)
{
    if (argcount = 3)
    {
       if (getarg(3)=aboutPrep) "О"; else               // О чем
       if (getarg(3)!=toPrep or v.padezh_type !=2) ZAG(getarg(3),&sdesc);
       
       if (getarg(3)=onPrep or getarg(3)=thruPrep or getarg(3)=inPrep or getarg(3)=atPrep) 
       {
         if (getarg(3)=inPrep) "о";     //В(о) что
         " что ";
       }
       else  if ((getarg(3)=underPrep) or (getarg(3)=behindPrep) or (getarg(3)=overPrep)
             or (getarg(3)=betweenPrep) or (getarg(3)=aboutPrep)) " чем ";
       else  if (getarg(3)=goonPrep) " чему ";
       else if (getarg(3)=toPrep)
         {
          if (v.padezh_type =2) "Кому ";
           else " чему ";
         }
        else if (v=askforVerb) " кого ";
       else " чего ";
        
       if (a <> parserGetMe() or a.lico=3)
        {
         a.sdesc;" ";"долж<<ok(a,'ны','ен','но','на')>> ";
        }
        else "Вы хотите ";
        v.sdesc;" ";
        if (getarg(3)!=aboutPrep)
        {
         if (v.pred) v.pred.sdesc;
         " это?";
        }
        else (v=tellVerb)?"этому персонажу?":"этого персонажа?";
     }
     else
     {
        ZAG(v,&vopr);
        if (a <> parserGetMe() || a.lico=3 || a.lico=1) 
         {
          a.sdesc;" ";"долж<<ok(a,'ны','ен','но','на')>> ";
         }
         else "<<parserGetMe().sdesc>> <<parserGetMe().isThem ? glok(parserGetMe(),2,1,'хот') : glok(parserGetMe(),'хочешь')>> "; 
        "<<v.sdesc>>?";
    }
}