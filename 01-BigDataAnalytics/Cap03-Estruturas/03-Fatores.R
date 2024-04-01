setwd("~/Documentos/dsa/BigDataAnalytics/Cap03-Estruturas")
getwd()

vec1 <- c("Macho", "Femea", "Femea", "Macho", "Macho")
vec1
fac_vec1 <- factor(vec1)
fac_vec1
class(vec1)
class(fac_vec1)

# Variáveis Categóricas Nominais
# Não existe ordem implícita
animais <- c("Zebra", "Pantera", "Rinoceronte", "Macaco", "Tigre")
animais
class(animais)
fac_animais <- factor(animais)
fac_animais
class(fac_animais)
levels(fac_animais)

# Variáveis Categóricas Ordinais
# Possuem uma ordem natural
grad <- c("Mestrado", "Doutorado", "Bacharelado", "Mestrado", "Mestrado")
grad
fac_grad <- factor(grad, order = T, levels = c("Doutorado", "Mestrado", "Bacharelado"))
fac_grad
levels(fac_grad)

# sumarizar os dados fornece uma visão geral sobre o conteúdo das variáveis
summary(fac_grad)
summary(grad)

vec2 <- c("M", "F", "F", "M", "M", "M", "F", "F", "M", "M", "M", "F", "F", "M", "M")
vec2
fac_vec2 <- factor(vec2)
levels(fac_vec2) <- c("Femea", "Macho")
fac_vec2
summary(fac_vec2)
summary(vec2)

# mais exemplos
data <- c(1, 2, 2, 3, 1, 2 ,3, 3, 1, 2, 3, 3, 1)
fdata = factor(data)
fdata
summary(fdata)

rdata = factor(data, labels = c("I", "II", "III"))
rdata
summary(rdata)

# Fatores não-ordenados
set1 <- c("AA", "B", "BA", "CC", "CA", "AA", "BA", "CC", "CC")
set1

# Transformando os dados.
# R apenas criou os níveis, o que não significa que exista uma hierarquia
f.set1 <- factor(set1)
f.set1
class(f.set1)
is.ordered(f.set1)

# Fatores Ordenados
o.set1 <- factor(set1, 
                 levels = c("CA", "BA", "AA", "CC", "B"),
                 ordered = T)
o.set1
is.ordered(o.set1)

as.numeric(o.set1)
table(o.set1)
summary(o.set1)

# Fatores e DF
df <- read.csv2("etnias.csv", sep=",")
df

# Variáveis do tipo fator
str(df)
View(df)

# Níveis de fatores
# R faz o mapeamento automátivo por níveis
levels(df$Etnia)
summary(df$Etnia)

# Plot
# Agora se fizermos um plot, temos um boxplot para as variáveis categóricas
plot(df$Idade~df$Etnia, xlab="Etnia", ylab = "Idade", main = "Idade por Etnia")
plot(df$Peso~df$Sexo, xlab="Sexo", ylab = "Peso", main = "PxS")

# Regressão
summary(lm(Idade~Etnia, data=df))

# Convertendo uma coluna em variável categória
df
str(df)
df$Estado_Civil.cat <- factor(df$Estado_Civil, labels = c("Solteiro", "Casado", "Divorciado"))
df
str(df)
