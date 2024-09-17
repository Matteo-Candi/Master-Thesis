****************************************************************************************;
* IMPORTAZIONE DATI ACI 2020                                                            ;
* CLASSIFICAZIONE EURO                                                                  ;
****************************************************************************************;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;
options nolabel;

*Importo i dati;
PROC IMPORT OUT= WORK.importato
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Circolante_Copert_2020.xls"
            DBMS=EXCEL2000 REPLACE;
			SHEET="AV per comune ";
     		RANGE="A2:L8117";
     		GETNAMES=YES;
RUN;

*Elimino subtotali e voci NON DEFINITO;
data nuovo;
	attrib comune length = $55. format = $55. informat = $55.;
	set importato;
	if index(comune, "NON DEFINITO") > 0
	or index(comune, "DATI DI RESIDENZA") > 0 or
	comune = " "
		then delete;
	array variabile{*} _numeric_; *sostituisco i missing con 0;
	do i = 1 to dim(variabile);
		if variabile{i} = . then variabile{i} = 0;
	end;
	drop i /*non_contemplato non_definito totale*/;
run; *7.903;

*Correggo le province;
data intermedio;
	attrib provincia1 length = $28. format = $28. informat = $28.;
	retain provincia1;
	set nuovo;
	if provincia ne "" then provincia1 = provincia;
*	drop provincia;
run;
data intermedio;
	set intermedio;
	if provincia1 = "AOSTA" then provincia1 = "VALLE D'AOSTA";
	if provincia1 = "BARLETTA TRANI" then provincia1 = "BARLETTA-ANDRIA-TRANI";
	if provincia1 = "FORLI'-CESENA" then provincia1 = "FORL�-CESENA";
	if provincia1 = "MASSA CARRARA" then provincia1 = "MASSA-CARRARA";
	if provincia1 = "MONZA BRIANZA" then provincia1 = "MONZA E DELLA BRIANZA";
	if provincia1 = "REGGIO EMILIA" then provincia1 = "REGGIO NELL'EMILIA";
	if provincia1 = "VERBANO CUSIO OSSOLA" then provincia1 = "VERBANO-CUSIO-OSSOLA";
run;

*Correggo i comuni;
PROC IMPORT OUT= WORK.rettifica
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\rettifica_comuni_aci.xlsx"
            DBMS=EXCEL2000 REPLACE;
			SHEET="Sheet1";
     		GETNAMES=YES;
RUN;
proc sort data = rettifica;
	by comune_originale;
run;
data errore;
	set rettifica;
	if comune_originale = lag(comune_originale);
run;	*vuoto;
proc sort data = intermedio;
	by comune;
run;
data intermedio1;
	merge intermedio rettifica (rename=(comune_originale=comune) drop = fase_attribuzione);
	by comune;
run;
data controllo;
	set intermedio1;
	if length(comune) > 34 /*or length(provincia1) > 30*/;
run;	*vuoto;
data intermedio1;
	set intermedio1;
	length comune_match $ 34
		   nome_provincia $ 30;

	comune1 = comune_modificato;
	if comune1 = "" then do;
		comune1 = tranwrd(comune,"A'","�");
		if (index(comune1," DE'") = 0 and index(comune1," NE'") = 0)
			then comune1 = tranwrd(comune1,"E'","�");
		comune1 = tranwrd(comune1,"I'","�");
		if comune1 ~= "VO'"
			then comune1 = tranwrd(comune1,"O'","�");
		comune1 = tranwrd(comune1,"U'","�");
	end;

	nome_provincia = provincia1;
	comune_match = translate(comune1," ","-");

run;
data manc;
	set intermedio1;
	if comune_match = '';
run;	*vuoto;

*Abbino codice comunale;
data geog;
	set ter_out.geografica_comune;
	comune_match = translate(nome_comune," ","-");
	keep codice_comune__str nome_comune comune_match nome_provincia;
run;
proc sort data = geog;
	by nome_provincia comune_match;
run;
proc sort data = intermedio1;
	by nome_provincia comune_match;
