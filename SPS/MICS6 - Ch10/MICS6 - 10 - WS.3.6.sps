* Encoding: windows-1252.

* For definitions, see Tables WS.1.2,  WS 2.1 and WS.3.2.

* Denominators are obtained by weighting the number of households by the total number of household members (HH48) .
											
* v02 - 2019-08-28. Last modified to reflect tab plan changes as of 25 July 2019.

***.

include "surveyname.sps".

get file = 'hh.sav'.

select if (HH46  = 1).

compute hhweightHH48 = HH48*hhweight.
weight by hhweightHH48.

compute nhhmem  = 1.
value labels nhhmem 1 "".
variable labels nhhmem "Number of household members".

* include definition of drinkingWater .
include "define/MICS6 - 10 - WS.sps" .

* Water.
compute drinkingLayer = 0.
value labels drinkingLayer 0 "Drinking water".

compute drinking = drinkingWater + 1.
if (any (WS1, 11, 12)) drinking=1.
if ((any(WS1, 61, 71)) and WS4<=30) drinking=1.
if ((any(WS1, 13, 14, 21, 31, 41, 51)) and ((any (WS3, 1, 2)) or WS4<=30)) drinking=1.
if (any(WS1, 91, 92)) and (any(WS2, 11, 12)) drinking=1.
if (any(WS1, 91, 92))  and ((any(WS2, 61, 71)) and WS4<=30) drinking=1.
if (any(WS1, 91, 92))  and (any(WS2, 13, 14, 21, 31, 41, 51)) and (((any(WS3, 1, 2)) or WS4<=30)) drinking=1.
if WS1 = 81  drinking = 4.
variable labels drinking "Drinking water".
value labels drinking 1 "Basic service [1]" 2 "Limited service" 3 "Unimproved" 4 " Surface water".

compute sanitation=toiletType+1.
if (toiletType=1 and sharedToilet = 0) sanitation=1.
variable labels sanitation "Sanitation".
value labels sanitation 1 "Basic service [2]" 2 "Limited service" 3 "Unimproved" 4 " Open defecation".

compute handwashing=4.
if HW1<=3 handwashing = 2.
if HW1=4 handwashing = 3.
if (HW1<=4) and (HW2=1 and (HW7A="A" or HW7B="B")) handwashing = 1.
variable labels handwashing "Handwashing [A]".
value labels handwashing 1 "Basic facility [B]" 2 "Limited facility" 3 "No facility" 4 " No permission to see/Other".

compute basictotal=0.
if (drinking=1 and sanitation=1 and handwashing=1) basictotal=100.
variable labels basictotal "Basic drinking water, sanitation and hygiene service".

compute total = 100.
variable labels total "Total".
value labels total 100 " ".

compute layer1 = 0.
value labels layer1 0 "Percentage of household population using:".

*  For labels in French uncomment commands below.
* variable labels
      nhhmem "Nombre de membres du ménage"
	 /drinking "Eau de boisson"
	 /sanitation "Assainissement"
	 /handwashing "Lavage des mains [A]"
	 /basictotal "Service d'eau potable, d'assainissement et d'hygiène".
* value labels 
      drinkingLayer 0 "Eau de boisson"
	 /drinking 1 "Service de base [1]" 2 "Service limité" 3 "Non amélioré" 4 " Eau de surface"
	 /sanitation 1 "Service de base [2]" 2 "Service limité" 3 "Non amélioré" 4 "Défecation à l'air libre"
	 /handwashing 1 "Installation de base [B]" 2 "Installation limitée" 3 " Aucune installation" 4 "Aucune autorisation à voir/Autre"
                   /layer1 0 "Pourcentage de la population utilisant de:"..

*  For labels in Spanish uncomment commands below.
* variable labels
      nhhmem "Número de miembros del hogar"
	 /drinking "Agua para beber"
	 /sanitation "Sanitation"
	 /handwashing "Lavado de manos [A]"
	 /basictotal "Servicio básico de agua potable, saneamiento e higiene".
* value labels 
      drinkingLayer 0 "Agua para beber"
	 /drinking 1 "Servicio básico [1]" 2 "Servicio limitado" 3 "No mejorado" 4 " Agua de superficie"
	 /sanitation 1 "Servicio básico [2]" 2 "Servicio limitado" 3 "No mejorado" 4 "Defecación abierta"
	 /handwashing 1 "Installation de base [B]" 2 "Instalación limitada" 3 "Sin instalación" 4 "Sin permiso para ver/Otro"
	 /layer1 0 "Porcentaje de población de los hogares usando: ".

	 
