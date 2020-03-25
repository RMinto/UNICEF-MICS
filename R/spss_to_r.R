
# To convert into spss to R functions

select if (HH46  = 1).
# df %>% filter(var == value)

compute hhweightHH48 = HH48*hhweight.
# df %>% mutate(hhweightHH48 = HH48 * hhweight)

variable labels  total100 "Total".
# variable labels are attribute labels


value labels total100 100 " ".
# value labels ***need to verify*** appear to be conditional recoding of vectors