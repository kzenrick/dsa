setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# Criando matrizes

# Número de linhas
matrix(seq(1,6), nr=2)
matrix(seq(1,6), nr=3)
matrix(seq(1,6), nr=6)
matrix(seq(1,6), nr=4)

# Número de colunas
matrix(seq(1, 6), ncol = 2)

# help
?matrix

# matrizess número de elementos devem ser múltiplos do número de linhas
matrix(seq(1,5), nr = 2)

# Criando matrizes a partir de vetores e preencher a partir das linhas
meus_dados = c(1:10)
matrix(data=meus_dados, nrow = 5, ncol = 2, byrow = T)
matrix(data=meus_dados, nrow = 5, ncol = 2)

# Fatiando a Matriz
mat <- matrix(c(2, 3, 4, 5), nr = 2)
mat
mat[1, 2]
mat[2, 2]
mat[1, 3]
mat[,2]
mat[2,]

# criando matriz diagonal -> apenas a diagonal não é zerada
matriz = 1:3
matriz
diag(matriz)

# extraindo vetor de uma matriz diagonal
vetor = diag(matriz)
vetor
diag(vetor)

# Transposta da matriz -> Trnansformar linhas em colunas
W <- matrix(c(2,4,8,12), nr=2, nc=2)
W
t(W)
U = t(W)
U
U - W

# obtendo uma matriz inversa -> aquela q multiplicada pela matriz
# obtén-se uma matriz identidade -> Matriz diagonal = 1
W
solve(W)
W * solve(W)
W %*% solve(W)
W * diag(1,1)

# Multiplicação de Matrizes
mat1 <- matrix(c(2,3,4,5), nr=2)
mat1
mat2 <- matrix(c(6,7,8,9), nr = 2)
mat2
mat1 * mat2
mat1 / mat2
mat1 + mat2
mat1 - mat2

# Multiplicar matriz por vetor
x = c(1:4)
x
y <- matrix(c(2,3,4,5), nr = 2)
y
x * y

# Nomeando a Matriz
mat3 <- matrix(c('Terra', 'Marte', 'Saturno', 'Neturno'), nr = 2)
mat3
dimnames(mat3) = list(c('_l1_', 'l2'), c('c1','_c2_'))
mat3
mat3['_l1_', '_c2_']

# Identificando linhas e colunas no momento da criação da Matriz
matrix(seq(1:4), nr = 2, dimnames = list(c('L1','L2'), c('C1','C2')))

# Combinando Matrizes
mat4 <- matrix(c(2,3,4,5), nr = 2)
mat4
mat5 <- matrix(c(6,7,8,9), nr = 2)
mat5
cbind(mat4, mat5)
rbind(mat4, mat5)

# Desconstruindo Matriz
c(mat4)
