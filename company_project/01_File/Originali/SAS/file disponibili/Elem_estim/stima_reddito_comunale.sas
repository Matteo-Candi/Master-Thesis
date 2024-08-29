*********************************************************************;
*STIMA DEL REDDITO COMUNALE                                          ;
*********************************************************************;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;
options nolabel;

%include "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Macro\macroquadraturagruppo.sas";
%include "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Macro\macroarrotondainterogruppo.sas";

title1 "STIMA COMUNALE DEL REDDITO";

*====================================================================;
*PREPARAZIONE DELLE QUADRATURE                                       ;
*====================================================================;

*Recupero il reddito regionale della release precedente;
data geog;
	set ter_out.geografica_comune;
	length territorio $ 40;
	if nome_regione = "TRENTINO-ALTO ADIGE"
		then territorio = nome_provincia;
		else territorio = nome_regione;
	keep codice_comune__str territorio nome_regione;
run;
proc freq data = geog;
	tables territorio*nome_regione /list;
run;
proc sort data = geog;
	by codice_comune__str;
run;
data eco;
	set ter.econom20b;
	keep codc620b red19;
	rename codc620b = codice_comune__str;
run;
proc sort data = eco;
	by codice_comune__str;
run;
data eco_g;
	merge geog eco;
	by codice_comune__str;
run;
proc means data = eco_g noprint;
	class territorio;
	types territorio;
	output out = regionale_precedente (drop = _type_ _freq_)
		   sum(red19) = reddito_stima_preced;
run;

*Recupero il reddito regionale Istat dell'ultimo biennio;
PROC IMPORT OUT= WORK.reddito_istat 
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\quadratura_reddito.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
data reddito_istat;
	attrib territorio length=$40 format=$40. informat=$40.;
	set reddito_istat;
	territorio = upcase(territorio);
	if territorio = "PROVINCIA AUTONOMA BOLZANO / BOZEN"
		then territorio = "BOLZANO";
	if territorio = "PROVINCIA AUTONOMA TRENTO"
		then territorio = "TRENTO";
	if territorio = "VALLE D'AOSTA / VALLéE D'AOSTE"
		then territorio = "VALLE D'AOSTA";
	rename reddito_2019 = reddito_istat_preced
		   reddito_2020 = reddito_istat_ultimo;
run;
proc sort data = reddito_istat;
	by territorio;
run;
data confronto;
	merge regionale_precedente (in = sele) reddito_istat;
	by territorio;
	if sele;
	difperc = 100*(reddito_stima_preced - reddito_istat_preced)/reddito_istat_preced;
	drop _ itter107;
run;
proc sort data = confronto;
	by difperc;
run;
title2 "REDDITO REGIONALE";
proc print data = confronto;
	format reddito_stima_preced reddito_istat_preced reddito_istat_ultimo comma18.;
	sum reddito_stima_preced reddito_istat_preced reddito_istat_ultimo;
run;

*====================================================================;
*PREPARAZIONE DEI DATI COMUNALI                                      ;
*====================================================================;

*Anagrafica territoriale;
data anacom;
	set ter_out.geografica_comune;
	keep codice_comune__str nome_comune nome_provincia sigla_provincia nome_regione codice_area_nielsen;
run;
proc sort data = anacom;
	by codice_comune__str;
run;

*Popolazione;
proc means data = ter_out.Popolazione_eta_sesso_comune noprint;
	class codice_comune__str;
	types codice_comune__str;
	output out = popolazione_ultima (drop = _type_ _freq_)
		   sum(popolazione) = ;
run;
data popolazione_precedente;
	set ter.demo20b;
	keep codc620b pop19;
	rename codc620b = codice_comune__str
		   pop19 = popolazione_precedente;
run;
proc sort data = popolazione_precedente;
	by codice_comune__str;
run;

*Reddito disponibile precedente e dati immobiliari;
data eco;
	set ter.econom20b;
	keep codc620b red19 medres19;
	rename codc620b = codice_comune__str
		   red19 = reddito_precedente
		   medres19 = prezzi_precedenti;
run;
proc sort data = eco;
	by codice_comune__str;
run;
data ecos;
	set ter.immobiliare_straordinaria20b;
	keep codc620b medres20;
	rename codc620b = codice_comune__str
		   medres20 = prezzi_correnti;
run;
proc sort data = ecos;
	by codice_comune__str;
run;

*Reddito fiscale;
data fisco;
	set ter_out.reddito_fiscale_comune;
	keep codice_comune__str reddito_tot_fasce_amm;
	rename reddito_tot_fasce_amm = reddito_fiscale;
run;
proc sort data = fisco;
	by codice_comune__str;
