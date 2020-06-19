
names(wm) = sapply(names(wm), tolower)

wm = wm %>% mutate(mstatus2 = ifelse(mstatus %in% 1:2, 1,
                                     ifelse(mstatus == 3, 2, mstatus)))



wm = wm %>% mutate(wageAux = wage) %>% 
  mutate(wageAux1 = ifelse(wb4 <= 17, 1.1, wageAux),
         wageAux2 = ifelse(wb4 >= 18 & wb4 <= 19, 1.2, wageAux))

wm = wm %>% mutate(wage1 = ifelse(wb4 %in% 15:24, 10,
                                  ifelse(wb4 %in% 25:34, 20,
                                         ifelse(wb4 %in% 35:49, 30, wage))),
                   wage2 = ifelse(wb4 %in% 15:19, 11,
                                  ifelse(wb4 %in% 20:24, 14, wage)),
                   wage3 = ifelse(wb4 %in% 15:17, 12,
                                  ifelse(wb4 %in% 18:19, 13, wage)))





wm = wm %>% mutate(wageAux1 = ifelse(wage == 2, 4, wageAux1),
                   wageAux2 = ifelse(wb4 %in% 15:17, 2,
                                     ifelse(wb4 %in% 18:19, 3,
                                            ifelse(wb4 %in% 20:22, 5,
                                                   ifelse(wb4 %in% 23:24, 6, wageAux2)))))

wm = wm %>% mutate(wage1y = ifelse(wb4 %in% 15:24, 10,
                                   ifelse(wb4 %in% 25:29, 20,
                                          ifelse(wb4 %in% 30:39, 30, 
                                                 ifelse(wb4 %in% 40:49, 40, wage)))),
                   wage2y = ifelse(wb4 %in% 15:19, 11,
                                   ifelse(wb4 %in% 20:24, 14, wage)),
                   wage3y = ifelse(wb4 %in% 15:17, 12,
                                   ifelse(wb4 %in% 18:19, 13, wage)))


wm = wm %>% mutate(wage1w = ifelse(wb4 %in% 15:24, 10,
                                   ifelse(wb4 %in% 25:29, 20,
                                          ifelse(wb4 %in% 30:34, 30, 
                                                 ifelse(wb4 %in% 40:44, 50, 
                                                        ifelse(wb4 %in% 45:49, 60, wage))))),
                   wage2w = ifelse(wb4 %in% 15:19, 11,
                                   ifelse(wb4 %in% 20:24, 14, wage)),
                   wage3w = ifelse(wb4 %in% 15:17, 12,
                                   ifelse(wb4 %in% 18:19, 13, wage)))






wm = wm %>% mutate(wage1z = ifelse(wb4 %in% 15:24, 10,
                                   ifelse(wb4 %in% 25:29, 20,
                                          ifelse(wb4 %in% 30:39, 30, 
                                                 ifelse(wb4 %in% 40:49, 40, wage)))),
                   wage2z = ifelse(wb4 %in% 15:19, 11,
                                   ifelse(wb4 %in% 20:24, 14, wage)),
                   wage3z = ifelse(wb4 %in% 15:17, 12,
                                   ifelse(wb4 %in% 18:19, 13, wage)))


wm = wm %>% mutate(wageu = ifelse(wb4 %in% 15:19, 1,
                                  ifelse(wb4 %in% 20:24, 2,
                                         ifelse(wb4 %in% 25:29, 3, 
                                                ifelse(wb4 %in% 30:39, 4, 
                                                       ifelse(wb4 %in% 40:49, 5, wage))))))




wm = wm %>% mutate(wage1xx = ifelse(wb4 %in% 15:19, 10,
                                    ifelse(wb4 %in% 20:24, 20,
                                           ifelse(wb4 %in% 25:29, 25, 
                                                  ifelse(wb4 %in% 30:39, 30, 
                                                         ifelse(wb4 %in% 40:49, 40, wage))))),
                   wage2xx = ifelse(wb4 %in% 15:17, 12,
                                    ifelse(wb4 %in% 18:19, 13, wage)))