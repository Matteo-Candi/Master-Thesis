****************************************************************************************;
*																			            ;  
*								ANALISI PRELIMINARE								        ;
*																		                ;
****************************************************************************************;
*Release: settembre 2020;
*Eseguito: settembre 2020;

libname mtgt "S:\MARKET ANALYTICS\Banca_Dati\Programmi\Stime_sez\Stime_Set20\Microtarget\Dati";
libname mtgt_stm "S:\MARKET ANALYTICS\Banca_Dati\Stime\Microtarget\Set20";
libname bi "S:\MARKET ANALYTICS\Fonti_dati\Bankitalia\Ricerche_BI\RicercaBI_16\Dati";
libname bi_ori "S:\MARKET ANALYTICS\Fonti_dati\Bankitalia\Ricerche_BI\RicercaBI_16\Dati\Originali";
libname mtgt_par "S:\market analytics\Banca_Dati\Stime\Microtarget\Set20\Parametri_logistiche_regio";
libname multi "S:\MARKET ANALYTICS\Fonti_dati\Istat\Indagini_multiscopo\Aspetti_vita_quotidiana\2018\MICRODATI";

ods html close;
ods html;
title "CREAZIONE MODELLI DA INDAGINE MULTISCOPO";
*INDAGINE MULTISCOPO 2018;
%include "S:\market analytics\Fonti_dati\Istat\Indagini_multiscopo\Aspetti_vita_quotidiana\2018\MICRODATI\PGM_2018_IT_DELIMITED_formati_num.sas";
proc import datafile = "S:\MARKET ANALYTICS\Fonti_dati\Istat\Indagini_multiscopo\Aspetti_vita_quotidiana\2018\MICRODATI\AVQ_Microdati_2018.txt"
		dbms = dlm
		out = importato replace;
	delimiter = "09"x;
	getnames = yes;
run; /*44.672*/
title2 "CONTENUTO DEL FILE IMPORTATO";
proc contents data = importato varnum; run;

proc format;
	value eta5f /* fasce_eta */
	8 = "da 20 a 24 anni"
	9 = "da 25 a 34 anni"
	10 = "da 35 a 44 anni"
	11 = "da 45 a 54 anni"
	12 = "da 55 a 59 anni"
	13 = "da 60 a 64 anni"
	14 = "da 65 a 74 anni"
	15 = "75 anni e più"
;
	value posizmi /* posizmi */
	1 = "DIRIG\IMPREND"
	2 = "IMPIEGATI"
	3 = "OPERAI"
	4 = "ARTIGIANI"
;
run;
*Leggo i dati dell'indagine;
*NB: alcune variabili presenti nell'edizione precedente non sono più disponibili (a commento);
*abbtv è nuovamente presente;
/* ! Importante: alcune variabili della multiscopo devono essere obbligatoriamente tenute perché sono necessarie 
per l'espansione su DAMA ;
Si tratta delle seguenti:
- etami
- sesso
- istrmi
- redprmi
- posizm
- condmi
- lavpas
- regmif
che,  raggruppate nei prossimi step, daranno luogo alle variabili che entreranno nella logistica,
cioè : fasce_eta sesso titst prof codr */

/*Differenze 2017 - 2018:
* ordcom --> proind
* dispcesf, dispcewifi, portusb e portwifi non sono più disponibili ma possono essere
	sostituite da disp_sma disp_lap e disp_tab
* incomu3 e incomu4 sono state unificate nella variabile incomu34
* incomu6c e incomu8 non sono più disponibili
* intatt7a (ascoltare radio su web) --> intatt32 (ascoltare musica)
* intatt18a (corso online) può essere sostituita da skl_fre, skl_auto, skl_pub e
	skl_dat, ma non si capisce se si tratta di corsi online o di corsi in generale
* intuso3n --> intuso3
* matdid, docstu, altfor, bikesh, carsh, oasi e voasi non sono più disponibili*/

