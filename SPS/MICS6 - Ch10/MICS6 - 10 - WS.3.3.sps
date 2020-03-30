* Encoding: windows-1252.
 * Type of onsite sanitation facility: Septic (WS11 = 12), Latrines and other improved (WS11 = 13, 21, 22, 31) 

 * Type of emptying from WS13, if WS12=(1, 2, 3)
Never emptied from WS12=4
Don't know if ever emptied from WS12=8

 * Safely disposed in situ = sum of columns D, H, I, L, P, Q
Unsafely discharged = sum of columns E, F, N, O
Removed for treatment = sum of columns B, C, G, K, L, P

 * Denominators are obtained by weighting by the number of household members living in households where the main 
type of sanitation facility is a flush to septic tank or pit latrine (WS11=12 or 13) or pit latrine (WS11=21, 22) or composting toilet (WS11=31). 

***.

include "surveyname.sps".

get file = 'hh.sav'.

recode WS11 (12 = 1) (13, 21, 22, 31 = 2) (else=0) into onsite. 
variable labels onsite "Type of onsite sanitation facility".

select if (HH46  = 1).

select if (onsite <> 0 ).

compute hhweightHH48 = HH48*hhweight.
weight by hhweightHH48.

compute nhhmem = 1.
variable labels  nhhmem "Number of household members in households with improved on-site sanitation facilities".
value labels nhhmem 1 " ".

* include definition of drinking  water and sanitation facilities.
include "define/MICS6 - 10 - WS.sps" .

*Septic tank.

compute septicemptiedproviderplant=0.
if  (onsite=1 and WS13 = 1) septicemptiedproviderplant=100.
variable lables septicemptiedproviderplant "Removed by a service provider to treatment".

compute septicemptiedproviderDK=0.
if  (onsite=1 and WS13 = 3) septicemptiedproviderDK=100.
variable lables septicemptiedproviderDK "Removed by a service provider to DK".

compute septicemptiedpit=0.
if  (onsite=1 and (WS13 = 2 or WS13 = 4)) septicemptiedpit=100.
variable lables septicemptiedpit "Buried in a covered pit".

compute septicemptiedHHpit=0.
if  (onsite=1 and WS13 = 5) septicemptiedHHpit=100.
variable lables septicemptiedHHpit "To uncovered pit, open ground, water body or elsewhere".

compute septicemptiedother=0.
if  (onsite=1 and WS13 = 6) septicemptiedother=100.
variable lables septicemptiedother "Other".

compute septicemptiedDK=0.
if  (onsite=1 and WS13 = 8) septicemptiedDK=100.
variable lables septicemptiedDK "DK where wastes were taken".

compute septicneveremptied=0.
if  (onsite=1 and WS12 = 4) septicneveremptied=100.
variable lables septicneveremptied "Never emptied".

compute septicDKemptied=0.
if  (onsite=1  and WS12 >= 8) septicDKemptied=100.
variable lables septicDKemptied "DK if ever emptied/Missing".

* other improved on-site sanitation facilities.

compute Oonsiteemptiedproviderplant=0.
if  (onsite=2 and WS13 = 1) Oonsiteemptiedproviderplant=100.
variable lables Oonsiteemptiedproviderplant "Removed by a service provider to treatment".

compute OonsiteemptiedproviderDK=0.
if  (onsite=2 and WS13 = 3) OonsiteemptiedproviderDK=100.
variable lables OonsiteemptiedproviderDK "Removed by a service provider to DK".

compute Oonsiteemptiedpit=0.
if  (onsite=2 and (WS13 = 2 or WS13 = 4)) Oonsiteemptiedpit=100.
variable lables Oonsiteemptiedpit "Buried in a covered pit".

compute OonsiteemptiedHHpit=0.
if  (onsite=2 and WS13 = 5) OonsiteemptiedHHpit=100.
variable lables OonsiteemptiedHHpit "To uncovered pit, open ground, water body or elsewhere".

compute Oonsiteemptiedother=0.
if  (onsite=2 and WS13 = 6) Oonsiteemptiedother=100.
variable lables Oonsiteemptiedother "Other".

compute OonsiteemptiedDK=0.
if  (onsite=2 and WS13 = 8) OonsiteemptiedDK=100.
variable lables OonsiteemptiedDK "DK where wastes were taken".