run;
data mancante;
	set fisco;
	if reddito_fiscale in (0, . );
run; *vuoto;

*Auto per categoria Euro;
data auto;
	set ter_out.parco_veicolare_comune;
	keep codice_comune__str euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6;
run;
proc sort data = auto;
	by codice_comune__str;
run;

*Societ� per classe di fatturato;
data prod;
	set ter.produt20b;
	keep codc620b fatt_1-fatt_6;
	rename codc620b = codice_comune__str;
run;
proc sort data = prod;
	by codice_comune__str;
run;

*Indicatore economico;
data indicatore_va;
	set appo.comunale_va;
	keep codice_comune__str variazione_va;
run;
proc sort data = indicatore_va;
	by codice_comune__str;
run;
title2 "DISTRIBUZIONE INDICATORE ECONOMICO (VARIAZIONE V.A.)";
proc univariate data = indicatore_va;
	var variazione_va;
	histogram variazione_va;
run;

*Abbino i data set;
data base;
	merge anacom geog (keep = codice_comune__str territorio)
		  popolazione_precedente popolazione_ultima eco ecos fisco auto prod indicatore_va;
	by codice_comune__str;
run;
%let vs = 
popolazione_precedente
popolazione
reddito_precedente
reddito_fiscale
euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6
fatt_1 fatt_2 fatt_3 fatt_4 fatt_5 fatt_6;
title2 "TOTALI GRANDEZZE DI INPUT";
proc tabulate data = base;
	var &vs;
	table &vs,sum*f=comma18.;
run;

*Verifico le concentrazioni di auto euro_6.
 Nel corso delle elaborazioni precedenti � sorto il sospetto che le sedi di alcune
 societ� di autonoleggio abbiano impatto sulla concentrazione di queste auto.
 Occorre verificare comuni con incidenza euro_6 elevata e rapporto auto pro capite elevato,
 al fine di valutare la normalizzazione degli indici.
 Tenere sotto osservazione in particolare Trento, Scandicci, Aosta e Bolzano;
data controllo;
	set base;
	auto_euro_pop = sum(euro_0,euro_1,euro_2,euro_3,euro_4,euro_5,euro_6)/popolazione;
	tot_auto_euro = sum(euro_0,euro_1,euro_2,euro_3,euro_4,euro_5,euro_6);
	array euro(*) euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6;
	array pct_euro (*) pct_euro_0 pct_euro_1 pct_euro_2 pct_euro_3 pct_euro_4 pct_euro_5 pct_euro_6;
	do i=1 to dim(euro);
		pct_euro(i) = 100*euro(i)/sum(euro_0,euro_1,euro_2,euro_3,euro_4,euro_5,euro_6);
	end;
	drop i;
run;
title2 "DISTRIBUZIONI RAPPORTI AUTO";
proc univariate data=controllo nextrobs = 20;
	var auto_euro_pop pct_euro_0 pct_euro_1 pct_euro_2 pct_euro_3 pct_euro_4 pct_euro_5 pct_euro_6;
	id codice_comune__str nome_comune sigla_provincia;
run;

*Estraggo statistiche delle societ� di autonoleggio e controllo quelle che hanno un numero elevato di dipendenti;
data autonoleggio;
	set ter.Imprese_dettcom20b;
	if codateco2007 = '77.11.00' and tiposede = 'SL';
	rename codc620b = codice_comune__str;
run;
proc sort data = autonoleggio;
	by codice_comune__str;
run;
data autonoleggio;
	merge anacom autonoleggio (in = presente);
	by codice_comune__str;
	if presente;
run;
proc sort data = autonoleggio;
	by descending id_classe_dipendenti;
run;
title2 "STATISTICHE COMUNALI AUTONOLEGGI COMUNI ATTENZIONATI";
proc print data = autonoleggio;
	where nome_comune in ('AOSTA','BOLZANO','TRENTO','SCANDICCI');
run;

*Esamino le variazioni dei prezzi (rapporti);
*prendo in considerazione anche il quadrato perch� la variazione � semestrale per la releaze corrente
 (I sem. 2020 / II sem. 2019);
data base;
	set base;
	if prezzi_correnti > 0 and prezzi_precedenti > 0
		then rapporto_prezzi = prezzi_correnti/prezzi_precedenti;
	if 0 < rapporto_prezzi
		then rapporto_prezzi_q = rapporto_prezzi**2;
run;
title2 "DISTRIBUZIONE RAPPORTO PREZZI";
proc univariate data = base nextrobs = 20;
	var rapporto_prezzi rapporto_prezzi_q;
	id nome_comune sigla_provincia;
	histogram rapporto_prezzi rapporto_prezzi_q;