data multiscopo;
	set importato;
	keep freqin12 /*ordcom*/ proind profam ncomp anno relpar etami sesso stcivmi stcpm
		amatr istrmi condmi lavpas posizmi tipnu2 numnu2 rpnuc2 tipfa2mi regmf
		ripmf coefin redprmi inttempo pc pctempo rivset nosett pariv psett lquot
		pquot libri pwebm1 sposal attfis freqspo spriv intcom teatro
		cine museo music acmus spspo monum bancm ccred nccredm auto nautom cersc
		cosint1 cosint2 cosint3 cosint5 cosint7_ok cosint8 cosint9a cosint9b cosint9c
		cosint11 cosint12_ok cosint14 cosint15 cosint16 cosint17 cosint18 cosint19 
		cosint20 cosint21_ok cosint22a cosint22b abbtv disp_sma disp_lap disp_tab
		/*dispcesf dispcewifi portusb portwifi*/ disppda incomu1b /*incomu3 incomu4*/
		incomu5 incomu6 /*incomu6c*/ incomu7 /*incomu8*/ incomu34 intatt4 intatt5
		/*intatt7a*/ intatt8 intatt10 intatt11 intatt13 intatt14 intatt16 intatt17
		/*intatt18a*/ intatt20 intatt21 intatt26 intatt28a intatt28b intatt31 intatt32
		intatt33 skl_fre skl_auto skl_pub skl_dat intuso1 intuso2 intuso3 intsal3
		nordini cloudsal /*matdid docstu altfor*/ mtpuso /*bikesh carsh*/ camfo2
		gas5 callelga serra estinz camcli smarif amrum_ok iaria inqsu inqfiu disdr
		catastr fores2 inqelet2 paesag2 esriso2 volon pgrvo finas /*oasi voasi*/
		chies visri2_ok accri2_ok;
	visri2_ok = visri2 + 0;
	accri2_ok = accri2 + 0;
	cosint21_ok = cosint21 + 0;
	cosint7_ok = cosint7 + 0;
	cosint12_ok = cosint12 + 0;
	amrum_ok = amrum + 0;
	rename visri2_ok = visri2
		accri2_ok = accri2
		cosint21_ok = cosint21
		cosint7_ok = cosint7
		cosint12_ok = cosint12
		amrum_ok = amrum;
	*inserisco 1 al posto di "presente";
	array uno(*) visri2_ok accri2_ok pwebm1 cosint1 cosint2 cosint3 cosint5 cosint7_ok
		cosint8 cosint11 cosint12_ok cosint14 cosint15 cosint16 cosint17 cosint18
		cosint19 cosint20 cosint21_ok cosint22a cosint22b pquot pariv psett serra
		estinz camcli smarif amrum_ok iaria inqsu inqfiu disdr catastr fores2
		inqelet2 paesag2 esriso2;
	do i = 1 to dim(uno);
		if uno(i) ne . then uno(i) = 1;
	end;

	*inserisco 1 al posto di "si" e 0 al posto di "no";
	array nosi(*) lavpas sposal spriv disp_sma disp_lap disp_tab disppda
		incomu1b incomu5 incomu6 incomu7 incomu34 intatt4 intatt5
		intatt8 intatt10 intatt11 intatt13 intatt14 intatt16 intatt17
		intatt20 intatt21 intatt26 intatt28a intatt28b intatt31 intatt32
		intatt33 cloudsal skl_fre skl_auto skl_pub skl_dat cosint9a
		cosint9b cosint9c intsal3 libri nosett pgrvo finas volon bancm
		ccred auto pc;
	do i = 1 to dim(nosi);
		if nosi(i) = . then nosi(i) = .;
		else if mod(nosi(i), 2) = 0 then nosi(i) = 1;
		else nosi(i) = 0;
	end;

	*seleziono gli individui con più di 20 anni;
 	if etami in (8, 9, 10, 11, 12, 13, 14, 15);
	
	*attribuisco i formati; 
	format freqin12 fre201f. relpar rel4f. etami eta5f. sesso ses6f. stcivmi stc7f.
		stcpm stc8f. istrmi ist10f. condmi con11f. posizmi posizmi. tipnu2 tip15f.
		rpnuc2 rpn17f. tipfa2mi tip18f. regmf reg19f. ripmf rip20f. redprmi red22f.
		inttempo int200f. pctempo pct198f. rivset riv313f. lquot lqu307f.
		attfis att103f. freqspo fre104f. intcom int262f. teatro tea299f.
		cine cin300f. museo mus301f. music mus302f. acmus acm303f. spspo sps304f.
		monum mon306f.  nccredm ncc396f. nautom nau658f. cersc cer372f. abbtv abb655f.
		intuso1 int259f. intuso2 int260f. intuso3 int261f. nordini nor263f. mtpuso mtp59f.
		camfo2 cam483f. gas5 gas475f. callelga cal494f. chies chi315f.;

	*attribuisco le labels;
	label profam = "progressivo famiglia"
		proind = "numero d'ordine del componente"
		ncomp = "numero dei componenti della famiglia attuale"
		anno = "anno della rilevazione"
		relpar = "relazione di parentela con la persona di riferimento"
		etami = "età in anni compiuti"
		sesso = "sesso - scheda generale"
		stcivmi = "stato civile"
		stcpm = "stato civile precedente il matrimonio"
		amatr = "anno del matrimonio"
		istrmi = "titolo di studio"
		condmi = "condizione professionale"
		lavpas = "ha lavorato in passato"
		posizmi = "posizione nella professione"
		tipnu2 = "tipo nucleo 2"
		numnu2 = "numero progressivo del nucleo nell'ambito della famiglia 2"
		rpnuc2 = "relazione di parentela nell'ambito del nucleo 2"
		tipfa2mi = "tipologia familiare 2"
		regmf = "regione di residenza dell'intervistato"
		ripmf = "ripartizione geografica di residenza dell'intervistato"
		coefin = "coefficiente di riporto all'universo"
		redprmi = "fonte principale di reddito"
		mtpuso = "mezzo di trasporto utilizzato nel  tratto più lungo per andare a scuola o al lavoro"
		visri2_ok = "rinuncia a visita specialistica ultimi 12 mesi: non poteva pagarla, costava troppo"
		accri2_ok = "rinuncia a accertamento specialistico ultimi 12 mesi: non poteva pagarlo, costava troppo"
		sposal = "nel suo tempo libero pratica saltuariamente uno o più sport"
		attfis = "le capita di svolgere nel tempo libero qualche attività fisica"
		freqspo = "frequenza nell'anno delle attività sportive praticate"
		spriv = "negli ultimi 12 mesi ha frequentato lezioni private o corsi di sport a spese sue o della famiglia?"
		pctempo = "lei ha mai usato il personal computer?"
		freqpc12 = "frequenza d'uso del personal computer negli ultimi 12 mesi"
		inttempo = "lei ha mai usato internet?"
		freqin12 = "frequenza d'uso di internet negli ultimi 12 mesi"
		disp_sma = "strumenti utlilizzati per accedere ad internet in luoghi diversi da casa o dal posto di lavoro negli ultimi 3 mesi: telefono cellulare o smartphone"
		disp_lap = "strumenti utlilizzati per accedere ad internet in luoghi diversi da casa o dal posto di lavoro negli ultimi 3 mesi: laptop, netbook"
		disp_tab = "strumenti utlilizzati per accedere ad internet in luoghi diversi da casa o dal posto di lavoro negli ultimi 3 mesi: tablet"
		disppda = "strumenti utlilizzati per accedere ad internet in luoghi diversi da casa o dal posto di lavoro negli ultimi 3 mesi: altro dispositivo portatile"
		incomu5 = "negli ultimi 3 mesi ha spedito o ricevuto mail"
		incomu1b = "negli ultimi 3 mesi ha telefonato/effettuato videochiamate"
		incomu34 = "negli ultimi 3 mesi ha usato messaggeria istantanea (es. whatsapp), ha inviato messaggi su chat, blog, newsgroup, forum"
		incomu6 = "negli ultimi 3 mesi ha partecipato a social network (creare un profilo utente, postare messaggi o altro su facebook, twitter, ecc.)"
		incomu7 = "negli ultimi 3 mesi ha espresso opinioni su temi sociali o politici su web (ad esempio tramite blog, social network, ecc.)"
		intatt20 = "negli ultimi 3 mesi ha consultato un wiki per ottenere informazioni (es. wikipedia, altre enciplopedie online)"
		intatt21 = "negli ultimi 3 mesi ha partecipato ad un network professionale (creare un profilo, postare messaggi o altri contributi su linkedln, xing, ecc.)"
		intatt26 = "negli ultimi 3 mesi ha caricato contenuti di propria creazione"
		intatt5 = "negli ultimi 3 mesi ha usato servizi relativi a viaggi o soggiorni"
		intatt4 = "negli ultimi 3 mesi ha cercato lavoro o mandato una richiesta di lavoro"
		intsal3 = "negli ultimi 3 mesi ha preso un appuntamento con un medico"
		intatt14 = "negli ultimi 3 mesi ha cercato informazioni sanitarie"
		intatt11 = "negli ultimi 3 mesi ha usato servizi bancari via internet"
		intatt33 = "negli ultimi 3 mesi ha usato servizi di pagamento (es paypal, braintree, ecc.) per acquistare beni o servizi su internet"
		intatt13 = "negli ultimi 3 mesi ha venduto merci o servizi"
		intatt17 = "negli ultimi 3 mesi ha cercato informazioni su attività di istruzione o corsi"
		intatt16 = "negli ultimi 3 mesi ha cercato informazioni su merci o servizi"
		intatt10 = "negli ultimi 3 mesi ha scaricato software (diverso da giochi)"
		intatt8 = "negli ultimi 3 mesi ha letto giornali, informazioni, riviste online"
		intatt31 = "negli ultimi 3 mesi ha letto o scaricato libri online o e_book"
		intatt32 = "negli ultimi 3 mesi ha ascoltato musica"
		intatt7bn = "negli ultimi 3 mesi ha guardato la televisione in streaming"
		intatt30a = "negli ultimi 3 mesi ha guardato video on demand"
		intatt30b = "negli ultimi 3 mesi ha guardato contenuti video da servizi di condivisione (es. youtube)"
		intatt28a = "negli ultimi 3 mesi ha scaricato immagini, film, musica"
		intatt28b = "negli ultimi 3 mesi ha giocato o scaricato giochi"
		cloudsal = "negli ultimi 3 mesi ha usato servizi di archiviazione/condivisione su internet per salvare"
		skl_fre = "negli ultimi 3 mesi ha fatto un corso di formazione online gratuito"
		skl_auto = "negli ultimi 3 mesi ha fatto un corso di formazione a pagamento completamente a proprio carico"
		skl_pub = "negli ultimi 3 mesi ha fatto un corso di formazione gratuito promosso da organizzazioni diverse dal proprio datore di lavoro"
		skl_dat = "negli ultimi 3 mesi ha fatto un corso di formazione finanziato o organizzato dal proprio datore di lavoro"
		skl_coll = "negli ultimi 3 mesi è stato formato sul posto di lavoro (es. colleghi, supervisori)"
		cosint9a = "negli ultimi 12 mesi  ha svolto operazioni finanziarie per uso privato su internet (escluse e-mail): acquistare/vendere azioni, obbligazioni fondi o altri servizi finanziari"
		cosint9b = "negli ultimi 12 mesi  ha svolto operazioni finanziarie per uso privato su internet (escluse e-mail): acquistare/rinnovare polizze assicurative"
		cosint9c = "negli ultimi 12 mesi  ha svolto operazioni finanziarie per uso privato su internet (escluse e-mail): ottenere un prestito/credito da banche o da altri fornitori di servizi finanziari"
		intuso1 = "negli ultimi 12 mesi ha usato internet per ottenere informazioni da siti web della p.a. o dei gestori dei servizi pubblici"
		intuso2 = "negli ultimi 12 mesi ha usato internet per scaricare moduli della p.a. o dei gestori dei servizi pubblici"
		intuso3 = "negli ultimi 12 mesi ha usato internet per inviare moduli compilati online per uso privato allla p.a. o dei gestori dei servizi pubblici"
		intcom = "ha mai comprato o ordinato merci e/o servizi per uso privato su internet"
		nordini = "negli ultimi 3 mesi quante volte ha comprato o ordinato merci e/o servizi per uso privato su internet"
		cosint1 = "negli ultimi 12 mesi ha comprato o ordinato prodotti alimentari"
		cosint2 = "negli ultimi 12 mesi ha comprato o ordinato articoli per la casa"
		cosint19 = "negli ultimi 12 mesi ha comprato o ordinato farmaci"
		cosint5 = "negli ultimi 12 mesi ha comprato o ordinato abiti, articoli sportivi"
		cosint3 = "negli ultimi 12 mesi ha comprato o ordinato film, musica"
		cosint22a = "negli ultimi 12 mesi ha comprato o ordinato libri (inclusi e-book)"
		cosint22b = "negli ultimi 12 mesi ha comprato o ordinato giornali, riviste"
		cosint21_ok = "negli ultimi 12 mesi ha comprato o ordinato materiale per la formazione a distanza"
		cosint15 = "negli ultimi 12 mesi ha comprato o ordinato software per computer e/o aggiornamenti (esclusi videogiochi)"
		cosint16 = "negli ultimi 12 mesi ha comprato o ordinato videogiochi e/o loro aggiornamenti"
		cosint7_ok = "negli ultimi 12 mesi ha comprato o ordinato hardware per computer"
		cosint8 = "negli ultimi 12 mesi ha comprato o ordinato attrezzature elettroniche (es. macchine fotografiche, telecamere, ecc.)"
		cosint20 = "negli ultimi 12 mesi ha comprato o ordinato servizi di telecomunicazione (es. abbonamenti a tv, a telecomunicazioni a banda larga, a telefono fisso o cellulare, ricariche di carte telefoniche prepagat"
		cosint18 = "negli ultimi 12 mesi ha comprato o ordinato pernottamenti per vacanze (alberghi, pensioni)"
		cosint17 = "negli ultimi 12 mesi ha effettuato altre spese di viaggio (biglietti ferroviari, aerei, noleggio auto, ecc.)"
		cosint11 = "negli ultimi 12 mesi ha comprato o ordinato biglietti per spettacoli"
		cosint12_ok = "negli ultimi 12 mesi ha comprato o ordinato biglietti delle lotterie o scommesse"
		cosint14 = "negli ultimi 12 mesi ha comprato o ordinato altri prodotti: altro"
		teatro = "frequenza con cui negli ultimi 12 mesi è andato a teatro"
		cine = "frequenza con cui negli ultimi 12 mesi è andato a cinema"
		museo = "frequenza con cui negli ultimi 12 mesi è andato a musei o mostre"
		music = "frequenza con cui negli ultimi 12 mesi è andato a concerti di musica classica"
		acmus = "frequenza con cui negli ultimi 12 mesi è andato ad altri concerti di musica"
		spspo = "frequenza con cui negli ultimi 12 mesi è andato a spettacoli sportivi"
		monum = "frequenza con cui negli ultimi 12 mesi è andato in siti archeologici, monumenti"
		lquot = "legge quotidiani almeno una volta alla settimana?"
		libri = "ha letto libri negli ultimi 12 mesi?"
		rivset = "abitualmente legge qualche rivista settimanale?"
		nosett = "abitualmente legge qualche periodico non settimanale?"
		chies = "abitualmente con che frequenza si reca in chiesa o in altro luogo di culto?"
		pgrvo = "ha partecipato negli ultimi 12 mesi a riunioni di: associazioni o gruppi di volontariato?"
		volon = "negli ultimi 12 mesi ha svolto attività gratuita per associazioni o gruppi di volontariato?"
		pwebm1 = "in che modo si informa dei fatti della politica attraverso internet: legge o scarica giornali, news, riviste online?"
		cersc = "negli ultimi 12 mesi ha richiesto: documenti o certificati per l'iscrizione a scuola o all'università?"
		bancm = "possiede il bancomat?"
		ccred = "possiede carta di credito?"
		nccredm = "quante carte di credito possiede?"
		serra = "problemi ambientali che la preoccupano maggiormente: effetto serra, buco nell'ozono"
		estinz = "problemi ambientali che la preoccupano maggiormente: estinzione di alcune specie animali/vegetali"
		camcli = "problemi ambientali che la preoccupano maggiormente: cambiamenti climatici"
		smarif = "problemi ambientali che la preoccupano maggiormente: produzione e smaltimento rifiuti"
		amrum_ok = "problemi ambientali che la preoccupano maggiormente: rumore"
		iaria = "problemi ambientali che la preoccupano maggiormente: inquinamento dell'aria"
		inqsu = "problemi ambientali che la preoccupano maggiormente: inquinamento del suolo"
		inqfiu = "problemi ambientali che la preoccupano maggiormente: inquinamento di fiumi, mari"
		disdr = "problemi ambientali che la preoccupano maggiormente: dissesto idrogeologico (terremoti, alluvioni, ecc.)"
		catastr = "problemi ambientali che la preoccupano maggiormente: catastrofi provocate dall'uomo"
		fores2 = "problemi ambientali che la preoccupano maggiormente: distruzione delle foreste"
		inqelet2 = "problemi ambientali che la preoccupano maggiormente: inquinamento elettromagnetico"
		paesag2 = "problemi ambientali che la preoccupano maggiormente: rovina del paesaggio (eccessiva costruzione di edifici)"
		esriso2 = "problemi ambientali che la preoccupano maggiormente: esaurimento risorse naturali (acqua, minerali, petrolio, ecc.)"
		gas5 = "come arriva il gas all'abitazione?"
		camfo2 = "ha mai cambiato fornitore di energia elettrica o gas negli ultimi 12 mesi?"
		callelga = "negli ultimi 12 mesi ha utilizzato il servizio di call-center dell'azienda di energia elettrica o gas?"
		abbtv = "la famiglia possiede abbonamento o carta pre-pagata pay tv?"
		auto = "la famiglia possiede l'automobile?"
		nautom = "numero automobili"
		pc = "la famiglia dispone di personal computer a casa?";

