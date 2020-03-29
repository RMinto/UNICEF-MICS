
* Encoding: windows-1252.

*2018.08.29: for WS1, 72 is added to syntax as improved source. 

* Drinking water sources.
* Improved sources of drinking water WS1=11, 12, 13, 14, 21, 31, 41, 51, 61, 71, 72, 91, 92
* DK and Missing are treated as "unimproved".


do if any(WS1, 11, 12, 13, 14, 21, 31, 41, 51, 61, 71, 72,  91, 92) .
+ compute drinkingWater = 1 .
else .
+ compute drinkingWater = 2 .
end if.

variable labels drinkingWater "Main source of drinking water".
value labels drinkingWater
  1 "Improved sources"
  2 "Unimproved sources".

**********

* Sanitation facilities.
* Improved sanitation facilities are: WS11=11, 12, 13, 18, 21, 22, and 31.
* DK and Missing are treated as "unimproved".

recode WS11
  (11, 12, 13, 18, 21, 22, 31 = 1)
  (95 = 3)
  (else = 2) into toiletType.
variable labels  toiletType "Type of sanitation facility".
value labels toiletType
    1 "Improved"
    2 "Unimproved"
    3 "Open defecation (no facility, bush, field)" .


compute flush=$sysmis.
recode WS11
  (11, 12, 13, 14, 18= 1) into flush.
variable labels  flush "".
value labels flush 1 "Flush/Pour flush to:".

* Shared facilities.
recode WS17
  (1 thru 5 = 1)
  (97, 98, 99 = 9)
  (sysmis = 0)
  (else = 2) into sharedToilet.

if (WS16 = 2) sharedToilet = 3.

variable labels sharedToilet " ".
value labels sharedToilet
  0 "Not shared"
  1 "5 households or less"
  2 "More than 5 households"
  3 "Public facility"
  9 "DK/Missing".

* French labels.
 * variable labels drinkingWater "Source principale d'eau de boisson".
 * value labels drinkingWater
  1 "Sources améliorées"
  2 "Sources non améliorées".

 * variable labels  toiletType "Type d'installation d'assainissement".
 * value labels toiletType
    1 "Améliorées"
    2 "TNon améliorées"
    3 "Défécation (Pas de toilette, brousse, champ)" .


