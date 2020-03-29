DATA LIST FILE='C:\MICS6TUN\SPSS\MYHL.DAT' RECORDS=1
 /
 HH1         1-3   
 HH2         4-5   
 HL1         6-7   
 HL2         8-87   (A)
 HL3        88-89  
 HL4        90-90  
 HL5M       91-92  
 HL5Y       93-96  
 HL6        97-98  
 HL8        99-100 
 HL9       101-102 
 HL10      103-104 
 HL11      105-105 
 HL12      106-106 
 HL13      107-107 
 HL14      108-109 
 HL15      110-110 
 HL16      111-111 
 HL17      112-112 
 HL18      113-114 
 HL19      115-115 
 HL20      116-117 
 HL33      118-118 
 HL39      119-119 
 ED1       120-121 
 ED2       122-281  (A)
 ED2A      282-283 
 ED3       284-284 
 ED4       285-285 
 ED5A      286-286 
 ED5B      287-288 
 ED6       289-289 
 ED7       290-290 
 ED8       291-291 
 ED9       292-292 
 ED10A     293-294 
 ED10B     295-296 
 ED11      297-297 
 ED12      298-298 
 ED13A     299-302  (A)
 ED13C     303-306  (A)
 ED13D     307-310  (A)
 ED13X     311-314  (A)
 ED13Z     315-318  (A)
 ED13NR    319-322  (A)
 ED14      323-323 
 ED15      324-324 
 ED16A     325-326 
 ED16B     327-328 
 HH4       329-331 
 HH5D      332-333 
 HH5M      334-335 
 HH5Y      336-339 
 HH6       340-340 
 HH7       341-341 
 MLINE     342-343 
 FLINE     344-345 
.
VARIABLE LABELS
  HH1      "Cluster number"
 /HH2      "Household number"
 /HL1      "Line number"
 /HL2      "Name"
 /HL3      "Relationship to the head"
 /HL4      "Sex"
 /HL5M     "Month of birth"
 /HL5Y     "Year of birth"
 /HL6      "Age"
 /HL8      "Line number of woman age 15 - 49"
 /HL9      "Line number of man age 15 - 49"
 /HL10     "Line number for children age 0-4"
 /HL11     "Member age 0-17"
 /HL12     "Is natural mother alive"
 /HL13     "Does natural mother live in HH"
 /HL14     "Natural mother's line number in HH"
 /HL15     "Where does natural mother live"
 /HL16     "Is natural father alive"
 /HL17     "Does natural father live in HH"
 /HL18     "Natural father's line number in HH"
 /HL19     "Where does natural father live"
 /HL20     "Line number of morhter or primary caretaker for children 0-17 years of age"
 /HL33     "Consent for interview girls 15-17"
 /HL39     "Consent for interview boys 15-17"
 /ED1      "Line number"
 /ED2      "Name"
 /ED2A     "Age"
 /ED3      "Age above 3"
 /ED4      "Ever attended school or any Early Childhood Education programme"
 /ED5A     "Highest level of education attended"
 /ED5B     "Highest grade attended at that level"
 /ED6      "Highest grade completed at that level"
 /ED7      "Age 3-24"
 /ED8      "Check: Ever attended school or any Early Childhood Education programme"
 /ED9      "Attended school during current school year"
 /ED10A    "Level of education attended current school year"
 /ED10B    "Grade of education attended current school year"
 /ED11     "Attended public school current school year"
 /ED12     "School tuition in the current school year"
 /ED13A    "Tuition provided: Govt./public"
 /ED13C    "Tuition provided: Religious / faith org."
 /ED13D    "Tuition provided: Private"
 /ED13X    "Tuition provided: Other"
 /ED13Z    "Tuition provided: Other"
 /ED13NR   "Tuition provided: DK"
 /ED14     "Material support in the current school year"
 /ED15     "Attended school previous school year"
 /ED16A    "Level of education attended previous school year"
 /ED16B    "Grade of education attended previous school year"
 /HH4      "Supervisor number"
 /HH5D     "Day of interview"
 /HH5M     "Month of interview"
 /HH5Y     "Year of interview"
 /HH6      "Area"
 /HH7      "Region"
 /MLINE    "Mother's line number"
 /FLINE    "Father's line number"
