library(stringr)

f <- function(){
  t <- ''
  
  while (str_length(t) < sample(3:8, size = 1)){
    t = str_c(t, sample(letters, size=1))
  }
  t
}


f()
