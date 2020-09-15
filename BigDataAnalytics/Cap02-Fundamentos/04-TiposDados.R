# Variaveis em R
setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# Todos os números criados em R são do tipo numéric
# São armazenados como números decimais (double)
num1 <- 7
num1

# classe da variável - numeric
class(num1)
mode(num1)

# tipo de dados específico - double
typeof(num1)

num2 = 16.82
num2
mode(num2)
typeof(num2)

# Integer
# convertemos tipos numeric para integer
is.integer(num2)
y = as.integer(num2)
class(y)
mode(y)
typeof(y)

as.integer(3.17)
as.integer('3.17')
as.integer('joe')
as.integer("joe")
as.integer(TRUE)
as.integer(FALSE)
as.integer('TRUE')

# character
char1 = 'A'
char1
mode(char1)
typeof(char1)

char2 = 'cientista'
char2
mode(char2)
typeof(char2)

char3 = c("Data", "Science", "Academy")
char3
mode(char3)
typeof(char3)

# Complexo
compl = 2.5 + 4i
compl
mode(compl)
typeof(compl)

sqrt(-1)
sqrt(1i)
sqrt(-1+0i)
as.complex(-1)

# Logic
x = 1; y = 2
z = x > y
z
class(z)

u = TRUE; v = FALSE
class(u)

u & v
u | v
!u

# operacao com 0
5/0
 0/5
 
 # Erro
 'joes'/5
 