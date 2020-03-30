* Encoding: windows-1252.
 * Column B (safely disposed of in situ) comes from Table 3.3, summing columns ( D, H, I, L, P, Q), multiplied by the proportion of the population using on-site improved sanitation facilities

 * Column C (unsafely discharged) comes from Table 3.3, summing columns ( E, F, M, N), multiplied by the proportion of the population using on-site improved sanitation facilities

 * Column D (removal of wastes for treatment) comes from Table 3.3, summing columns ( B, C, G, J, K, O ), multiplied by the proportion of the population using on-site improved sanitation facilities

 * Column E (connected to sewer) comes from WS11 = 11

 * Column F (unimproved sanitation) comes from WS11 = 14,23,41,51,96

 * Column G (open defecation) comes from WS11 = 95

***.

* v02 - 2019-08-28. Last modified to reflect tab plan changes as of 25 July 2019.

include "surveyname.sps".

get file = 'hh.sav'.

include "CommonVarsHH.sps".
select if (HH46  = 1).

recode WS11 (12 = 1) (13, 21, 22, 31 = 2) (else=3) into onsite. 
variable labels onsite "Type of onsite sanitation facility".
value labels onsite 1 "Flush to septic tank" 2 "Latrines and other improved" 3 "Unimproved or not onsite".

compute hhweightHH48 = HH48*hhweight.
weight by hhweightHH48.

compute nhhmem = 1.
variable labels  nhhmem "Number of household members".
value labels nhhmem 1 " ".

* include definition of drinking  water and sanitation facilities.
include "define/MICS6 - 10 - WS.sps" .

*Septic tank.

compute septicemptiedproviderplant=0.
if  (onsite=1 and WS13 = 1) septicemptiedproviderplant=100.
variable labels septicemptiedproviderplant "Removed by a service provider to treatment".

compute septicemptiedproviderDK=0.
if  (onsite=1 and WS13 = 3) septicemptiedproviderDK=100.
variable labels septicemptiedproviderDK "Removed by a service provider to DK".

compute septicemptiedpit=0.
if  (onsite=1 and (WS13 = 2 or WS13 = 4)) septicemptiedpit=100.
variable labels septicemptiedpit "Buried in a covered pit".

compute septicemptiedHHpit=0.
if  (onsite=1 and WS13 = 5) septicemptiedHHpit=100.
variable labels septicemptiedHHpit "To uncovered pit, open ground, water body or elsewhere".

compute septicemptiedother=0.
if  (onsite=1 and WS13 = 6) septicemptiedother=100.
variable labels septicemptiedother "Other".

compute septicemptiedDK=0.
if  (onsite=1 and WS13 = 8) septicemptiedDK=100.
variable labels septicemptiedDK "DK where wastes were taken".

compute septicneveremptied=0.
if  (onsite=1 and WS12 = 4) septicneveremptied=100.
variable labels septicneveremptied "Never emptied".

compute septicDKemptied=0.
if  (onsite=1  and WS12 >= 8) septicDKemptied=100.
variable labels septicDKemptied "DK if ever emptied/Missing".

* other improved on-site sanitation facilities.

compute Oonsiteemptiedproviderplant=0.
if  (onsite=2 and WS13 = 1) Oonsiteemptiedproviderplant=100.
variable labels Oonsiteemptiedproviderplant "Removed by a service provider to treatment".

compute OonsiteemptiedproviderDK=0.
if  (onsite=2 and WS13 = 3) OonsiteemptiedproviderDK=100.
variable labels OonsiteemptiedproviderDK "Removed by a service provider to DK".

compute Oonsiteemptiedpit=0.
if  (onsite=2 and (WS13 = 2 or WS13 = 4)) Oonsiteemptiedpit=100.
variable labels Oonsiteemptiedpit "Buried in a covered pit".

compute OonsiteemptiedHHpit=0.
if  (onsite=2 and WS13 = 5) OonsiteemptiedHHpit=100.
variable labels OonsiteemptiedHHpit "To uncovered pit, open ground, water body or elsewhere".

compute Oonsiteemptiedother=0.
if  (onsite=2 and WS13 = 6) Oonsiteemptiedother=100.
variable labels Oonsiteemptiedother "Other".

compute OonsiteemptiedDK=0.
if  (onsite=2 and WS13 = 8) OonsiteemptiedDK=100.
variable labels OonsiteemptiedDK "DK where wastes were taken".

compute Oonsiteneveremptied=0.
if  (onsite=2 and WS12 = 4) Oonsiteneveremptied=100.
variable labels Oonsiteneveremptied "Never emptied".

compute OonsiteDKemptied=0.
if  (onsite=2  and WS12 >= 8) OonsiteDKemptied=100.
variable labels OonsiteDKemptied "DK if ever emptied/Missing".

compute safedisposal=0.
if (septicemptiedpit=100 or septicneveremptied=100 or septicDKemptied=100 or Oonsiteemptiedpit=100 or Oonsiteneveremptied=100 or OonsiteDKemptied=100) safedisposal=100.
variable labels safedisposal "Safe disposal in situ of excreta from on-site sanitation facilities".

