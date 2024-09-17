%macro quadraturagruppo(daquadrare,		/*data set di input*/
						daquad,			/*variabile da quadrare*/
						totpergru,		/*data set totali per gruppo*/
						perquad,		/*variabile per quadratura*/
						giaquad,		/*variabile quadrata*/
						vargruppo,		/*variabile di raggruppamento*/
						quadrato);		/*data set di output*/
/*macro di quadratura della variabile daquad                  */
/*mediante le somme per gruppo fornite dalla variabile perquad*/
/*NB: ai parametri daquad e giaquad devono essere passati nomi*/
/*di variabile diversi (la prima variabile non è conservata)  */

%put;
%put %str(WARNING- ============================================================);
%put %str(WARNING: I nomi);
%put %str(WARNING- somma quadrare);
%put %str(WARNING- identificano data set ausiliari della macro quadraturagruppo);
%put %str(WARNING- che vengono cancellati al termine delle elaborazioni        );
%put %str(WARNING- ============================================================);
%put;

/*preparo data set delle somme per quadratura*/
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

/*aggiungo somme ai dati ed effettuo quadratura*/
data quadrare;
	merge &daquadrare somma (in = presente);
	by &vargruppo;
	if presente;
	&giaquad = &daquad*&perquad/datot;
run;

/*genero data set di output*/
data &quadrato;
	set quadrare;
	drop &daquad datot &perquad;
run;

/*elimino i data set ausiliari*/
proc datasets library = work;
	delete somma quadrare;
run;
quit;

%mend quadraturagruppo;
