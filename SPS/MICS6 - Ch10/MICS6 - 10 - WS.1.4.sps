* Encoding: windows-1252.

 * Households without drinking water on premises and where household members are primarily responsible for collecting water: WS3=3 and (WS4<>000 or 998).

 * Person usually collecting drinking water is obtained from WS5 by matching the line number of the person from the List of Household Members module in the Household Questionnaire.

 * Time spent collecting water is WS6 multiplied by average roundtrip travel time (WS4) and divided by 7. 

 * Denominators are obtained by weighting the number of households by the total number of household members (HH48).


***.

get file = 'hl.sav'.

* Sort the cases by cluster number, household number and line number.
sort cases by HH1 HH2 HL1.

* Customize the household member education level categories.
recode ED5A (1 = 1) (2 = 2) (3,4 = 3)  (8,9 = 9) (else = 0) into elevel.
variable labels elevel "Education".
value labels elevel
  0 "None/ECE"
  1 "Primary"
  2 "Lower secondary"
  3 "Upper secondary or higher"  
  9 "DK/Missing".


* Save data file of person collecting water as only variables.
save outfile = 'tmppersoncwater.sav'
  /keep HH1 HH2 HL1 HL4 HL6 elevel 
  /rename HL1 = WS5.

new file.

get file = 'hh.sav'.

* Call include file for the working directory and the survey name.
include "surveyname.sps".

sort cases by HH1 HH2.

* Merge the person collecting the water with the household file. 
match files
  /file = *
  /table = 'tmppersoncwater.sav'
  /by HH1 HH2 WS5.

select if (HH46  = 1 and WS4>0).

compute hhweightHH48 = HH48*hhweight.
weight by hhweightHH48.

compute nhhmem  = 1.
variable labels  nhhmem "Number of household members without drinking water on premises and where household members are primarily responsible for collecting water".
value labels nhhmem 1 "".

compute time=$sysmis.
if (WS4<995 and WS6<95) time=TRUNC(WS4*WS6/7).
recode time
  (0 thru 30 = 1)
  (31 thru 60 = 2)
  (61 thru 180 = 3)
  (181 thru highest = 4) into averagetime.
if (WS4>995 or WS6>95) averagetime= 9.

variable labels  averagetime "Average time spent collecting water per day".
value labels averagetime
    1 "Up to 30 minutes"
    2 "From 31 mins to 1 hour"
    3 "Over 1 hour to 3 hours"
    4 "Over 3 hours"
    9 "DK/Missing" .

recode HL6 (0 thru 14 = 1) (15 thru 49 = 3) (50 thru 95 = 4) (else = 9) into age1.
variable labels age1 "Age".
recode HL6 (15 thru 17 = 2)  into age2.
value labels age1 1 "<15" 2 "5-14" 3 "15-49" 4 "50+" 9 "DK/Missing". 

* Define Multiple Response Sets.
mrsets
  /mcgroup name = $age
           label = 'Age'
           variables = age1 age2.

* include definition of drinkingWater .
include "define/MICS6 - 10 - WS.sps" .

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute total100 = 100.
variable labels  total100 "Total".
value labels total100 100 " ".

variable labels drinkingWater "Source of drinking water".
value labels drinkingWater 1 "Improved" 2 "Unimproved".

*  For labels in French uncomment commands below.
* variable labels 
     nhhmem "Nombre de membres du ménage sans eau  dans les locaux et où les membres du ménage sont principalement responsables de la collecte de l'eau"
	 /drinkingWater "Source d'eau de boisson".
* value labels   
	 averagetime
      1 "Jusqu'à 30 minutes "
      2 "De 31 minutes à 1 heure "
      3 "Plus d'une heure à 3 heures "
      4 "Plus de 3 heures "
      9 "NSP/Manquant"
	/age1 
	  1 "<15" 
	  2 "5-14" 
	  3 "15-49" 
	  4 "50+" 
	  9 "NSP/Manquant"
	/drinkingWater 
	  1 "Améliorées" 
	  2 "Non améliorées".
	  
*  For labels in Spanish uncomment commands below.
* variable labels 
     nhhmem "Número de miembros del hogar sin agua potable en el sitio y donde los miembros del hogar son los principales responsables de la recolección de agua"
	 /drinkingWater "Fuente de agua potable".
* value labels   
	 averagetime
      1 "Hasta 30 minutos "
      2 "De 31 mins a 1 hora "
      3 "Más de 1 hora a 3 horas "
      4 "Más de 3 horas "
      9 "NS/Ignorado"
	/age1 
	  1 "<15" 
	  2 "5-14" 
	  3 "15-49" 
	  4 "50+" 
	  9 "NS/Ignorado"
	/drinkingWater 
	  1 "Mejorada" 
	  2 "No mejorada".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = time
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + elevel [c]
         + $age [c]
         + HL4 [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
             averagetime[c][layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Table WS.1.4: Time spent collecting water "
    "Average time spent collecting water by person usually responsible for water collection, " + surveyname
  .

* Ctables command in French.  
* ctables
  /vlabels variables = time
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + elevel [c]
         + $age [c]
         + HL4 [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
             averagetime[c][layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.1.4: Temps consacré à la collecte de l'eau"
    "Temps moyen consacré à la collecte de l'eau par la personne habituellement responsable de la collecte de l'eau, " + surveyname
  .


* Ctables command in Spanish.  
* ctables
  /vlabels variables = time
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + elevel [c]
         + $age [c]
         + HL4 [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
             averagetime[c][layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.1.4: Tiempo dedicado a recolectar agua"
    "Tiempo promedio dedicado a la recolección de agua por persona generalmente responsable de la recolección de agua, " + surveyname
  .
  
new file.

erase file = 'tmppersoncwater.sav'.