run; /*36.580*/

title2 "REGIONI";
proc freq data = multiscopo;
	tables regmf;
run;

title2 "ANALISI DELLE VARIABILI AMBIENTE";
proc freq data = multiscopo;
	tables serra estinz camcli smarif amrum iaria inqsu inqfiu disdr
		catastr fores2 inqelet2 paesag2 esriso2;
run;

title2 "ANALISI DELLE VARIABILI INTERNET";
proc freq data = multiscopo;
	table inttempo freqin12 disp_sma disp_lap disp_tab disppda
		incomu1b incomu34 incomu5 incomu6 incomu7 intsal3 cloudsal
		intatt8 intatt10 intatt11 intatt13 intatt14 intatt16 intatt17
		intatt20 intatt21 intatt26 intatt28a intatt28b intatt31 intatt32
		intatt33 cosint9a cosint9b cosint9c intuso1 intuso2 intuso3 intcom
		nordini cosint1 cosint2 cosint3 cosint5 cosint7 cosint8 cosint11
		cosint12 cosint14 cosint15 cosint16 cosint17 cosint18 cosint19
		cosint20 cosint21 cosint22a cosint22b;
run;

data multiscopo_internet1;
	set multiscopo;

	*e-commerce (almeno un acquisto nella vita);
	if intcom = 4 then ecommerce = 0;
	else if intcom = . then ecommerce = .;
	else ecommerce = 1;

	nonpres_beni = nmiss(cosint1, cosint2, cosint19, cosint5, cosint3,
		cosint22a, cosint22b, cosint21, cosint16, cosint7, cosint8);
	if nonpres_beni = 11 and intcom = . then acquisti_beni = .;
	else if nonpres_beni = 11 then acquisti_beni = 0;
	else acquisti_beni = 1;

	nonpres_tot = nmiss(cosint1, cosint2, cosint19, cosint5, cosint3,
		cosint22a, cosint22b, cosint21, cosint15, cosint16, cosint7,
		cosint8, cosint20, cosint18, cosint17, cosint11, cosint12, cosint14);
	if nonpres_tot = 18 and sum(cosint9a, cosint9b, cosint9c) in (0, .)
		and intcom = . then acquisti_tot = .;
	else if nonpres_tot = 18 and sum(cosint9a, cosint9b, cosint9c) in (0, .)
		then acquisti_tot = 0;
	else acquisti_tot = 1;

	/* creo variabili per PROPENSIONE ALL'ACQUISTO PER MACROCATEGORIA */
	no_hobby = nmiss(cosint3, cosint22a, cosint22b, cosint16, cosint11,
		cosint12, cosint21);
	if no_hobby = 7 and intcom = . then internet_hobby = .;
	else if no_hobby = 7 and (intcom in (1, 2)) then internet_hobby = 0;
	else internet_hobby = 1;

	no_viaggi = nmiss(cosint18, cosint17);
	if no_viaggi = 2 and intcom = . then internet_viaggi = .;
	else if no_viaggi = 2 and (intcom in (1, 2)) then internet_viaggi = 0;
	else internet_viaggi = 1;

	no_casa_persona = nmiss(cosint1, cosint2, cosint19, cosint5, cosint14);
	if no_casa_persona = 5 and intcom = . then intern_casapers = .;
	else if no_casa_persona = 5 and (intcom in (1, 2)) then intern_casapers = 0;
	else intern_casapers = 1;

	no_elettronica = nmiss(cosint15, cosint7, cosint20, cosint8);
	if no_elettronica = 4 and intcom = . then internet_elettron = .;
	else if no_elettronica = 4 and (intcom in (1, 2)) then internet_elettron = 0;
	else internet_elettron = 1;