run;

*Per prudenza stabilisco di utilizzare il rapporto semplice normalizzato;
proc univariate data = base noprint;
	var rapporto_prezzi;
	output out = estpre
		   pctlpre = p_
		   pctlname = alpre pctlpts = 99
		   pctlname = bapre pctlpts = 1;
run;
data _null_;
	set estpre;
	call symput('alpre',trim(left(p_alpre)));
	call symput('bapre',trim(left(p_bapre)));
run;
%put _user_;
data base;
	set base;
	rapporto_prezzi_n = rapporto_prezzi;
	if . < rapporto_prezzi < &bapre
		then rapporto_prezzi_n = mean(&bapre,rapporto_prezzi);
	if rapporto_prezzi > &alpre
		then rapporto_prezzi_n = mean(&alpre,rapporto_prezzi);
	drop rapporto_prezzi_q;
run;
title2 "RAPPORTO ORIGINALE E NORMALIZZATO";
proc gplot data = base;
	symbol1 i = none  v = dot c = black;
	plot rapporto_prezzi_n * rapporto_prezzi = 1;
run;
quit;
title2 "DISTRIBUZIONE RAPPORTO PREZZI NORMALIZZATO";
proc univariate data = base nextrobs = 20;
	var rapporto_prezzi_n;
	id nome_comune sigla_provincia;
	histogram rapporto_prezzi_n;
run;

*====================================================================;
*ANALISI DEI DATI                                                    ;
*====================================================================;

*Aggiungo correttivo di quadratura del reddito precedente;
proc sort data = base;
	by territorio;
run;
data correttivo;
	set confronto;
	correttivo = reddito_istat_preced/reddito_stima_preced;
	keep territorio correttivo;
run;
proc sort data = correttivo;
	by territorio;
run;
data base;
	merge base correttivo;
	by territorio;
run;

*Esame preliminare delle correlazioni;
*Per la release corrente:
 - introduco correttivo valore aggiunto su dati di reddito per tenere conto
   degli impatti della crisi pandemica sui settori economici
 - utilizzo i prezzi delle case solo attraverso la variazione;
data base1;
	set base;
	reddito_precedente_q = correttivo*reddito_precedente;
	redproult = (1 + variazione_va/100)*reddito_precedente_q/popolazione_precedente;
	fispro = (1 + variazione_va/100)*reddito_fiscale/popolazione_precedente;
	redpro_prezzi = rapporto_prezzi_n*reddito_precedente_q/popolazione_precedente;
	fatt_per_mille_2 = 1000*sum(fatt_2,fatt_3,fatt_4,fatt_5,fatt_6)/popolazione;
	if fatt_per_mille_2 = 0 then fatt_per_mille_2 = . ;
	euro_per_mille_4 = 1000*sum(euro_4, euro_5, euro_6)/popolazione;
run;
title2 "CORRELAZIONI RAPPORTI DI INPUT";
proc corr data = base1;
	var redproult fispro prezzi_precedenti prezzi_correnti redpro_prezzi euro_per_mille_4 fatt_per_mille_2;
run;
title2 "TOTALE REDDITO PRECEDENTE RIQUADRATO (CONTROLLO)";
proc tabulate data = base1;
	var reddito_precedente_q;
	table reddito_precedente_q,sum*f=comma18.;
run;

*Calcolo medie nazionali;
proc means data = base1 noprint;
	weight popolazione;
	output out = medie (drop = _type_ _freq_)
	mean(redproult fispro redpro_prezzi euro_per_mille_4 fatt_per_mille_2) = /autoname;
run;

*Calcolo indici Base Italia = 100;
data medie;
	set medie;
	call symput('redproult_m',trim(redproult_mean));
	call symput('fispro_m',trim(fispro_mean));
	call symput('medres_m',trim(redpro_prezzi_mean));
	call symput('euro_per_mille_4_m',trim(euro_per_mille_4_mean));
	call symput ('fatt_per_mille_2_m',trim(fatt_per_mille_2_mean));
run;
%put _user_;
data base2;
	set base1;
	reddind = 100*redproult/&redproult_m.;
	fiscind = 100*fispro/&fispro_m.;
	if redpro_prezzi ~= . then prezind = 100*redpro_prezzi/&medres_m.;
	if euro_per_mille_4 ~= . then eurind = 100*euro_per_mille_4/&euro_per_mille_4_m.;
	if fatt_per_mille_2 ~= . then fattind = 100*fatt_per_mille_2/&fatt_per_mille_2_m.;
run;

