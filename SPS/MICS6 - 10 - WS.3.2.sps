* Encoding: windows-1252.

* Basic sanitation services are improved and not shared: (WS11=11, 12, 13, 18, 21, 22, 31) and (WS15=2)

* Public facility: WS16=2. 

* Number of households sharing toilet facilities is based on responses to WS11.

* Denominators are obtained by weighting the number of households by the number of household members (HH48). 

* The distribution of users of between types of improved and unimproved sanitation facilities are as shown in Table WS.3.1.
***.

include "surveyname.sps".

get file = 'hh.sav'.

select if (HH46  = 1).

compute hhweightHH48 = HH48*hhweight.
weight by hhweightHH48.

compute nhhmem = 1.
variable labels  nhhmem "Number of household members".
value labels nhhmem 1 " ".

* include definition of drinking  water and sanitation facilities.
include "define/MICS6 - 10 - WS.sps" .

do if (toiletType = 1).
+ compute shared1 = sharedToilet.
end if.
variable labels shared1 "Users of improved sanitation facilities".
value labels shared1
  0 "Not shared [1]"
  1 "Shared by: 5 households or less"
  2 "Shared by: More than 5 households"
  3 "Public facility"
  9 "DK/Missing".

do if (toiletType = 2).
+ compute shared2 = sharedToilet.
end if.
variable labels shared2 "Users of unimproved sanitation facilities".
value labels shared2
  0 "Not shared"
  1 "Shared by: 5 households or less"
  2 "Shared by: More than 5 households"
  3 "Public facility"
  9 "DK/Missing".

do if (toiletType = 3).
+ compute shared3 = 1.
end if.
variable labels  shared3 "".
value labels shared3 1 "Open defecation (no facility, bush, field)".

if WS11=95 WS14=4.
variable labels WS14 "Location of sanitation facility".
add value labels WS14  4 "Open defecation (no facility, bush, field)".

compute total = 1.
variable labels  total "Total".
value labels total 1 " ".

compute total100 = 100.
variable labels  total100 "Total".
value labels total100 100 " ".

*  For labels in French uncomment commands below.
* variable labels
      nhhmem "Nombre de membres des ménages"
	 /WS14 "Emplacement de l'installation d'assainissement"
	 /shared2 "Utilisateurs de toilettes non améliorées"
	 /shared1 "Utilisateurs de toilettes améliorées".	 
* add value labels WS14  4 "Aucune installation / Buisson / Champ".
* value labels 
      shared3 1 "Défécation à l'air libre (pas de toilettes, brousse, champ)"
	 /shared2
          0 "Non partagées"
          1 "Partagées par: 5 ménages ou moins"
          2 "Partagées par: Plus de 5 ménages"
          3 "Toilettes publiques"
          9 "NSP/Manquant"
     /shared1
          0 "Non partagées [1]"
          1 "Partagées par: 5 ménages ou moins"
          2 "Partagées par: Plus de 5 ménages"
          3 "Toilettes publiques"
          9 "NSP/Manquant".
		  
*  For labels in Spanish uncomment commands below.
* variable labels
      nhhmem "Número de miembros del hogar"
	 /WS14 "Ubicación de la instalación sanitaria"
	 /shared2 "Usuarios de instalaciones sanitarias no mejoradas"
	 /shared1 "Usuarios de instalaciones sanitarias mejoradas".	 
* add value labels WS14 4 "No hay instalación, campo abierto, matorrales".
* value labels 
      shared3 1 "Defecación al aire libre (no hay instalación, campo abierto, matorrales)"
	 /shared2
          0 "No compartidas"
          1 "Compartidas por: 5 hogares o menos"
          2 "Compartidas por: Más de 5 hogares"
          3 "Instalación pública"
          9 "NS/Ignorado"
     /shared1
          0 "No compartidas [1]"
          1 "Compartidas por: 5 hogares o menos"
          2 "Compartidas por: Más de 5 hogares"
          3 "Instalación pública"
          9 "NS/Ignorado".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /format missing = "na" 
  /vlabels variables = shared3
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + WS14 [c]
         + ethnicity [c]
         + windex5 [c]
   by
           shared1 [c] [rowpct.totaln '' f5.1]
         + shared2 [c] [rowpct.totaln '' f5.1]
         + shared3 [c] [rowpct.totaln '' f5.1]
         + total100 [s] [mean '' f5.1]
         + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Table WS.3.2: Use basic and limited sanitation services"
    "Percent distribution of household population by use of private and public sanitation facilities and use of shared facilities, "+ 
    "by users of improved and unimproved sanitation facilities, " + surveyname
   caption =
     "[1] MICS indicator WS.9 - Use of basic sanitation services; SDG indicators 1.4.1 & 6.2.1"
     "na: not applicable".

* Ctables command in French.  
* ctables
  /format missing = "na" 
  /vlabels variables = shared3
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + WS14 [c]
         + ethnicity [c]
         + windex5 [c]
   by
           shared1 [c] [rowpct.totaln '' f5.1]
         + shared2 [c] [rowpct.totaln '' f5.1]
         + shared3 [c] [rowpct.totaln '' f5.1]
         + total100 [s] [mean '' f5.1]
         + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tableau WS.3.2: Utilisation des services d'assainissement de base et limités"
    "Pourcentage de la population des ménages selon l'utilisation de toilettes publiques et privées et l'utilisation de toilettes partagées, "+ 
    "par des utilisateurs de toilettes améliorées ou non améliorées, " + surveyname
   caption =
     "[1] Indicateur MICS WS.9 - Utilisation des services d'assainissement de base; Indicateurs ODD 1.4.1 et 6.2.1"
     "na: n'est pas applicable".

* Ctables command in Spanish.  
* ctables
  /format missing = "na" 
  /vlabels variables = shared3
           display = none
  /table   total [c]
         + HH6 [c]
         + HH7 [c]
         + helevel [c]
         + WS14 [c]
         + ethnicity [c]
         + windex5 [c]
   by
           shared1 [c] [rowpct.totaln '' f5.1]
         + shared2 [c] [rowpct.totaln '' f5.1]
         + shared3 [c] [rowpct.totaln '' f5.1]
         + total100 [s] [mean '' f5.1]
         + nhhmem[s][sum '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Tabla WS.3.2: Uso de servicios sanitarios básicos y limitados "
    "Distribución porcentual de la población de los hogares por use de instalaciones sanitarias públicas y privadas  y uso compartido de las instalaciones,  "+ 
    "por usuarios de instalaciones sanitarias mejoradas y no mejoradas, " + surveyname
   caption =
     "[1] MICS indicador WS.9 - Uso de servicios básicos de saneamiento; indicadores ODS 1.4.1 & 6.2.1"
     "na: no aplicable".

new file.