run;
title2 "VARIABILI INTERNET ACCORPATE";
proc freq data = multiscopo_internet1; 
	tables internet_hobby * (cosint3 cosint22a cosint22b cosint16 cosint11
		cosint12 cosint21)
		internet_viaggi * (cosint18 cosint17)
		intern_casapers * (cosint1 cosint2 cosint19 cosint5 cosint14)
		internet_elettron * (cosint15 cosint7 cosint20 cosint8)
		/ nopercent nocol norow missing;
run;
title2 "INCROCIO ACQUISTI TOTALI - VARIABILI INTERNET";
proc freq data = multiscopo_internet1;
	tables acquisti_tot * (internet_hobby internet_viaggi
		intern_casapers internet_elettron)	
		/ nopercent nocol norow missing;
run;
title2 "INCROCIO INTCOM - VARIABILI INTERNET";
proc freq data = multiscopo_internet1;
	tables intcom * (internet_hobby internet_viaggi
		intern_casapers internet_elettron)	
		/ nopercent nocol norow missing;
run;
title2 "INCROCIO ACQUISTI_BENI E ACQUISTI_TOT";
proc freq data = multiscopo_internet1;
	tables intcom * acquisti_beni
		intcom * acquisti_tot
		acquisti_tot * acquisti_beni / nopercent nocol norow missing;
