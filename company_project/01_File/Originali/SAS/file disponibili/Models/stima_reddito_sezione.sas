*********************************************************************;
*STIMA DEL REDDITO PER SEZIONE                                       ;
*********************************************************************;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname tel "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;
options nofmterr;
options nolabel;

%include "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Macro\macroquadraturagruppo.sas";
%include "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Macro\macroarrotondainterogruppo.sas";

title1 "STIMA DEL REDDITO PER SEZIONE";

*====================================================================;
*FASE DI STIMA                                                       ;
*====================================================================;

*recupero i riferimenti geografici;
data geog;
	set sez_out.geografica_sezione;
	keep codice_sezione codice_comune__str nome_comune sigla_provincia
		 codice_regione nome_regione flag_capoluogo_provincia;
run;
proc freq data = geog;
	tables codice_regione*nome_regione /list;
run;
proc sort data = geog;
	by codice_sezione;
run;

*Recupero i dati precedenti;
data red;
	set sez.econom20b;
	keep cods11 red19 medres19 abitazioni18;
	rename cods11 = codice_sezione
		   red19 = reddito_pre
		   medres19 = prezzo_imm
		   abitazioni18 = abitazioni;
run;
proc sort data = red;
	by codice_sezione;
run;
data pop;
	set sez.demo20b;
	keep cods11 stmpop19;
	rename cods11 = codice_sezione
		   stmpop19 = popolazione_pre;
run;
proc sort data = pop;
	by codice_sezione;
run;
data popred;
	merge geog pop red;
	by codice_sezione;
	if popolazione_pre > 0
		then pro_capite_pre = reddito_pre/popolazione_pre;
run;
proc univariate data = popred;
	var pro_capite_pre;
	histogram pro_capite_pre;
run;
proc univariate data = popred;
	var prezzo_imm;
	histogram prezzo_imm;
run;

*Utilizzo il minimo provinciale per gestire i missing dei prezzi su comuni molto scoperti;
proc sort data = popred;
	by codice_comune__str;
run;
proc means data = popred noprint;
	where prezzo_imm ~= . ;
	by codice_comune__str;
	output out = num (drop = _type_)
		   sum(popolazione_pre) = popcop;
run;
proc means data = popred noprint;
	by codice_comune__str;
	id nome_comune sigla_provincia;
	output out = den (drop = _type_)
		   sum(popolazione_pre) = poptot;
run;
data numden;
	merge num den;
	by codice_comune__str;
	copertura = 100*max(popcop,0)/poptot;
run;
proc univariate data = numden;
	where copertura < 100;
	var copertura;
	histogram copertura;
run;
proc sort data = numden;
	by copertura;
run;
data numden;
	set numden;
	poco_coperto = (copertura < 70);
run;
proc sort data = numden;
	by codice_comune__str;
run;
data popred;
	merge popred numden (keep = codice_comune__str poco_coperto);
	by codice_comune__str;
run;
proc sort data = popred;
	by sigla_provincia;
run;
proc means data = popred noprint;
	by sigla_provincia;
	output out = minprov (drop = _type_ _freq_)
		   min(prezzo_imm) = prezzo_min;
run;
data popred;
	merge popred minprov;
	by sigla_provincia;
run;
data popred;
	set popred;
	if poco_coperto = 1 and popolazione_pre > 0 and prezzo_imm = . 
		then prezzo_imm = prezzo_min;
	drop prezzo_min poco_coperto;
run;
proc sort data = popred;
	by codice_sezione;
run;

*Recupero i dati relativi al titolo di studio;
data totst_cens;
	set sez.demo20b;
	dentit = sum(laurea,diplom,media,elemen);
	if dentit > 0
		then incidenza_laurea = 100*laurea/dentit;
	keep cods11 laurea dentit incidenza_laurea;
	rename cods11 = codice_sezione;
run;
proc univariate data = totst_cens;
	var incidenza_laurea;
	histogram incidenza_laurea;
run;
proc sort data = totst_cens;
	by codice_sezione;
run;

*Recupero i dati telefonici;
*Isolo: weekday, fascia oraria serale, tipi business e consumer;
data basetelsel;
	set tel.pubblico_2019_coeff_2018;
	if daytype = "1"
	and fasciaoraria = "7"
	and datatype in ("B","C");
	rename cods11 = codice_sezione;
	drop trimestre1 trimestre2 trimestre3 daytype fasciaoraria;