compute Oonsiteneveremptied=0.
if  (onsite=2 and WS12 = 4) Oonsiteneveremptied=100.
variable lables Oonsiteneveremptied "Never emptied".

compute OonsiteDKemptied=0.
if  (onsite=2  and WS12 >= 8) OonsiteDKemptied=100.
variable lables OonsiteDKemptied "DK if ever emptied/Missing".

compute safedisposal=0.
if (septicemptiedpit=100 or septicneveremptied=100 or septicDKemptied=100 or Oonsiteemptiedpit=100 or Oonsiteneveremptied=100 or OonsiteDKemptied=100) safedisposal=100.
variable labels safedisposal "Safe disposal in situ of excreta from on-site sanitation facilities [1]".

compute unsafedisposal=0.
if (septicemptiedHHpit=100 or septicemptiedother=100 or OonsiteemptiedHHpit=100 or Oonsiteemptiedother=100) unsafedisposal=100.
variable labels unsafedisposal "Unsafe disposal of excreta from on-site sanitation facilities".

compute treatment=0.
if (septicemptiedproviderplant=100 or septicemptiedproviderDK=100 or septicemptiedDK=100 or Oonsiteemptiedproviderplant=100 or OonsiteemptiedproviderDK=100 or OonsiteemptiedDK=100) treatment=100.
variable labels treatment "Removal of excreta for treatment from on-site sanitation facilities".

compute layer1 = 0.
variable labels layer1 " ".
value labels layer1 0 "Emptying and disposal of wastes from septic tanks".

compute layer2 = 0.
variable labels layer2 " ".
value labels layer2 0 "Emptying and disposal of wastes from other improved on-site sanitation facilities".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute total100 = 100.
variable labels  total100 "Total".
value labels total100 100 " ".

recode WS11 (12 = sysmis)(else = copy) into WS11c.
variable labels WS11c "Type of sanitation facility".

value labels onsite 
1 "Flush to septic tank" 
2 "Latrines and other improved"
13 "  Flush to pit latrine"
21 "  Ventilated Improved Pit Latrine (VIP)"
22 "  Pit latrine with slab"
31 "  Composting toilet"
.

* Define Multiple Response Sets.
mrsets
  /mcgroup name = $WS11recode
           label = 'Type of sanitation facility'
           variables = onsite WS11c.

*  For labels in French uncomment commands below.
* variable labels
      onsite "Type d'installation d'assainissement sur place"
	 /septicemptiedproviderplant "Retiré par un fournisseur de services "
	 /septicemptiedproviderDK "Retiré par un fournisseur de services pour une destination inconnue"
	 /septicemptiedpit "Enterré dans une fosse couverte"
	 /septicemptiedHHpit "À fosse non découverte, terrain découvert, plan d'eau ou ailleurs"
	 /septicemptiedother "Autre"
	 /septicemptiedDK "NSP où les déchets ont été enlevés"
	 /septicneveremptied "Jamais vidé"
	 /septicDKemptied "NSP si jamais vidé/Manquant"
	 /Oonsiteemptiedproviderplant "Retiré par un fournisseur de services "
	 /OonsiteemptiedproviderDK "Retiré par un fournisseur de services pour une destination inconnue"
	 /Oonsiteemptiedpit "Enterré dans une fosse couverte"
	 /OonsiteemptiedHHpit "À fosse non découverte, terrain découvert, plan d'eau ou ailleurs"
	 /Oonsiteemptiedother "Autre"
	 /OonsiteemptiedDK "NSP où les déchets ont été enlevés"
	 /Oonsiteneveremptied "Jamais vidé"
	 /OonsiteDKemptied "NSP si jamais vidé/Manquant"
	 /safedisposal "Élimination sûre des excréments des installations d'assainissement sur place [1]"
	 /unsafedisposal "Élimination dangereuse des excréments des installations d'assainissement sur place"
	 /treatment "Élimination des excréments pour traitement dans les installations d'assainissement sur place"
	 /nhhmem "Nombre de ménages dont les membres ont des installations d'assainissement améliorées sur place"
                   /WS11 "Type d'installation d'assainissement".	 
