geraCor <- function (){
  a = colors()
  a[as.integer(runif(1, min=1, max=length(a)))]
}

print(geraCor())


