%macro arrotondainterogruppo(ingresso,		
							 variab,		
							 datototeff,	
							 effettiva,		
							 vargru,		
							 uscita);		




%put;
%put %str(WARNING- =================================================================);
%put %str(WARNING: I nomi);
%put %str(WARNING- intermedio somma segnali);
%put %str(WARNING- identificano data set ausiliari della macro arrotondainterogruppo);
%put %str(WARNING- che vengono cancellati al termine delle elaborazioni             );
%put %str(WARNING- =================================================================);
%put;


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


data somma;
	set somma;
	diff = vartot - &effettiva;
	keep &vargru diff;
run;


data intermedio;
	merge intermedio somma (in = presente);
	by &vargru;
	if presente;
run; 


proc sort data = intermedio;
	by &vargru descending &variab;
run;


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


data &uscita;
	merge intermedio (drop = segnale) segnali;
	by &vargru;
	if _N_ < segnale + abs(diff) then
		if diff < 0 then &variab = &variab + 1;
		else &variab = max(&variab - 1,0);
	drop diff segnale;
run;


proc datasets library = work;
	delete intermedio somma segnali;
run;
quit;

%mend arrotondainterogruppo;
