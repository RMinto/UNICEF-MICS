
hh <- hh %>% 
  mutate(drinkingWater = ifelse(WS1 %in% c(11:14, 21, 31, 41, 51, 61, 71, 72, 91, 92), 1, 2))

var_lab(hh$drinkingWater) = "Main source of drinking water"
val_lab(hh$drinkingWater) = make_labels("
                                        1 Improved sources
                                        2 Unimproved sources
                                        ")



hh <- hh %>% 
  mutate(toiletType = case_when(
    WS11 %in% c(11:13, 18, 21, 22, 31) ~ 1,
    WS11 == 95 ~ 3,
    TRUE ~ 2
  ))


var_lab(hh$toiletType) = "Type of sanitation facility"
val_lab(hh$toiletType) = make_labels("
                                     1 Improved
                                     2 Unimproved
                                     3 Open defecation (no facility, bush, field)
                                     ")


hh <- hh %>% mutate(flush = NA) %>% mutate(flush = case_when(
  WS11 %in% c(1:14, 18) ~ 1
))

var_lab(hh$flush) = ""; val_lab(hh$flush) = make_labels(" 
                                                        1 Flush/Pour flush to:
                                                        ")



hh <- hh %>% mutate(sharedToilet = case_when(
  WS17 %in% c(1:5) ~ 1,
  WS17 %in% 97:99 ~ 9,
  NA ~ 0,
  TRUE ~ 2
))

hh <- hh %>% mutate(sharedToilet = ifelse(WS16 == 2, 3, sharedToilet))

var_lab(hh$sharedToilet) = " "
val_lab(hh$sharedToilet) = make_labels("
  0 Not shared
  1 5 households or less
  2 More than 5 households
  3 Public facility
  9 DK/Missing
                                       ")


var_lab(hh$drinkingWater) = "Source of drinking water"
val_lab(hh$drinkingWater) = make_labels("
1 Improved
2 Unimproved
                                        ")



hh <- hh %>% mutate(total = 1); var_lab(hh$total) = "Total"; 
val_lab(hh$total) = make_labels("1 ")