.
VALUE LABELS
  HL3     
     1 "HEAD"
     2 "SPOUSE / PARTNER"
     3 "SON / DAUGHTER"
     4 "SON-IN-LAW / DAUGHTER-IN-LAW"
     5 "GRANDCHILD"
     6 "PARENT"
     7 "PARENT-IN-LAW"
     8 "BROTHER / SISTER"
     9 "BROTHER-IN-LAW / SISTER-IN-LAW"
    10 "UNCLE / AUNT"
    11 "NIECE / NEPHEW"
    12 "OTHER RELATIVE"
    13 "ADOPTED / FOSTER / STEPCHILD"
    14 "SERVANT (LIVE-IN)"
    96 "OTHER (NOT RELATED)"
    97 "INCONSISTENT"
    98 "DK"
 /HL4     
     1 "MALE"
     2 "FEMALE"
 /HL5M    
     1 "JANUARY"
     2 "FEBRUARY"
     3 "MARCH"
     4 "APRIL"
     5 "MAY"
     6 "JUNE"
     7 "JULY"
     8 "AUGUST"
     9 "SEPTEMBER"
    10 "OCTOBER"
    11 "NOVEMBER"
    12 "DECEMBER"
    97 "INCONSISTENT"
    98 "DK"
    99 "NO RESPONSE"
 /HL5Y    
  9997 "INCONSISTENT"
  9998 "DK"
  9999 "NO RESPONSE"
 /HL6     
    95 "95+"
    97 "INCONSISTENT"
    98 "DK"
    99 "NO RESPONSE"
 /HL8     
     0 "NOT ELIGIBLE"
 /HL9     
     0 "NOT ELIGIBLE"
 /HL10    
     0 "NOT ELIGIBLE"
 /HL11    
     1 "YES"
     2 "NO"
 /HL12    
     1 "YES"
     2 "NO"
     8 "DK"
     9 "NO RESPONSE"
 /HL13    
     1 "YES"
     2 "NO"
     9 "NO RESPONSE"
 /HL14    
    97 "INCONSISTENT"
    99 "NO RESPONSE"
 /HL15    
     1 "ABROAD"
     2 "IN ANOTHER HOUSEHOLD IN THE SAME REGION"
     3 "IN ANOTHER HOUSEHOLD IN ANOTHER REGION"
     4 "INSTITUTION IN THIS COUNTRY"
     8 "DK"
     9 "NO RESPONSE"
 /HL16    
     1 "YES"
     2 "NO"
     8 "DK"
     9 "NO RESPONSE"
 /HL17    
     1 "YES"
     2 "NO"
     9 "NO RESPONSE"
 /HL18    
    97 "INCONSISTENT"
    99 "NO RESPONSE"
 /HL19    
     1 "ABROAD"
     2 "IN ANOTHER HOUSEHOLD IN THE SAME REGION"
     3 "IN ANOTHER HOUSEHOLD IN ANOTHER REGION"
     4 "INSTITUTION IN THIS COUNTRY"
     8 "DK"
     9 "NO RESPONSE"
 /HL20    
    90 "NO ONE"
 /HL33    
     1 "YES, PERMISSION IS GIVEN"
     2 "NO, PERMISSION IS NOT GIVEN"
 /HL39    
     1 "YES, PERMISSION IS GIVEN"
     2 "NO, PERMISSION IS NOT GIVEN"
 /ED3     
     1 "YES"
     2 "NO"
 /ED4     
     1 "YES"
     2 "NO"
     9 "NO RESPONSE"
 /ED5A    
     0 "ECE"
     1 "PRIMARY"
     2 "LOWER SECONDARY"
     3 "UPPER SECONDARY"
     4 "HIGHER"
     5 "ADULT EDUCATION"
     8 "DK"
     9 "NO RESPONSE"
 /ED5B    
    97 "INCONSISTENT"
    98 "DK"
    99 "NO RESPONSE"
 /ED6     
     1 "YES"
     2 "NO"
     8 "DK"
     9 "NO RESPONSE"
 /ED7     
     1 "YES"
     2 "NO"
 /ED8     
     1 "YES"
     2 "NO"
 /ED9     
     1 "YES"
     2 "NO"
     9 "NO RESPONSE"
 /ED10A   
     0 "ECE"
     1 "PRIMARY"
     2 "LOWER SECONDARY"
     3 "UPPER SECONDARY"
     4 "HIGHER"
     5 "VOCATIONAL TRAINING SCHOOL"
     6 "CAP "
     7 "BTP"
     8 "BTS"
     9 "VOCATIONAL TRAINING"
    10 "ADULT EDUCATION"
    98 "DK"
    99 "NO RESPONSE"
 /ED10B   
    97 "INCONSISTENT"
    98 "DK"
    99 "NO RESPONSE"
 /ED11    
     1 "GOVT./ PUBLIC"
     3 "PRIVATE"
     4 "OTHER"
     8 "DK"
     9 "NO RESPONSE"
 /ED12    
     1 "YES"
     2 "NO"
     8 "DK"
     9 "NO RESPONSE"
 /ED13A   
  'A' "GOVT./ PUBLIC"
  '?' "NO RESPONSE"
 /ED13C   
  'C' "RELIGIOUS/ FAITH ORG."
  '?' "NO RESPONSE"
 /ED13D   
  'D' "PRIVATE"
  '?' "NO RESPONSE"
 /ED13X   
  'X' "OTHER"
  '?' "NO RESPONSE"
 /ED13Z   
  'X' "OTHER"
  '?' "NO RESPONSE"
 /ED13NR  
  'Z' "DK"
  '?' "NO RESPONSE"
 /ED14    
     1 "YES"
     2 "NO"
     8 "DK"
     9 "NO RESPONSE"
 /ED15    
     1 "YES"
     2 "NO"
     8 "DK"
     9 "NO RESPONSE"
 /ED16A   
     0 "ECE"
     1 "PRIMARY"
     2 "LOWER SECONDARY"
     3 "UPPER SECONDARY"
     4 "HIGHER"
     5 "VOCATIONAL TRAINING SCHOOL"
     6 "CAP "
     7 "BTP"
     8 "BTS"
     9 "VOCATIONAL TRAINING"
    10 "ADULT EDUCATION"
    98 "DK"
    99 "NO RESPONSE"
 /ED16B   
    97 "INCONSISTENT"
    98 "DK"
    99 "NO RESPONSE"
 /HH6     
     1 "URBAIN"
     2 "RURAL"
 /HH7     
     1 "DISTRICT TUNIS"
     2 "NORD EST"
     3 "NORD OUEST"
     4 "CENTRE EST"
     5 "CENTRE OUEST"
     6 "SUD EST"
     7 "SUD OUEST"
 /MLINE   
     0 "Not in household"
 /FLINE   
     0 "Not in household"
.
EXECUTE.