*esame distribuzione indici;
title2 'DISTRIBUZIONE INDICE DEL REDDITO DISPONIBILE';
proc univariate data = base2 nextrobs = 10;
	var reddind;
	id codice_comune__str nome_comune sigla_provincia;
run;
title2 'DISTRIBUZIONE INDICE DEL REDDITO FISCALE';
proc univariate data = base2 nextrobs = 10;
	var fiscind;
	id codice_comune__str nome_comune sigla_provincia;
run;
title2 'DISTRIBUZIONE INDICE DEI PREZZI RESIDENZIALI';
proc univariate data = base2 nextrobs = 10;
	var prezind;
	id codice_comune__str nome_comune sigla_provincia;
run;
title2 'DISTRIBUZIONE INDICE DELLE CATEGORIE AUTO (EURO)';
proc univariate data = base2 nextrobs = 10;
	var eurind;
	id codice_comune__str nome_comune sigla_provincia;
run;
title2 'DISTRIBUZIONE INDICE FATTURATO';
proc univariate data = base2 nextrobs = 10;
	var fattind;
	id codice_comune__str nome_comune sigla_provincia;
run;

title2 "CONFRONTO DISTRIBUZIONI INDICI";
proc tabulate data = base2;
	var reddind fiscind prezind eurind fattind;
	table n*f=comma12. (max p99 p95 p90 p75 p50 p25 p10 p5 p1 min)*f=12.1,
		  reddind fiscind prezind eurind fattind;
run;

data base2;
	set base2;
	drop euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6
		 fatt_1 fatt_2 fatt_3 fatt_4 fatt_5 fatt_6;
run;

*--------------------------------------------------------------------;
*Normalizzo l'indice del reddito fiscale;

proc univariate data = base2 noprint;
	var fiscind;
	output out = estfisc
		   pctlpre = ed
		   pctlname = p99 pctlpts = 99
		   pctlname = p1 pctlpts = 1;
run;
data estfisc;
	set estfisc;
	ponte = 1;
run;
data base2b;
	set base2;
	ponte = 1;
run;
data base2b;
	merge base2b estfisc;
	by ponte;
	if . < fiscind < edp1
		then norfiscind = sum(0.50*edp1,0.50*fiscind);
	else if fiscind > edp99
		then norfiscind = sum(0.4*edp99,0.6*fiscind);
	else norfiscind = fiscind;
	drop ponte edp1 edp99;
run;
title2 "INDICE REDDITO FISCALE NORMALIZZATO E NON";
proc gplot data = base2b;
	symbol1 i = none  v = dot c = black;
	plot norfiscind * fiscind = 1;
run;
quit;
title2 'DISTRIBUZIONE INDICE DEL REDDITO FISCALE NORMALIZZATO';
proc univariate data = base2b nextrobs = 10;
	var norfiscind;
	id codice_comune__str nome_comune sigla_provincia;
	histogram norfiscind;
run;
*Ripristino media Italia = 100;
proc means data = base2b noprint;
	weight popolazione;
	output out = media1d (drop = _type_ _freq_)
		   mean(norfiscind) = /autoname;
run;
data media1d;
	set media1d;
	call symput('norfiscind_m',trim(norfiscind_mean));
run;
%put _user_;
data base2c;
	set base2b;
	newfiscind = 100*norfiscind/&norfiscind_m.;
	drop fiscind norfiscind;
run;
title2 'DISTRIBUZIONE INDICE DEL REDDITO FISCALE RETTIFICATO';
proc univariate data = base2c nextrobs = 10;
	var newfiscind;
	id codice_comune__str nome_comune sigla_provincia;
run;

*--------------------------------------------------------------------;
*Normalizzo l'indice dei prezzi;
*Non necessario per questa release perch� si utilizza un indice
 del reddito precedente corretto con la variazione dei prezzi
 e non un indice dei prezzi;

data base2d;
	set base2c;
	newpreind = prezind;
	drop prezind;
run;

*--------------------------------------------------------------------;
* Normalizzo l'indice EURO (categoria auto);

proc univariate data = base2 noprint;
	var eurind;
	output out = esteur
		   pctlpre = ed
		   pctlname = p99 pctlpts = 99
		   pctlname = p1 pctlpts = 1;
run;
data esteur;
	set esteur;
	ponte = 1;
run;
data base2d;
	set base2d;
	ponte = 1;
run;
data base2d;
	merge base2d esteur;
	by ponte;
	if . < eurind < edp1
		then noreurind = sum(0.50*edp1,0.50*eurind);
	else if eurind > edp99
		then noreurind = sum(0.90*edp99,0.10*eurind);
	else noreurind = eurind;
	drop ponte edp1 edp99;