run;
proc sort data = basetelsel;
	by codice_sezione datatype;
run;
proc transpose data = basetelsel
			   out = tel_t (drop = _name_)
			   prefix = presenze_;
	by codice_sezione;
	id datatype;
	var trimestre4;
run;
proc univariate data = tel_t;
	var presenze_c;
run;
proc tabulate data = tel_t;
	var presenze_c;
	table presenze_c,sum*f=comma12.;
run;
%let sogliatelpre = 8;
data tel_t;
	set tel_t;
	if presenze_c > &sogliatelpre
		then incidenza_b = 100*max(presenze_b,0)/sum(presenze_b,presenze_c);
run;
proc univariate data = tel_t;
	var incidenza_b;
	histogram incidenza_b;
run;

*Isolo le sezioni con popolazione per cui non ho un rapporto;
data persele;
	merge pop tel_t;
	by codice_sezione;
run;
data sele;
	set persele;
	if popolazione_pre > 0 and incidenza_b = . ;
run;

*Recupero la matrice delle sezioni vicine nel comune;
data matrice;
	set sez_out.Sezioni_vicine_comune;
run;
data matrice_sel;
	merge sele (in = presente keep = codice_sezione)
		  matrice (rename=(sezione_partenza=codice_sezione) in = mat);
	by codice_sezione;
	if presente and mat;
run;

*Abbino i dati e aggrego;
proc sort data = matrice_sel;
	by sezione_arrivo;
run;
data matrice_sel_dati;
	merge matrice_sel (in = presente) tel_t (keep = codice_sezione presenze_b presenze_c
											 rename=(codice_sezione=sezione_arrivo));
	by sezione_arrivo;
	if presente;
run;
data sele_dati;
	set sele;
	sezione_arrivo = codice_sezione;
	distanza_aerea = 0;
	drop popolazione_pre incidenza_b;
run;
data matrice_sel_dati;
	set matrice_sel_dati sele_dati;
run;
proc sort data = matrice_sel_dati;
	by codice_sezione distanza_aerea;
run;
data matrice_sel_dati;
	set matrice_sel_dati;
	by codice_sezione;
	if first.codice_sezione
		then do;
			contatore = 1;
			tot_b = presenze_b;
			tot_c = presenze_c;
		end;
		else do;
			contatore + 1;
			tot_b + presenze_b;
			tot_c + presenze_c;
		end;
run;
proc means data = matrice_sel_dati noprint;
	where tot_c > &sogliatelpre;
	class codice_sezione;
	types codice_sezione;
	output out = xflag (drop = _type_ _freq_)
		   min(contatore) = segnalatore;
run;
data matrice_sel_dati;
	merge matrice_sel_dati xflag;
	by codice_sezione;
run;
data tottel;
	set matrice_sel_dati;
	if contatore = segnalatore;
run;

*Utilizzo i dati aggregati per ridurre i missing;
data persele_integ;
	merge persele tottel (keep = codice_sezione tot_b tot_c);
	by codice_sezione;
run;
data persele_integ;
	set persele_integ;
	if popolazione_pre > 0 and incidenza_b = . and tot_c > &sogliatelpre
		then incidenza_b = 100*max(tot_b,0)/sum(tot_b,tot_c);
run;
data controllo;
	set persele_integ;
	if popolazione_pre > 0 and incidenza_b = . ;
run;
proc univariate data = persele_integ;
	var incidenza_b;
	histogram incidenza_b;
run;

*Assegno valore 0 nei casi ancora missing;
data persele_integ;
	set persele_integ;
	if popolazione_pre > 0 and incidenza_b = . 
		then incidenza_b = 0;
run;

*Abbino;
data base1;
	merge popred totst_cens persele_integ (keep = codice_sezione incidenza_b);
	by codice_sezione;
run;
proc corr data = base1;
	var pro_capite_pre prezzo_imm incidenza_laurea incidenza_b;
run;

*Aggiungo la dimensione comunale;
proc means data = ter_out.popolazione_eta_sesso_comune noprint;
	class codice_comune__str;
	types codice_comune__str;
	output out = popcom (drop = _type_ _freq_)
		   sum(popolazione) = ;
run;
data popcom;
	set popcom;
	dim0 = (popolazione <= 5000);
	dim1 = (5000 < popolazione <= 20000);
	dim2 = (20000 < popolazione <= 50000);
	dim3 = (50000 < popolazione <= 200000);
	dim4 = (200000 < popolazione);
