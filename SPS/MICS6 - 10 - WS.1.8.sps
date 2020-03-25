* Encoding: windows-1252.
* Denominators are obtained by weighting the number of households by the number of household members 
* where water quality was assessed for E. coli (HH48 * wqsweight).

* MICS indicator: Safely managed drinking water sources are defined as improved (WS1=11, 12, 13, 14, 21, 31, 41, 51, 61, 71, 72, 91, 92), 
* located on premises (WS1 or WS2=11, 12, or 13) or (WS3=1 or 2), 
* available when needed (WS7=2) and free from faecal contamination at the source (WQ27=0).

* Note in some countries the sample sizes will be too small to disaggregate all types of drinking water source and 
* these can be combined into groups (e.g. piped water, protected wells and springs). 

																																																	   
***.

* v02 - 2019-08-27. Last modified to reflect tab plan changes as of 25 July 2019.

* Call include file for the working directory and the survey name.
include "surveyname.sps".

get file = 'hh.sav'.

sort cases by HH1 HH2.

* include definition of drinking water sources: both improved and unimproved .
include "define/MICS6 - 10 - WS.sps" .

include "CommonVarsHH.sps".

select if (WQ31 = 1).

* Generate E. coli weights for population.
compute wqsweightHH48 = 0.
if (wqsweight>0) wqsweightHH48=wqsweight*HH48.

*Weighting by number of household members.
weight by wqsweightHH48.

compute nhhmem = 1.
variable labels  nhhmem "Number of household members".
value labels nhhmem 1 " ".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute EC_100_S = $sysmis.
if (WQ27 <997 and WQ27 >= 100)  EC_100_S = 101.
if (WQ27 <101 or WQ27 >=997 ) EC_100_S = WQ27. 

recode EC_100_S (0=0) (1 thru 10=1) (11 thru 100=2) (101 = 3) (102 thru highest=9) into Risk_S.
variable labels Risk_S "Risk level based on number of E. coli per 100 mL".
value labels Risk_S 0 "Low (<1 per 100 mL)" 1 "Moderate (1-10 per 100 mL)" 2 "High (11-100 per 100 mL)" 3 "Very high (>100 per 100 mL)" 9 "DK/Missing". 

compute  WithoutEC_S=0.
if Risk_S = 0 WithoutEC_S=100.
variable labels WithoutEC_S "Without E. coli in drinking water source".

*sufficient water.
compute sufficentwater=0.
if WS7= 2 sufficentwater=100.
variable labels sufficentwater "With drinking water available in sufficient quantities".

* Water on premises.
compute wpremises = 0.
if ( any(WS1, 11, 12, 13) or
     any(WS2, 11, 12, 13) or
     any(WS3, 1, 2) )        wpremises = 100.
variable labels wpremises "Drinking water accessible on premises".

compute indSDG611 = 0.
if (drinkingWater = 1 and WithoutEC_S = 100 and sufficentwater = 100 and wpremises = 100) indSDG611=100.
variable labels indSDG611 "Percentage of household members with an improved drinking water source located on premises, free of E. coli and available when needed [1]".

select if Risk_S <=3.

*Type of drinking water source.
do if any(WS1, 11, 12, 13, 14).
+ compute impdrinkingWaterSource = 11.
else if (WS1 = 21).
+ compute impdrinkingWaterSource = 12.
else if any(WS1, 31, 41).
+ compute impdrinkingWaterSource = 13.
else if (WS1 = 51).
+ compute impdrinkingWaterSource = 14.
else if any(WS1, 72).
+ compute impdrinkingWaterSource = 15.						 
else if any(WS1, 61, 71).
+ compute impdrinkingWaterSource = 16.
else if any(WS1, 91, 92).
+ compute impdrinkingWaterSource = 17.
else if any(WS1, 32, 42).			  
+ compute unimpdrinkingWaterSource = 21.
else.
+ compute unimpdrinkingWaterSource = 22.
end if.