run;
title2 "INDICE AUTO EURO NORMALIZZATO E NON";
proc gplot data = base2d;
	symbol1 i = none  v = dot c = black;
	plot noreurind * eurind = 1;
run;
quit;
title2 'DISTRIBUZIONE INDICE EUR NORMALIZZATO';
proc univariate data = base2d nextrobs = 10;
	var noreurind;
	id codice_comune__str nome_comune sigla_provincia;
run;
*Ripristino media Italia = 100;
proc means data = base2d noprint;
	weight popolazione;
	output out = media1f (drop = _type_ _freq_)
		   mean(noreurind) = /autoname autolabel;
run;
data media1f;
	set media1f;
	call symput('noreurind_m',trim(noreurind_mean));
run;
%put _user_;
data base2e;
	set base2d;
	neweurind = 100*noreurind/&noreurind_m.;
	drop eurind noreurind;
run;
title2 'DISTRIBUZIONE INDICE EURO RETTIFICATO';
proc univariate data = base2e nextrobs = 10;
	var neweurind;
	id codice_comune__str nome_comune sigla_provincia;
run;

*--------------------------------------------------------------------;
*Normalizzo l'indice del fatturato;

proc univariate data = base2 noprint;
	var fattind;
	output out = estfat
		   pctlpre = ed
		   pctlname = p95 pctlpts = 95
		   pctlname = p5 pctlpts = 5;
run;
data estfat;
	set estfat;
	ponte = 1;
run;
data base2e;
	set base2e;
	ponte = 1;
run;
data base2f;
	merge base2e estfat;
	by ponte;
	if . < fattind < edp5
		then norfatind = sum(0.95*edp5,0.05*fattind);
	else if fattind > edp95
		then norfatind = sum(0.95*edp95,0.05*fattind);
	else norfatind = fattind;
	drop ponte edp5 edp95;
run;
title2 "INDICE FATTURATO NORMALIZZATO E NON";
proc gplot data = base2f;
	symbol1 i = none  v = dot c = black;
	plot norfatind * fattind = 1;
run;
quit;
title2 'DISTRIBUZIONE INDICE DEL FATTURATO NORMALIZZATO';
proc univariate data = base2f nextrobs = 10;
	var norfatind;
	id codice_comune__str nome_comune sigla_provincia;
run;
*Ripristino media Italia = 100;
proc means data = base2f noprint;
	weight popolazione;
	output out = media1t (drop = _type_ _freq_)
		   mean(norfatind) = /autoname;
run;
data media1t;
	set media1t;
	call symput('norfatind_m',trim(norfatind_mean));
run;
%put _user_;
data base2g;
	set base2f;
	newfatind = 100*norfatind/&norfatind_m.;
	drop fattind norfatind;
run;
title2 'DISTRIBUZIONE INDICE DEL FATTURATO RETTIFICATO';
proc univariate data = base2g nextrobs = 10;
	var newfatind;
	id codice_comune__str nome_comune sigla_provincia;
run;

title2 "CONFRONTO DISTRIBUZIONI INDICI DOPO NORMALIZZAZIONE";
proc tabulate data = base2g;
	var reddind newfiscind newpreind neweurind newfatind;
	table n*f=comma12. (max p99 p95 p90 p75 p50 p25 p10 p5 p1 min)*f=12.1,
		  reddind newfiscind newpreind neweurind newfatind;
run;

*--------------------------------------------------------------------;
*Calcolo e confronto punteggi basati su indici;
*Calcolo innanzitutto punteggi del reddito;
proc rank data = base2g out = base5 groups = 100;
	var reddind;
	ranks r_red;
run;
*Calcolo punteggi altri indici utilizzando gli intervalli individuati dal reddito;
proc sort data = base5;
	by r_red;
run;
proc means data = base5 noprint;
	where r_red > 0;
	by r_red;
	output out = minimi (drop = _type_ _freq_)
		   min(reddind) = minimo;
run;
proc transpose data = minimi
			   out = minimit (drop = _NAME_)
			   prefix = pre;
	id r_red;
	var minimo;
run;
data base6;
	set base5;
	ponte = 1;
run;
data minimit;
	set minimit;
	ponte = 1;
run;
data base6;
	merge base6 minimit;
	by ponte;
	drop ponte;
run;

%macro assegnoranking(dentro,fuori,variabile);
data &fuori.;
	set &dentro.;
	array estremo{99} pre1-pre99;
	if . < &variabile. < pre1
		then r_&variabile. = 0;
	do i = 2 to 99;
		if estremo{i-1} <= &variabile. < estremo{i}
			then r_&variabile. = i-1;
	if &variabile. >= pre99
		then r_&variabile. = 99;
	end;
	drop i;