run;
proc means data = popcom min max noprint;
	class dim0 dim1 dim2 dim3 dim4 /missing;
	types dim0*dim1*dim2*dim3*dim4;
	output out = repdim (drop = _type_ _freq_)
		   min(popolazione) = minimo
		   max(popolazione) = massimo;
run;
proc print data = repdim;
	format minimo massimo comma12.;
run;
proc sort data = popcom;
	by codice_comune__str;
run;
proc sort data = base1;
	by codice_comune__str;
run;
data base1;
	merge base1 popcom (drop = popolazione);
	by codice_comune__str;
run;

*Genero dummy delle regioni;
data base1;
	set base1;
	array regio{19};
	do i = 1 to 19;
	 	regio{i} = (codice_regione*1 = i);
	end;
run;

*Effettuo regressione;
%let regioni = regio1 regio2 regio3 regio4 regio5
			   regio6 regio7 regio8 regio9 regio10
			   regio11 regio12 regio13 regio14 regio15
			   regio16 regio17 regio18 regio19;
proc reg data = base1;
	model pro_capite_pre = prezzo_imm incidenza_laurea incidenza_b
						   flag_capoluogo_provincia dim1 dim2 dim3 dim4 &regioni;
	output out = esitoreg
		   p = yteorica_pre;
run;
quit;

*Poich� il Molise non � significativo lo accorpo all'abruzzo;
data base2;
	set base1;
	if regio14 = 1
		then regio13 = 1;
	drop regio14;
run;
%let reginew = regio1 regio2 regio3 regio4 regio5
			   regio6 regio7 regio8 regio9 regio10
			   regio11 regio12 regio13 /*regio14*/ regio15
			   regio16 regio17 regio18 regio19;
proc reg data = base2 outest = parametri;
	model pro_capite_pre = prezzo_imm incidenza_laurea incidenza_b
						   flag_capoluogo_provincia dim1 dim2 dim3 dim4 &reginew;
	output out = esitoreg
		   p = yteorica_pre;
run;
quit;
data errore;
	set esitoreg;
	if . < yteorica_pre < 0;
run;
proc gplot data = esitoreg;
	symbol1 i = none  v = dot c = black;
	plot yteorica_pre * pro_capite_pre = 1;
run;
quit;
proc gplot data = esitoreg;
	where pro_capite_pre < 20;
	symbol1 i = none  v = dot c = black;
	plot yteorica_pre * pro_capite_pre = 1;
run;
quit;
data mancante;
	set esitoreg;
	if popolazione_pre > 0 and yteorica_pre = . ;
run;

*====================================================================;
*FASE DI ESPANSIONE                                                  ;
*====================================================================;

*recupero i dati immobiliari aggiornati;
data immnew;
	set sez.Immobiliare_straordinaria20b;
	keep cods11 medres20;
	rename cods11 = codice_sezione
		   medres20 = prezzo_imm;
run;
proc sort data = immnew;
	by codice_sezione;
run;

*Recupero le stime relative ai titolo di studio aggiornate;
data base_stima_titolo;
	infile "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\sezione_titolo_studio.csv"
		   firstobs = 2		/*prima riga dati*/
		   lrecl = 512		/*lunghezza record*/
		   dlm = ","		/*delimitatore; dlm = '09'x per tab*/
		   dsd				/*assegna un missing a due delimitatori consecutivi*/
		   stopover;		/*arresta il processo in caso di tentativo di lettura a capo*/
	input codice_sezione : $13.
		  sesso 		 : $1.
		  fascia_eta	 : $6.
		  titolo_sintesi
		  stima_non_arrotondata;
run;
proc means data = base_stima_titolo noprint;
	where titolo_sintesi = 5;
	class codice_sezione;
	types codice_sezione;
	output out = pertit (drop = _type_ _freq_)
		   sum(stima_non_arrotondata) = laurea;
run;
proc means data = base_stima_titolo noprint;
	where titolo_sintesi > 1;
	class codice_sezione;
	types codice_sezione;
	output out = totst (drop = _type_ _freq_)
		   sum(stima_non_arrotondata) = titolo_tot;
run;
data totst;
	merge pertit totst;
	by codice_sezione;
	if titolo_tot > 0 then incidenza_laurea = 100*laurea/titolo_tot;
