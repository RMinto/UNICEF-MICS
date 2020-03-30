* Encoding: windows-1252.
 * Drinking water is considered appropriately treated if one the following methods of treatment is used: boiling; adding bleach or chlorine; using a water filter; or using solar disinfection (WS10=A, B, D, E).

 * Note that responses may total to more than 100 percent since households may be using more than one treatment method.

 * Denominators are obtained by weighting the number of households by the number of household members (HH48).

 * Households are considered to use improved sources of drinking water if WS1=11, 12, 13, 14, 21, 31, 41, 51, 61, 71, 72, 91, 92

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

compute treat = 1.
value labels treat 1  "Water treatment method used in the household".
variable labels  treat " ".

compute none = 0.
if (WS9 <> 1) none = 100.
variable labels  none "None".

compute boil = 0.
if (WS10A = "A") boil = 100.
variable labels  boil "Boil".

compute bleach = 0.
if (WS10B = "B") bleach = 100.
variable labels  bleach "Add bleach / chlorine".

compute cloth = 0.
if (WS10C = "C") cloth = 100.
variable labels  cloth "Strain through a cloth".

compute waterFilter = 0.
if (WS10D = "D") waterFilter = 100.
variable labels  waterFilter "Use water filter".

compute solar = 0.
if (WS10E = "E") solar = 100.
variable labels  solar "Solar disinfection".

compute stand = 0.
if (WS10F = "F") stand = 100.
variable labels  stand "Let it stand and settle".

compute other = 0.
if (WS10X = "X") other = 100.
variable labels  other "Other".

compute dkmissing = 0.
if (WS10Z = "Z" or WS10NR = "?") dkmissing = 100.
variable labels  dkmissing "DK/Missing".

include "define/MICS6 - 10 - WS.sps" .

variable labels drinkingWater "Source of drinking water".
add value labels drinkingWater 1 "Improved" 2 "Unimproved".

compute appropriate = 0.
* Appropriately treated if method is: 
* boiling; adding bleach or chlorine; using a water filter; or using solar disinfection (WS10=A, B, D, E).
if (boil = 100 or bleach = 100 or waterFilter = 100 or solar = 100) appropriate = 100.

variable labels appropriate "Percentage of household members in households using an appropriate water treatment method".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

*  For labels in French uncomment commands below.
* variable labels 
     nhhmem "Nombre de membres des ménages"
	/none "Aucune"
	/boil "La faire bouillir"
	/bleach "Y ajouter de l'eau de javel/ chlore"
	/cloth "La filtrer à travers un linge"
	/waterFilter "Utiliser un filtre à eau"
	/solar "Désinfection solaire"
	/stand "Laisser reposer"
	/other "Autre"
	/dkmissing "NSP/Manquant"
	/drinkingWater "Source d'eau de boisson"
	/appropriate "Pourcentage de membres des ménages dans les ménages utilisant une méthode appropriée de traitement de l'eau".
* value labels treat 1  "Méthode de traitement de l'eau dans le ménage".
* add value labels drinkingWater 1 "Améliorée" 2 "Non améliorée".


*  For labels in Spanish uncomment commands below.
* variable labels 
     nhhmem "Número de miembros del hogar"
	/none "Ninguno"
	/boil "Hervir"
	/bleach "Agregar blanqueador/ cloro"
	/cloth "Filtrar con una tela"
	/waterFilter "Usar filtro de agua"
	/solar "Desinfección solar"
	/stand "Dejar asentar"
	/other "Otro"
	/dkmissing "NS/Ignorado"
	/drinkingWater "Fuente de agua potable
	/appropriate "Porcentaje de miembros del hogar en hogares que usan un método apropiado de tratamiento de agua".
* value labels treat 1  "Método de tratamiento del agua usado en el hogar".
* add value labels drinkingWater 1 "Mejorada" 2 "No mejorada".


* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = treat display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
           treat [c] > (
             none[s][mean '' f5.1]
           + boil[s][mean '' f5.1]
           + bleach[s][mean '' f5.1]
           + cloth[s][mean '' f5.1]
           + waterFilter[s][mean '' f5.1]
           + solar[s][mean '' f5.1]
           + stand[s][mean '' f5.1]
           + other[s][mean '' f5.1]
           + dkmissing[s][mean '' f5.1] )
         + appropriate[s][mean '' f5.1]
         + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title = 
    "Table WS.1.9: Household water treatment"
    "Percentage of household population by drinking water treatment method used in the household and the percentage who are using an appropriate treatment method, " + surveyname 
.

* Ctables command in French.  
* ctables
  /vlabels variables = treat display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
           treat [c] > (
             none[s][mean '' f5.1]
           + boil[s][mean '' f5.1]
           + bleach[s][mean '' f5.1]
           + cloth[s][mean '' f5.1]
           + waterFilter[s][mean '' f5.1]
           + solar[s][mean '' f5.1]
           + stand[s][mean '' f5.1]
           + other[s][mean '' f5.1]
           + dkmissing[s][mean '' f5.1] )
         + appropriate[s][mean '' f5.1]
         + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title = 
    "Tableau WS.1.9: Traitement de l'eau par les ménages"
    "Pourcentage de la population des ménages selon la méthode de traitement de l'eau de boisson utilisée dans le ménage et pourcentage de ceux uutilisant une méthode de traitement appropriée, " + surveyname 
.

* Ctables command in Spanish.  
* ctables
  /vlabels variables = treat display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
           treat [c] > (
             none[s][mean '' f5.1]
           + boil[s][mean '' f5.1]
           + bleach[s][mean '' f5.1]
           + cloth[s][mean '' f5.1]
           + waterFilter[s][mean '' f5.1]
           + solar[s][mean '' f5.1]
           + stand[s][mean '' f5.1]
           + other[s][mean '' f5.1]
           + dkmissing[s][mean '' f5.1] )
         + appropriate[s][mean '' f5.1]
         + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title = 
    "Tabla WS.1.9: Tratamiento del agua en el hogar "
    "Porcentaje de la población de hogares por método de tratamiento del agua para beber usado por el hogar y el porcentaje que está usando un método apropiado de tratamiento, " + surveyname 
.
                            
new file.
