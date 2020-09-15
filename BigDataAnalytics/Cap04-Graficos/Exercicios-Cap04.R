setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap04-Graficos")
getwd()


# Exercicio 1 - Crie uma função que receba os dois vetores abaixo como parâmetro, 
# converta-os em um dataframe e imprima no console
vec1 <- (10:13)
vec2 <- c("a", "b", "c", "d")

# ----- 
# Meu
f <- function (x, y){
  df <- data.frame(num = vec1, txt = vec2)
}

a <- f(vec1, vec2)
a
# --- t1

# Solução
myfunc <- function(x, y){
  df = data.frame(cbind(x, y))
  print(df)
}

myfunc(vec1, vec2)

# Exercicio 2 - Crie uma matriz com 4 linhas e 4 colunas preenchida com 
# números inteiros e calcule a média de cada linha
m <- matrix(1:16, nrow = 4, ncol = 4, byrow = T)
# Meu
rowMeans(m)
colMeans(m)

# Solução
apply(m, 1, mean)

# Exercicio 3 - Considere o dataframe abaixo. 
# Calcule a média por disciplina e depois calcule a média de apenas uma disciplina
escola <- data.frame(Aluno = c('Alan', 'Alice', 'Alana', 'Aline', 'Alex', 'Ajay'),
                     Matematica = c(90, 80, 85, 87, 56, 79),
                     Geografia = c(100, 78, 86, 90, 98, 67),
                     Quimica = c(76, 56, 89, 90, 100, 87))

escola
# Meu
# notas <- escola[1:length(escola), c(2:4)]
notas <- escola[1:nrow(escola), c(2:4)]

# Alunos
escola[1]

# Média por aluno
rowMeans(notas)

# Média por Matérias
colMeans(notas)

# Média de Matemática
mean(notas$Matematica)


# --- Solução
apply(escola[,c(2,3,4)], 2, mean)

# Média com erro :: 
#-- apply(escola$Matematica, 2, mean)

apply(escola[, c(2), drop = F], 2, mean)

# Exercicio 4 - Cria uma lista com 3 elementos, todos numéricos 
# e calcule a soma de todos os elementos da lista

# Meu
l <- list(c(1:3), 4, c(5:9))
l
do.call(sum, l)

# Solução
lst <- list(a = 1:10, b = 1:5)
lst
do.call(sum, lst)

# Exercicio 5 - Transforme a lista anterior um vetor
# Meu
v <- unlist(l)
v

# Solução
unlist(lst)

# Exercicio 6 - Considere a string abaixo. Substitua a palavra "textos" por "frases"
str <- c("Expressoes", "regulares", "em linguagem R", 
         "permitem a busca de padroes", "e exploracao de textos",
         "podemos buscar padroes em digitos",
         "como por exemplo",
         "10992451280")

str
sub(pattern = "textos", replacement = "frases", str)


# Exercicio 7 - Usando o dataset mtcars, crie um gráfico com ggplot do tipo 
# scatter plot. Use as colunas disp e mpg nos eixos x e y respectivamente
library(ggplot2)

# Plot Normal
x <- mtcars$disp
y <- mtcars$mpg

plot(x, 
     y, 
     col = "steelblue",
     main = "Disp x Mpg",
     col.main = "lavenderblush3",
     xlab = "Disp",
     ylab =  "mpg",
     cex.main = 2)

ggplot(mtcars,
       aes(x = mtcars$disp,
           y = mtcars$mpg,
           color = carb
       )) +
  geom_point() +
  xlab ( "Disp") +
  ylab ("Mpg")

# Exercicio 8 - Considere a matriz abaixo.
# Crie um bar plot que represente os dados em barras individuais.
mat1 <- matrix(c(652,1537,598,242,36,46,38,21,218,327,106,67), nrow = 3, byrow = T)
mat1

cores = c("")
while (length(cores) < 13){
  cores <- c(cores, geraCor())
}
cores <- cores[-1]

cores
barplot(mat1, beside = T, col = cores, ylim = c(0, as.integer(max(mat1 * 1.05))))

df_mat1 <- as.data.frame(mat1)
ggplot() +
  geom_bar(data = df_mat1)

# Exercício 9 - Qual o erro do código abaixo?
data(diamonds)
ggplot(data = diamonds, aes(x = price, group = fill, fill = cut)) + 
  geom_density(adjust = 1.5)


# Meu --> retirar group = fill
ggplot(data = diamonds, aes(x = price, fill = cut)) + 
  geom_density(adjust = 1.5)


# Exercício 10 - Qual o erro do código abaixo?
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_barplot() +
  labs(fill = "cyl")

# Meu --> Mudado geom_barplot para geom_bar
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  labs(fill = "cyl")
