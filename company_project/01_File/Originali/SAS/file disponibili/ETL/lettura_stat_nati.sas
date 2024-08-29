*********************************************************************;
*IMPORTAZIONE DATI SULLE NASCITE PER ET� DELLA MADRE                 ;
*********************************************************************;

*Al momento dell'elaborazione sono disponibili dati al 2019;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

title1 "IMPORTAZIONE DATI SULLE NASCITE PER ET� DELLA MADRE";

*Importo i dati Istat;
data provincia;
	infile "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\DCIS_NATI1_provincia.csv"
	firstobs = 2	/*prima riga dati*/
	lrecl = 512		/*lunghezza record*/
	dlm = ","		/*delimitatore; dlm = '09'x per tab*/
	dsd				/*assegna un missing a due delimitatori consecutivi*/
	stopover;		/*arresta il processo in caso di tentativo di lettura a capo*/
	input
	itter107 : $5.
	territorio_di_residenza : $34.
	tipo_dato15	: $18.
	tipo_dato : $50.
	cittadinanza : $5.
	cittadinanza_della_madre : $11.
	eta1_a : $6.
	eta_della_madre : $14.
	time
	tempo
	valore
	flag_codes : $2.
	flags : $1.
;
run;

title2 "FREQUENZA DELLE VARIABILI DI CLASSIFICAZIONE";
proc freq data = provincia;
	tables itter107*territorio_di_residenza /list;
run;
proc freq data = provincia;
	tables tipo_dato15*tipo_dato /list;
run;
proc freq data = provincia;
	tables cittadinanza*cittadinanza_della_madre /list;
run;
proc freq data = provincia;
	tables eta1_a*eta_della_madre /list;
run;
proc freq data = provincia;
	tables time*tempo /list;
run;
proc freq data = provincia;
	tables flag_codes*flags /list missing;
run;

*Seleziono le colonne e righe effettivamente utili;
data provincia_selez1;
	set provincia;
	if length(itter107) = 5;
	keep itter107 territorio_di_residenza cittadinanza cittadinanza_della_madre
		 eta1_a	eta_della_madre time valore;
run;
title2 "FREQUENZA DELLE VARIABILI DI CLASSIFICAZIONE";
proc freq data = provincia_selez1;
	tables itter107*territorio_di_residenza /list;
run;
proc freq data = provincia_selez1;
	tables cittadinanza*cittadinanza_della_madre /list;
run;
proc freq data = provincia_selez1;
	tables eta1_a*eta_della_madre /list;
run;
data provincia_selez2;
	set provincia_selez1;
	if cittadinanza = "TOTAL" and eta1_a ~= "TOTAL";
run;

*Abbino la geografia provinciale ai territori;
data territorio;
	set provincia_selez2;
	nome_provincia = upcase(territorio_di_residenza);
	if nome_provincia = "BOLZANO / BOZEN"
		then nome_provincia = "BOLZANO";
	if nome_provincia = "VALLE D'AOSTA / VALL�E D'AOSTE"
		then nome_provincia = "VALLE D'AOSTA";
	if nome_provincia = "REGGIO DI CALABRIA"
		then nome_provincia = "REGGIO CALABRIA";
	keep territorio_di_residenza nome_provincia;
run;
title2 "CONTROLLO ASSEGNAZIONI NOMI PROVINCIA";
proc freq data = territorio;
	where nome_provincia ~= upcase(territorio_di_residenza);
	tables territorio_di_residenza*nome_provincia /list;
run;
proc sort data = territorio;
	by nome_provincia;
run;
data territorio;
	set territorio;
	by nome_provincia;
	if first.nome_provincia;
run; *106;
data geog_prov;
	set ter_out.geografica_comune;
	keep codice_provincia nome_provincia sigla_provincia nome_regione;
run;
proc sort data = geog_prov;
	by nome_provincia;
run;
data geog_prov;
	set geog_prov;
	by nome_provincia;
	if first.nome_provincia;
