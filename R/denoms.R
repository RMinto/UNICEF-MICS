


N <- hh %>% dplyr::summarize(Count = sum(nhhmem)) %>% 
  rbind.data.frame(hh %>% group_by(as_factor(HH6)) %>% 
                     dplyr::summarize(Count = sum(nhhmem)) %>% select(Count)) %>% 
  rbind.data.frame(hh %>% group_by(as_factor(HH7)) %>% 
                     dplyr::summarize(Count = sum(nhhmem)) %>% select(Count)) %>% 
  rbind.data.frame(hh %>% group_by(as_factor(helevel)) %>% 
                     dplyr::summarize(Count = sum(nhhmem)) %>% select(Count)) %>% 
  rbind.data.frame(hh %>% group_by(as_factor(windex5)) %>% 
                     dplyr::summarize(Count = sum(nhhmem)) %>% select(Count))


N$Count = round(N$Count)
#N <- N %>% mutate(Total = Count)
#N <- data.frame(N); colnames(N)[1] = c("Number of household members")
#rownames(N) = c("Total", levels(as_factor(hh$HH6)), levels(as_factor(hh$HH7)), levels(as_factor(hh$helevel)), 
#                levels(as_factor(hh$windex5)))








