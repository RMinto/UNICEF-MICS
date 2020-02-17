

# fake example f'n takes an input df then uses sapply/lapply to map 
# a function to every column of the input
fake_helper_fun <- function(x) {
  return(sapply(x, sum(is.na(x))))
}
# R object that's returned, depending on whether sapply / lapply used, is a
# vector / list of length p, corresponding to p columns in df, with every element in p 
# the number of summed / aggregate nulls in each column 