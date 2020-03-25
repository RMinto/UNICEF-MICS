* Encoding: windows-1252.
* Only households where handwashing facility was observed by the interviewer (HW1=1, 2, 3) and households 
* with no handwashing facility (HW1=4) are included in the denominator of the indicator (HW1=5, 6, and 9 [if any] are excluded). 
* Households with water at handwashing facility (HW2=1) and soap or other cleansing agent at handwashing facility (HW7=A or B) are included in the numerator.
	
* In countries where a large proportion of households (>10%) do not give permission to observe handwashing facilities 
* further analysis of the responses to HW4-HW7 is advised.  

* Denominators are obtained by weighting the number of households by the total number of household members (HH48).
***.

* Call include file for the working directory and the survey name.
include "surveyname.sps".

get file = 'hh.sav'.

select if (HH46  = 1).

compute hhweightHH48 = HH48*hhweight.
weight by hhweightHH48.

compute nhhmem = 1.
variable labels  nhhmem " ".
value labels nhhmem 1 "Number of household members".

compute layer1 = 0.
variable labels layer1 " ".
value labels layer1 0 "Handwashing facility observed".

compute layer2 = 0.
variable labels layer2 " ".
value labels layer2 0 "Handwashing facility observed and".

compute fixedobserved = 0.
if (HW1 = 1 or HW1 = 2) fixedobserved = 100.
variable labels  fixedobserved "Fixed facility observed".

compute mobileobserved = 0.
if (HW1 = 3) mobileobserved = 100.
variable labels  mobileobserved "Mobile object observed".

compute noplace = 0.
if (HW1 = 4) noplace = 100.
variable labels  noplace "No handwashing facility observed in the dwelling, yard, or plot".

compute nopermission = 0.
if (HW1 >= 5) nopermission = 100.
variable labels  nopermission "No permission to see/Other".

do if (fixedobserved = 100 or mobileobserved = 100).
+ compute numHouseholdsObs = 1.
+ compute water=0.
* Water is available.
+ if HW2=1 water=100.
+ compute Soap = 0.
* Soap present.
+ if (HW7A = "A" or HW7B = "B") Soap = 100.
+ compute Ash = 0.
* Ash, mud, or sand present.
+ if (HW7C = "C") Ash = 100.
end if.

do if (fixedobserved = 100 or mobileobserved = 100 or noplace = 100).
+ compute numHHObsnoplace = 1.
+ compute indWS7 = 0.
+ if (HW2 = 1 and (HW7A = "A" or HW7B = "B")) indWS7 = 100.
end if.

variable labels  water "water available".
variable labels  Soap "soap available".
variable labels  Ash "with ash/mud/sand available".

variable labels indWS7 "Percentage of household members with handwashing facility where water and soap are present[1]".

* Make sure to include entire labels in final table. As labels exceeds 120 characters it had to be truncated by removing > in the dwelling, yard, or plot<.
*  Number of household members where handwashing facility was observed or with no handwashing facility in the dwelling, yard, or plot.
value labels numHHObsnoplace 1 "Number of household members where handwashing facility was observed or with no handwashing facility in the dwelling, yard, or plot".

variable labels numHouseholdsObs "".
value labels numHouseholdsObs 1 "Number of household members where handwashing facility was observed".

compute total = 1.
variable labels total "".
value labels total 1 "Total".

compute total100 = 100.
variable labels total100 "Total".
value labels total100 100 "".

*  For labels in French uncomment commands below.
* variable labels 
     fixedobserved "Installation fixe observée"
	/mobileobserved "Objet mobile observé"
	/noplace "Pas de lieu spécifique pour le lavage des mains dans le logement/cour/ jardin"
	/nopermission "Aucune permission de voir / Autre"
	/water "Eau disponible"
    /Soap "Savon disponible"
    /Ash "Cendre, boue ou sable disponible"
	/indWS7 " Pourcentage des membres du ménage ayant une installation de lavage des mains où l'eau et le savon sont présents [1]".
* value labels 
     nhhmem 1 "Nombre de membres des ménages"
	/layer1 0 "Lieu de lavage des mains observé"
                  /layer2 0 "Lieu de lavage des mains observé et"
	/numHHObsnoplace 1 "Nombre de membres du ménage où l'installation de lavage des mains a été observée ou sans installation de lavage des mains dans le logement, la cour ou la parcelle"
	/numHouseholdsObs 1 "Nombre de membres du ménage où l'on a observé une installation de lavage des mains".
	
*  For labels in Spanish uncomment commands below.
* variable labels 
     fixedobserved "Instalación fija observada"
	/mobileobserved "Objeto móvil observado"
	/noplace "No se observó instalación para lavarse las manos en la vivienda, patio o parcela"
	/nopermission "Sin permiso para ver/Otro"
	/water "Agua disponible"
    /Soap "Jabón  disponible"
    /Ash "Ceniza/barro/arena disponible"
	/indWS7 " Porcentaje de miembros del hogar con instalaciones para lavarse las manos donde el agua y el jabón están presentes [1]".