run;
%mend assegnoranking;
*;
%assegnoranking(base6,base7,reddind); /*per controllo*/
data controllo;/*0*/
	set base7;
	if r_red ~= r_reddind;
run;
%assegnoranking(base7,base7,newfiscind);
%assegnoranking(base7,base7,newpreind);
%assegnoranking(base7,base7,neweurind);
%assegnoranking(base7,base7,newfatind);

data base8;
	set base7;
	max_r = max(r_red,r_newfiscind,r_newpreind,r_neweurind,r_newfatind);
	min_r = min(r_red,r_newfiscind,r_newpreind,r_neweurind,r_newfatind);
	scarto_r = max_r - min_r;
	rename r_newfiscind = r_fis
		   r_newpreind = r_pre
		   r_neweurind = r_eur
		   r_newfatind = r_fatt;
	drop pre1-pre99 r_reddind;
run;
title2 'CORRELAZIONE PUNTEGGI';
proc corr data = base8;
	var r_red r_fis r_pre r_eur r_fatt;
run;

title2 'DISTRIBUZIONE SCARTI PUNTEGGI INDICI';
proc univariate data = base8 nextrobs = 10;
	var scarto_r;
	id codice_comune__str nome_comune sigla_provincia;
run;
proc sort data = base8;
	by descending scarto_r;
run;
data ctscarto_r;	*data set di controllo;
	set base8;
	keep codice_comune__str nome_comune sigla_provincia popolazione
		 r_red r_fis r_pre r_eur r_fatt scarto_r;
run;

*====================================================================;
*ELABORAZIONE STIME                                                  ;
*====================================================================;

*Per la release corrente (2021) congelo il criterio di selezionE normalmente utilizzato
 (recuperarlo se occorre da programma originale);

*Stabilisco di utilizzare in tutti i casi
 - stima precedente con correttivo valore aggiunto
 - reddito fiscale (t-1) con correttivo valore aggiunto
 e di selezionare gli altri indici in base al livello di coerenza
 rispetto ai due indici fissi;

*Seleziono i punteggi;
data basestima0a;
	set base8;

	array punteggio{3} r_pre r_eur r_fatt;
	array depurato{3} dep_pre dep_eur dep_fatt;
	array indicein{3} newpreind neweurind newfatind;
	array indiceout{3} predef eurdef fattdef;
	array peso{3} p_pre p_eur p_fat;

	do i = 1 to 3;
		depurato{i} = punteggio{i};
		indiceout{i} = indicein{i};
	end;

	numind = N(predef,eurdef,fattdef);
	do k = 1 to 84;
		soglia = 100 - k;
		do j = 3 to 1 by -1;
			if depurato{j} ~= . 
			and abs(depurato{j} - r_red) > soglia
			and abs(depurato{j} - r_fis) > soglia
			and numind >= 2
				then do;
					depurato{j} = . ;
					indiceout{j} = . ;
					numind = N(predef,eurdef,fattdef);
				end;
		end;
	end;
	
	rif = mean(r_red,r_fis);
	do h = 1 to 3;
		if depurato{h} ~= . 
			then peso{h} = 100/(abs(depurato{h} - rif) + 1);
	end;

	numindout = N(predef,eurdef,fattdef);
	rename reddind = reddef
		   newfiscind = fisdef;
	drop i j k h;
run;
title2 "FREQUENZE NUMERI INDICI UTILIZZABILI";
proc tabulate data = basestima0a;
	class numindout;
	var dep_pre dep_eur dep_fatt;
	table numindout all,n*f=comma12. (dep_pre dep_eur dep_fatt)*n*f=comma12. /nocellmerge;
run;

*Calcolo indice sintetico;
data basestima1;
	set basestima0a;
	ausmedia = sum(predef*p_pre,eurdef*p_eur,fattdef*p_fat)/sum(p_pre,p_eur,p_fat);
	newmedind = mean(reddef,fisdef,ausmedia);
run;
data manc;
	set basestima1;
	if ausmedia = . ;
run; *vuoto;
title2 "INDICE NUOVA STIMA RISPETTO A PRECEDENTE CON CORRETTIVI";
proc gplot data = basestima1;
	symbol1 i = none  v = dot c = black;
	plot newmedind * reddef = 1;
run;
quit;

*Recupero dati di quadratura;
data quadra;
	set confronto;
	keep territorio reddito_istat_ultimo;
run;

*Calcolo totali nazionali e reddito pro capite nazionale;
proc means data = quadra noprint;
	output out = rednaz (drop = _type_ _freq_)
		   sum(reddito_istat_ultimo) = redita;