run;

*Creazione variabili per PROPENSIONE ALL'ACQUISTO FREQUENTE O DIVERSIFICATO;
data multiscopo_internet2;
	set multiscopo_internet1;
	if intcom in (1, 2) then ecommerce_12m = 1;
	else if intcom in (3, 4) then ecommerce_12m = 0;

	if nordini in (3, 4) then ecomm_addicted = 1;
	else if nordini in (1, 2) then ecomm_addicted = 0;
	*acquisto diversificato;
	if sum(internet_hobby, internet_viaggi, intern_casapers, internet_elettron) >= 3 
		then ecomm_diversific = 1;
	else if sum(internet_hobby, internet_viaggi, intern_casapers, internet_elettron) >= 1 
		then ecomm_diversific = 0;
run;
title2 "INCROCIO VARIABILI ECOMMERCE";
proc freq data = multiscopo_internet2;
	tables ecommerce_12m * intcom
		ecomm_addicted * nordini / nopercent nocol norow missing;
run;
*Creazione variabili per PROPENSIONE ALLA PARTECIPAZIONE A NETWORK SOCIALI O PROFESSIONALI;
data multiscopo_internet3;
	set multiscopo_internet2;
	if incomu34 = 1 or incomu6 = 1 or intatt21 = 1 or incomu7 = 1 /*or incomu8 = 1*/
		then social_network = 1;
	else if incomu34 = 0 and incomu6 = 0 and intatt21 = 0 and incomu7 = 0 /*and incomu8 = 0*/
		then social_network = 0;
run;
title2 "INCROCIO VARIABILI SOCIAL_NETWORK";
proc freq data = multiscopo_internet3; 
	table social_network * (incomu34 incomu6 incomu7 intatt21)
		/ nopercent nocol norow missing list;
run;

*Creazione variabili per PROPENSIONE ALLA NAVIGAZIONE "UTILE";
data multiscopo_internet4;
	set multiscopo_internet3;
	if intatt8 = 1 or cosint9a = 1 or cosint9b = 1 or cosint9c = 1 or intuso1 in (2, 3) or
		intuso2 in (2, 3) or intuso3 in (2, 3) or intatt4 = 1 or intsal3 = 1 or intatt14 = 1 or 
		intatt11 = 1 or intatt33 = 1 or intatt13 = 1 or intatt17 = 1 or intatt16 = 1 or
		skl_fre = 1 or intatt10 = 1
		then navigaz_utile = 1;
	else if intatt8 = 0 and cosint9a = 0 and cosint9b = 0 and cosint9c = 0 and intuso1 = 1 and
		intuso2 = 1 and intuso3 = 1 and intatt4 = 0 and intsal3 = 0 and intatt14 = 0 and
		intatt11 = 0 and intatt33 = 0 and intatt13 = 0 and intatt17 = 0 and intatt16 = 0 and
		skl_fre = 0 and intatt10 = 0 
		then navigaz_utile = 0;
run;
title2 "INCROCIO VARIABILI NAVIGAZ_UTILE";
proc freq data = multiscopo_internet4; 
	table navigaz_utile navigaz_utile*(intatt8 cosint9a cosint9b cosint9c intuso1
		intuso2 intuso3 intatt4 intsal3 intatt14 intatt11 intatt33 intatt13
		intatt17 intatt16 skl_fre intatt10)
		/ nopercent nocol norow missing list;
run;

