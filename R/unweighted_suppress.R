



library(expss); library(tidyverse)


# Create dataframe of unweighted cases

unweighted <- calc_cro_cases(
  hh,
  cell_vars = nn,
  row_vars = row.vars,
  col_vars = total(),
  total_row_position = "none"
) %>%
  data.frame() %>% 
  select(2) %>% 
  mutate(ind = ifelse(X.Total < 25, 1, 
                      ifelse(X.Total %in% 25:49, 2, 3))) %>% 
  slice(-c(27:30))




# suppress rule based on unweighted 

for (i in 1:nrow(tab)) 
  for (j in 1:ncol(tab)) 
  {
    tab[i, j] = ifelse(unweighted$ind[i] == 1, "(*)", 
                       ifelse(unweighted$ind[i] == 2, paste0("(", tab[i,j], ")"),
                              tab[i, j])) # else
  }