run;
proc means data = basestima1 noprint;
	output out = popnaz (drop = _type_ _freq_)
		   sum(popolazione) = popita;
run;
data italia;
	set rednaz;
	set popnaz;
	redproit = redita/popita;
	call symput('proit',trim(redproit));
run;
%put _user_;
data basestima1a;
	set basestima1;
	medst = popolazione*&proit.*newmedind/100;
run;
title2 "TOTALE DELLE STIME PRIMA DELLA QUADRATURA";
proc tabulate data = basestima1a;
	var medst;
	table medst,sum*f=comma18.;
run;

*Effettuo la quadratura;
%quadraturagruppo(basestima1a,	/*data set di input*/
				  medst,		/*variabile da quadrare*/
				  quadra,		/*data set totali per gruppo*/
				  reddito_istat_ultimo,	/*variabile per quadratura*/
				  stima_qua,	/*variabile quadrata*/
				  territorio,	/*variabile di raggruppamento*/
				  qua1);		/*data set di output*/
data qua2;
	set qua1;
	stima_qua = round(stima_qua);
run;
%arrotondainterogruppo(qua2,		/*data set di input*/
					   stima_qua,	/*variabile stimata*/
					   quadra,		/*data set dei totali effettivi*/
					   reddito_istat_ultimo,	/*variabile dei totali effettivi*/
					   territorio,	/*variabile di raggruppamento*/
					   qua3);		/*data set di output*/

title2 "TOTALI REGIONALI";
proc tabulate data = qua3;
	class territorio;
	var stima_qua;
	table territorio all,stima_qua*sum*f = comma18.3 /nocellmerge;
run;

*Esamino le variazioni percentuali;
data stima_varia;
	set qua3;
	redpro_ult = stima_qua/popolazione;
	redpro_pre = reddito_precedente/popolazione_precedente;
	redpro_pre_q = reddito_precedente_q/popolazione_precedente;
	varia_effettiva = 100*((redpro_ult/redpro_pre) - 1);
	varia_q = 100*((redpro_ult/redpro_pre_q) - 1);
	rename stima_qua = reddito;
run;
title2 "VARIAZIONE DELLE STIME COMUNALI RISPETTO ALLE STIME PRECEDENTI";
proc univariate data = stima_varia nextrobs = 40;
	var varia_effettiva;
	id codice_comune__str nome_comune sigla_provincia redpro_ult redpro_pre redpro_pre_q;
	histogram varia_effettiva;
run;
title2 "VARIAZIONE DELLE STIME COMUNALI RISPETTO ALLE STIME PRECEDENTI RETTIFICATE";
proc univariate data = stima_varia nextrobs = 40;
	var varia_q;
	id codice_comune__str nome_comune sigla_provincia redpro_ult redpro_pre redpro_pre_q;
	histogram varia_q ;
run;
title2 "VARIAZIONE DELLE STIME COMUNALI RISPETTO ALLE STIME PRECEDENTI RETTIFICATE";
title3 "COMUNI MEDIO-GRANDI";
proc univariate data = stima_varia nextrobs = 40;
	where popolazione >= 50000;
	var varia_q;
	id codice_comune__str nome_comune sigla_provincia redpro_ult redpro_pre redpro_pre_q;
	histogram varia_q ;
run;
title2 'REDDITO PRO CAPITE NUOVO';
proc univariate data = stima_varia nextrobs = 10;
	var redpro_ult;
	id codice_comune__str nome_comune sigla_provincia;
	histogram redpro_ult;
run;
title2 'REDDITO PRO CAPITE PRECEDENTE';
proc univariate data = stima_varia nextrobs = 10;
	var redpro_pre;
	id codice_comune__str nome_comune sigla_provincia;	
	histogram redpro_pre;
run;

*Normalizzo le variazioni;
proc univariate data = stima_varia noprint;
	var varia_q;
	output out = estremi
		   pctlpre = p_
		   pctlname = alto pctlpts = 99
		   pctlname = basso pctlpts = 1;
run;
data _null_;
	set estremi;
	call symput('alto',trim(left(p_alto)));
	call symput('basso',trim(left(p_basso)));
run;
%put _user_;
data stima_norma;
	set stima_varia;
	varia_n = varia_q;
	if varia_q > &alto
		then varia_n = sum(.9*&alto,.1*varia_q);
	if varia_q < &basso
		then varia_n = sum(.5*&basso,.5*varia_q);
run;
title2 "VARIAZIONE ORIGINALE E NORMALIZZATA";
proc gplot data = stima_norma;
	symbol1 i = none  v = dot c = black;
	plot varia_n * varia_q = 1;
