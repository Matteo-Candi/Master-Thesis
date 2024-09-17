*****************************************************************************************;
*LETTURA DEL REDDITO FISCALE 2019 - DICHIARAZIONI 2020                                   ;
*LIVELLO CAP                                                                             ;
*****************************************************************************************;

libname ter "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname ter_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";
libname sez_out "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

libname appo "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets";

options mergenoby = warn;
options nolabel;

title1 "IMPORTAZIONE DEL REDDITO FISCALE";

*Importo i dati del ministero;
PROC IMPORT OUT= WORK.tabella_ministero_finanze
            DATAFILE= "C:\Users\mcandi\OneDrive - KPMG\Desktop\project\SAS_scripts\Data_sets\Redditi_e_principali_variabili_IRPEF_su_base_subcomunale_CSV_2019.xlsx"
            DBMS=EXCEL2000 REPLACE;
     		GETNAMES=YES;
RUN;
title2 "CONTENUTO DEL FILE IMPORTATO";
proc contents data = tabella_ministero_finanze varnum short;
run;
data tabella_ministero_finanze1;
	set tabella_ministero_finanze;
	rename codice_istat_comune = codice_comune__num
		   cap = cap_num
		Numero_contribuenti = Numero_contribuenti_Maius
		reddito_da_fabbricati___frequenz = reddito_fabbricati_frequenza
		reddito_da_fabbricati___ammontar = reddito_fabbricati_ammontare
		reddito_da_lavoro_dipendente_e_a = reddito_lavoro_dip_ass_frequenza
		reddito_da_lavoro_dipendente_e_0 = reddito_lavoro_dip_ass_ammontare
		reddito_da_pensione___frequenza = reddito_pensione_frequenza
		reddito_da_pensione___ammontare_ = reddito_pensione_ammontare
		reddito_da_lavoro_autonomo__comp = reddito_lavoro_auton_frequenza
		reddito_da_lavoro_autonomo__com0 = reddito_lavoro_auton_ammontare
		reddito_di_spettanza_dell_impren = reddito_imprend_ordin_frequenza
		reddito_di_spettanza_dell_impre0 = reddito_imprend_ordin_ammontare
		reddito_di_spettanza_dell_impre1 = reddito_imprend_sempli_frequenza
		reddito_di_spettanza_dell_impre2 = reddito_imprend_sempli_ammontare
		reddito_da_partecipazione___comp = reddito_partecipazione_frequenza
		reddito_da_partecipazione___com0 = reddito_partecipazione_ammontare
		reddito_imponibile___frequenza = reddito_imponibile_frequenza
		reddito_imponibile___ammontare_i = reddito_imponibile_ammontare
		imposta_netta___frequenza = imposta_netta_frequenza
		imposta_netta___ammontare_in_eur = imposta_netta_ammontare
		bonus_spettante___frequenza = bonus_spettante_frequenza
		bonus_spettante___ammontare_in_e = bonus_spettante_ammontare
		reddito_imponibile_addizionale__ = reddito_impon_addiz_frequenza
		reddito_imponibile_addizionale_0 = reddito_impon_addiz_ammontare
		addizionale_regionale_dovuta___f = addizionale_region_frequenza
		addizionale_regionale_dovuta___a = addizionale_region_ammontare
		addizionale_comunale_dovuta___fr = addizionale_comun_frequenza
		addizionale_comunale_dovuta___am = addizionale_comun_ammontare
		reddito_complessivo_minore_o_ugu = reddito_fino_a_0_freq
		reddito_complessivo_minore_o_ug0 = reddito_fino_a_0_amm
		reddito_complessivo_da_0_a_10000 = reddito_0_10000_freq
		reddito_complessivo_da_0_a_10001 = reddito_0_10000_amm
		reddito_complessivo_da_10000_a_1 = reddito_10000_15000_freq
		reddito_complessivo_da_10000_a_0 = reddito_10000_15000_amm
		reddito_complessivo_da_15000_a_2 = reddito_15000_26000_freq
		reddito_complessivo_da_15000_a_0 = reddito_15000_26000_amm
		reddito_complessivo_da_26000_a_5 = reddito_26000_55000_freq
		reddito_complessivo_da_26000_a_0 = reddito_26000_55000_amm
		reddito_complessivo_da_55000_a_7 = reddito_55000_75000_freq
		reddito_complessivo_da_55000_a_0 = reddito_55000_75000_amm
		reddito_complessivo_da_75000_a_1 = reddito_75000_120000_freq
		reddito_complessivo_da_75000_a_0 = reddito_75000_120000_amm
		reddito_complessivo_oltre_120000 = reddito_oltre_120000_freq
		reddito_complessivo_oltre_120001 = reddito_oltre_120000_amm;
