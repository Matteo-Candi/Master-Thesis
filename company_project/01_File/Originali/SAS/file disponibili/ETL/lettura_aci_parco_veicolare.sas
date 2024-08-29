****************************************************************************************;
*ELABORAZIONE FILE COMUNALE ACI                                                         ;
*PARCO VEICOLARE 2020    	                                                            ;
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
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Parco_veicolare_2020.xlsx"
            DBMS=EXCEL2000 REPLACE;
			SHEET="Comune categoria";
     		RANGE="B2:O8138";
     		GETNAMES=YES;
RUN;

*Elimino subtotali e voci NON IDENTIFICATO e rinomino le variabili;
*Le condizioni sono state impostate su casi storici e potrebbero essere pazialmente superflue attualmente;
data nuovo;
	set importato;
	if index(provincia, "Totale") > 0
	or (substr(comune, 1, 12) = "NON DEFINITO") 
	or comune in ("", "DATI DI RESIDENZA NON CODIFICABILI")
	or index(provincia, "NON DEFINITO") > 0
	or index(comune, "zzNON DEFINITO") > 0
		then delete;
	array variabile{*} _numeric_; *sostituisco i missing con 0;
	do i = 1 to dim(variabile);
		if variabile{i} = . then variabile{i} = 0;
	end;
	drop i;
run; *7.903;
data intermedio;
	attrib comune length = $55.;
	retain provincia1;
	set nuovo;
	if provincia ne "" then provincia1 = provincia;
	rename autoveicoli_speciali___specifici = autoveicoli_speciali_specifici
		   motocarri_e_quadricicli_trasport = motocarri_quadricicli_trasporto
		   motoveicoli_e_quadricicli_specia = motoveicoli_quadricicli_speciali
		   rimorchi_e_semirimorchi_speciali = rimorchi_semirimorchi_speciali
		   rimorchi_e_semirimorchi_trasport = rimorchi_semirimorchi_trasporto
		   trattori_stradali_o_motrici = trattori_stradali_motrici;
*	drop provincia;
run;

*Importo le rettifiche delle denominazioni ACI dei comuni;
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

*Applico le correzioni;
data controllo;
	set intermedio1;
	if length(comune) > 34 or length(provincia) > 30;
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

	if provincia1 = "AOSTA" then provincia1 = "VALLE D'AOSTA";
	if provincia1 = "BARLETTA TRANI" then provincia1 = "BARLETTA-ANDRIA-TRANI";
	if provincia1 = "FORLI'-CESENA" then provincia1 = "FORL�-CESENA";
	if provincia1 = "MASSA CARRARA" then provincia1 = "MASSA-CARRARA";
	if provincia1 = "MONZA BRIANZA" then provincia1 = "MONZA E DELLA BRIANZA";
	if provincia1 = "REGGIO EMILIA" then provincia1 = "REGGIO NELL'EMILIA";
	if provincia1 = "VERBANO CUSIO OSSOLA" then provincia1 = "VERBANO-CUSIO-OSSOLA";

	nome_provincia = provincia1;
	comune_match = translate(comune1," ","-");

*	drop provincia1 provincia comune comune1;
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

*Verifico le quadrature;
data chk;
	set abbinato;
	if 2*totale ne sum(of _numeric_);
run; *vuoto;

*Controllo se ci sono valori < 0;
data chk;
	set abbinato;
	if autobus < 0
	or autocarri_trasporto_merci < 0
	or autoveicoli_speciali_specifici < 0
	or autovetture < 0
	or motocarri_quadricicli_trasporto < 0
	or motocicli < 0
	or motoveicoli_quadricicli_speciali < 0
	or rimorchi_semirimorchi_speciali < 0
	or rimorchi_semirimorchi_trasporto < 0
	or trattori_stradali_motrici < 0
	or non_definito < 0
	or totale < 0;
run;	*vuoto;

*Calcolo ed esamino le variazioni rispetto all'ultimo dato disponibile;
data demo_old;
	set ter.demo20b;
	keep codc620b pop19;
	rename codc620b = codice_comune__str
		   pop19 = popolazione_old;
run;
proc means data = ter_out.Popolazione_eta_sesso_comune noprint;
	class codice_comune__str;
	types codice_comune__str;
	output out = demo_new (drop = _type_ _freq_)
		   sum(popolazione) = ;
run;
proc means data = ter.Imprese_dettcom20b noprint;
	class codc620b;
	types codc620b;
	output out = unita_locali (drop = _type_ _freq_)
		   sum(totale_imprese) = unita_locali;
run;
data precedente;
	set ter.miscel20b;
	keep codc620b auto19 carri19;
	rename codc620b = codice_comune__str
		   auto19 = autovetture_old
		   carri19 = autocarri_old;
run;
proc sort data = precedente;
	by codice_comune__str;
run;
proc sort data = abbinato;
	by codice_comune__str;
run;
data abbinato_chk;
	merge abbinato demo_old precedente demo_new unita_locali (rename=(codc620b=codice_comune__str));
	by codice_comune__str;
run;
data chkvar;
	set abbinato_chk;

	carridif = autocarri_trasporto_merci - autocarri_old;
	if autocarri_old > 0 then carrivar = 100*carridif/autocarri_old;

	autodif = autovetture - autovetture_old;
	if autovetture_old > 0 then autovar = 100*autodif/autovetture_old;

	carriperul = autocarri_trasporto_merci/unita_locali;

	autoperab = autovetture/popolazione;
	autoperab_old = autovetture_old/popolazione_old;
run;
title "VARIAZIONE NUMERO DEI CARRI";
proc univariate data = chkvar nextrobs = 50;
	var carridif carrivar;
	id nome_comune nome_provincia autocarri_trasporto_merci autocarri_old carriperul; 
run;
title "VARIAZIONE NUMERO DELLE AUTO";
proc univariate data = chkvar nextrobs = 20;
	var autodif autovar;
	id nome_comune nome_provincia autovetture autovetture_old popolazione autoperab;
run;
title "AUTOCARRI PER UL";
proc univariate data = chkvar nextrobs = 20;
	var carriperul;
	id nome_comune nome_provincia autocarri_trasporto_merci autocarri_old carrivar unita_locali;
	histogram carriperul;
run;
title "AUTO PER ABITANTE";
proc univariate data = chkvar nextrobs = 20;
	var autoperab;
	id nome_comune nome_provincia autovetture autovetture_old autovar popolazione;
	histogram autoperab;
run;

*Controllo i totali;
%let elenco = 
autovetture
autocarri_trasporto_merci
autobus
autoveicoli_speciali_specifici
motocarri_quadricicli_trasporto
motocicli
motoveicoli_quadricicli_speciali
rimorchi_semirimorchi_speciali
rimorchi_semirimorchi_trasporto
trattori_stradali_motrici
non_definito
totale;
title2 "TOTALI 2019";
proc tabulate data = abbinato_chk;
	var &elenco autovetture_old autocarri_old;
	table &elenco autovetture_old autocarri_old,sum*f=comma18.;
run;

*Salvo;
data risultato;
	retain codice_comune__str &elenco;
	set abbinato;
	keep codice_comune__str &elenco;
run;
/*
data appo.parco_veicolare;
	set risultato;
run;
*/
