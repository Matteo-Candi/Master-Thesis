*********************************************************************;
*ELABORAZIONE DATI SULLE NASCITE PER ET� DELLA MADRE                 ;
*********************************************************************;

*Al momento dell'elaborazione sono disponibili dati al 2019;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;

*Predispongo i totali provinciali delle donne per classe di et�;
*recupero la popolazione per et� e comune;
data xclasse;
	set ter.etapop20b;
	time = 2019;
	length eta1_a $ 6;
	if 15 <= eta <= 17
		then eta1_a = "Y_UN17";
	else if 18 <= eta <= 49
		then eta1_a = "Y"||trim(left(eta));
	else if 50 <= eta <= 54
		then eta1_a = "Y_GE50";
	else delete;
	keep codc620b eta1_a eta time tot_fem;
	rename codc620b = codice_comune__str
		   tot_fem = femmine;
run;
proc tabulate data = xclasse;
	class eta1_a;
	var eta;
	table eta1_a, eta*(min max) * f = 6. /nocellmerge;
run;
proc sort data = xclasse;
	by codice_comune__str;
run;
*abbino i riferimento geografici;
data xgeog;
	set ter_out.geografica_comune;
	keep codice_comune__str codice_provincia;
run;
proc sort data = xgeog;
	by codice_comune__str;
run;
data xclageo;
	merge xgeog xclasse;
	by codice_comune__str;
run;
*sommo per provincia e classe di et�;
proc means data = xclageo noprint;
	class codice_provincia eta1_a;
	types codice_provincia * eta1_a;
	id time;
	output out = provinciale_donne (drop = _type_ _freq_)
		sum(femmine) = donne_classe_eta;
run;

*Abbino al file dei nati per et� della madre;
data nati;
	set appo.nati_eta_madre_provincia_istat;
	rename valore = nati;
run;
proc sort data = nati;
	by codice_provincia eta1_a;
run;
proc sort data = provinciale_donne;
	by codice_provincia eta1_a;
run;
data nati_donne;
	merge nati provinciale_donne (drop = time);
	by codice_provincia eta1_a;
run; /*3.638*/

*Elaboro i nati per 1000 donne;
data nati_donne_rapp;
	set nati_donne;
	nati_1000_donne_classe_eta = 1000 * nati / donne_classe_eta;
run;

*salvo;
options nolabel;
/*
data appo.nati_eta_madre_rapporto;
	set nati_donne_rapp;
run;
*/