*Creazione variabili per PROPENSIONE ALLA NAVIGAZIONE "LEISURE";
data multiscopo_internet5;
	set multiscopo_internet4;
	if intatt31 = 1 or intatt28a = 1 or intatt28b = 1 or cloudsal = 1
		then navigaz_leisure = 1;
	else if intatt31 = 0 and intatt28a = 0 and intatt28b = 0 and cloudsal = 0
		then navigaz_leisure = 0;
run;
title2 "INCROCIO VARIABILI NAVIGAZ_LEISURE";
proc freq data = multiscopo_internet5; 
	table navigaz_leisure navigaz_leisure * (intatt31 intatt28a intatt28b
		cloudsal) / nopercent nocol norow missing list;
run;
proc sort data = ter.geog20b out = vedo (keep = codr desr) nodupkey;
	by codr;
run;

*Ricodifico le variabili; 
data multiscopo_sistemo;
	set multiscopo_internet5;

	*sistemo le variabili di by;
	if istrmi = 1 then titst = 4; /*laurea*/
	else if istrmi = 7 then titst = 3; /*diploma*/
	else if istrmi = 9 then titst = 2; /*medie*/
	else if istrmi = 10 then titst = 1; /*elementare*/

	*fasce_età;
	fasce_eta = etami;

	*regione;
	codr = substr(put(regmf, z3.), 1, 2);

	*area geografica;
	if ripmf = 9 then area_geog = .;
	else if ripmf = 5 then area_geog = 4;
	else area_geog = ripmf;

	*sport o attività fisica;
	if sposal = 1 or attfis ne 1 then sport = 1;
	else if sposal = . and attfis = . then sport = .;
	else sport = 0;

	*utilizzo internet (almeno una volta nella vita);
	if inttempo = 4 then internet = 0;
	else if inttempo = . then internet = .;
	else internet = 1;

	*utilizzo frequente internet, internet-addicted;
	if freqin12 = 1  then internet_addicted = 1;
	else if freqin12 = . then internet_addicted = .;
	else internet_addicted = 0;

	*possesso PC;
	if pc = 0 then pc_possesso = 0;
	else if pc = 1 then pc_possesso = 1;

	*intrattenimenti per categoria;
	array divert (*) teatro cine museo music acmus monum;
	do i = 1 to dim(divert);
		if divert(i) = 1 then divert(i) = 0;
		else if divert(i) > 1 then divert(i) = 1;
	end;
	intrat_teatr_cine = max(teatro, cine);
	intrat_concerti = max(music, acmus);
	intrat_arte_cult = max(monum, museo);

	*intrattenimento sportivo;
	if spspo = 1 then intrat_sport = 0;
	else if spspo = . then intrat_sport  = .;
	else intrat_sport = 1;	

	*bancomat e carte di credito;
	rename bancm = bancomat
		ccred = ccredito;

	*numero carte credito;
	if nccredm in (3, 4) then nccredm = 3;
	else if nccredm in (1, 2) then nccredm = nccredm;

	*paytv;
	if abbtv in (1, 2) then paytv = 1;
	else if abbtv = 3 then paytv = 0;
	
	*se il prezzo è il fattore discriminante per la scelta
		di usufruire di servizi sanitari;
	no_prezzo_servizi = nmiss(visri2, accri2);
	if no_prezzo_servizi = 2 then prez_serv_sanita = 0;
	else prez_serv_sanita = 1;

	*sensibilità problematiche ambientali;
	no_sensibil_ambiente = nmiss(serra, estinz, camcli,
		smarif, amrum, iaria, inqsu, inqfiu, disdr, catastr,
		fores2, inqelet2, paesag2, esriso2);
	if no_sensibil_ambiente = 14 then sensib_ambiente = 0;
	else sensib_ambiente = 1;

	*call center luce, gas;
	if callelga in (2, 3, 4) then callc_lucegas = 1;
	else if callelga = 1 then callc_lucegas = 0;
	else callc_lucegas = .;

	*no gas;
	if gas5 = 5 then nongas_abitaz = 1;
	else if gas5 = . then nongas_abitaz = .;
	else nongas_abitaz = 0;

	*cambiato fornitore luce, gas;
	if camfo2 in (2, 3, 4) then cambiafornit = 1;
	else if camfo2 = . then cambiafornit = .;
	else cambiafornit = 0;

	*mobilità sostenibile;
	if mtpuso in (7, 8, 9) then mobil_sostenib = 0;
	else if mtpuso = . then mobil_sostenib = .;
	else mobil_sostenib = 1;

	*praticante luoghi di culto;
	if chies in(1, 2, 3, 4) then religione = 1;
	else if chies = . then religione = .; 
	else religione = 0; 

	*donatore verso associazioni;
	rename finas = donazioni;

	*attività di volontariato;
	if pgrvo = 1 or volon = 1 then volontariato = 1;
	else if  pgrvo = . and volon = . then volontariato = .;
	else volontariato = 0;

	*lettura riviste, periodici e quotidiani CARTACEI;
	if rivset > 1 or nosett = 1 or pariv = 1 or psett = 1 or lquot > 1
		or pquot = 1 then riv_quotid_carta = 1;
	else if rivset = 1 or nosett = 0 or pariv = 0 or psett = 0
		or lquot = 1 or pquot = 0 then riv_quotid_carta = 0;

	*lettura riviste, periodici e quotidiani DIGITALI;
	if intatt8 = 1 or pwebm1 = 1 then riv_quotid_digit = 1;
	else if intatt8 = . and pwebm1 = . then riv_quotid_digit = .;
	else riv_quotid_digit = 0;

	*lettura libri CARTACEI;
	if libri = 1 then libri_carta = 1;
	else if libri = 0 then libri_carta = 0;

	*lettura libri DIGITALI;
	if intatt31 = 1 then libri_digitali = 1;
	else if intatt31 = 0 then libri_digitali = 0;

	drop i cosint1 cosint2 cosint19 cosint5 cosint3 cosint22a
		cosint22b cosint21 cosint15 cosint16 cosint7 cosint8 cosint20
		cosint9a cosint9b cosint9c cosint18 cosint17 cosint11 cosint12
		cosint14 nonpres_beni nonpres_tot no_sensibil_ambiente
		no_prezzo_servizi no_hobby no_viaggi no_casa_persona
		no_elettronica;