run;
proc univariate data = totst;
	var incidenza_laurea;
	histogram incidenza_laurea;
run;

*Recupero i dati telefonici aggiornati;
*Utilizzo Q1 2021 perch� non ho dati 2020;
data basetelnew;
	infile "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Q1_2021.csv"
		   firstobs = 1		/*prima riga dati*/
		   lrecl = 512		/*lunghezza record*/
		   dlm = ";"		/*delimitatore; dlm = '09'x per tab*/
		   dsd				/*assegna un missing a due delimitatori consecutivi*/
		   stopover;		/*arresta il processo in caso di tentativo di lettura a capo*/
	input sezione 		: $17.
		  trimestre		: $1.
		  daytype		: $1.
		  fasciaoraria	: $1.
		  datatype		: $2.
		  datavalue
		  min
		  max;
run;
*Isolo: weekday, fascia oraria serale, tipi utili a ricostruire business e consumer;
data basetelselnew;
	set basetelnew;
	if daytype = "1"
	and fasciaoraria = "7"
	and datatype in ("Ni","Gm","Gf");
	length codice_sezione $ 13;
	codice_sezione = substr(sezione,5);
	drop sezione trimestre daytype fasciaoraria min max;
run;
proc sort data = basetelselnew;
	by codice_sezione datatype;
run;
proc transpose data = basetelselnew
			   out = tel_tnew (drop = _name_)
			   prefix = presenze_;
	by codice_sezione;
	id datatype;
	var datavalue;
run;
data tel_tnew;
	set tel_tnew;
	presenze_c = sum(presenze_gm,presenze_gf);
	presenze_b = sum(presenze_ni,-presenze_c);
	if presenze_b < 0 then presenze_b = . ;
run;
proc univariate data = tel_tnew;
	var presenze_c;
run;
proc tabulate data = tel_tnew;
	var presenze_c;
	table presenze_c,sum*f=comma12.;
run;
%let sogliatelnew = 4;
data tel_tnew;
	set tel_tnew;
	if presenze_c > &sogliatelnew
		then incidenza_b = 100*max(presenze_b,0)/sum(presenze_b,presenze_c);
run;
proc univariate data = tel_tnew;
	var incidenza_b;
	histogram incidenza_b;
run;

*Isolo le sezioni con popolazione per cui non ho un rapporto;
proc means data = sez_out.Popolazione_eta_sesso_sezione noprint;
	class codice_sezione;
	types codice_sezione;
	output out = popolazione (drop = _type_ _freq_)
		   sum(popolazione) = ;
run;
data perselenew;
	merge popolazione tel_tnew;
	by codice_sezione;
run;
data selenew;
	set perselenew;
	if popolazione > 0 and incidenza_b = . ;
run;

*Recupero la matrice delle sezioni vicine nel comune;
data matrice_selnew;
	merge selenew (in = presente keep = codice_sezione)
		  matrice (rename=(sezione_partenza=codice_sezione) in = mat);
	by codice_sezione;
	if presente and mat;
run;

*Abbino i dati e aggrego;
proc sort data = matrice_selnew;
	by sezione_arrivo;
run;
data matrice_selnew_dati;
	merge matrice_selnew (in = presente) tel_tnew (keep = codice_sezione presenze_b presenze_c
											 	   rename=(codice_sezione=sezione_arrivo));
	by sezione_arrivo;
	if presente;
run;
data selenew_dati;
	set selenew;
	sezione_arrivo = codice_sezione;
	distanza_aerea = 0;
	keep codice_sezione sezione_arrivo distanza_aerea presenze_b presenze_c;
run;
data matrice_selnew_dati;
	set matrice_selnew_dati selenew_dati;
run;
proc sort data = matrice_selnew_dati;
	by codice_sezione distanza_aerea;
run;
data matrice_selnew_dati;
	set matrice_selnew_dati;
	by codice_sezione;
	if first.codice_sezione
		then do;
			contatore = 1;
			tot_b = presenze_b;
			tot_c = presenze_c;
		end;
		else do;
			contatore + 1;
			tot_b + presenze_b;
			tot_c + presenze_c;
		end;
run;
proc means data = matrice_selnew_dati noprint;
	where tot_c > &sogliatelnew;
	class codice_sezione;
	types codice_sezione;
	output out = xflagnew (drop = _type_ _freq_)
		   min(contatore) = segnalatore;