run; *609;

*Confronto l'elenco dei comuni con la geografia in uso;
data geog;
	set ter_out.geografica_comune;
	keep codice_comune__num codice_comune__str;
run;
proc sort data = geog;
	by codice_comune__num;
run;
proc sort data = Tabella_ministero_finanze1;
	by codice_comune__num;
run;
data geog_ministero solo_ministero;
	merge geog (in = a) tabella_ministero_finanze1 (in = b);
	by codice_comune__num;
	if a = 1 and b = 1 then output geog_ministero; /*7.903*/
	if a = 0 and b = 1 then output solo_ministero; /*0*/
run;

*Salvo;
data redfisc;
	set geog_ministero;
	cap = put(cap_num,z5.);
	reddito_tot_fasce_freq = sum(reddito_fino_a_0_freq,reddito_0_10000_freq,
								 reddito_10000_15000_freq,reddito_15000_26000_freq,
								 reddito_26000_55000_freq,reddito_55000_75000_freq,
								 reddito_75000_120000_freq,reddito_oltre_120000_freq);
	reddito_tot_fasce_amm = sum(reddito_fino_a_0_amm,reddito_0_10000_amm,
								reddito_10000_15000_amm,reddito_15000_26000_amm,
								reddito_26000_55000_amm,reddito_55000_75000_amm,
								reddito_75000_120000_amm,reddito_oltre_120000_amm);
	drop Anno_di_imposta Codice_catastale codice_comune__num Denominazione_Comune Sigla_Provincia Regione Codice_Istat_Regione cap_num;
	rename Numero_contribuenti_Maius = numero_contribuenti;
run;
title2 "TOTALI";
proc tabulate data = redfisc;
	var _numeric_;
	table _numeric_,sum*f=comma18.;
run;
%let ammontare = 
reddito_fabbricati_ammontare
reddito_lavoro_dip_ass_ammontare
reddito_pensione_ammontare
reddito_lavoro_auton_ammontare
reddito_imprend_ordin_ammontare
reddito_imprend_sempli_ammontare
reddito_partecipazione_ammontare
reddito_imponibile_ammontare
imposta_netta_ammontare
bonus_spettante_ammontare
reddito_impon_addiz_ammontare
addizionale_region_ammontare
addizionale_comun_ammontare
reddito_fino_a_0_amm
reddito_0_10000_amm
reddito_10000_15000_amm
reddito_15000_26000_amm
reddito_26000_55000_amm
reddito_55000_75000_amm
reddito_75000_120000_amm
reddito_oltre_120000_amm
reddito_tot_fasce_amm;
data redfisc1000;
	set redfisc;
	array reddito{*} &ammontare;
	do i = 1 to dim(reddito);
		if reddito{i} ~= . then reddito{i} = reddito{i}/1000;
	end;
	anno_riferimento = 2019;
	release = 2021;
	drop i;
run;
data ordinato;
	retain codice_comune__str cap;
	set redfisc1000;
run;
title2 "CONTENUTO DEL FILE FINALE";
proc contents data = ordinato varnum;
run;
/*
data sez_out.reddito_fiscale_cap;
	set ordinato;
run;
*/

