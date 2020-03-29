DATA LIST FILE='C:\MICS6TUN\SPSS\MYBH.DAT' RECORDS=1
 /
 HH1         1-3   
 HH2         4-5   
 WM1         6-8   
 WM2         9-10  
 WMINT      11-13  
 WM3        14-15  
 LN         16-17  
 BH0        18-19  
 BH1        20-99   (A)
 BH2       100-100 
 BH3       101-101 
 BH4D      102-103 
 BH4M      104-105 
 BH4Y      106-109 
 BH5       110-110 
 BH6       111-112 
 BH7       113-113 
 BH8       114-115 
 BH9U      116-116 
 BH9N      117-118 
 BH10      119-119 
 BH4C      120-123 
 BH4F      124-124 
 BH9C      125-127 
 BH9F      128-128 
 HH4       129-131 
 HH6       132-132 
 HH7       133-133 
 WDOI      134-137 
 WDOB      138-141 
.
VARIABLE LABELS
  HH1      "Cluster number"
 /HH2      "Household number"
 /WM1      "Cluster number"
 /WM2      "Household number"
 /WMINT    "Interviewer number"
 /WM3      "Woman's line number"
 /LN       "Line number"
 /BH0      "Line Number"
 /BH1      "Name of child"
 /BH2      "Twins"
 /BH3      "Sex of child"
 /BH4D     "Day of birth"
 /BH4M     "Month of birth"
 /BH4Y     "Year of birth"
 /BH5      "Still alive"
 /BH6      "Age of child"
 /BH7      "Living with respondent"
 /BH8      "Line number of child in HH"
 /BH9U     "Age at death (units)"
 /BH9N     "Age at death (number)"
 /BH10     "Any other between births"
 /BH4C     "Date of birth of child (CMC)"
 /BH4F     "Date flag for BH4C"
 /BH9C     "Age at death months (imputed)"
 /BH9F     "Date flag for BH9C"
 /HH4      "Supervisor number"
 /HH6      "Area"
 /HH7      "Region"
 /WDOI     "Date of interview women (CMC)"
 /WDOB     "Date of birth of woman (CMC)"
.
VALUE LABELS
  BH2     
     1 "SINGLE"
     2 "MULTIPLE"
     9 "NO RESPONSE"
 /BH3     
     1 "BOY"
     2 "GIRL"
     9 "NO RESPONSE"
 /BH4D    
    97 "INCONSISTENT"
    99 "NO RESPONSE"
 /BH4M    
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
    99 "NO RESPONSE"
 /BH4Y    
  9997 "INCONSISTENT"
  9999 "NO RESPONSE"
 /BH5     
     1 "YES"
     2 "NO"
 /BH6     
    97 "INCONSISTENT"
    99 "NO RESPONSE"
 /BH7     
     1 "YES"
     2 "NO"
 /BH8     
     0 "NOT LISTED"
 /BH9U    
     1 "DAYS"
     2 "MONTHS"
     3 "YEARS"
     9 "DK / NO RESPONSE"
 /BH9N    
    97 "INCONSISTENT"
    99 "NO RESPONSE"
 /BH10    
     1 "YES"
     2 "NO"
     9 "NO RESPONSE"
 /BH4F    
     1 "Month and year"
     2 "Month and age -y imp"
     3 "Year and age - m imp"
     4 "Y & age - y ignored"
     5 "Year - a, m imp"
     6 "Age - y, m imp"
     7 "Month - a, y imp"
     8 "None - all imp"
 /BH9F    
     0 "No flag"
     1 "> interview"
     2 "< breastfeeding"
     3 "< age supplemented"
     4 "< first breastfed"
     5 "< last vaccination"
     6 "Outside range"
     7 "Imputed, units given"
     8 "Imputed, no units"
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
.
EXECUTE.