run;
data matrice_selnew_dati;
	merge matrice_selnew_dati xflagnew;
	by codice_sezione;
run;
data tottelnew;
	set matrice_selnew_dati;
	if contatore = segnalatore;
run;

*Utilizzo i dati aggregati per ridurre i missing;
data persele_integ_new;
	merge perselenew tottelnew (keep = codice_sezione tot_b tot_c);
	by codice_sezione;
run;
data persele_integ_new;
	set persele_integ_new;
	if popolazione > 0 and incidenza_b = . and tot_c > &sogliatelnew
		then incidenza_b = 100*max(tot_b,0)/sum(tot_b,tot_c);
run;
data controllonew;
	set persele_integ_new;
	if popolazione > 0 and incidenza_b = . ;
run;
proc univariate data = persele_integ_new;
	var incidenza_b;
	histogram incidenza_b;
run;

*Confronto con incidenza business precedente;
data cfb;
	merge geog
		  persele_integ (keep = codice_sezione incidenza_b
						 rename=(incidenza_b = incidenza_b_pre))
		  persele_integ_new;
	by codice_sezione;
	differenza_b = incidenza_b - incidenza_b_pre;
run;
proc univariate data = cfb nextrobs = 20;
	var differenza_b;
	histogram differenza_b;
	id nome_comune sigla_provincia incidenza_b incidenza_b_pre;
run;

*Normalizzo le differenze di incidenza business;
proc univariate data = cfb noprint;
	var differenza_b;
	output out = estremi_b
		   pctlpre = diff
		   pctlname = p99 pctlpts = 99
		   pctlname = p1 pctlpts = 1;
run;
data cfbe;
	if _N_ = 1 then set estremi_b;
	set cfb;
run;
data cfbe;
	set cfbe;
	differenza_b_ori = differenza_b;
	if . < differenza_b < diffp1
		then incidenza_b = incidenza_b_pre + mean(differenza_b,diffp1);
	if differenza_b > diffp99
		then incidenza_b = incidenza_b_pre + mean(differenza_b,diffp99);
	differenza_b = incidenza_b - incidenza_b_pre;
run;
proc gplot data = cfbe;
	symbol1 i = none  v = dot c = black;
	plot differenza_b * differenza_b_ori = 1;
run;
quit;
proc univariate data = cfbe nextrobs = 20;
	var differenza_b;
	histogram differenza_b;
	id nome_comune sigla_provincia incidenza_b incidenza_b_pre;
run;
data cfbe;
	set cfbe;
	if popolazione > 0 and incidenza_b = . 
		then incidenza_b = max(incidenza_b_pre,0);
run;

*Abbino;
proc sort data = base2;
	by codice_sezione;
run;
data espa;
	merge base2 (keep = codice_sezione 
						dim1 dim2 dim3 dim4
						flag_capoluogo_provincia
						&reginew)
		  immnew (keep = codice_sezione prezzo_imm)
		  totst (keep = codice_sezione incidenza_laurea)
		  cfbe (keep = codice_sezione incidenza_b)
		  popolazione;
	by codice_sezione;
run;

*Utilizzo il minimo provinciale per gestire i missing dei prezzi nei comuni poco coperti;
data espa;
	merge geog (keep = codice_sezione codice_comune__str sigla_provincia) espa;
	by codice_sezione;
run;
proc sort data = espa;
	by codice_comune__str;
run;
proc means data = espa noprint;
	where prezzo_imm ~= . ;
	by codice_comune__str;
	output out = numnew (drop = _type_)
		   sum(popolazione) = popcop;
run;
proc means data = espa noprint;
	by codice_comune__str;
	id sigla_provincia;
	output out = dennew (drop = _type_)
		   sum(popolazione) = poptot;
run;
data numdennew;
	merge numnew dennew;
	by codice_comune__str;
	copertura = 100*max(popcop,0)/poptot;
run;
proc univariate data = numdennew;
	where copertura < 100;
	var copertura;
	histogram copertura;
run;
proc sort data = numdennew;
	by copertura;
run;
data numdennew;
	set numdennew;
	poco_coperto = (copertura < 70);
run;
proc sort data = numdennew;
	by codice_comune__str;
run;
data espa;
	merge espa numdennew (keep = codice_comune__str poco_coperto);
	by codice_comune__str;
run;
proc sort data = espa;
	by sigla_provincia;
