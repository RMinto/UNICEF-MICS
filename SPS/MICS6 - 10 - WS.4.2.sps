* Encoding: windows-1252.

 * Women who did not participate in social activities, school or work due to their last menstruation in the last 12 months: UN16=1

 * Women age 15-49 who reported menstruating in the last 12 months: UN15=1

***.

* Call include file for the working directory and the survey name.
include "surveyname.sps".

* Open women dataset.
get file = 'wm.sav'.

include "CommonVarsWM.sps".

* Select completed interviews.
select if (WM17 = 1).
* Select women mensurated in last years.
select if (not(sysmis(UN16))).

* Weight the data by the women weight.
weight by wmweight.

* Generate numWomen variable.
compute numWomen = 1.
variable labels numWomen "".
value labels numWomen 1 "Number of women who reported menstruating in the last 12 months".

compute noparticipation=0.
if UN16=1  noparticipation=100.
variable labels noparticipation "Percentage of women who did not participate in social activities, school or work due to their last menstruation in the last 12 months [1]".

compute total = 1.
variable labels total "".
value labels total 1 "Total".

*  For labels in French uncomment commands below.
* variable labels noparticipation "Pourcentage de femmes qui n'ont pas participé à des activités sociales, à l'école ou au travail en raison de leurs dernières règles au cours des 12 derniers mois [1]".
* value labels numWomen 1 "Nombre de femmes âgées de 15 à 49 ans qui ont déclaré avoir eu leurs règles au cours des 12 derniers mois".

*  For labels in Spanish uncomment commands below.
* variable labels noparticipation "Porcentaje de mujeres que no participaron en actividades sociales, escolares o laborales debido a su última menstruación en los últimos 12 meses [1]".
* value labels numWomen 1 "Número de mujeres de 15 a 49 años de edad que informaron haber menstruado en los últimos 12 meses".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables =  numWomen total
         display = none
  /table   total [c]
        + HH6 [c]
        + HH7 [c]
        + wageu [c]
        + welevel [c]
        + disability [c]
        + ethnicity [c]
        + windex5 [c]
      by
           noparticipation [s] [mean '' f5.1]
           + numWomen[c][count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
     "Table WS.4.2: Exclusion from activities during menstruation"
     "Percentage of women age 15-49 years who did not participate in social activities, school, or work due to their last mensturation in the last 12 months, "
     + surveyname
   caption =
        "[1] MICS indicator WS.13 - Exclusion from activities during menstruation".									

* Ctables command in French.  
* ctables
  /vlabels variables =  numWomen total
         display = none
  /table   total [c]
        + HH6 [c]
        + HH7 [c]
        + wageu [c]
        + welevel [c]
        + disability [c]
        + ethnicity [c]
        + windex5 [c]
      by
           noparticipation [s] [mean '' f5.1]
           + numWomen[c][count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
     "Tableau WS.4.2: Exclusion des activités pendant la menstruation"
     "Pourcentage de femmes qui n'ont pas participé à des activités sociales, à l'école ou au travail en raison de leur dernière mensturation au cours des 12 derniers mois, "
     + surveyname
   caption =
        "[1] Indicateur MICS WS.13 - Exclusion des activités pendant la menstruation".									


* Ctables command in Spanish.  
* ctables
  /vlabels variables =  numWomen total
         display = none
  /table   total [c]
        + HH6 [c]
        + HH7 [c]
        + wageu [c]
        + welevel [c]
        + disability [c]
        + ethnicity [c]
        + windex5 [c]
      by
           noparticipation [s] [mean '' f5.1]
           + numWomen[c][count '' f5.0]
  /categories variables=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
     "Tabla WS.4.2: Exclusión de actividades durante la menstruación"
     "Porcentaje de mujeres que no participaron en actividades sociales, escuela o trabajo debido a su última menstruación en los últimos 12 meses, "
     + surveyname
   caption =
        "[1] MICS indicador WS.13 - Exclusión de actividades durante la menstruación".
							
new file.
