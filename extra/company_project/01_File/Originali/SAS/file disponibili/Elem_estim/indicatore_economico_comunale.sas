*********************************************************************;
*STIMA DEL REDDITO - LIVELLO COMUNALE                                ;
*COSTRUZIONE INDICATORE DI PRESTAZIONE ECONOMICA DEL SISTEMA         ;
*********************************************************************;

*Al fine di tenere conto dei diversi impatti della pandemia sui
 differenti settori economici, si elaborano le variazioni del
 valore aggiunto ponderandole a livello comunale sulla base delle
 unit� locali presenti;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;
options nolabel;

*Importo i dati Istat del valore aggiunto per settore;
PROC IMPORT OUT= WORK.va 
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\valore_aggiunto.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
proc freq data = va;
	tables territorio;
run;
proc freq data = va;
	tables branca_attivitarev2*Branca_attivita_NACE_Rev2 /list;
run;

*fisso il livello territoriale;
data territorio_c;
	set ter_out.geografica_comune;
	length territorio $ 34;
	if nome_provincia in ("TRENTO","BOLZANO")
		then territorio = nome_provincia;
		else territorio = nome_regione;
	keep codice_comune__str territorio nome_regione;
run;
proc sort data = territorio_c;
	by territorio;
run;
data territorio;
	set territorio_c;
	by territorio;
	if first.territorio;
	drop codice_comune__str;
run;
data vat;
	set va (rename=(territorio=territorio_input));
	length territorio $ 34;
	if territorio_input = "Provincia Autonoma Trento"
		then territorio = "TRENTO";
	else if territorio_input = "Provincia Autonoma Bolzano / Bozen"
		then territorio = "BOLZANO";
	else if territorio_input = "Valle d'Aosta / Vallée d'Aoste"
		then territorio = "VALLE D'AOSTA";
	else territorio = upcase(territorio_input);
run;
proc freq data = vat;
	tables territorio*territorio_input /list missing;
run;
proc sort data = vat;
	by territorio;
run;
data vaok solova solote;
	merge territorio (in = te drop = nome_regione) vat (in = va);
	by territorio;
	if te = 1 and va = 1 then output vaok;
	if te = 1 and va = 0 then output solote;
	if te = 0 and va = 1 then output solova;
run;
proc freq data = solova;
	tables territorio*territorio_input /list missing;
run;
data vavar;
	set vaok;
	variazione_va = 100*(va_2020 - va_2019)/va_2019;
run;

*Preparo i codici di settore;
*Importo Ateco aggiornato;
PROC IMPORT OUT= WORK.ateco
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Ateco2007-aggiornamento-2022-struttura.xlsx"
            DBMS=EXCEL2000 REPLACE;
			SHEET="STRUTTURA 01.01.2022";
     		RANGE="A2:B3166";
     		GETNAMES=YES;
			*MIXED = YES;	/*converts numeric data values into character data values for a column that contains mixed data types*/
RUN;
data ateco2;
	set ateco;
	if length(Codice_Ateco_2007) <= 2;
run;
data ateco2;
	retain sezione;
	set ateco2;
	if length(Codice_Ateco_2007) = 1 then sezione = Codice_Ateco_2007;
run;
data ateco2;
	set ateco2;
	if length(Codice_Ateco_2007) = 2;
run;
proc print data = ateco2;
run;
data ateco2;
	set ateco2;
	length BRANCA_ATTIVITAREV2 $ 3;
	if sezione in ("A","F")
		then BRANCA_ATTIVITAREV2 = sezione;
	if "B" <= sezione <= "E"
		then BRANCA_ATTIVITAREV2 = "BTE";
	if "G" <= sezione <= "J"
		then BRANCA_ATTIVITAREV2 = "GTJ";
	if "K" <= sezione <= "N"
		then BRANCA_ATTIVITAREV2 = "KTN";
	if "O" <= sezione <= "U"
		then BRANCA_ATTIVITAREV2 = "OTU";
run;
proc freq data = ateco2;
	tables sezione*BRANCA_ATTIVITAREV2 /list;
run;

*Recupero le UL per comune;
proc tabulate data = ter.Imprese_dettcom20b;
	where codateco2007 = '';
	var totale_imprese;
	table totale_imprese,sum*f=comma12.;
run;
data ul;
	set ter.Imprese_dettcom20b;
	if codateco2007 ~= '';
	ateco2 = substr(codateco2007,1,2);
run;

*Abbino la corrispondenza dei settori;
proc sort data = ul;
	by ateco2;
run;
proc sort data = ateco2;
	by Codice_Ateco_2007;
run;
data ul;
	merge ateco2 (rename=(Codice_Ateco_2007=ateco2) keep = Codice_Ateco_2007 BRANCA_ATTIVITAREV2)
		  ul (in = presente);
	by ateco2;
	if presente;
run;
data mancante;
	set ul;
	if BRANCA_ATTIVITAREV2 = '';
run; *vuoto;

*Sommo per comune e settore;
proc means data = ul noprint;
	class codc620b BRANCA_ATTIVITAREV2;
	types codc620b*BRANCA_ATTIVITAREV2;
	output out = ulaggre (drop = _type_ _freq_)
		   sum(totale_imprese) = ;
run;

*Abbino il territorio;
proc sort data = ulaggre;
	by codc620b;
run;
proc sort data = territorio_c;
	by codice_comune__str;
run;
data ulaggre;
	merge ulaggre (rename=(codc620b=codice_comune__str)) territorio_c (drop = nome_regione);
	by codice_comune__str;
run;

*abbino le variazioni;
proc sort data = ulaggre;
	by territorio branca_attivitarev2;
run;
proc sort data = vavar;
	by territorio branca_attivitarev2;
run;
data ulaggre;
	merge ulaggre (in = presente) vavar (keep = territorio branca_attivitarev2 variazione_va);
	by territorio branca_attivitarev2;
	if presente;
run;
data mancante;
	set ulaggre;
	if variazione_va = . ;
run; *vuoto;

*aggrego per comune;
proc means data = ulaggre noprint;
	class codice_comune__str;
	types codice_comune__str;
	weight totale_imprese;
	output out = comunale (drop = _type_ _freq_)
		   mean(variazione_va) = ;
run;
proc univariate data = comunale;
	var variazione_va;
	histogram variazione_va;
run;

*Abbino riferimenti territoriali;
data geog;
	set ter_out.geografica_comune;
	keep codice_comune__str nome_comune nome_provincia nome_regione;
run;
proc sort data = geog;
	by codice_comune__str;
run;
data comunale;
	merge geog comunale;
	by codice_comune__str;
run;
proc tabulate data = comunale;
	class nome_regione nome_provincia;
	var variazione_va;
	table nome_regione*(nome_provincia all) all,
		  variazione_va*(min p1 p5 p10 p25 median p75 p90 p95 p99 max)*f=5.1 /nocellmerge;
run;

*Salvo;
/*
data appo.comunale_va;
	set comunale;
run;
*/
