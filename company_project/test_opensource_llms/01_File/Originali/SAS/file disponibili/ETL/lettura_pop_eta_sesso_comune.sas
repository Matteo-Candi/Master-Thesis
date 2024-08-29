**********************************************************************;
*LETTURA DELLA POPOLAZIONE PER ET� E SESSO AL AL 01/01/2021           ;
**********************************************************************;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;

*Leggo il file comunale Istat;
data comunale_istat;
		infile "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\comuni.csv"
		firstobs = 3	/*prima riga dati*/
		lrecl = 512		/*lunghezza record*/
		dlm = ","		/*delimitatore; dlm = '09'x per tab*/
		dsd				/*assegna un missing a due delimitatori consecutivi*/
		stopover;		/*arresta il processo in caso di tentativo di lettura a capo*/
	input codice_comune
		denominazione : $50.
		eta
		maschi_celibi
		maschi_coniugati
		maschi_divorziati
		maschi_vedovi
		maschi_uniti_civilmente
		mas_gia_unione_civ_scioglimento
		mas_gia_unione_civ_decesso
		tot_maschi
		femmine_nubili
		femmine_coniugate
		femmine_divorziate
		femmine_vedove
		femmine_unite_civilmente
		fem_gia_unione_civ_scioglimento
		femmine_gia_unione_civ_decesso
		tot_femmine
;
run; /*806.106*/

*converto missing in zeri;
data comunale_istat;
	set comunale_istat;
	array varia{16} maschi_celibi maschi_coniugati maschi_divorziati maschi_vedovi
				   maschi_uniti_civilmente mas_gia_unione_civ_scioglimento
				   mas_gia_unione_civ_decesso tot_maschi
				   femmine_nubili femmine_coniugate femmine_divorziate femmine_vedove
				   femmine_unite_civilmente fem_gia_unione_civ_scioglimento
				   femmine_gia_unione_civ_decesso tot_femmine;
	do i = 1 to 16;
		if varia{i} = . then varia{i} = 0;
	end;
	drop i;
run;

data errore_m;
	set comunale_istat;
	if tot_maschi ~= sum(maschi_celibi,maschi_coniugati,maschi_divorziati,maschi_vedovi,
						 maschi_uniti_civilmente,mas_gia_unione_civ_scioglimento,mas_gia_unione_civ_decesso);
run; *vuoto;
data errore_f;
	set comunale_istat;
	if tot_femmine ~= sum(femmine_nubili,femmine_coniugate,femmine_divorziate,femmine_vedove,
						  femmine_unite_civilmente,fem_gia_unione_civ_scioglimento,femmine_gia_unione_civ_decesso);
run; *vuoto;

*Controllo i totali per comune, separando i totali (eta = 999);
data chk_eta chk_sum;
	set comunale_istat;
	if eta = 999 then output chk_eta; /*7.903*/
	else output chk_sum; 			/*798.203*/
run;
proc sort data = chk_eta;
	by codice_comune;
run;
proc sort data = chk_sum;
	by codice_comune;
run;
proc means data = chk_sum noprint;
	by codice_comune;
	output out = sum_tot (drop = _type_ _freq_ eta_sum) 
		   sum = /autoname;
run;

*Verifico quadrature;
data unione;
	merge sum_tot chk_eta;
	by codice_comune;
run;
data errore;
	set unione;
	if maschi_celibi ~= maschi_celibi_sum
	or maschi_coniugati ~= maschi_coniugati_sum
	or maschi_divorziati ~= maschi_divorziati_sum
	or maschi_vedovi ~= maschi_vedovi_sum
	or maschi_uniti_civilmente ~= maschi_uniti_civilmente_sum
	or mas_gia_unione_civ_scioglimento ~= mas_gia_unione_civ_sciogli_sum
	or mas_gia_unione_civ_decesso ~= mas_gia_unione_civ_decesso_sum
	or tot_maschi ~= tot_maschi_sum
	or femmine_nubili ~= femmine_nubili_sum
	or femmine_coniugate ~= femmine_coniugate_sum
	or femmine_divorziate ~= femmine_divorziate_sum
	or femmine_vedove ~= femmine_vedove_sum
	or femmine_unite_civilmente ~= femmine_unite_civilmente_sum
	or fem_gia_unione_civ_scioglimento ~= fem_gia_unione_civ_sciogli_sum
	or femmine_gia_unione_civ_decesso ~= femmine_gia_unione_civ_dec_sum
	or tot_femmine ~= tot_femmine_sum;
run; *vuoto;

*Abbino codice comunale in formato testo;
data geog;
	set ter_out.geografica_comune;
	keep codice_comune__num codice_comune__str;
	rename codice_comune__num = codice_comune;
run;
proc sort data = geog;
	by codice_comune;
run;
proc sort data = chk_sum;
	by codice_comune;
run;
data abbinato;
	merge geog chk_sum;
	by codice_comune;
run;
data mancante;
	set abbinato;
	if tot_maschi = . 
	or tot_femmine = . ;
run;	*vuoto;

*Preparo il file di output;
data risultato;
	set abbinato;
	popolazione = tot_maschi + tot_femmine;
	anno_riferimento = 2020;
	release = 2021;
	rename tot_maschi = maschi
		   tot_femmine = femmine;
	drop codice_comune denominazione;
run;
%let varia = 
maschi_celibi
maschi_coniugati
maschi_divorziati
maschi_vedovi
maschi_uniti_civilmente
mas_gia_unione_civ_scioglimento
mas_gia_unione_civ_decesso
maschi
femmine_nubili
femmine_coniugate
femmine_divorziate
femmine_vedove
femmine_unite_civilmente
fem_gia_unione_civ_scioglimento
femmine_gia_unione_civ_decesso
femmine
popolazione;
proc tabulate data = risultato;
	var &varia;
	table &varia,sum*f=comma12.;
run;
proc contents data = risultato varnum;
run;

*Salvo;
options nolabel;
/*
data ter_out.popolazione_eta_sesso_comune;
	set risultato;
run;
*/