* value labels 
     nhhmem 1 "Número de miembros del hogar"
	/layer1 0 "Lugar para lavarse las manos observado"
                  /layer2 0 "Lugar para lavarse las manos observado y"
	/numHHObsnoplace 1 "Número de miembros del hogar donde se observó el lugar para lavarse las manos o sin instalaciones para lavarse las manos en la vivienda, jardín o parcela"
	/numHouseholdsObs 1 "Número de miembros del hogar donde se observó el lugar para lavarse las manos".
	
ctables
  /vlabels variables =  layer1 layer2 total nhhmem numHouseholdsObs numHHObsnoplace
         display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + ethnicity [c]
         + windex5 [c]
   by
          layer1 [c] > (fixedobserved [s] [mean '' f5.1] + mobileobserved [s] [mean '' f5.1]) + noplace [s] [mean '' f5.1] + nopermission [s] [mean '' f5.1] + total100  [s] [mean '' f5.1] + nhhmem [c] [count '' f5.0]
         +  layer2 [c] > (water [s] [mean '' f5.1] + Soap [s] [mean '' f5.1] + Ash [s] [mean '' f5.1]) + numHouseholdsObs [c] [count '' f5.0]
         + indWS7  [s] [mean '' f5.1]
         + numHHObsnoplace [c] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Table WS.2.1: Handwashing facility with soap and water on premises" 
      "Percent distribution of household members by observation of handwashing facility and percentage of household members by availability of water and soap or detergent at the handwashing facility, " + surveyname
   caption=
     "[1] MICS indicator WS.7 - Handwashing facility with water and soap; SDG indicators 1.4.1 & 6.2.1"
     "Note: Ash, mud, sand are not as effective as soap and not included in the MICS or SDG indicator. ".

* Ctables command in French.  
* ctables
  /vlabels variables =  layer1 layer2 total nhhmem numHouseholdsObs numHHObsnoplace
         display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + ethnicity [c]
         + windex5 [c]
   by
          layer1 [c] > (fixedobserved [s] [mean '' f5.1] + mobileobserved [s] [mean '' f5.1]) + noplace [s] [mean '' f5.1] + nopermission [s] [mean '' f5.1] + total100  [s] [mean '' f5.1] + nhhmem [c] [count '' f5.0]
         +  layer2 [c] > (water [s] [mean '' f5.1] + Soap [s] [mean '' f5.1] + Ash [s] [mean '' f5.1]) + numHouseholdsObs [c] [count '' f5.0]
         + indWS7  [s] [mean '' f5.1]
         + numHHObsnoplace [c] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.2.1: Installation de lavage des mains avec du savon et de l'eau dans les locaux" 
      "Répartition en pourcentage des membres du ménage par observation de l'installation de lavage des mains et " +
      "pourcentage des membres du ménage selon la disponibilité d'eau et de savon ou de détergent dans l'installation de lavage des mains, " + surveyname
   caption=
     "[1] Indicateur MICS WS.7 - Installation de lavage des mains à l'eau et au savon; Indicateurs ODD 1.4.1 et 6.2.1"
     "Remarque: Les cendres, la boue et le sable ne sont pas aussi efficaces que le savon et ne sont pas inclus dans l'indicateur MICS ou ODD. ".
	 

* Ctables command in Spanish.  
* ctables
  /vlabels variables =  layer1 layer2 total nhhmem numHouseholdsObs numHHObsnoplace
         display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + ethnicity [c]
         + windex5 [c]
   by
          layer1 [c] > (fixedobserved [s] [mean '' f5.1] + mobileobserved [s] [mean '' f5.1]) + noplace [s] [mean '' f5.1] + nopermission [s] [mean '' f5.1] + total100  [s] [mean '' f5.1] + nhhmem [c] [count '' f5.0]
         +  layer2 [c] > (water [s] [mean '' f5.1] + Soap [s] [mean '' f5.1] + Ash [s] [mean '' f5.1]) + numHouseholdsObs [c] [count '' f5.0]
         + indWS7  [s] [mean '' f5.1]
         + numHHObsnoplace [c] [count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.2.1: Lugar para lavarse las manos con agua y jabón en el sitio" 
      "RéDistribución porcentual de los miembros del hogar por observación del lugar para lavarse las manos y porcentaje de miembros del hogar por disponibilidad de agua y jabón o detergente en el lugar para lavarse las manos, " + surveyname
   caption=
     "[1] MICS indicador WS.7 - Lugar para lavarse las manos con agua y jabón; Indicadores ODS 1.4.1 y 6.2.1"
     "Nota: Las cenizas, el barro y la arena no son tan efectivos como el jabón y no están incluidos en el indicador MICS u ODS.".
	 	 
new file.
