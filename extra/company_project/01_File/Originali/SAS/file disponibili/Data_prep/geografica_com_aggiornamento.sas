*********************************************************************;
*AGGIORNAMENTO SEZIONE GEOGRAFICA COMUNALE                           ;
*********************************************************************;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

*importo la geografia Istat al 31/12/2020;
PROC IMPORT OUT= WORK.nuovo_istat
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Codici-statistici-e-denominazioni-al-31_12_2020.xls"
            DBMS=EXCEL2000 REPLACE;
			SHEET="CODICI al 31_12_2020";
     		GETNAMES=YES;
RUN;
*recupero la geografia precedente;
data precedente;
	set ter.geog20b;
	Codice_Comune_formato_alfanumeri = codc620b;
run;
*abbino le versioni;
proc sort data = precedente;
	by Codice_Comune_formato_alfanumeri;
run;
proc sort data = nuovo_istat;
	by Codice_Comune_formato_alfanumeri;
run;
data confronto;
	merge precedente nuovo_istat;
	by Codice_Comune_formato_alfanumeri;
run;

*effettuo alcuni controlli;
data reg_div;
	set confronto;
	if codr ~= Codice_Regione;
run; *vuoto;
data provistat_div;
	set confronto;
	if Codice_dell_Unit__territoriale_s ~= Codice_Provincia__Storico__1_;
run;
data anomalo;
	set confronto;
	if (Codice_dell_Unit__territoriale_s ~= Codice_Provincia__Storico__1_ and Tipologia_di_Unit__territoriale_ ~= 3)
	or (Codice_dell_Unit__territoriale_s = Codice_Provincia__Storico__1_ and Tipologia_di_Unit__territoriale_ = 3);
run; *vuoto;
proc freq data = provistat_div;
	tables desp20b*Denominazione_dell_Unit__territo /list;
run; *citt� metropolitane;
data prov_div;
	set confronto;
	if codp20b ~= Codice_Provincia__Storico__1_;
run; *vuoto;
data com_div;
	set confronto;
	if desc20b ~= upcase(Denominazione_in_italiano);
run; *210;
proc print data = com_div;
	var desc20b Denominazione_in_italiano;
run;
data provn_div;
	set confronto;
	if desp20b ~= upcase(Denominazione_dell_Unit__territo);
run;
proc freq data = provn_div;
	tables desp20b*Denominazione_dell_Unit__territo /list;
run;
data capo_div;
	set confronto;
	if capolg ~= Flag_Comune_capoluogo_di_provinc;
run; *vuoto;
data sigla_div;
	set confronto;
	if sigla20b ~= Sigla_automobilistica;
run; *vuoto;
proc contents data = confronto varnum;
run;
proc freq data = confronto;
	tables desn*Denominazione_Regione /list;
run;

*aggiorno le denominazioni sulla base dei descrittivi Istat;
data confronto_aggiornato;
	set confronto;
	*;
	nome_comune = upcase(Denominazione_in_italiano);
	nome_ripartizione = upcase(Ripartizione_geografica);
	*;
	length nome_regione $ 30;
	if Denominazione_Regione = "Valle d'Aosta/Vall�e d'Aoste"
		then nome_regione = "VALLE D'AOSTA";
	else if Denominazione_Regione = "Trentino-Alto Adige/S�dtirol"
		then nome_regione = "TRENTINO-ALTO ADIGE";
	else nome_regione = upcase(Denominazione_Regione);
	*;
	length nome_provincia $ 30;
	if Denominazione_dell_Unit__territo = "Valle d'Aosta/Vall�e d'Aoste"
		then nome_provincia = "VALLE D'AOSTA";
	else if Denominazione_dell_Unit__territo = "Bolzano/Bozen"
		then nome_provincia = "BOLZANO";
	else nome_provincia = upcase(Denominazione_dell_Unit__territo);
	*;
	release = 2021;
run;
proc freq data = confronto_aggiornato;
	where nome_regione ~= upcase(Denominazione_Regione);
	tables Denominazione_Regione*nome_regione /list;
run;
proc freq data = confronto_aggiornato;
	where nome_provincia ~= upcase(Denominazione_dell_Unit__territo);
	tables Denominazione_dell_Unit__territo*nome_provincia /list;
run;
*seleziono e rinomino i campi;
%let selezione = 
codc20b
codc620b
codn
desn
altcen
zonac
deszoc
litor
supc
multicap
caporeg
cag
desa
despa
codc20ba
codc620ba
Codice_Regione
Codice_dell_Unit__territoriale_s
Codice_Provincia__Storico__1_
nome_comune
Codice_Ripartizione_Geografica
nome_ripartizione
nome_regione
nome_provincia
Tipologia_di_Unit__territoriale_
Flag_Comune_capoluogo_di_provinc
Sigla_automobilistica
Codice_Catastale_del_comune
Codice_NUTS1_2010
Codice_NUTS2_2010__3_
Codice_NUTS3_2010
release;
data confronto_ren;
	set confronto_aggiornato;
	rename  codc20b = codice_comune__num
			codc620b = codice_comune__str
			codn = codice_area_nielsen
			desn = nome_area_nielsen
			altcen = altitudine_comune_centrale
			zonac = codice_zona_altimetrica
			deszoc = nome_zona_altimetrica
			litor = flag_litoraneo
			supc = superficie_comune
			multicap = flag_multicap
			caporeg = flag_capoluogo_regione
			cag = codice_area_grav_banc
			desa = nome_area_grav_banc
			despa = nome_provincia_grav_banc
			codc20ba = codice_capo_grav_banc__num
			codc620ba = codice_capo_grav_banc__str
			Codice_Regione = codice_regione
			Codice_dell_Unit__territoriale_s = codice_unita_sovracomunale
			Codice_Provincia__Storico__1_ = codice_provincia
			Codice_Ripartizione_Geografica = codice_ripartizione
			Tipologia_di_Unit__territoriale_ = tipologia_unita_sovracomunale
			Flag_Comune_capoluogo_di_provinc = flag_capoluogo_provincia
			Sigla_automobilistica = sigla_provincia
			Codice_Catastale_del_comune = codice_catastale
			Codice_NUTS1_2010 = codice_nuts1_2010
			Codice_NUTS2_2010__3_ = codice_nuts2_2010
			Codice_NUTS3_2010 = codice_nuts3_2010;
	keep &selezione;
