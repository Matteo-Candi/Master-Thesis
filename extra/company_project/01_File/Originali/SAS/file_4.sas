libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;
options nolabel;

%include "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Macro\macroquadraturagruppo.sas";
%include "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Macro\macroarrotondainterogruppo.sas";

title1 "STIMA DEI CONSUMI PER SEZIONE";

ods graphics off;


data geog;
	set ter_out.geografica_comune;
	length territorio $ 40;
	if nome_regione = "TRENTINO-ALTO ADIGE"
		then territorio = nome_provincia;
		else territorio = nome_regione;
	keep codice_comune__str nome_comune sigla_provincia
		 territorio nome_regione codice_ripartizione;
run;
proc sort data = geog;
	by codice_comune__str;
run;
data eco;
	set ter_out.economica_comune;
	keep codice_comune__str reddito consumi_totali;
run;
proc sort data = eco;
	by codice_comune__str;
run;
proc means data = ter_out.Popolazione_eta_sesso_comune noprint;
	class codice_comune__str;
	types codice_comune__str;
	output out = popnew (drop = _type_ _freq_)
		   sum(popolazione) = ;
run;
data basecom1;
	merge geog eco popnew;
	by codice_comune__str;
	red_pop = reddito/popolazione;
	con_pop = consumi_totali/popolazione;
	propensione = con_pop/red_pop;
	inverso = 1/red_pop;
run;
proc univariate data = basecom1;
	var propensione;
	histogram propensione;
run;
proc corr data = basecom1;
	var propensione red_pop inverso;
run;
proc sort data = basecom1;
	by territorio;
run;
proc corr data = basecom1 outp = corcom noprint;
	by territorio;
	var propensione red_pop inverso;
run;
proc print data = corcom;
	where _type_ = "CORR" and _name_ = "propensione";
run;
proc gplot data = basecom1;
	by territorio;
	symbol1 i = none  v = dot c = black;
	plot propensione * inverso = 1;
run;
quit;


proc reg data = basecom1 ;

	by territorio;
	model propensione = inverso;
	output out = esitoreg
		   p = yteorica
		   rstudent = rstud;
run;
quit;
data base_dep;
	set esitoreg;
	if abs(rstud) < 2;
	drop yteorica;
run;
proc reg data = base_dep outest = parametri;

	by territorio;
	model propensione = inverso;
	output out = esitoreg
		   p = yteorica;
run;
quit;
proc gplot data = esitoreg;
	by territorio;
	symbol1 i = none  v = dot c = black;
	plot yteorica * inverso = 1;
run;
quit;


data geosez;
	set sez_out.geografica_sezione;
	length territorio $ 40;
	if nome_regione = "TRENTINO-ALTO ADIGE"
		then territorio = nome_provincia;
		else territorio = nome_regione;
	keep codice_sezione codice_comune__str nome_comune sigla_provincia
		 territorio nome_regione;
run;
proc sort data = geosez;
	by codice_sezione;
run;
data ecosez;
	set sez_out.economica_sezione;
	keep codice_sezione reddito;
run;
proc sort data = ecosez;
	by codice_sezione;
run;
proc means data = sez_out.Popolazione_eta_sesso_sezione noprint;
	class codice_sezione;
	types codice_sezione;
	output out = popnewsez (drop = _type_ _freq_)
		   sum(popolazione) = ;
run;
data basesez1;
	merge geosez ecosez popnewsez;
	by codice_sezione;
	if popolazione > 0
		then do;
			red_pop = reddito/popolazione;
			inverso = 1/red_pop;
		end;
run;


proc sort data = basesez1;
	by territorio;
run;
proc score data = basesez1
		   score = parametri
		   type = parms
		   out = basesez2;
		   var inverso;
		   by territorio;
run;
proc univariate data = basesez2 nextrobs = 20;
	by territorio;
	var model1;
	histogram model1;
	id nome_comune sigla_provincia red_pop;
run;
proc univariate data = basesez2 nextrobs = 20;
	var model1;
	histogram model1;
	id nome_comune sigla_provincia red_pop;
run;


data basesez2;
	set basesez2;
	if reddito > 0
		then stima_grezza = reddito*model1;
		else stima_grezza = 0;