compute unsafedisposal=0.
if (septicemptiedHHpit=100 or septicemptiedother=100 or OonsiteemptiedHHpit=100 or Oonsiteemptiedother=100) unsafedisposal=100.
variable labels unsafedisposal "Unsafe disposal of excreta from on-site sanitation facilities".

compute treatment=0.
if (septicemptiedproviderplant=100 or septicemptiedproviderDK=100 or septicemptiedDK=100 or Oonsiteemptiedproviderplant=100 or OonsiteemptiedproviderDK=100 or OonsiteemptiedDK=100) treatment=100.
variable labels treatment "Removal of excreta for treatment off-site [1]".

compute connectedsewer=0.
if WS11=11 or WS11=18 connectedsewer=100.
variable labels connectedsewer "Connected to sewer".

recode WS11 (14,23,41,51,96=100) (else =0) into usingimproved.
variable labels usingimproved "Using unimproved sanitation facilities".

compute opendefecation=0.
if WS11=95 opendefecation=100.
variable labels opendefecation "Practising open defecation".

compute missingx=0.
if WS11 > 97 missingx=100.
variable labels missingx "Missing".

compute layer1 = 0.
variable labels layer1 " ".
value labels layer1 0 "Using improved on-site sanitation systems (including shared)".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute total100 = 100.
variable labels  total100 "Total".
value labels total100 100 " ".

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
	 /safedisposal "Safe disposal in situ of excreta from on-site sanitation facilities"
	 /unsafedisposal "Élimination dangereuse des excréments des installations d'assainissement sur place"
	 /treatment "Removal of excreta for treatment off-site [1]"
	 /connectedsewer " Connecté à l'égout"
	 /usingimproved "Utilisation d'installations sanitaires non améliorées"
	 /opendefecation "Pratique de la défécation à l'air libre"
	 /missingx "Manquant"
	 /nhhmem "Nombre de membres du ménage".
* value labels 
      onsite 1 "Reliée à la fosse septique" 2 "Latrines et autres améliorés"
	 /layer1 0 "Utilisation de systèmes d'assainissement améliorés sur place (y compris les systèmes partagés)".

*  For labels in Spanish uncomment commands below.
* variable labels
      onsite "Tipo de instalación sanitaria en el sitio"
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
	 /safedisposal "Safe disposal in situ of excreta from on-site sanitation facilities"
	 /unsafedisposal "Eliminación no segura de excretas de instalaciones de saneamiento en el sitio"
	 /treatment "Removal of excreta for treatment off-site [1]"
	 /connectedsewer " Conectado al alcantarillado"
	 /usingimproved "Uso de instalaciones sanitarias no mejoradas"
	 /opendefecation "No hay instalación, campo abierto, matorrales"
	 /missingx "Ignorado"
	 /nhhmem "Número de miembros del hogar".
* value labels 
      onsite 1 "Descarga a tanque séptico" 2 "Letrinas y otros mejorados"
	 /layer1 0 "Uso de sistemas de saneamiento mejorados en el sitio (incluidos los compartidos)".	 

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
           layer1 [c] > (safedisposal [s] [mean '' f5.1] + unsafedisposal [s] [mean '' f5.1] + treatment [s] [mean '' f5.1])
          + connectedsewer [s] [mean '' f5.1] + usingimproved [s] [mean '' f5.1] + opendefecation [s] [mean '' f5.1] + missingx [s] [mean '' f5.1] + Total100 [s] [mean '' f5.1]
          + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Table WS.3.4: Management of excreta from household sanitation facilities"
    "Percent distribution of household population by management of excreta from household sanitation facilities, " + surveyname
   caption =
     "[1] MICS indicator WS.11 - Removal of excreta for treatment off-site; SDG indicator 6.2.1"
     .

* Ctables command in French.  
* ctables
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
           layer1 [c] > (safedisposal [s] [mean '' f5.1] + unsafedisposal [s] [mean '' f5.1] + treatment [s] [mean '' f5.1])
          + connectedsewer [s] [mean '' f5.1] + usingimproved [s] [mean '' f5.1] + opendefecation [s] [mean '' f5.1] + missingx [s] [mean '' f5.1] + Total100 [s] [mean '' f5.1]
          + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.3.4: Gestion des excreta provenant des installations d'assainissement ménager"
    "Répartition en pourcentage de la population des ménages selon la gestion des excréments provenant des installations d'assainissement ménager, " + surveyname
   caption =
     "[1] Indicateur MICS WS.11 - Enlèvement des excréta pour traitement hors site; Indicateur ODD 6.2.1"
     .

* Ctables command in Spanish.  
* ctables
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
           layer1 [c] > (safedisposal [s] [mean '' f5.1] + unsafedisposal [s] [mean '' f5.1] + treatment [s] [mean '' f5.1])
          + connectedsewer [s] [mean '' f5.1] + usingimproved [s] [mean '' f5.1] + opendefecation [s] [mean '' f5.1] + missingx [s] [mean '' f5.1] + Total100 [s] [mean '' f5.1]
          + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.3.4: Manejo de excretas de las instalaciones sanitarias del hogar"
    "Distribución porcentual de la población de los hogares por manejo de excretas de las instalaciones sanitarias del hogar, " + surveyname
   caption =
     "[1] MICS indicador WS.11 - Eliminación de excretas para tratamiento fuera del sitio; indicador ODS 6.2.1"
     .

new file.