* Ctables command in English (currently active, comment it out if using different language).
ctables
 /vlabels variables = layer1
           display = none 
 /table   total [c]
        + HH6 [c]
        + HH7 [c]
        + helevel [c]
        + ethnicity [c]
        + windex5 [c]
  by
             layer1 [c] > (drinking [c] [rowpct.totaln '' f5.1]
          + sanitation [c] [rowpct.totaln '' f5.1]     
          + handwashing [c] [rowpct.totaln '' f5.1]   
          + basictotal [s] [mean '' f5.1])   
          + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=drinking sanitation handwashing total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Table WS.3.6: Drinking water, sanitation and handwashing ladders"
    "Percentage of household population by drinking water, sanitation and handwashing ladders, " + surveyname
   caption =
    "[1] MICS indicator WS.2 - Use of basic drinking water services; SDG Indicator 1.4	"
    "[2] MICS indicator WS.9 - Use of basic sanitation services; SDG indicators 1.4.1 & 6.2.1"
    "[A] For the purposes of calculating the ladders, 'No permission to see / other' is included in the denominator."
    "[B] Differs from the MICS indicator WS.7 'Handwashing facility with water and soap' (SDG indicators 1.4.1 & 6.2.1) as it includes 'No permission to see / other'. See table WS2.1 for MICS indicator WS.7".
  .																

* Ctables command in French.  
* ctables
 /vlabels variables = layer1 
           display = none 
 /table   total [c]
        + HH6 [c]
        + HH7 [c]
        + helevel [c]
        + ethnicity [c]
        + windex5 [c]
  by
             layer1 [c] > (drinking [c] [rowpct.totaln '' f5.1]
          + sanitation [c] [rowpct.totaln '' f5.1]     
          + handwashing [c] [rowpct.totaln '' f5.1]   
          + basictotal [s] [mean '' f5.1])
          + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=drinking sanitation handwashing total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.3.6: Échelles d'eau potable, d'assainissement et de lavage des mains"
    "Pourcentage de la population à domicile par échelles d'eau potable, d'assainissement et de lavage des mains, " + surveyname
   caption =
    "[1] Indicateur MICS WS.2 - Utilisation des services d'eau potable de base; Indicateur ODD 1.4.1"
    "[2] Indicateur MICS WS.9 - Utilisation des services d'assainissement de base; Indicateurs ODD 1.4.1 et 6.2.1"
    "[3] Indicateur MICS WS.7 - Installation de lavage des mains à l'eau et au savon; Indicateurs ODD 1.4.1 et 6.2.1"
    "[A] Pour le calcul des échelles, <<Aucune permission de voir / autre>> est inclus dans le dénominateur."
    "[B] Differs from the MICS indicator WS.7 'Handwashing facility with water and soap' (SDG indicators 1.4.1 & 6.2.1) as it includes 'No permission to see / other'. See table WS2.1 for MICS indicator WS.7".
  .

* Ctables command in Spanish.  
* ctables
 /vlabels variables = layer1 
           display = none 
 /table   total [c]
        + HH6 [c]
        + HH7 [c]
        + helevel [c]
        + ethnicity [c]
        + windex5 [c]
  by
            layer1 [c] > (drinking [c] [rowpct.totaln '' f5.1]
          + sanitation [c] [rowpct.totaln '' f5.1]     
          + handwashing [c] [rowpct.totaln '' f5.1]   
          + basictotal [s] [mean '' f5.1])
          + nhhmem [s] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=drinking sanitation handwashing total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.3.6: Escalas de agua para beber, saneamiento y lavado de manos"
    "Porcentaje de población de los hogares por escalas de agua para beber, saneamiento y lavado de manos, " + surveyname
   caption =
    "[1] MICS indicador WS.2 -  Uso de servicios básicos de agua potable; Indicador ODS 1.4.1"
    "[2] MICS indicador WS.9 - Uso de servicios básicos de saneamiento; indicadores ODS 1.4.1 & 6.2.1"
    "[3] MICS indicador WS.7 - Lugar para lavarse las manos con agua y jabón; Indicadores ODS 1.4.1 y 6.2.1"
    "[A] Para efecto de calcular las escalas, <<Sin permiso paraver/otro>> está incluido en el denominador."
    "[B] Differs from the MICS indicator WS.7 'Handwashing facility with water and soap' (SDG indicators 1.4.1 & 6.2.1) as it includes 'No permission to see / other'. See table WS2.1 for MICS indicator WS.7".
  .
new file.