run;
proc tabulate data = basesez2;
	var reddito stima_grezza;
	table reddito stima_grezza,sum*f=comma18.;
run;


data quadra;
	set basecom1;
	keep codice_comune__str consumi_totali;
run;
%quadraturagruppo(basesez2, 
				  stima_grezza, 
				  quadra, 
				  consumi_totali, 
				  consumi_qua, 
				  codice_comune__str, 
				  base_out1); 
data base_out2;
	set base_out1;
	consumi_qua = round(consumi_qua);
run;
%arrotondainterogruppo(base_out2, 
					   consumi_qua, 
					   quadra, 
					   consumi_totali, 
					   codice_comune__str, 
					   base_out3); 
proc tabulate data = base_out3;
	var reddito consumi_qua;
	table reddito consumi_qua,sum*f=comma18.;
run;


data oldpop;
	set sez.demo20b (keep = cods11 stmpop19);
	rename cods11 = codice_sezione
		   stmpop19 = popolazione_pre;
run;
proc sort data = oldpop;
	by codice_sezione;
run;
data oldcon;
	set sez.econom20b (keep = cods11 red19 con19);
	rename cods11 = codice_sezione
		   red19 = reddito_pre
		   con19 = consumi_pre;
run;
proc sort data = oldcon;
	by codice_sezione;
run;
proc sort data = base_out3;
	by codice_sezione;
run;
data base_controllo;
	merge base_out3 oldpop oldcon;
	by codice_sezione;
	if popolazione_pre > 0
		then do;
			red_pop_pre = reddito_pre/popolazione_pre;
			con_pop_pre = consumi_pre/popolazione_pre;
		end;
	if popolazione > 0
		then do;
			con_pop = consumi_qua/popolazione;
			propeff = consumi_qua/reddito;
		end;
	if popolazione > 0 and popolazione_pre > 0
		then do;
			varred = 100*(red_pop - red_pop_pre)/red_pop_pre;
			varcon = 100*(con_pop - con_pop_pre)/con_pop_pre;
		end;
run;
proc univariate data = base_controllo nextrobs = 100;
	var varcon;
	id codice_sezione nome_comune sigla_provincia varred red_pop con_pop popolazione;
	histogram varcon;
run;
proc univariate data = base_controllo nextrobs = 100;
	where nome_comune ~= "TRENTO";
	var varcon;
	id codice_sezione nome_comune sigla_provincia varred red_pop con_pop popolazione;
	histogram varcon;
run;

proc univariate data = base_controllo;

	var con_pop con_pop_pre;
	histogram con_pop con_pop_pre;
run;
proc gplot data = base_controllo;

	symbol1 i = none  v = dot c = black;
	plot varcon * varred = 1;
run;
quit;
proc gplot data = base_controllo;

	symbol1 i = none  v = dot c = black;
	plot con_pop * red_pop = 1;
run;
quit;
proc gplot data = base_controllo;

	symbol1 i = none  v = dot c = black;
	plot propeff * red_pop = 1;
run;
quit;
data errore;
	set base_controllo;
	if (popolazione = 0 and consumi_qua > 0)
	or (popolazione > 0 and consumi_qua = 0);
run;	*vuoto;


proc means data = base_controllo noprint;
	class codice_comune__str;
	types codice_comune__str;
	output out = somma (drop = _type_ _freq_)
		sum(reddito consumi_qua) = ;
run;
proc sort data = basecom1;
	by codice_comune__str;
run;
data cfrcom;
	merge somma basecom1 (keep = codice_comune__str reddito consumi_totali
						  rename=(reddito=reddito_com));
	by codice_comune__str;
run;
data diverso;
	set cfrcom;
	if reddito ~= reddito_com
	or consumi_qua ~= consumi_totali;
run;	*vuoto;


data attuale;
	set sez_out.economica_sezione;
run;
proc sort data = attuale;
	by codice_sezione;
run;
proc sort data = base_controllo;
	by codice_sezione;
run;
data nuova;
	merge attuale base_controllo (keep = codice_sezione consumi_qua);
	by codice_sezione;
	rename consumi_qua = consumi_totali;
run;
%let tracciato = 
codice_sezione
reddito
consumi_totali
anno_riferimento
release;
data ordinata;
	retain &tracciato;
	set nuova;
run;

