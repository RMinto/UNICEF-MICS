
# To convert into spss to R functions

select if (HH46  = 1).
# df %>% filter(var == value)

compute hhweightHH48 = HH48*hhweight.
# df %>% mutate(hhweightHH48 = HH48 * hhweight)

variable labels  total100 "Total".
# variable labels are attribute labels


value labels total100 100 " ".
# value labels ***need to verify*** appear to be conditional recoding of vectors


do if any(WS1, 11, 12, 13, 14, 21, 31, 41, 51, 61, 71, 72,  91, 92) .
+ compute drinkingWater = 1 .
else .
+ compute drinkingWater = 2 .
end if.
# create new variable that's just using ifelse for conditional evaluation 
# based on values of var already in dataset
