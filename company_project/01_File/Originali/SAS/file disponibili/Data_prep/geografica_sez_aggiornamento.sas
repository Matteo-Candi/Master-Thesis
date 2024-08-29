*********************************************************************;
*AGGIORNAMENTO SEZIONE GEOGRAFICA PER SEZIONE DI CENSIMENTO          ;
*********************************************************************;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

*recupero la geografia precedente;
data precedente;
	set sez.geog20b;
	keep cods11 codc620b sups longx laty;
	rename cods11 = codice_sezione
		   codc620b = codice_comune__str
		   sups = superficie_sezione
		   longx = longitudine_centroide_sezione
		   laty = latitudine_centroide_sezione;
run;

*abbino i dati della tabelle comunale;
data dacom;
set ter_out.geografica_comune;
keep
codice_comune__str
codice_comune__num
nome_comune
codice_provincia
sigla_provincia
nome_provincia
codice_regione
nome_regione
codice_area_nielsen
nome_area_nielsen
codice_area_grav_banc
codice_capo_grav_banc__num
codice_capo_grav_banc__str
nome_area_grav_banc
nome_provincia_grav_banc
altitudine_comune_centrale
codice_zona_altimetrica
nome_zona_altimetrica
flag_litoraneo
flag_isolano
superficie_comune
flag_capoluogo_provincia
flag_multicap
flag_capoluogo_regione
release;
run;
proc sort data = precedente;
	by codice_comune__str;
run;
proc sort data = dacom;
	by codice_comune__str;
run;
data nuova;
	merge precedente dacom;
	by codice_comune__str;
run;

*salvo;
%let tracciato_sez = 
codice_sezione
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
codice_area_grav_banc
codice_capo_grav_banc__num
codice_capo_grav_banc__str
nome_area_grav_banc
nome_provincia_grav_banc
altitudine_comune_centrale
codice_zona_altimetrica
nome_zona_altimetrica
flag_litoraneo
flag_isolano
superficie_comune
superficie_sezione
longitudine_centroide_sezione
latitudine_centroide_sezione
flag_capoluogo_provincia
flag_multicap
flag_capoluogo_regione
release;
data ordinata;
	retain &tracciato_sez;
	set nuova;
run;
options nolabel;
/*
data sez_out.geografica_sezione;
	set ordinata;
run;
*/
