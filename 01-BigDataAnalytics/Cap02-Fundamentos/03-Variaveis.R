# Variaveis em R
setwd("~/Documentos/dsa/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# Criando variáveis
var1 = 100
var1
mode(var1)
help("mode")
sqrt(100)

#  Iniciar variável a partir de outra
var2 <- var1
var2
mode(var2)
typeof(var2)
help("typeof")

# variável lista de elementos
var3 = c("primeiro", "segundo", "terceiro")
var3
mode(var3)
typeof(var3)

# variável pode ser uma função
var4 = function(x) { x + 3}
var4
mode(var4)

# mudar o tipo de uma variável
var5 = as.character(var1)
var5
mode(var5)

# atribuindo valores a variáveis
x <- c(1,2,3)
mode(x)
typeof(x)
x

x1 = c(1,2,3)
mode(x1)
typeof(x1)
x1

c(1, 2, 3) -> y
y

assign("x", c(6.3, 4, -2))
x

# verificando posição específica -> posição começa em 1
x[1]
var5[3]
var5[1]
var5[0]

# listar as variáveis de memória
ls()
objects()

# remover variável de memória
a = aa = 1
a; aa
ls()
rm(a)
rm('aa')
ls()