do if any(impdrinkingWaterSource, 11, 12, 13, 14, 15, 16, 17).
+ compute watersource = 10.
end if.
do if any(unimpdrinkingWaterSource, 21, 22).
+ compute watersource = 20.
end if.

value labels watersource
  10 "Improved sources"
  11 "   Piped water"
  12 "   Tubewell/Borehole"
  13 "   Protected well or spring"
  14 "   Rainwater collection"
  15 "   Water kiosk"	  				 
  16 "   Tanker-truck/Cart will small tank"
  17 "   Bottled/Sachet water"
  20 "Unimproved sources"
  21 "   Unprotected well or spring"
  22 "   Surface water/Other".

* Define Multiple Response Sets.
mrsets
  /mcgroup name = $watersource
           label = 'Main source of drinking water [A]'
           variables = watersource impdrinkingWaterSource unimpdrinkingWaterSource.
  
  *  For labels in French uncomment commands below.
* variable labels 
      nhhmem "Nombre de membres du ménage"
     /drinkingWater "Source d'eau de boisson"
	 /Risk_S "Niveau de risque basé sur le nombre de E. coli par 100 mL"
	 /WithoutEC_S "Sans E. coli dans la source d'eau de boisson "
	 /sufficentwater "Avec suffisamment d'eau potable disponible en cas de besoin"
	 /wpremises "Eau sur place"
	 /indSDG611 "Pourcentage de membres du ménage ayant une source d'eau de boisson améliorée située dans des locaux, exempts d'E. Coli et disponibles en cas de besoin [1]".
* value labels Risk_S 0 "Faible  (<1 per 100 mL)" 1 "Modéré  (1-10 per 100 mL)" 2 "Haut  (11-100 per 100 mL)" 3 "Très haut  (>100 per 100 mL)" 9 "NSP/Manquant". 
* value labels watersource
  10 "Sources améliorées d'eau"
  11 "   Eau courante"
  12 "   Tube bien / trou de forage"
  13 "   Puits protégé ou source d'eau"
  14 "   Collecte d'eau de pluie"
  15 "   Kiosque à eau"	  				 
  16 "   Camion-citerne / chariot avec petit réservoir"
  17 "   Eau en bouteille / sachet"
  20 "Sources d'eau non améliorées"
  21 "   Puits ou source non protégé"
  22 "   Eau de surface ou autre".
* mrsets
  /mcgroup name = $watersource
           label = 'Main source of drinking water [A]'
           variables = watersource impdrinkingWaterSource unimpdrinkingWaterSource.

*  For labels in Spanish uncomment commands below.
* variable labels 
     nhhmem "Número de miembros del hogar"
	 /drinkingWater "Fuente de agua potable"
	/Risk_S "Nivel de riesgo basado en el número de E. coli por 100 mL "
	 /WithoutEC_S "Sin E. coli en fuente de agua potable"
	 /sufficentwater "Con suficiente agua potable disponible cuando se necesita"
	 /wpremises "Agua potable accesible en el sitio"
	 /indSDG611 "Porcentaje de miembros del hogar con una fuente mejorada de agua potable en el  sitio, libre de E. coli y disponible cuando se necesita [1]".
*value labels Risk_S 0 "Bajo  (<1 per 100 mL)" 1 "Moderado (1-10 per 100 mL)" 2 "Alto  (11-100 per 100 mL)" 3 "Muy alto  (>100 per 100 mL)" 9 "NS/Ignorado". 
* value labels watersource
  10 "Fuentes mejoradas de agua potable"
  11 "   Agua de tubería"
  12 "   Pozo con tubería"
  13 "   Pozo o manantial protegido"
  14 "   Agua de lluvia recolectada"
  15 "   Puesto de agua"	  				 
  16 "   Carro tanque/Carreta con tanque"
  17 "   Agua embotellada/en bolsa"
  20 "Fuentes no mejoradas de agua potable"
  21 "   Pozo o manantial no protegido"
  22 "   Agua de superficie u otro".