run;
proc means data = espa noprint;
	by sigla_provincia;
	output out = minprovnew (drop = _type_ _freq_)
		   min(prezzo_imm) = prezzo_min;
run;
data espa;
	merge espa minprovnew;
	by sigla_provincia;
run;
data espa;
	set espa;
	if popolazione > 0 and prezzo_imm = . and poco_coperto = 1
		then prezzo_imm = prezzo_min;
	drop prezzo_min sigla_provincia poco_coperto;
run;
proc sort data = espa;
	by codice_sezione;
run;

*Espando le stime;
%let varmodello = prezzo_imm incidenza_laurea incidenza_b
				  flag_capoluogo_provincia dim1 dim2 dim3 dim4 &reginew;
proc score data = espa
		   score = parametri
		   type = parms
		   out = espay;
		   var &varmodello;
run;

*Elaboro variazioni %;
proc sort data = esitoreg;
	by codice_sezione;
run;
proc sort data = espay;
	by codice_sezione;
run;
data esitoreg_new;
	merge esitoreg
		  espay (keep = codice_sezione model1
		  		 rename=(model1=yteorica));
	by codice_sezione;
run;
data novaria;
	set esitoreg_new;
	if (yteorica_pre > 0 and yteorica = . )
	or (yteorica_pre = . and yteorica > 0);
run;	*9130;
data esitoreg_new;
	set esitoreg_new;
	if yteorica > 0 and yteorica_pre > 0
		then variazione = 100*(yteorica - yteorica_pre)/yteorica_pre;
run;
proc univariate data = esitoreg_new nextrobs = 40;
	var variazione;
	histogram variazione;
	id codice_sezione nome_comune sigla_provincia yteorica yteorica_pre;
run;
proc gplot data = esitoreg_new;
	symbol1 i = none  v = dot c = black;
	plot yteorica * yteorica_pre = 1;
run;
quit;
proc gplot data = esitoreg_new;
	symbol1 i = none  v = dot c = black;
	plot yteorica * pro_capite_pre = 1;
run;
quit;
data noncalc;
	set esitoreg_new;
	if popolazione_pre > 0 and variazione = . ;
run;
data noncalc_bis;
	set esitoreg_new;
	if popolazione_pre > 0 and variazione = . and dentit > 0;
run;

*====================================================================;
*FASE DI APPLICAZIONE DELLE VARIAZIONI                               ;
*====================================================================;

*controllo l'incidenza delle sezioni senza variazioni a livello di comune;
proc means data = esitoreg_new noprint;
	where variazione ~= . ;
	class codice_comune__str;
	types codice_comune__str;
	output out = novarcom (drop = _type_ _freq_)
		   sum(popolazione_pre) = popolazione_pre_coperta;
run;
proc means data = esitoreg_new noprint;
	class codice_comune__str;
	types codice_comune__str;
	id nome_comune sigla_provincia;
	output out = totcom (drop = _type_ _freq_)
		   sum(popolazione_pre) = ;
run;
data copcom;
	merge totcom novarcom;
	by codice_comune__str;
	copertura_com = 100*max(popolazione_pre_coperta,0)/popolazione_pre;
run;
proc univariate data = copcom nextrobs = 20;
	where copertura_com < 100;
	var copertura_com;
	histogram copertura_com;
	id nome_comune sigla_provincia;
run;

*Recupero variazioni comunali;
data oldredcom;
	set ter.econom20b;
	keep codc620b red19;
	rename codc620b = codice_comune__str
		   red19 = redcompre;
run;
proc sort data = oldredcom;
	by codice_comune__str;
run;
data oldpopcom;
	set ter.demo20b;
	keep codc620b pop19;
	rename codc620b = codice_comune__str
		   pop19 = popcompre;
run;
proc sort data = oldpopcom;
	by codice_comune__str;
run;
proc means data = ter_out.Popolazione_eta_sesso_comune noprint;
	class codice_comune__str;
	types codice_comune__str;
	output out = newpopcom (drop = _type_ _freq_)
		   sum(popolazione) = popcom;
run;
data quadra;
	set ter_out.economica_comune;
	keep codice_comune__str reddito;
run;
proc sort data = quadra;
	by codice_comune__str;
run;
data comunale;
	merge oldpopcom oldredcom newpopcom quadra;
	by codice_comune__str;
	rapporto_com = (reddito/popcom)/(redcompre/popcompre);
	variazione_com = 100*(rapporto_com - 1);