run; *107;
data territorio_match soloter sologeo;
	merge territorio (in = a) geog_prov (in = b);
	by nome_provincia;
	if a = 1 and b = 1 then output territorio_match;
	if a = 1 and b = 0 then output soloter; /*0: ok*/
	if a = 0 and b = 1 then output sologeo; /*1: Sud Sardegna*/
run;

*Abbino i riferimenti geografici al file Istat;
proc sort data = provincia_selez2;
	by territorio_di_residenza;
run;
proc sort data = territorio_match;
	by territorio_di_residenza;
run;
data provincia_selez3;
	merge territorio_match provincia_selez2;
	by territorio_di_residenza;
run; /*3.638*/

*Ricostruisco i dati della provincia Sud Sardegna che risultano mancanti;
data sardegna_istat;
	set provincia;
	if territorio_di_residenza = "Sardegna"
	and cittadinanza = "TOTAL"
	and eta1_a ~= "TOTAL";
	keep itter107 territorio_di_residenza cittadinanza cittadinanza_della_madre
		 eta1_a	eta_della_madre time valore;
run;
proc means data = provincia_selez3 noprint;
	where nome_regione = "SARDEGNA";
	class eta1_a;
	types eta1_a;
	output out = sardegna_calc (drop = _type_ _freq_)
		   sum(valore) = /autoname;
run;
proc sort data = sardegna_istat;
	by eta1_a;
run;
data sardegna_cfr;
	merge sardegna_istat sardegna_calc;
	by eta1_a;
run;
data errore;
	set sardegna_cfr;
	if valore < valore_sum;
run; *vuoto;
data su_ricostruita;
	set sardegna_cfr;
	totale = valore;
	valore = totale - valore_sum;
	territorio_di_residenza = "Sud Sardegna";
	drop itter107 valore_sum totale;
run;
title2 "TOTALE SUD SARDEGNA RICOSTRUITO";
proc tabulate data = su_ricostruita;
	var valore;
	table valore,sum*f=comma12.;
run;

*Verifico che il valore sia plausibile;
data selezione_com_su;
	set ter.geog20b;
	if sigla20b = "SU";
	keep codc620b sigla20b;
run;
proc sort data = selezione_com_su;
	by codc620b;
run;
data oldeta;
	set ter.etapop20b;
run;
proc sort data = oldeta;
	by codc620b;
run;
data oldetasel;
	merge selezione_com_su (in = sele) oldeta;
	by codc620b;
	if sele;
run;
title2 "POPOLAZIONE SUD SARDEGNA 0 ANNI";
proc tabulate data = oldetasel;
	where eta = 0;
	var totale;
	table totale,sum*f=comma12.;
run; *OK: discrepanza di 28 unit�;

*Riabbino i riferimenti geografici;
data provincia_selez2bis;
	set provincia_selez2 su_ricostruita;
run;
proc sort data = provincia_selez2bis;
	by territorio_di_residenza;
run;
data sologeobis;
	set sologeo;
	territorio_di_residenza = "Sud Sardegna";
run;
data territorio_matchbis;
	set territorio_match sologeobis;
	drop nome_regione;
run;
proc sort data = territorio_matchbis;
	by territorio_di_residenza;
run;
data provincia_selez3bis;
	merge territorio_matchbis provincia_selez2bis;
	by territorio_di_residenza;
	rename time = anno_riferimento;
run;
title2 "TOTALE NATI";
proc tabulate data = provincia_selez3bis;
	var valore;
	table valore,sum*f=comma12.;
run;

*Salvo;
%let tracciato =
codice_provincia
nome_provincia
sigla_provincia
eta1_a
eta_della_madre
anno_riferimento
valore;
data risultato;
	set provincia_selez3bis;
	keep &tracciato;
run;
options nolabel;
/*
data appo.nati_eta_madre_provincia_istat;
	set risultato;
run;
*/
