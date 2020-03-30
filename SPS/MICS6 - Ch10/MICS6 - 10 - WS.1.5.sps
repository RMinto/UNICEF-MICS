* Encoding: windows-1252.
* MICS6 WS.1.5.

 * Household members with a water source that is available when needed (WS7=2). 

 * Households are considered to use improved sources of drinking water if WS1=11, 12, 13, 14, 21, 31, 41, 51, 61, 71, 72, 91, 92

 * Denominators are obtained by weighting the number of households by the total number of household members (HH48).

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

* include definition of drinkingWater .
include "define/MICS6 - 10 - WS.sps" .

variable labels drinkingWater "Source of drinking water".
add value labels drinkingWater 1 "Improved" 2 "Unimproved".

compute sufficentwater=0.
if WS7= 2 sufficentwater=100.
variable labels sufficentwater "Percentage of household population with drinking water available in sufficient quantities [1]".

do if (not(sysmis(WS8))).
+ compute nmemnotsufficent  = 1.
end if.

variable labels nmemnotsufficent "Number of household members unable to access water in sufficient quantities when needed".

recode WS8 (8=9) (else = copy).
add value labels WS8 9 "DK/Missing".

variable labels WS8 "Main reason that the household members are unable to access water in sufficient quantities".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute total100 = 100.
variable labels  total100 "Total".
value labels total100 100 " ".

*  For labels in French uncomment commands below.
* variable labels
    nhhmem "Nombre de membres du ménage"
   /sufficentwater "Pourcentage de ménages disposant d'eau de boisson en quantité suffisante [1]"
   /nmemnotsufficent "Nombre de membres du ménage n'ayant pas accès à l'eau en quantité suffisante en cas de besoin"
   /WS8 "Principale raison pour laquelle les membres du ménage n'ont pas accès à l'eau en quantité suffisante ".
* add value labels WS8 9 "NSP/Manquant".
* variable labels drinkingWater "Source d'eau de boisson".
* add value labels drinkingWater 1 "Améliorées" 2 "Non améliorées".

*  For labels in Spanish uncomment commands below.
* variable labels
    nhhmem "Número de miembros del hogar"
   /sufficentwater "Porcentaje de población de hogares con agua potable disponible en cantidades suficientes [1]"
   /nmemnotsufficent "Número de miembros del hogar que no pueden acceder al agua en cantidades suficientes cuando se necesita"
   /WS8 "Motivo principal por el cual los miembros del hogar no pueden acceder al agua en cantidades suficientes".
* add value labels WS8 9 "NS/Ignorado".
* variable labels drinkingWater "Fuente de agua potable".
* add value labels drinkingWater 1 "Mejorada" 2 "No mejorada".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + drinkingWater [c]
         + ethnicity [c]
         + windex5 [c]
   by
           sufficentwater [s] [mean '' f5.1]
         + nhhmem [s][sum '' f5.0]
         + WS8 [c] [rowpct.validn '' f5.1]
         + nmemnotsufficent[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=WS8 total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Table WS.1.5: Availability of sufficient drinking water when needed"
    "Percentage of household members with drinking water available when needed and percent distribution of the main reasons " +
    "household members unable to access water in sufficient quantities when needed, " + surveyname
 caption=
    "[1] MICS indicator WS.3 - Availability of drinking water".
	
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
           sufficentwater [s] [mean '' f5.1]
         + nhhmem [s][sum '' f5.0]
         + WS8 [c] [rowpct.validn '' f5.1]
         + nmemnotsufficent[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=WS8 total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.1.5: Disponibilité d'eau de boisson suffisante en cas de besoin"
    "Pourcentage de membres du ménage ayant de l'eau potable disponible en cas de besoin et pourcentage de distribution des principales raisons pour lesquelles " +
    "les membres du ménage n'ont pas accès à l'eau en quantité suffisante en cas de besoin, " + surveyname
 caption=
    "[1] Indicateur MICS WS.3 - Disponibilité de l'eau potable".

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
           sufficentwater [s] [mean '' f5.1]
         + nhhmem [s][sum '' f5.0]
         + WS8 [c] [rowpct.validn '' f5.1]
         + nmemnotsufficent[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /categories variables=WS8 total=yes position= after label= "Total"
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.1.5: Disponibilidad de suficiente agua potable cuando se necesita"
    "Porcentaje de miembros del hogar con agua potable disponible cuando se necesita y distribución porcentual de los principales motivos " +
    "por los que los miembros del hogar no pueden acceder al agua en cantidades suficientes cuando se necesita, " + surveyname
 caption=
    "[1] MICS indicador WS.3 - Disponibilidad de agua potable".	
	
new file.