run;
proc sort data = esitoreg_new;
	by codice_comune__str;
run;
data esitoreg_new;
	merge esitoreg_new comunale (keep = codice_comune__str rapporto_com variazione_com);
	by codice_comune__str;
run;

*normalizzo;
proc univariate data = esitoreg_new noprint;
	var variazione;
	output out = estremi
		   pctlpre = varia
		   pctlname = p99 pctlpts = 99
		   pctlname = p1 pctlpts = 1;
run;
data pernorma;
	if _N_ = 1 then set estremi;
	set esitoreg_new;
run;
data norma;
	set pernorma;
	variazione_n = variazione;
	if . < variazione < variap1
		then variazione_n = mean(variazione,variap1);
	if variazione > variap99
		then variazione_n = mean(variazione,variap99);
run;
proc gplot data = norma;
	symbol1 i = none  v = dot c = black;
	plot variazione_n * variazione = 1;
run;
quit;
proc univariate data = norma nextrobs = 20;
	var variazione_n;
	histogram variazione_n;
run;

*Elaboro una stima grezza;
data stima_grezza;
	set norma;
	if pro_capite_pre > 0 then do;
		if variazione_n ~= . 
			then pro_capite_grezzo = pro_capite_pre*(1 + variazione_n/100);
			else pro_capite_grezzo = pro_capite_pre*rapporto_com;
	end;
run;
proc gplot data = stima_grezza;
	symbol1 i = none  v = dot c = black;
	plot pro_capite_grezzo * pro_capite_pre = 1;
run;
quit;

*====================================================================;
*FASE DI QUADRATURA                                                  ;
*====================================================================;

*recupero i dati di popolazione;
proc sort data = stima_grezza;
	by codice_sezione;
run;
data stima_grezza;
	merge stima_grezza popolazione;
	by codice_sezione;
run;
data anomalo1;
	set stima_grezza;
	if (pro_capite_grezzo > 0 and popolazione = 0);
run;	*4 casi;
data anomalo2;
	set stima_grezza;
	if (pro_capite_grezzo = . and popolazione > 0);
run;	*vuoto;
data stima_grezza;
	set stima_grezza;
	if popolazione > 0
		then reddito_grezzo = pro_capite_grezzo*popolazione;
		else reddito_grezzo = 0;
run;
proc tabulate data = stima_grezza;
	var reddito_grezzo;
	table reddito_grezzo,sum*f=comma18.;
run;
proc tabulate data = quadra;
	var reddito;
	table reddito,sum*f=comma18.;
run;

*effetto quadratura;
%quadraturagruppo(stima_grezza,		/*data set di input*/
				  reddito_grezzo,	/*variabile da quadrare*/
				  quadra,			/*data set totali per gruppo*/
				  reddito,			/*variabile per quadratura*/
				  reddito_qua,		/*variabile quadrata*/
				  codice_comune__str,	/*variabile di raggruppamento*/
				  qua1);			/*data set di output*/
data qua1;
	set qua1;
	reddito_qua = round(reddito_qua);
run;
%arrotondainterogruppo(qua1,		/*data set di input*/
					   reddito_qua,	/*variabile stimata*/
					   quadra,		/*data set dei totali effettivi*/
					   reddito,		/*variabile dei totali effettivi*/
					   codice_comune__str,	/*variabile di raggruppamento*/
					   qua2);		/*data set di output*/
data anomalo;
	set qua2;
	if (reddito_qua > 0 and popolazione = 0)
	or (reddito_qua = 0 and popolazione > 0);
run;	*vuoto;

*Esamino le variazioni %;
data nuova;
	set qua2;
	if popolazione > 0
		then pro_capite = reddito_qua/popolazione;
	if pro_capite_pre > 0 and pro_capite > 0
		then varia_nuova = 100*(pro_capite - pro_capite_pre)/pro_capite_pre;
run;
proc univariate data = nuova nextrobs = 20;
*	where sigla_provincia = "VV";
	var varia_nuova;
	histogram varia_nuova;
	id nome_comune sigla_provincia pro_capite pro_capite_pre;
run;

*Elaboro una versione depurata dalle variazioni comunali;
proc univariate data = comunale;
	var rapporto_com;
	histogram rapporto_com;
run;
data nuova_r;
	set nuova;
	if pro_capite_pre  > 0 and pro_capite > 0
		then do;
			rapporto_dep = (pro_capite/pro_capite_pre)/rapporto_com;
			varia_dep = 100*(rapporto_dep - 1);
		end;