run;
quit;
data stima_norma;
	set stima_norma;
	stima_n = reddito;
	if varia_q < &basso or varia_q > &alto
		then stima_n = redpro_pre_q*(1 + varia_n/100)*popolazione;
	drop reddito redpro_ult redpro_pre redpro_pre_q varia_effettiva varia_q;
run;

*Ripeto la quadratura;
%quadraturagruppo(stima_norma,	/*data set di input*/
				  stima_n,		/*variabile da quadrare*/
				  quadra,		/*data set totali per gruppo*/
				  reddito_istat_ultimo,	/*variabile per quadratura*/
				  stima_qua,	/*variabile quadrata*/
				  territorio,	/*variabile di raggruppamento*/
				  qua12);		/*data set di output*/
data qua22;
	set qua12;
	stima_qua = round(stima_qua);
run;
%arrotondainterogruppo(qua22,		/*data set di input*/
					   stima_qua,	/*variabile stimata*/
					   quadra,		/*data set dei totali effettivi*/
					   reddito_istat_ultimo,	/*variabile dei totali effettivi*/
					   territorio,	/*variabile di raggruppamento*/
					   qua32);		/*data set di output*/

title2 "TOTALI REGIONALI";
proc tabulate data = qua3;
	class territorio;
	var stima_qua;
	table territorio all,stima_qua*sum*f = comma18.3 /nocellmerge;
run;

*Esamino le variazioni percentuali;
data stima_varia_bis;
	set qua32;
	redpro_ult = stima_qua/popolazione;
	redpro_pre = reddito_precedente/popolazione_precedente;
	redpro_pre_q = reddito_precedente_q/popolazione_precedente;
	varia_effettiva = 100*((redpro_ult/redpro_pre) - 1);
	varia_q = 100*((redpro_ult/redpro_pre_q) - 1);
	rename stima_qua = reddito;
run;
title2 "VARIAZIONE DELLE STIME COMUNALI RISPETTO ALLE STIME PRECEDENTI";
proc univariate data = stima_varia_bis nextrobs = 40;
	var varia_effettiva;
	id codice_comune__str nome_comune sigla_provincia redpro_ult redpro_pre redpro_pre_q;
	histogram varia_effettiva;
run;
title2 "VARIAZIONE DELLE STIME COMUNALI RISPETTO ALLE STIME PRECEDENTI RETTIFICATE";
proc univariate data = stima_varia_bis nextrobs = 40;
	var varia_q;
	id codice_comune__str nome_comune sigla_provincia redpro_ult redpro_pre redpro_pre_q popolazione;
	histogram varia_q ;
run;
title2 "VARIAZIONE DELLE STIME COMUNALI RISPETTO ALLE STIME PRECEDENTI RETTIFICATE";
title3 "COMUNI MEDIO-GRANDI";
proc univariate data = stima_varia_bis nextrobs = 40;
	where popolazione >= 50000;
	var varia_q;
	id codice_comune__str nome_comune sigla_provincia redpro_ult redpro_pre redpro_pre_q;
	histogram varia_q ;
run;
title2 'REDDITO PRO CAPITE NUOVO';
proc univariate data = stima_varia_bis nextrobs = 20;
	var redpro_ult;
	id codice_comune__str nome_comune sigla_provincia redpro_pre_q;
	histogram redpro_ult;
run;
title2 'REDDITO PRO CAPITE PRECEDENTE';
proc univariate data = stima_varia_bis nextrobs = 10;
	var redpro_pre;
	id codice_comune__str nome_comune sigla_provincia;	
	histogram redpro_pre;
run;

*Esamino evoluzione livelli di reddito;
proc rank data = stima_varia_bis out = stima_varia_ok groups = 10;
	var redpro_ult redpro_pre_q;
	ranks rank_ult rank_pre;
run;
title2 "CONFRONTO RANKING REDDITO PRO CAPITE";
proc freq data = stima_varia_ok;
	table rank_ult*rank_pre /nopercent norow nocol;
run;
proc rank data = stima_varia_bis out = stima_varia_ok_g groups = 10;
	where popolazione >= 50000;
	var redpro_ult redpro_pre_Q;
	ranks rank_ult rank_pre;
run;
title2 "CONFRONTO RANKING REDDITO PRO CAPITE";
title3 "COMUNI MEDIO-GRANDI";
proc freq data = stima_varia_ok_g;
	table rank_ult*rank_pre /nopercent norow nocol;
run;

*Salvataggio;
data risultato;
	set stima_varia_ok (keep = codice_comune__str reddito);
	anno_riferimento = 2020;
	release = 2021;
run;
/*
data ter_out.economica_comune;
	set risultato;
run;
*/
