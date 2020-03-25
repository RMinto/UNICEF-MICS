* Encoding: windows-1252.

 * Households without drinking water on premises (WS1 or WS2<>11 or 12) or (WS3<>1 or 2).

 * Person usually collecting drinking water is obtained from WS5 by matching the line number of the person from the List of Household Members module in the Household Questionnaire.

 * Denominators are obtained by weighting the number of households by the total number of household members (HH48).

***.

get file = 'hl.sav'.

* Sort the cases by cluster number, household number and line number.
sort cases by HH1 HH2 HL1.

compute personcwater=9.
if (HL4=2 and HL6>=15 and HL6<=95) personcwater=1.
if (HL4=1 and HL6>=15 and HL6<=95) personcwater=2.
if (HL4=2 and HL6<=14) personcwater=3.
if (HL4=1 and HL6<=14) personcwater=4.
variable labels  personcwater "Person usually collecting drinking water".
value labels personcwater 1 "Woman (15+)" 2 "Man (15+)" 3 "Female child under age 15" 4 "Male child under age 15" 9 "DK/Missing/Members do not collect".


* Save data file of person collecting water as only variables.
save outfile = 'tmppersoncwater.sav'
  /keep HH1 HH2 HL1 personcwater
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

if WS4=0 personcwater=9.
if WS5=0 or WS5>90 personcwater=9.
select if (HH46  = 1).

compute hhweightHH48 = HH48*hhweight.

weight by hhweightHH48.

compute nhhmem = 1.
variable labels  nhhmem "Number of household members".
value labels nhhmem 1 "".

compute withoutWater = 0.
if (not(sysmis(WS4))) withoutWater = 100.
variable labels  withoutWater "Percentage of household members without drinking water on premises".

do if (not(sysmis(WS4))).
+ compute nhhmemwithoutWater  = 1.
end if.

variable labels  nhhmemwithoutWater "Number of household members without drinking water on premises".
value labels nhhmemwithoutWater 1 "".

* include definition of drinkingWater .
include "define/MICS6 - 10 - WS.sps" .

variable labels drinkingWater "Source of drinking water".
value labels drinkingWater 1 "Improved" 2 "Unimproved".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

*  For labels in French uncomment commands below.
* variable labels 
      nhhmem "Nombre de membres des ménages "
	 /drinkingWater "Source d'eau de boisson"
	 /withoutWater "Pourcentage de ménages sans eau de boisson sur place"
	 /personcwater "Personne qui va habituellement chercher de l'eau de boisson"
	 /nhhmemwithoutWater "Nombre de membres des ménages sans eau de boisson sur place".
* value labels   
	 personcwater 
	  1 "Femme (15+)" 
	  2 "Homme(15+)" 
	  3 "Fillette de moins de 15 ans" 
	  4 "Garçon de moins de 15 ans" 
	  9 "NSP/Manquant/Les membres ne collectent pas"
	/drinkingWater 
	  1 "Améliorées" 
	  2 "Non améliorées".

*  For labels in Spanish uncomment commands below.
* variable labels 
      nhhmem "Número de miembros del hogar "
	 /drinkingWater "Fuente de agua potable"
	 /withoutWater "Porcentaje de hogares sin agua para beber en el sitio"
	 /personcwater "Persona que recoge habitualmente el agua para beber"
	 /nhhmemwithoutWater "Número de miembros del hogar sin agua para beber en el sitio".
* value labels   
	 personcwater 
	  1 "Mujer (15+)" 
	  2 "Hombre(15+)" 
	  3 "Niña menor de 15 años" 
	  4 "Niño menor de 15 años" 
	  9 "NS/Ignorado"
	/drinkingWater 
	  1 "Mejorada" 
	  2 "No mejorada".
 
ctables
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
           withoutWater [s] [mean '' f5.1]
         + nhhmem [s][sum '' f5.0]
         + personcwater [c] [rowpct.validn '' f5.1]
         + nhhmemwithoutWater[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=personcwater total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Table WS.1.3: Person collecting water"
    "Percentage of household members without drinking water on premises, and percent distribution of household members " +
    "without drinking water on premises according to the person usually collecting drinking water used in the household, " + surveyname
  .
  
* Ctables command in French.  
* ctables
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
           withoutWater [s] [mean '' f5.1]
         + nhhmem [s][sum '' f5.0]
         + personcwater [c] [rowpct.validn '' f5.1]
         + nhhmemwithoutWater[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=personcwater total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.1.3: Personne qui collecte de l'eau"
    "Pourcentage des membres des ménages sans eau de boisson sur place et pourcentage des membres des ménages " +
    "sans eau de boisson sur place selon la personne qui va habituellement chercher l'eau de boisson utilisée dans le ménage, " + surveyname
  .

* Ctables command in Spanish.  
* ctables
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
           withoutWater [s] [mean '' f5.1]
         + nhhmem [s][sum '' f5.0]
         + personcwater [c] [rowpct.validn '' f5.1]
         + nhhmemwithoutWater[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=personcwater total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.1.3: Persona que recoge el agua"
    "Porcentaje de hogares sin agua para beber en el sitio, y distribución porcentual de hogares sin agua para beber en el sitio, según la persona que recoge habitualmente el agua para beber que usa el hogar, " + surveyname
  .


new file.

erase file = 'tmppersoncwater.sav'.