* value labels 
      onsite 1 "Reliée à la fosse septique" 2 "Latrines et autres améliorés"
	 /layer1 0 "Vidange des fosses septiques"
	 /layer2 0 "Vidange des autres installations sanitaires améliorées sur place"
.

*  For labels in Spanish uncomment commands below.
* variable labels
      onsite "Tipo de instalación sanitaria en el sitio"
	 /toiletType "Tipo de instalación sanitaria"
	 /septicemptiedproviderplant "Eliminado por un proveedor de servicios para tratamiento "
	 /septicemptiedproviderDK "Eliminado por un proveedor de servicios para NS"
	 /septicemptiedpit "Enterrado en un pozo cubierto"
	 /septicemptiedHHpit "A un pozo descubierto, campo abierto, cuerpo de agua o en otro lugar"
	 /septicemptiedother "Otro"
	 /septicemptiedDK "NS dónde se tomaron los desechos"
	 /septicneveremptied "Nunca vaciado"
	 /septicDKemptied "NS si alguna vez fue vaciado/Ignorado"
	 /Oonsiteemptiedproviderplant "Eliminado por un proveedor de servicios para tratamiento "
	 /OonsiteemptiedproviderDK "Eliminado por un proveedor de servicios para NS"
	 /Oonsiteemptiedpit "Enterrado en un pozo cubierto"
	 /OonsiteemptiedHHpit "A un pozo descubierto, campo abierto, cuerpo de agua o en otro lugar"
	 /Oonsiteemptiedother "Otro"
	 /OonsiteemptiedDK "NS dónde se tomaron los desechos"
	 /Oonsiteneveremptied "Nunca vaciado"
	 /OonsiteDKemptied "NS si alguna vez fue vaciado/Ignorado"
	 /safedisposal "Eliminación segura in situ de excretas de instalaciones de saneamiento en el sitio [1]"
	 /unsafedisposal "Eliminación no segura de excretas de instalaciones de saneamiento en el sitio"
	 /treatment "Remoción de excretas para tratamiento de instalaciones de saneamiento en el sitio "
	 /nhhmem "Número de miembros del hogar en hogares con instalaciones mejoradas de saneamiento en el sitio"
                   /WS11 "Type d'installation d'assainissement".	 
* value labels 
      onsite 1 "Descarga a tanque séptico" 2 "Letrinas y otros mejorados"
	 /layer1 0 "Vaciado de fosas sépticas"
	 /layer2 0 "Vaciado de otras instalaciones mejoradas de saneamiento en el sitio"
.
	 
* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = layer1 layer2 total100
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + $WS11recode [c]
         + ethnicity [c]
         + windex5 [c]
   by
           layer1 [c] > (septicemptiedproviderplant [s] [mean '' f5.1] + septicemptiedproviderDK [s] [mean '' f5.1] + septicemptiedpit [s] [mean '' f5.1] + septicemptiedHHpit [s] [mean '' f5.1]
          + septicemptiedother [s] [mean '' f5.1] + septicemptiedDK [s] [mean '' f5.1] + septicneveremptied [s] [mean '' f5.1] + septicDKemptied [s] [mean '' f5.1])
          +  layer2 [c] > (Oonsiteemptiedproviderplant [s] [mean '' f5.1] + OonsiteemptiedproviderDK [s] [mean '' f5.1] + Oonsiteemptiedpit [s] [mean '' f5.1] + OonsiteemptiedHHpit [s] [mean '' f5.1]
          + Oonsiteemptiedother [s] [mean '' f5.1] + OonsiteemptiedDK [s] [mean '' f5.1] + Oonsiteneveremptied [s] [mean '' f5.1] + OonsiteDKemptied [s] [mean '' f5.1] )
          + total100 [s] [mean '' f5.1]
          + safedisposal [s] [mean '' f5.1] + unsafedisposal [s] [mean '' f5.1] + treatment [s] [mean '' f5.1] 
          + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Table WS.3.3: Emptying and removal of excreta from on-site sanitation facilities"
    "Percent distribution of household members in households with septic tanks and improved latrines by method of emptying and removal, " + surveyname
   caption =
     "[1] MICS indicator WS.10 - Safe disposal in situ of excreta from on-site sanitation facilities; SDG indicator 6.2.1"
     "na: not applicable".
     .


new file.

