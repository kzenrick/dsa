# Lista de Exercícios - Capítulo 3

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Documentos/dsa/BigDataAnalytics/Cap03-Estruturas")
getwd()


# Exercício 1 - Pesquise pela função que permite listar todos os arquivo no diretório de trabalho
list.files()

# Exercício 2 - Crie um dataframe a partir de 3 vetores: um de caracteres, um lógico 
# e um de números
df = data.frame(Coluna1 = c("a", "b", "c"),
                Coluna2 = c(T, F, F),
                Coluna3 = c(1, 0, 0)
                ) 
df

# Exercício 3 - Considere o vetor abaixo. 
# Criando um Vetor
vec1 <-c(12, 3, 4, 19, 34)
vec1

# Crie um loop que verifique se há números maiores que 10 e imprima o número e uma mensagem no console.
for (v in vec1){
  if (v > 10){
    print(sprintf("%d é maior do que 10", v))
  }
}

# Exercício 4 - Considere a lista abaixo. Crie um loop que imprima no console cada elemento da lista
lst2 <- list(2, 3, 5, 7, 11, 13)
lst2

for (l in lst2){
  print(l)
}

for (v in unlist(lst2)) {
  print(v)
}


# Exercício 5 - Considere as duas matrizes abaixo. 
# Faça uma multiplicação element-wise e multiplicação normal entre as materizes
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1
mat2 <- t(mat1)
mat2

# Multiplicação element-wise
mat1 * mat2

# Multiplicação de matrizes
mat1 %*% mat2

# Exercício 6 - Crie um vetor, matriz, lista e dataframe e faça a nomeação de cada um dos objetos
# ------- Vetor
# Meu:
v = c(1, 2, 3)
v
# Resposta:
names(vec1) <- c("C1", "C2", "C3", "C4", "C5")
vec1

# ------- Matrix
# Meu
m = matrix(v, nrow = 2, dimnames = list(c("R1","R2"), c("C1", "C2")))
m

# Resposta
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1
dimnames(mat1) = list(c('obs1','obs2','obs3','obs4','obs5'),
                      c('var1','var2','var3','var4','var5'))
mat1

# ------ List
# Meu
l = list(vetor = v, matrix = m)
l

# Resposta
lst1 <- list(2, 3 , c(1,2,3))
lst1
names(lst1) <- c('dim1', 'dim2','dim3')
lst1

# ------ DF
# Meu
df = data.frame(Coluna1 = c("a", "b", "c"),
                Coluna2 = c(T, F, F),
                Coluna3 = c(1, 0, 0),
                row.names = c("L1", "L2", "L3")
                ) 
df

# Resposta
df1 <- data.frame(c("A","B","C"),
                  c(4.5, 3.9, 7.2),
                  c(T, T, F))
df1
colnames(df1) <- c("Char", "Float", "Bool")
rownames(df1) <- c("Obs1", "Obs2", "Obs3")
df1


# Exercício 7 - Considere a matriz abaixo. Atribua valores NA de forma aletória para 50 elementos da matriz
# Dica: use a função sample()
mat2 <- matrix(1:90, 10)
mat2

# Meu
a = sample(90, 50)
a
for (i in a){
  mat2[[i]] = NA
}
mat2

# Resposta
mat2 <- matrix(1:90, 10)
mat2
mat2[a] <- NA
mat2

# Exercício 8 - Para a matriz abaixo, calcule a soma por linha e por coluna
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1

# Meu
apply(mat1, 1, sum)
apply(mat1, 2, sum)

# Resposta
rowSums(mat1)
colSums(mat1)

# Exercício 9 - Para o vetor abaixo, ordene os valores em ordem crescente
a <- c(100, 10, 10000, 1000)
a
# Meu
sort(a)

# Resposta
order(a)
a[order(a)]

# # Exercício 10 - Imprima no console todos os elementos da matriz abaixo que forem maiores que 15
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1

for (m in mat1){
  if (m > 15){
    print(m)
  }
} 

