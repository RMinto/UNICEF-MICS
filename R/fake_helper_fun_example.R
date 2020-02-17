

# fake example f'n takes an input df then uses sapply/lapply to map 
# a function to every column of the input
fake_helper_fun <- function(x) {
  return(sapply(x, sum(is.na(x))))  
}
# f'n above gives total NULLs per column / variable, takes the sum of NULL values in a column, then
# maps this function across every column

helper_fun_logicals <- function(x) {
  return(lapply(x, any(is.na(x))))
}
# similarly, but whether there is at least a single NULL per each column