run;
title2 "CONTENUTO DI MULTISCOPO_SISTEMO";
proc contents data = multiscopo_sistemo varnum short; run;
title2 "REGIONI";
proc freq data = multiscopo_sistemo;
	tables regmf;
run;
title2 "INCROCIO VARIABILI CARTE DI CREDITO";
proc freq data = multiscopo_sistemo;
	tables ccredito  * nccredm / nopercent nocol norow missing; 
run;
title2 "INCROCIO VARIABILI MOBIL_SOSTENIB";
proc freq data = multiscopo_sistemo;
	tables mobil_sostenib * (mtpuso) / nopercent nocol norow missing; 
run;
data multiscopo_seleziono;
	set multiscopo_sistemo;
	keep profam proind ncomp anno relpar sesso stcivmi istrmi fasce_eta
		condmi lavpas posizmi regmf ripmf redprmi coefin codr titst
		area_geog sport intrat_teatr_cine intrat_concerti intrat_arte_cult
		intrat_sport /*inter_aree_prot*/ riv_quotid_carta riv_quotid_digit
		libri_carta libri_digitali auto nautom bancomat nccredm ccredito paytv 
		internet internet_addicted pc_possesso ecommerce acquisti_beni acquisti_tot
		internet_hobby internet_viaggi intern_casapers internet_elettron 
		ecommerce_12m ecomm_addicted ecomm_diversific social_network
		navigaz_utile navigaz_leisure sensib_ambiente mobil_sostenib
		callc_lucegas cambiafornit nongas_abitaz religione donazioni
		volontariato prez_serv_sanita /*bikecarsharing*/;
run; /*59 variabili*/
title2 "INCROCIO VARIABILI PREZ_SERV_SANITA E REDDITO";
proc freq data = multiscopo_seleziono;
	tables prez_serv_sanita * redprmi / nopercent nocol norow missing;
run;
title2 "INCROCIO VARIABILI REGIONE * NONGAS_ABITAZ";
proc freq data = multiscopo_seleziono;
	tables regmf * nongas_abitaz / norow missing;
run;

proc means data = multiscopo_seleziono noprint;
	var acquisti_beni acquisti_tot internet_hobby internet_viaggi
		intern_casapers internet_elettron ecommerce_12m ecomm_addicted
		ecomm_diversific;
	class area_geog regmf;
	types() area_geog regmf;
	weight coefin;
	output out = perc_ecomm
		mean(acquisti_beni) = 
		mean(acquisti_tot) = 
		mean(internet_hobby) = 
		mean(internet_viaggi) = 
		mean(intern_casapers) = 
		mean(internet_elettron) =
		mean(ecommerce_12m) = 
		mean(ecomm_addicted) = 
		mean(ecomm_diversific) = ;
run;
data mtgt_par.perc_ecomm;
	retain area_geog regmif;
	set perc_ecomm;
	regmif = put(regmf, z3.);
	drop regmf;
	rename regmif = regmf;
run;




****************************************************************************************;
*							ANALISI UNIVARIATA					                        ;
****************************************************************************************;
ods html close;
ods html;
*Frequenza della variabile target;
ods rtf file = "S:\MARKET ANALYTICS\Banca_Dati\Stime\Microtarget\Set20\Frequenze_multiscopo.rtf";
title "FREQUENZA DELLE VARIABILI UTILI PER LA STIMA DELLE PROPENSIONI";
proc freq data = multiscopo_seleziono;
	tables sport intrat_teatr_cine intrat_concerti intrat_arte_cult
		intrat_sport /*inter_aree_prot*/ riv_quotid_carta riv_quotid_digit
		libri_carta libri_digitali auto nautom bancomat nccredm ccredito
		paytv internet internet_addicted pc_possesso ecommerce acquisti_beni
		acquisti_tot internet_hobby internet_viaggi intern_casapers
		internet_elettron ecommerce_12m ecomm_addicted ecomm_diversific 
		social_network navigaz_utile navigaz_leisure sensib_ambiente
		mobil_sostenib /*bikecarsharing*/ callc_lucegas cambiafornit
		nongas_abitaz religione donazioni volontariato prez_serv_sanita;
	weight coefin;
run;
title2 "INCROCIO FASCE DI ETÀ * ECOMM_DIVERSIFIC";
proc freq data = multiscopo_seleziono;
	tables ecomm_diversific * fasce_eta / nopercent norow nocol missing;
run;
title2 "ACQUISTI_BENI, ACQUISTI_TOT ED ECOMMERCE";
proc freq data = multiscopo_seleziono;
	tables acquisti_beni acquisti_tot ecommerce;
	weight coefin;
	where ecommerce ne .;
run;
title2 "INCROCIO VARIABILI LAVORO";
proc freq data = multiscopo_seleziono;
	tables condmi * (lavpas posizmi) / nopercent nocol missing;
run;
proc sort data = multiscopo_seleziono;
	by sesso;
run;
title2 "INATTIVI CHE NON HANNO LAVORATO IN PASSATO";
proc freq data = multiscopo_seleziono;
	by sesso;
	tables redprmi * fasce_eta / nopercent nocol norow missing;
	where condmi = 3 and lavpas = 0;
	format fasce_eta ETA5F.;
run;
ods rtf close;

data condizione_professionale;
	set multiscopo_seleziono;
	
	length prof $50.;
	*se hanno dichiarato una professione presente o passata per
		i pensionati consideriamo la condizione attiva;
	if redprmi = 3 and posizmi ne . then prof = put(posizmi, $POSIZMI.);
	else if posizmi ne . then prof = put(posizmi, $POSIZMI.);
	*altrimenti deduciamo la tipologia di inattività in base al
		reddito prevalente, all'età e al sesso;
	else if posizmi = . then do;
		if condmi = 3 /*inattivo*/ and redprmi = 3 /*pensione*/ and posizmi = . then
			prof = "PENSIONATI";
		else if redprmi in (4, 5, 5) /*indennità e provvidenze varie, redditi
			patrimoniali, mantenimento da parte della famiglia*/
			and lavpas = 2 /*lavoro in passato*/ then prof = "ALTRO";
		else if fasce_eta in (8, 9) /*fino a 30 anni*/ and redprmi = 6 /*mantenimento
			da parte della famiglia*/ then prof = "STUDENTI";
		else if redprmi = 6 /*mantenimento da parte della famiglia*/
			then prof = "CASALINGHE";
		else prof = "ALTRO";
		if condmi = 2 then prof = "DISOCCUPATI";
	end;
	if prof = "ARTIGIANI" then prof = "IMPIEGATI";
	if prof = "           99" then prof = "ALTRO";
	if regmf = 999 then delete;
 	if codr not in (44, 55, 66, 77, 88);
