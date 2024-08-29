%macro quadraturagruppo(daquadrare,		
						daquad,			
						totpergru,		
						perquad,		
						giaquad,		
						vargruppo,		
						quadrato);		





%put;
%put %str(WARNING- ============================================================);
%put %str(WARNING: I nomi);
%put %str(WARNING- somma quadrare);
%put %str(WARNING- identificano data set ausiliari della macro quadraturagruppo);
%put %str(WARNING- che vengono cancellati al termine delle elaborazioni        );
%put %str(WARNING- ============================================================);
%put;


proc sort data = &daquadrare;
	by &vargruppo;
run;
proc means data = &daquadrare noprint;
	by &vargruppo;
	output out = somma (keep = &vargruppo datot)
		   sum(&daquad) = datot;
run;
proc sort data = &totpergru;
	by &vargruppo;
run;
data somma;
	merge somma (in = inso) &totpergru (in = into);
	by &vargruppo;
	if inso and into;
	keep &vargruppo datot &perquad;
run; 


data quadrare;
	merge &daquadrare somma (in = presente);
	by &vargruppo;
	if presente;
	&giaquad = &daquad*&perquad/datot;
run;


data &quadrato;
	set quadrare;
	drop &daquad datot &perquad;
run;


proc datasets library = work;
	delete somma quadrare;
run;
quit;

%mend quadraturagruppo;
