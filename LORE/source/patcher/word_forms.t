/*
This file is part of the RTADS Patcher.
This set of libraries is a configurable patching system for the RTADS
by Nikita Tseykovets <tseikovets@rambler.ru>.
The RTADS Patcher fixes errors and inaccuracies of the parser in different situations.
This code is distributed under the terms of the TADS license.
*/

// ��������� �� TADS 2.5.11 ������� ����� 27
// ���� ���������� ��������� 2017.09.05

// ������ advr.t

// ���������� ������������ ������������� yoa() ������ iao()

// ����� ��� ������ � �� ������ ������ ������ � ������������ ����� ������� "�����" ��� �������������� �����
modify doorway
	verDoLock(actor) =
	{
		if (self.islocked)
			{"��"; iao(self);" ��� ������"; yao(self); "! ";}
		else if (not self.islockable)
			{"��"; iao(self);" �� <<self.isThem ? "�����" : "�����">> ���� ������"; yao(self); ". ";}
		else if (self.isopen)
			"<<ZAG(actor,&ddesc)>> ������� ������� ������� <<self.vdesc>>. ";
	}
;

modify doorway
	verDoUnlock(actor) =
	{
		if (not self.islocked)
	  { "��"; iao(self); " �� ������"; yao(self); "! "; }
	}
;

modify doorway
	verDoUnlockWith(actor, io) =
	{
		if (not self.islocked)
			{"��"; iao(self);" �� ������"; yao(self); "! ";}
		if (self.islocked) if (self.mykey = nil)
			"<<ZAG(actor,&ddesc)>> ����� �� ������� �������� <<self.itobjdesc>>. ";
	}
;

modify openable
	doOpen(actor) =
	{
		if (itemcnt(self.contents))
		{
			"������ "; self.vdesc; ", %You% ���������"; iao(actor);" <<listcont(self)>>. ";
		}
		else
			{"������"; yao(self); ". ";}
		self.isopen := true;
	}
;

// ���������� ������������ ������������� ioa() ������ yao()
// ����� ��� ������ � � ������ ������ ������ � ������������ ����� ������� "�����" ��� �������������� �����
modify dialItem
	ldesc =
	{
		"<<ZAG(self,&sdesc)>> <<self.isThem ? "�����" : "�����">> ���� ����������<<yao(self)>> �� �������� ��
		<< self.minsetting >> �� << self.maxsetting >>.
		<<ZAG(self,&sdesc)>> ������ ����������<<yao(self)>> �� << self.setting >>. ";
	}
;

// ���������� ��������� ����� ella ��� ������ ���������� ���� ��� ��������� ����� ��� �����
modify doorway
	doUnlock(actor) =
	{
		if (self.mykey = nil)
		{
			"<<ZAG(actor,&sdesc)>> �����"; if (actor.gender!=1) ella(actor);  " <<self.vdesc>>. "; 
			self.setIslocked(nil);
		}
		else
			askio(withPrep);
	}
;

// ������ errorru.t

// ���������� ������ "������" �� ������������� �����
replace parseAskobjActor: function(a, v, ...)
{
    if (argcount = 3)
    {
       if (getarg(3)=aboutPrep) "�"; else               // � ���
       if (getarg(3)!=toPrep or v.padezh_type !=2) ZAG(getarg(3),&sdesc);
       
       if (getarg(3)=onPrep or getarg(3)=thruPrep or getarg(3)=inPrep or getarg(3)=atPrep) 
       {
         if (getarg(3)=inPrep) "�";     //�(�) ���
         " ��� ";
       }
       else  if ((getarg(3)=underPrep) or (getarg(3)=behindPrep) or (getarg(3)=overPrep)
             or (getarg(3)=betweenPrep) or (getarg(3)=aboutPrep)) " ��� ";
       else  if (getarg(3)=goonPrep) " ���� ";
       else if (getarg(3)=toPrep)
         {
          if (v.padezh_type =2) "���� ";
           else " ���� ";
         }
        else if (v=askforVerb) " ���� ";
       else " ���� ";
        
       if (a <> parserGetMe() or a.lico=3)
        {
         a.sdesc;" ";"����<<ok(a,'��','��','��','��')>> ";
        }
        else "�� ������ ";
        v.sdesc;" ";
        if (getarg(3)!=aboutPrep)
        {
         if (v.pred) v.pred.sdesc;
         " ���?";
        }
        else (v=tellVerb)?"����� ���������?":"����� ���������?";
     }
     else
     {
        ZAG(v,&vopr);
        if (a <> parserGetMe() || a.lico=3 || a.lico=1) 
         {
          a.sdesc;" ";"����<<ok(a,'��','��','��','��')>> ";
         }
         else "<<parserGetMe().sdesc>> <<parserGetMe().isThem ? glok(parserGetMe(),2,1,'���') : glok(parserGetMe(),'������')>> "; 
        "<<v.sdesc>>?";
    }
}