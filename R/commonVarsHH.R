
hh = hh %>% mutate(HHAGEx = ifelse(HHAGE %in% 15:19, 1,
                                   ifelse(HHAGE %in% 20:24, 2,
                                          ifelse(HHAGE %in% 25:49, 3,
                                                 ifelse(HHAGE >= 50, 4, HHAGE)))))

var_lab(hh$HHAGEx) = "Age of household head"

hh = hh %>% mutate(HHAGEy = ifelse(HHAGE %in% 15:19, 1,
                                   ifelse(HHAGE %in% 20:24, 2,
                                          ifelse(HHAGE %in% 25:29, 3,
                                                 ifelse(HHAGE %in% 30:34, 4,
                                                        ifelse(HHAGE %in% 35:39, 5, 
                                                               ifelse(HHAGE %in% 40:44, 6,
                                                                      ifelse(HHAGE %in% 45:49, 7,
                                                                             ifelse(HHAGE %in% 50:59, 8,
                                                                                    ifelse(HHAGE %in% 60:69, 9,
                                                                                           ifelse(HHAGE >= 70, 10, HHAGE)))))))))))


var_lab(hh$HHAGEy) = "Age of household head"