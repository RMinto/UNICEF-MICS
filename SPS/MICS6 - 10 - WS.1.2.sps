* Encoding: windows-1252.
* MICS6 WS.1.2.
 * Households are considered to use improved sources of drinking water if WS1=11, 12, 13, 14, 21, 31, 41, 51, 61, 71, 72, 91, 92

 * Water on premises: (WS1 or WS2=11, 12, or 13) or (WS3=1 or 2).

 * Time to water source is based on responses to WS4. Note that "up to and including 30 mins" differs from previous MICS tabulation and is aligned with SDG definition for 
   basic drinking water services (no more than 30 mins roundtrip). Members do not collect should be treated as <=30 mins.

 * Households are considered to use basic drinking water services if
     (WS1=11 or 12) OR
     [(WS1=61, 71, or 72) and WS4<=30] OR
     [(WS1=13, 14, 21, 31, 41, or 51) and [(WS3=1 or 2) or (WS4<=30)]] OR
     [(WS1=91 or 92) and (WS2=11 or 12)] OR
     [(WS1=91 or 92) and [(WS2=61, 71, or 72) and WS4<=30)]] OR
     [(WS1=91 or 92) and [(WS2=13, 14, 21, 31, 41, or 51) and [(WS3=1 or 2) or (WS4<=30)]]]

 * Denominators are obtained by weighting the number of households by the number of household members (HH48).
***.

* Call include file for the working directory and the survey name.
include "surveyname.sps".

get file = 'hh.sav'.

select if (HH46  = 1).

compute hhweightHH48 = HH48*hhweight.

weight by hhweightHH48.

compute nhhmem  = 1.
variable labels  nhhmem "Number of household members".
value labels nhhmem 1 "".

recode WS4
  (0 = 2)
 (1 thru 30 = 2)
  (31 thru 990 = 3)
  (998, 999 = 9) into time.

* Water on premises.
if ( any(WS1, 11, 12, 13) or
     any(WS2, 11, 12, 13) or
     any(WS3, 1, 2) )        time = 1.

variable labels  time "Time to source of drinking water".
value labels time
    1 "Water on premises"
    2 "Up to and including 30 minutes [A]"
    3 "More than 30 minutes"
    9 "DK/Missing" .

* include definition of drinkingWater .
include "define/MICS6 - 10 - WS.sps" .

variable labels  drinkingWater "Time to source of drinking water".
value labels drinkingWater 1 "Users of improved drinking water sources" 2 "Users of unimproved drinking water sources".

COMPUTE	INDWS2=0.
IF (any (WS1, 11, 12)) INDWS2=100.
IF ((any(WS1, 61, 71, 72)) AND WS4<=30) INDWS2=100.
IF ((any(WS1, 13, 14, 21, 31, 41, 51)) AND ((any (WS3, 1, 2)) OR WS4<=30)) INDWS2=100.
IF (any(WS1, 91, 92)) AND (any(WS2, 11, 12)) INDWS2=100.
IF (any(WS1, 91, 92))  AND ((any(WS2, 61, 71, 72)) AND WS4<=30) INDWS2=100.
IF (any(WS1, 91, 92))  AND (any(WS2, 13, 14, 21, 31, 41, 51)) AND (((any(WS3, 1, 2)) OR WS4<=30)) INDWS2=100.
variable labels INDWS2 "Percentage using basic drinking water services [1]".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute total100 = 100.
variable labels  total100 "Total".
value labels total100 100 " ".

*  For labels in French uncomment commands below.
* variable labels
     nhhmem "Nombre de membres des ménages "
	/drinkingWater "Temps mis pour atteindre la source d'eau de boisson"
	/time "Temps mis pour atteindre la source d'eau de boisson"
    /INDWS2 "Pourcentage utilisant les services basiques de l'eau [1]".
* value labels 
     time 
      1 "Eau sur place"
      2 "30 minutes ou moins [A]"
      3 "Plus de 30 minutes"
      9 "NSP/Manquant" 
	/drinkingWater 
	  1 "Utilisateurs de sources améliorées d'eau" 
	  2 "Utilisateurs de sources non améliorées d'eau".
	  
*  For labels in Spanish uncomment commands below.
* variable labels
     nhhmem "Número de miembros del hogar "
	/drinkingWater "Tiempo a la fuente de agua para beber"
	/time "Tiempo a la fuente de agua para beber"
    /INDWS2 "Porcentaje que utiliza servicios básicos de agua potable [1]".
* value labels 
     time 
      1 "Agua en el sitio"
      2 "Hasta e incluyendo 30 minutos [A]"
      3 "Más de 30 minutos"
      9 "NS/Ignorado" 
	/drinkingWater 
	  1 "Usuarios de fuentes mejoradas de agua para beber" 
	  2 "Usuarios de fuentes no mejoradas de agua para beber".


* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = time
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + ethnicity [c]
         + windex5 [c]
   by
           drinkingWater [c] >
             time[c][layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + INDWS2 [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Table WS.1.2: Use of basic and limited drinking water services"
    "Percent distribution of household population according to time to go to source of drinking water, get water and return, " +
    "for users of improved and unimproved drinking water sources and percentage using basic drinking water services, " + surveyname
 caption=
    "[1] MICS indicator WS.2 - Use of basic drinking water services; SDG Indicator 1.4.1"
    "[A] Includes cases where household members do not collect".

* Ctables command in French.  
* ctables
ctables
  /vlabels variables = time
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + ethnicity [c]
         + windex5 [c]
   by
           drinkingWater [c] >
             time[c][layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + INDWS2 [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.1.2: Utilisation des services d'eau de base et limités"
    "Pourcentage de la population des ménages selon le temps mis  " +
    "par les utilisateurs de sources améliorées et non améliorées d'eau de boisson, pour se rendre à la source d'eau de boisson, obtenir de l'eau et revenir, " + surveyname											
 caption=
    "[1] Indicateur MICS WS.2 - Utilisation des services basique d'eau; Indicateur ODD 1.4.1"
    "[A] Inclut les cas où les membres du ménage ne collectent pas".

* Ctables command in Spanish.  
* ctables
ctables
  /vlabels variables = time
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + ethnicity [c]
         + windex5 [c]
   by
           drinkingWater [c] >
             time[c][layerrowpct.validn '' f5.1]
         + total100 [s] [mean '' f5.1]
         + INDWS2 [s] [mean '' f5.1]
         + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.1.2: Uso de servicios de agua potable básicos y limitados"
    "Distribución porcentual de población de hogares, según el tiempo para ir a la fuente de agua para beber, " + 
	"recoger agua y regresar, para usuarios de fuentes mejoradas y no mejoradas de agua para beber y porcentaje que utiliza servicios básicos de agua potable, " + surveyname
 caption=
    "[1] MICS indicador WS.2 - Uso de servicios básicos de agua potable; Indicador ODS 1.4.1"
    "[A] Incluye casos en los que los miembros del hogar no recogen".

new file.
