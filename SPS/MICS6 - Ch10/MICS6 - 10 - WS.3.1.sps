* Encoding: windows-1252.
 * Improved sanitation facilities are: WS11=11, 12, 13, 15, 18, 21, 22, and 31.

 * Denominators are obtained by weighting the number of households by the number of household members (HH48). 

***.

* Call include file for the working directory and the survey name.
include "surveyname.sps".

get file = 'hh.sav'.

select if (HH46  = 1).

compute hhweightHH48 = HH48*hhweight.
weight by hhweightHH48.

compute nhhmem = 1.
variable labels  nhhmem "Number of household members".
value labels nhhmem 1 " ".

* include definition of sanitation facilities .
include "define/MICS6 - 10 - WS.sps" .

recode WS11 (97,98, 99 = 99) .
variable labels  WS11 "".
add value labels WS11 
	95 " " 
	99 "DK/Missing".

compute improvepercent=0.
if toiletType=1 improvepercent=100.
variable labels improvepercent "Percentage using improved sanitation [1]".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute total100 = 100.
variable labels  total100 "Total".
value labels total100 100 " ".

if WS11 = 95 WS14 = 4.
variable labels WS14 "Location of sanitation facility".
add value labels WS14 4 "Open defecation (no facility, bush, field)".

variable labels toiletType "Type of sanitation facility used by household".
add value labels toiletType 1 "Improved sanitation facility" 2 "Unimproved sanitation facility" 3"Open defecation (no facility, bush, field)".

*  For labels in French uncomment commands below.
* variable labels
      nhhmem "Nombre de membres des ménages"
	 /improvepercent "Pourcentage utilisant des installations sanitaires améliorées [1]"
	 /WS14 "Emplacement de l'installation d'assainissement"
	 /toiletType "Type de toilettes utilisées par les ménages".
* add value labels WS14 4 "Aucune installation /Buisson/Champ"
	 /toiletType 1 "Toilettes améliorées" 2 "Toilettes non améliorées" 3"Défécation à l'air libre (pas de toilettes, brousse, champs)".
	 
*  For labels in Spanish uncomment commands below.
* variable labels
      nhhmem "Número de miembros del hogar"
	 /improvepercent "Porcentaje que utiliza saneamiento mejorado [1]"
	 /WS14 "Ubicación de la instalación sanitaria"
	 /toiletType "Type of sanitation facility used by household".
* add value labels WS14 4 "No hay instalación, campo abierto, matorrales"
	 /toiletType 1 "Improved sanitation facility" 2 "Unimproved sanitation facility" 3"Open defecation (no facility, bush, field)".
	 

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = WS11 
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + WS14 [c]
         + ethnicity [c]
         + windex5 [c]
   by
           toiletType [c] >  WS11 [c] [layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + improvepercent [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Table WS.3.1: Use of improved and unimproved sanitation facilities"
    "Percent distribution of household population according to type of sanitation facility used by the household, " + surveyname
   caption=
     "[1] MICS indicator WS.8 - Use of improved sanitation facilities; SDG indicator 3.8.1"
     "na: not applicable".

* Ctables command in French.  
* ctables
  /vlabels variables = WS11 
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + WS14 [c]
         + ethnicity [c]
         + windex5 [c]
   by
           toiletType [c] >  WS11 [c] [layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + improvepercent [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.3.1: Utilisation d'installations sanitaires améliorées et non améliorées"
    "Distribution en pourcentage de la population des ménages selon le type de toilettes utilisées par les ménages, " + surveyname
   caption=
     "[1] Indicateur MICS WS.8 - Utilisation d'installations sanitaires améliorées; indicateur ODD 3.8.1"
     "na: not applicable".

* Ctables command in Spanish.  
* ctables
  /vlabels variables = WS11 
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + WS14 [c]
         + ethnicity [c]
         + windex5 [c]
   by
           toiletType [c] >  WS11 [c] [layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + improvepercent [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.3.1: Uso de instalaciones de saneamiento mejoradas y no mejoradas"
    "Distribución porcentual de la población de los hogares según el tipo de instalación sanitaria utilizada por el hogar, " + surveyname
   caption=
     "[1] MICS indicador WS.8 - Uso de instalaciones sanitarias mejoradas; indicador ODS 3.8.1"
     "na: not applicable".

new file.