run;
proc univariate data = nuova_r nextrobs = 20;
	var varia_dep;
	histogram varia_dep;
	id nome_comune sigla_provincia varia_nuova rapporto_com popolazione codice_sezione;
run;

*Normalizzo la versione depurata;
proc univariate data = nuova_r noprint;
	var rapporto_dep;
	output out = estremi_rd
		   pctlpre = rappo
		   pctlname = p99 pctlpts = 99
		   pctlname = p1 pctlpts = 1;
run;
data perrinorma;
	if _N_ = 1 then set estremi_rd;
	set nuova_r;
run;
data rinorma;
	set perrinorma;
	rapporto_n = rapporto_dep;
	if . < rapporto_dep < rappop1
		then rapporto_n = mean(rapporto_dep,rappop1);
	if rapporto_dep > rappop99
		then rapporto_n = mean(rapporto_dep,rappop99);
run;
proc gplot data = rinorma;
	symbol1 i = none  v = dot c = black;
	plot rapporto_n * rapporto_dep = 1;
run;
quit;
proc univariate data = rinorma nextrobs = 20;
	var rapporto_n;
	histogram rapporto_n;
run;

*Elaboro una nuova stima grezza;
data stima_grezza_new;
	set rinorma;
	if pro_capite_pre > 0 and popolazione > 0
		then do;
			pro_capite_grezzo_new = pro_capite_pre*rapporto_com*rapporto_n;
			reddito_grezzo_new = pro_capite_grezzo_new*popolazione;
		end;
	else reddito_grezzo_new = 0;
run;
proc gplot data = stima_grezza_new;
	symbol1 i = none  v = dot c = black;
	plot pro_capite_grezzo_new * pro_capite_pre = 1;
run;
quit;

*effetto quadratura;
%quadraturagruppo(stima_grezza_new,	/*data set di input*/
				  reddito_grezzo_new,	/*variabile da quadrare*/
				  quadra,			/*data set totali per gruppo*/
				  reddito,			/*variabile per quadratura*/
				  reddito_qua_new,		/*variabile quadrata*/
				  codice_comune__str,	/*variabile di raggruppamento*/
				  quanew1);			/*data set di output*/
data quanew1;
	set quanew1;
	reddito_qua_new = round(reddito_qua_new);
run;
%arrotondainterogruppo(quanew1,		/*data set di input*/
					   reddito_qua_new,	/*variabile stimata*/
					   quadra,		/*data set dei totali effettivi*/
					   reddito,		/*variabile dei totali effettivi*/
					   codice_comune__str,	/*variabile di raggruppamento*/
					   quanew2);		/*data set di output*/
data anomalo;
	set quanew2;
	if (reddito_qua_new > 0 and popolazione = 0)
	or (reddito_qua_new = 0 and popolazione > 0);
run;	*vuoto;

*Esamino le variazioni %;
data nuovabis;
	set quanew2;
	if popolazione > 0
		then pro_capite_new = reddito_qua_new/popolazione;
	if pro_capite_pre > 0 and pro_capite_new > 0
		then varia_nuova_bis = 100*(pro_capite_new - pro_capite_pre)/pro_capite_pre;
run;
proc univariate data = nuovabis nextrobs = 50;
	var varia_nuova_bis;
	histogram varia_nuova_bis;
	id nome_comune sigla_provincia pro_capite_new pro_capite_pre popolazione variazione_com;
run;
proc univariate data = nuovabis nextrobs = 50;
	where popolazione >= 20;
	var varia_nuova_bis;
	histogram varia_nuova_bis;
	id nome_comune sigla_provincia pro_capite_new pro_capite_pre popolazione variazione_com;
run;
proc univariate data = nuovabis nextrobs = 50;
	var pro_capite_pre pro_capite_new;
	histogram pro_capite_pre pro_capite_new;
	id nome_comune sigla_provincia popolazione varia_nuova_bis;
run;

*salvo;
/*
data sez_out.economica_sezione;
	set nuovabis;
	keep codice_sezione reddito_qua_new;
	rename reddito_qua_new = reddito;
run;
proc sort data = sez_out.economica_sezione;
	by codice_sezione;
run;
data sez_out.economica_sezione;
	set sez_out.economica_sezione;
	anno_riferimento = 2020;
	release = 2021;
run;
*/

