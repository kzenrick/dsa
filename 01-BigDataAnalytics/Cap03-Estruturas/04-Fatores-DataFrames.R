setwd("~/Documentos/dsa/BigDataAnalytics/Cap03-Estruturas")
getwd()

# Criando vetores
vec1 = c(1001, 1002, 1003, 1004, 1005)
vec2 = c(0, 1, 1, 0, 2)
vec3 = c('Verde', 'Laranja', 'Azul', 'Laranja', 'Verde')

# unindo os datas sets
df <- data.frame(vec1, vec2, vec3)
df

# verificando que o R categorizou a ultima coluna como fator
str(df)

# Verificando os níveis do fator.
levels(df$vec3)
levels(df$vec2)

# Criando nova coluna e atribuindo labes
df$cat1 <- factor(df$vec3, labels = c("cor2", "cor1", "cor3"))
df

# Internamento, os fatores são registrados como inteiros, mas a
# ordenação das strings
str(df)

df$cat2 <- factor(df$vec2, labels = c("Divorciado", "Casado", "Solteiro"))
df
str(df)
levels(df$cat2)