run;
*riordino le colonne;
%let tracciato = 
codice_comune__num
codice_comune__str
nome_comune
codice_provincia
sigla_provincia
nome_provincia
codice_regione
nome_regione
codice_area_nielsen
nome_area_nielsen
codice_ripartizione
nome_ripartizione
altitudine_comune_centrale
codice_zona_altimetrica
nome_zona_altimetrica
flag_litoraneo
superficie_comune
flag_capoluogo_provincia
flag_multicap
flag_capoluogo_regione
codice_unita_sovracomunale
tipologia_unita_sovracomunale
codice_area_grav_banc
nome_area_grav_banc
nome_provincia_grav_banc
codice_capo_grav_banc__num
codice_capo_grav_banc__str
codice_catastale
codice_nuts1_2010
codice_nuts2_2010
codice_nuts3_2010
release;
data confronto_ordinato;
	retain &tracciato;
	set confronto_ren;
run;
proc contents data = confronto_ordinato varnum;
run;

*salvo;
options nolabel;
/*
data ter_out.geografica_comune;
	set confronto_ordinato;
run;
*/

*====================================================================;
*AGGIORNAMENTO CLASSIFICAZIONI STATISTICHE;

*recupero il file salvato;
data salvato;
	set ter_out.geografica_comune;
run;
*recupero le classificazioni statistiche Istat aggiornate;
PROC IMPORT OUT= WORK.cla_istat
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Classificazioni statistiche-e-dimensione-dei-comuni_31_12_2020.xls"
            DBMS=EXCEL2000 REPLACE;
			SHEET="Comuni al 31122020";
     		GETNAMES=YES;
RUN;
data mancante;
	set cla_istat;
	if Codice_Istat_del_Comune___alfanu = '';
run; *23 righe vuote;
data cla_istat;
	set cla_istat;
	if Codice_Istat_del_Comune___alfanu ~= '';
run;
proc contents data = cla_istat varnum;
run;
*abbino i data set;
proc sort data = salvato;
	by codice_comune__str;
run;
proc sort data = cla_istat;
	by Codice_Istat_del_Comune___alfanu;
run;
data abbinato;
	merge salvato cla_istat (rename=(Codice_Istat_del_Comune___alfanu=codice_comune__str)
							 keep = Codice_Istat_del_Comune___alfanu
									Superficie_territoriale__kmq__al
									Zona_altimetrica
									Altitudine_del_centro__metri_
									Comune_litoraneo
									Comune_isolano);
	by codice_comune__str;
run;

*controllo la superficie;
data sup_div;
	set abbinato;
	if superficie_comune ~= Superficie_territoriale__kmq__al;
run; *vuoto;

*controllo la sona altimetrica;
proc freq data = abbinato;
	tables Zona_altimetrica*codice_zona_altimetrica*nome_zona_altimetrica /list;
run; *coerente;

*controllo l'altitudine;
data alt_div;
	set abbinato;
	if altitudine_comune_centrale ~= Altitudine_del_centro__metri_;
run; *vuoto;

*controllo il flag di litoraneit�;
data lit_div;
	set abbinato;
	if flag_litoraneo ~= Comune_litoraneo;
run; *2 casi;

*a seguito delle verifiche:
- aggiorno flag di litoraneit�
- aggiungo flag di insularit�;

data aggiornato;
	set abbinato;
	flag_litoraneo = Comune_litoraneo;
	rename Comune_isolano = flag_isolano;
	drop Superficie_territoriale__kmq__al
		 Zona_altimetrica
		 Altitudine_del_centro__metri_
		 Comune_litoraneo;
run;

*salvo;
%let tracciato_bis = 
codice_comune__num
codice_comune__str
nome_comune
codice_provincia
sigla_provincia
nome_provincia
codice_regione
nome_regione
codice_area_nielsen
nome_area_nielsen
codice_ripartizione
nome_ripartizione
altitudine_comune_centrale
codice_zona_altimetrica
nome_zona_altimetrica
flag_litoraneo
flag_isolano
superficie_comune
flag_capoluogo_provincia
flag_multicap
flag_capoluogo_regione
codice_unita_sovracomunale
tipologia_unita_sovracomunale
codice_area_grav_banc
nome_area_grav_banc
nome_provincia_grav_banc
codice_capo_grav_banc__num
codice_capo_grav_banc__str
codice_catastale
codice_nuts1_2010
codice_nuts2_2010
codice_nuts3_2010
release;
data riordinato;
	retain &tracciato_bis;
	set aggiornato;
run;
options nolabel;
/*
data ter_out.geografica_comune;
	set riordinato;
run;
*/