run;
data abbinato dati_ko solo_geo;
	merge geog (in = a) intermedio1 (in = b);
	by nome_provincia comune_match;
	if a = 1 and b = 1 then output abbinato;
	if a = 0 and b = 1 then output dati_ko;
	if a = 1 and b = 0 then output solo_geo;
run;

*Controllo i totali;
data ct_tot;
	set abbinato;
	if sum(of EURO_0-EURO_6) + non_contemplato + non_definito ~= totale;
run; *vuoto;
data parco;
	set appo.parco_veicolare;
	keep codice_comune__str autovetture;
run;
proc sort data = parco;
	by codice_comune__str;
run;
proc sort data = abbinato;
	by codice_comune__str;
run;
data abbinato_parco;
	merge abbinato parco;
	by codice_comune__str;
run;
data anomalo;
	set abbinato_parco;
	if autovetture ~= totale;
run; *Per il comune di Roccella Ionica RC il dettaglio EURO � pressoch� assente;

*Recupero non assegnati della provincia e stimo i dati dell'anno corrente;
data non_definito_rc;
	set importato;
	if comune = "NON DEFINITO RC";
run;
data _null_;
	set anomalo;
	call symput('totale_corrente',trim(left(autovetture)));
run;
%put _user_;
data roccella_stima;
	set non_definito_rc;
	array eurovett{8} euro_0 euro_1 euro_2 euro_3 euro_5 euro_6 non_contemplato non_definito;
	do i = 1 to 8;
		eurovett{i} = round(eurovett{i}*&totale_corrente/totale);
	end;
	euro_4 = &totale_corrente - sum(euro_0,euro_1,euro_2,euro_3,euro_5,euro_6,non_contemplato,non_definito);
	totale = sum(euro_0,euro_1,euro_2,euro_3,euro_4,euro_5,euro_6,non_contemplato,non_definito);
	comune = "ROCCELLA IONICA";
	drop provincia i;
run;
title "CONTROLLO DI COERENZA STIMA ROCCELLA IONICA E NON ASSEGNATO RC";
proc print data = roccella_stima;
*	var comune euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6 non_contemplato non_definito totale;
run;
proc print data = importato;
	where comune in ("ROCCELLA IONICA", "NON DEFINITO RC");
	var comune euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6 non_contemplato non_definito totale;
run;

*Sostituisco i dati stimati;
data abbinato_parco_ok roccella_ko;
	set abbinato_parco;
	if comune = "ROCCELLA IONICA"
		then output roccella_ko;
		else output abbinato_parco_ok;
run;
data roccella_ok;
	merge roccella_ko (drop = euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6 non_contemplato non_definito totale)
		  roccella_stima;
	by comune;
	nota = "Dati EURO stimati sulla base dei non definiti della provincia in quanto pressoch� assenti";
run;
data abbinato_ricostruito;
	set abbinato_parco_ok roccella_ok;
	rename non_contemplato = euro_non_contemplato
		   non_definito = euro_non_definito;
run;
title "TOTALI";
proc tabulate data = abbinato_ricostruito;
	var euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6 euro_non_contemplato euro_non_definito;
	table (euro_0 euro_1 euro_2 euro_3 euro_4 euro_5 euro_6 euro_non_contemplato euro_non_definito),sum*f=comma12.;
run;

*Salvo;
%let tracciato = 
codice_comune__str
euro_0
euro_1
euro_2
euro_3
euro_4
euro_5
euro_6
euro_non_contemplato
euro_non_definito
nota;
data risultato;
	retain &tracciato;
	set abbinato_ricostruito;
	keep &tracciato;
run;
proc sort data = risultato;
	by codice_comune__str;
run;
data parco_veicolare;
	set appo.parco_veicolare;
run;
proc sort data = parco_veicolare;
	by codice_comune__str;
run;
data parco_veicolare_euro;
	merge parco_veicolare risultato;
	by codice_comune__str;
	anno_riferimento = 2020;
	release = 2021;
run;
data errore;
	set parco_veicolare_euro;
	if autovetture ~= sum(euro_0,euro_1,euro_2,euro_3,euro_4,euro_5,euro_6,euro_non_contemplato,euro_non_definito);
run; *vuoto;
/*
data ter_out.parco_veicolare_comune;
	set parco_veicolare_euro;
run;
*/