run; /*36.488*/
title2 "INCROCIO VARIABILI PROFESSIONALI";
proc freq data = condizione_professionale;
	tables prof condmi prof * (condmi redprmi lavpas posizmi)
	/ missing nopercent norow nocol;
	*weight coefin;
run;




****************************************************************************************;
*					ANALISI UNIVARIATA CON GLI INDICI					                ;
****************************************************************************************;

option mprint;
ods html close;
ods html;

*Frequenza semplice di tutte le variabili;
filename myfile "E:\MarketAnalytics\Enicchio\Microtarget\2020\log_univariate.log";
proc printto log = myfile; run;

%include "S:\market analytics\Banca_Dati\Programmi\Stime_sez\Stime_Set20\Microtarget\macro_indici_con_count.sas";

%let elenco = fasce_eta sesso titst prof codr ripmf area_geog;
%let elenco_tgt = sport intrat_teatr_cine intrat_concerti intrat_arte_cult
	intrat_sport /*inter_aree_prot*/ riv_quotid_carta riv_quotid_digit
	libri_carta libri_digitali auto /*nautom*/ bancomat /*nccredm*/ ccredito
	paytv internet internet_addicted pc_possesso ecommerce acquisti_beni
	acquisti_tot internet_hobby internet_viaggi intern_casapers internet_elettron 
	ecommerce_12m ecomm_addicted ecomm_diversific social_network
	navigaz_utile navigaz_leisure sensib_ambiente mobil_sostenib /*bikecarsharing*/ 
	callc_lucegas cambiafornit nongas_abitaz religione donazioni volontariato 
	prez_serv_sanita;

%indici(condizione_professionale, indici);
*Ripristino il log nella finestra SAS;
proc printto; run;
/*
proc export data = indici_tot
	outfile = "S:\market analytics\Banca_Dati\Stime\Microtarget\Set20\Indici_univariate.xls"
	dbms = excelcs replace;
run;
*/


ods rtf file = "S:\market analytics\Banca_Dati\Stime\Microtarget\Set20\Output\output_logist_reg.rtf";
****************************************************************************************;
*							ANALISI MULTIVARIATA				                        ;
****************************************************************************************;
%let elenco_tgt = sport intrat_teatr_cine intrat_concerti intrat_arte_cult
	intrat_sport /*inter_aree_prot*/ riv_quotid_carta riv_quotid_digit
	libri_carta libri_digitali auto /*nautom*/ bancomat /*nccredm*/ ccredito
	paytv internet internet_addicted pc_possesso ecommerce acquisti_beni
	acquisti_tot internet_hobby internet_viaggi intern_casapers internet_elettron 
	ecommerce_12m ecomm_addicted ecomm_diversific social_network navigaz_utile
	navigaz_leisure sensib_ambiente mobil_sostenib /*bikecarsharing*/ 
	callc_lucegas cambiafornit nongas_abitaz religione donazioni volontariato 
	prez_serv_sanita;

filename myfile "E:\MarketAnalytics\Enicchio\Microtarget\2020\log_output_logist.log";
proc printto log = myfile; run;

%macro logist;

	%local i;
	%let i = 0;
	%do %until (%scan(&elenco_tgt, &i+1) = );
	%let i = %eval(&i + 1);
	%let tgt = %scan(&elenco_tgt, &i);

	*Preparo il db per la logistica;
	data db_base;
		set condizione_professionale;
		peso_tgt = &tgt * coefin;
		where &tgt ne .;
		format fasce_eta ETA5F. posizmi $POSIZMI.;
	run;

	*Calcolo percentuale pesata del target;
	proc means data = db_base noprint;
		var &tgt peso_tgt coefin;
		output out = db_pct_tgt (drop = _type_)
			sum = tgt peso_tgt peso;
	run; 
	data db_pct_tgt1;
		set db_pct_tgt;
		pct_tgt = peso_tgt / peso;
	run;

	title "Percentuale del target ponderato - &tgt";
	proc print data = db_pct_tgt1;
	run;
	  
	proc sort data = db_base;
		by fasce_eta sesso titst prof codr;
	run;
	proc means data = db_base noprint;
		var &tgt peso_tgt coefin;
		by fasce_eta sesso titst prof codr;
		output out = db_logistica (drop = _type_)
			sum = tgt peso_tgt peso;
	run; /*4.347*/

	title "Stepwise Logistic on Target Data - &tgt";
	proc logistic data = db_logistica outmodel = mtgt_par.parametri_&tgt;
		class fasce_eta sesso titst prof codr / descending order = internal;
		model peso_tgt/peso = fasce_eta sesso titst prof codr
			/ selection = stepwise slentry = .1 slstay = .1 ctable;
		output out = pred_misto_&tgt p = phat lower = lcl upper = ucl xbeta = score;
	run;
	%end;

%mend logist;

%logist;

ods rtf close;
*Ripristino il log nella finestra SAS;
proc printto; run;

*Calcolo le propensioni regionali dall'indigine multiscopo;
proc means data = condizione_professionale noprint;
	class codr;
	var &elenco_tgt;
	output out = mtgt_par.medie_multiscopo
		mean = ;
	weight coefin;
run;

/*
proc export data = mtgt_par.medie_multiscopo
	outfile = "S:\MARKET ANALYTICS\Banca_Dati\Stime\Microtarget\Set20\Medie_da_ricerche_e_stime.xls"
	dbms = excelcs replace;
	sheet = "Multiscopo";
run;
*/
