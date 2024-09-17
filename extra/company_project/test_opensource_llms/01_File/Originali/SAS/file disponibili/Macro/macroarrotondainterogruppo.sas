%macro arrotondainterogruppo(ingresso,		/*data set di input*/
							 variab,		/*variabile stimata*/
							 datototeff,	/*data set dei totali effettivi*/
							 effettiva,		/*variabile dei totali effettivi*/
							 vargru,		/*variabile di raggruppamento*/
							 uscita);		/*data set di output*/
/*macro di correzione dell'arrotondamento della variabile stimata variab  */
/*mediante il totale fornito per gruppo dalla variabile intera effettiva  */
/*NB: la variabile arrotondata ha il medesimo nome della variabile stimata*/

%put;
%put %str(WARNING- =================================================================);
%put %str(WARNING: I nomi);
%put %str(WARNING- intermedio somma segnali);
%put %str(WARNING- identificano data set ausiliari della macro arrotondainterogruppo);
%put %str(WARNING- che vengono cancellati al termine delle elaborazioni             );
%put %str(WARNING- =================================================================);
%put;

/*preparo somme per determinare scarto totale per gruppo*/
data intermedio;
	set &ingresso;
run;
proc sort data = intermedio;
	by &vargru;
run;
proc means data = intermedio noprint;
	by &vargru;
	output out = somma (keep = &vargru vartot)
		   sum(&variab) = vartot;
run;
proc sort data = &datototeff;
	by &vargru;
run;
data somma;
	merge somma (in = inso) &datototeff (in = inda);
	by &vargru;
	if inso and inda;
	keep &vargru vartot &effettiva;
run;

/*calcolo scarto*/
data somma;
	set somma;
	diff = vartot - &effettiva;
	keep &vargru diff;
run;

/*aggiungo lo scarto ai dati*/
data intermedio;
	merge intermedio somma (in = presente);
	by &vargru;
	if presente;
run; 

/*per ciascuno gruppo,
ordino i dati secondo i valori decrescenti della variabile stimata,
con lo scopo di modificare solo le osservazioni con i valori più elevati*/
proc sort data = intermedio;
	by &vargru descending &variab;
run;

/*preparo indicatori per individuare la posizione della prima osservazione di ciascun gruppo*/
data intermedio;
	set intermedio;
	by &vargru;
	if first.&vargru then segnale = _N_;
run;
data segnali;
	set intermedio;
	by &vargru;
	if first.&vargru;
	keep &vargru segnale;
run;

/*aggiungo o sottraggo 1 alle osservazioni con i valori più elevati
fino a raggiungere l'esatto totale*/
data &uscita;
	merge intermedio (drop = segnale) segnali;
	by &vargru;
	if _N_ < segnale + abs(diff) then
		if diff < 0 then &variab = &variab + 1;
		else &variab = max(&variab - 1,0);
	drop diff segnale;
run;

/*elimino i data set ausiliari*/
proc datasets library = work;
	delete intermedio somma segnali;
run;
quit;

%mend arrotondainterogruppo;