* mrsets
  /mcgroup name = $watersource
           label = 'Main source of drinking water [A]'
           variables = watersource impdrinkingWaterSource unimpdrinkingWaterSource.
  
* Ctables command in English (currently active, comment it out if using different language).
ctables
  /format missing = "na" 
  /table  total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + $watersource [c]
         + ethnicity [c]
         + windex5 [c]
   by 
          drinkingWater [c] > (
         WithoutEC_S [s] [mean '' f5.1] 
         + sufficentwater [s] [mean '' f5.1] 
         + wpremises [s] [mean '' f5.1] )
         + indSDG611 [s] [mean '' f5.1] 
         + nhhmem [s] [count '' f5.0] 
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no 
 /titles title = 
     "Table WS.1.8: Safely managed drinking water services"   
     "Percentage of household population with drinking water free from faecal contamination, available when needed, and accessible on premises, " +
     "for users of improved and unimproved drinking water sources and percentage of household members with an improved drinking water source located " +
     "on premises, free of E. coli and available when needed, " + surveyname
   caption =
     "[1] MICS indicator WS.6 - Use of safely managed drinking water services; SDG indicator 6.1.1"
     "[A] As collected in the Household Questionnaire; may be different than the source drinking water tested"
     "na: not applicable".
	 
* Ctables command in French.  
* ctables
  /format missing = "na" 
  /table  total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + $watersource [c]
         + ethnicity [c]
         + windex5 [c]
   by 
            drinkingWater [c] > (
         WithoutEC_S [s] [mean '' f5.1] 
         + sufficentwater [s] [mean '' f5.1] 
         + wpremises [s] [mean '' f5.1] )
         + indSDG611 [s] [mean '' f5.1] 
         + nhhmem [s] [count '' f5.0] 
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no 
 /titles title = 
     "Tableau WS.1.8: Services d'eau de boisson gérés en toute sécurité"   
     "Répartition en pourcentage de la population des menage ayant de l'eau de boisson dans les locaux, disponible au besoin, " + 
     "et n'ayant pas de contamination fécale, pour les utilisateurs de sources d'eau de boisson améliorées et non améliorées " + 
     "et pourcentage de membres du ménage ayant une source d'eau de boisson améliorée n'ayant pas de E. coli, et disponible en cas de besoin, " + surveyname
   caption =
     "[1] Indicateur MICS WS.6 - Utilisation de services d'eau potable gérés de manière sûre; Indicateur SDG 6.1.1"
     "[A] As collected in the Household Questionnaire; may be different than the source drinking water tested"
     "na: n'est pas applicable".
	 
* Ctables command in Spanish.  
* ctables
  /format missing = "na" 
  /table  total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + $watersource [c]
         + ethnicity [c]
         + windex5 [c]
   by 
            drinkingWater [c] > (
         WithoutEC_S [s] [mean '' f5.1] 
         + sufficentwater [s] [mean '' f5.1] 
         + wpremises [s] [mean '' f5.1] )
         + indSDG611 [s] [mean '' f5.1] 
         + nhhmem [s] [count '' f5.0] 
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no 
 /titles title = 
     "Tabla WS.1.8: Servicios de agua potable gestionados de forma segura"   
     "Distribución porcentual de la población de los hogares con agua potable en el sitio, disponible cuando se necesita y libre de contaminación fecal,  " + 
     "para los usuarios de fuentes mejoradas y no mejoradas de agua potable " + 
	 "y porcentaje de miembros del hogar con una fuente mejorada de agua potable en el sitio, libre de E. coli y disponible cuando se necesita, " + surveyname
   caption =
     "[1] MICS indicador WS.6 - Uso de servicios de agua potable gestionados de forma segura; Indicador ODS 6.1.1"
     "[A] As collected in the Household Questionnaire; may be different than the source drinking water tested"
     "na: no aplicable".

new file.
