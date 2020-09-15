setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap07-ManipulacaoDados")
getwd()

## Vetores
x <- c('A','E', 'D', 'B', 'C')
x
x[]

# Elementos em Posições Específicas
x[c(1,3)]
x[c(1,1)]
x[order(x)]

# Índices negativos - Ignora os elementos em posições específicas
x[-c(1, 3)]
x[-c(1, 4)]

# Vetor lógico para gerar substring
x
x[c(T, F)]        # Como tem mais itens na lista que nos registros, ele fica repetindo o vetor T,F várias vezes
x[c(T, F, T, F)]
x[c(T, F, F)]

# Vetor de caracteres
x <- c('A', 'B', 'C', 'D')
y <- setNames(x, letters[1:4])
y

y[c('d', 'c', 'a')]
y[c('a', 'a', 'a')]

# Matrizes
mat <- matrix(1:9, nrow = 3)
colnames(mat) <- c('A', 'B', 'C')
mat
mat[1:2,]
mat[1:2, 2:3]
mat[c(1,3), c(3, 1)]

# Função outer() permite que uma Matriz se comporte como vetores individuais
?outer
vals <- outer(1:5, 1:5, FUN = 'paste', sep = ',')
vals
vals[c(4,15)]

# DataFrames
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df
df$x
df[df$x == 2,]
df[c(1, 3), ]
df[c('x', 'z')]
df[, c('x', 'z')]
str(df['x']) # Retorna um data frame
str(df[,'x']) # Retorna vetor de inteiros

# Removendo colunas de dataframes
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df
df$z <- NULL
df

# Operadores [], [[]], e $
a <- list(x = 1:3, y = 4:5)
a
a[1]
a[[1]]
a[[1]][[1]]
a[['x']]

b <- list(a = list(b = list(c = list(d = 1))))
b
b[[c('a','b','c','d')]]
b[['a']][['b']][['c']][['d']]

# x$y é equivalente a x[["y", exact = F]]
var <- 'cyl'
mtcars$var
mtcars[[var]]

x <- list(abc = 1)
x$a # Nome parcial, desde que não exista mais nenhum começando com 'a'
x[['a']]

x <- list(abc = 1, acb = 2)
x$a # Nulo pois 2 começam com o mesmo nome
x$ab # Imprime 1
x$ac # Imprime 2

# Subsetting e atribuição
x <- 1:5
x
x[c(1,2)] <- 2:3  # altera os valores dos índices de 1 a 2
x

x[-1] <- 4:1 # Excluindo a posição 1, altera demais valores com valores de 4 a 1
x

# Isso é subsetting
head(mtcars)
mtcars[] <- lapply(mtcars, as.integer)
head(mtcars)

# Isso não é subsetting
mtcars <- lapply(mtcars, as.integer)
head(mtcars)

# lookup tables
x <- c('m','f','u','f','f','m','m')
lookup <- c(m = 'male', f = 'female', u = NA)
lookup[x]
unname(lookup[x])

# Usando valores lógicos
x1 <- 1:10 %% 2 == 0
x1
?which
which(x1)

x2 <- which(x1)
x2

y1 <- 1:10 %% 5 == 0
y2 <- which(y1)
y2

intersect(x2, y2)
x1 & y1

union(x2, y2)
setdiff(x2, y2)
