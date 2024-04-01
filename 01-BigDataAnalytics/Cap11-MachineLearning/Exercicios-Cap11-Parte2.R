# Lista de Exercícios Parte 2 - Capítulo 11

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")
source("~/Documentos/dsa/BigDataAnalytics/function_aplica_lm.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap11-MachineLearning")
getwd()


# Regressão Linear
# Definição do Problema: Prever as notas dos alunos com base em diversas métricas
# https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Dataset com dados de estudantes
# Vamos prever a nota final (grade) dos alunos

# Carregando o dataset
df <- read.csv2('estudantes.csv')

# Explorando os dados
head(df)
summary(df)
str(df)
any(is.na(df))

# install.packages("ggplot2")
# install.packages("ggthemes")
# install.packages("dplyr")

library(dplyr)


# Descrição Atributos ---------------------------- 

# Attributesfor both student-mat.csv (Math course) and student-por.csv (Portuguese language course) datasets:
#  1 school     - student's school (binary: 'GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)
#  2 sex        - student's sex (binary: 'F' - female or 'M' - male)
#  3 age        - student's age (numeric: from 15 to 22)
#  4 address    - student's home address type (binary: 'U' - urban or 'R' - rural)
#  5 famsize    - family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)
#  6 Pstatus    - parent's cohabitation status (binary: 'T' - living together or 'A' - apart)
#  7 Medu       - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
#  8 Fedu       - father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
#  9 Mjob       - mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
# 10 Fjob       - father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
# 11 reason     - reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')
# 12 guardian   - student's guardian (nominal: 'mother', 'father' or 'other')
# 13 traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
# 14 studytime  - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
# 15 failures   - number of past class failures (numeric: n if 1<=n<3, else 4)
# 16 schoolsup  - extra educational support (binary: yes or no)
# 17 famsup     - family educational support (binary: yes or no)
# 18 paid       - extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)
# 19 activities - extra-curricular activities (binary: yes or no)
# 20 nursery    - attended nursery school (binary: yes or no)
# 21 higher     - wants to take higher education (binary: yes or no)
# 22 internet   - Internet access at home (binary: yes or no)
# 23 romantic   - with a romantic relationship (binary: yes or no)
# 24 famrel     - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
# 25 freetime   - free time after school (numeric: from 1 - very low to 5 - very high)
# 26 goout      - going out with friends (numeric: from 1 - very low to 5 - very high)
# 27 Dalc       - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
# 28 Walc       - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)
# 29 health     - current health status (numeric: from 1 - very bad to 5 - very good)
# 30 absences   - number of school absences (numeric: from 0 to 93)

# these grades are related with the course subject, Math or Portuguese:
# 31 G1 - first period grade (numeric: from 0 to 20)
# 31 G2 - second period grade (numeric: from 0 to 20)
# 32 G3 - final grade (numeric: from 0 to 20, output target)



# Mostrar Apenas Variáveis Numéricas -----------------------------
for (n in names(df)) {
  if (is.integer(df[[n]]) ){  
    cat('- - - - - -\t', n, '\t- - - - - -\n')
    estatisticas(df[[n]], n)
    cat("\n")
  }
}


# Mostrar Apenas Variáveis Categóricas------------------------------
for (n in names(df)) {
  if (is.factor(df[[n]])) {
    cat('- - - - - -\t', n, '\t- - - - - -\n')
    categoricas(df[[n]], n)
    cat("\n")
  }
}


# Tranformar Variável Fator ----------------- 
#  7 Medu       - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
#  8 Fedu       - father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)

# 13 traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)

# 14 studytime  - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
# 15 failures   - number of past class failures (numeric: n if 1<=n<3, else 4)

# 24 famrel     - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
# 25 freetime   - free time after school (numeric: from 1 - very low to 5 - very high)
# 26 goout      - going out with friends (numeric: from 1 - very low to 5 - very high)
# 27 Dalc       - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
# 28 Walc       - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)
# 29 health     - current health status (numeric: from 1 - very bad to 5 - very good)


# ---
# Transformar variável com muitos valores em uma variável binária
# 30 absences   - number of school absences (numeric: from 0 to 93)
#                 absences em baixa (até 4) ou alta (maior que 4)
# df$absencesLow <- df$absences %in% seq(from = 0, to = 4, by = 1)
# View(df[1:100, c('absences','absencesLow'), drop = F])

# Transformar em um factor
# df$absencesLow <- factor(df$absencesLow,
#                         levels = c(T, F),
#                         labels = c('yes', 'no')
#                         )


# Verficar correlação de campos numéricos ----------
library(corrplot)
numeric.var <- sapply(df, is.numeric)
corr.matrix <- cor(df[, numeric.var])
corrplot(corr.matrix,
         main="Gráfico de Correlação numérica",
         method="number")


pairs(df[, numeric.var])

# utilizando corrgram ----
#install.packages('corrgram')
library(corrgram)
corrgram(df)
corrgram(df,
         order = T,
         lower.panel = panel.shade,
         upper.panel = panel.pie,
         text.panel = panel.text
         )


library(psych)
pairs.panels(df[, numeric.var], scale = T)

# Criando histogranma para relação com o G3
ggplot(df,
       aes(x = G3)) +
  geom_histogram(bins = 20,
                 alpha = 0.5,
                 fill = 'blue') +
  theme_minimal()

# Retirar Campos de maior Correlação ----------

# Colunas a serem removidas devido a alta relação
# Medu x Fedu -> Fica Medu
df$Fedu <- NULL

# goout x Dalc x Walc -> Fica goout
df$Dalc <- NULL
df$Walc <- NULL

# absences retirada por ser usada o novo campo
# df$absences <- NULL

# retirada os campos G1 e G2 devido a forte referencia com G3
df$G1 <- NULL
df$G2 <- NULL

# Abasenses alterada para 5 níveis - 0: very low, 1: low, 2: 
nivel_absences <- function (x){
  case_when(
    x < 4 ~ "0",
    x < 8 ~ "1",
    x < 12 ~ "2",
    x < 16 ~ "3",
    T ~ "4"
  )
}
df$absencesLow <- sapply(df$absences, nivel_absences)
df$absencesLow <- factor(df$absencesLow,
                         levels = c("0", "1", "2", "3", "4"),
                         labels = c("0", "1", "2", "3", "4")
                         )
df$absences <- NULL

# Transforma o resultado final em 5 notas possíveis, de E a A
Nota <- function(x){
  case_when(
     x < 4 ~ "E",
     x < 8 ~ "D",
     x < 12 ~ "C",
     x < 16 ~ "B",
     T ~ "A"
  )
}

Nota2 <- function(x){
  case_when(
    x < 4 ~ 5,
    x < 8 ~ 4,
    x < 12 ~ 3,
    x < 16 ~ 2,
    T ~ 1
  )
}
# df$NotaFinal <- sapply(df$G3, Nota)
# df$NotaFinal <- as.factor(df$NotaFinal)

# Faço 4 cópias da df, 1 para cada modelo a ser criada
df0 <- df

# Verificar relação de variáveis categóricas  ---------------------------------------
# Gráficos de barra de variáveis categóricas
library(ggplot2)
library(ggthemes)
library(gridExtra)

p1 <- ggplot(df, aes(x=school)) + 
  ggtitle("School") + 
  xlab("Escola") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p2 <- ggplot(df, aes(x=sex)) + 
  ggtitle("Sex") + 
  xlab("Sexo") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p3 <- ggplot(df, aes(x=address)) + 
  ggtitle("Address") + 
  xlab("Endereço") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p4 <- ggplot(df, aes(x=famsize)) + 
  ggtitle("Fam. Size") + 
  xlab("Tam. Família") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

# -- Mostra as 4 primeiras categorias
grid.arrange(p1, p2, p3, p4, ncol=2)


p5 <- ggplot(df, aes(x=Pstatus)) + 
  ggtitle("Pstatus") + 
  xlab("Pais juntos") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p6 <- ggplot(df, aes(x=Mjob)) + 
  ggtitle("Mjob") + 
  xlab("Trab. da mãe") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p7 <- ggplot(df, aes(x=Fjob)) + 
  ggtitle("Fjob") + 
  xlab("Trab. do pai") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p8 <- ggplot(df, aes(x=reason)) + 
  ggtitle("Reason") + 
  xlab("Motivo Escola") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

# Mostra o segundo grupos
grid.arrange(p5, p6, p7, p8, ncol=2)


p9 <- ggplot(df, aes(x=guardian)) + 
  ggtitle("Guardian") + 
  xlab("Guardião") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p10 <- ggplot(df, aes(x=schoolsup)) + 
  ggtitle("School Sup") + 
  xlab("Educação Extra") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p11 <- ggplot(df, aes(x=famsup)) + 
  ggtitle("Fam Sup") + 
  xlab("Apoio Familiar") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + coord_flip() + theme_minimal()

p12 <- ggplot(df, aes(x=paid)) + 
  ggtitle("Paid") + 
  xlab("Extra Classe Paga") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

# Mostra variáveis do terceiro grupos
grid.arrange(p9, p10, p11, p12, ncol=2)


p13 <- ggplot(df, aes(x=activities)) + 
  ggtitle("Activities") + 
  xlab("Atividades") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p14 <- ggplot(df, aes(x=nursery)) + 
  ggtitle("Nursery") + 
  xlab("Fez Berçário") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p15 <- ggplot(df, aes(x=higher)) + 
  ggtitle("Higher") + 
  xlab("Pretende Superior") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p16 <- ggplot(df, aes(x=internet)) + 
  ggtitle("Internet") + 
  xlab("Internet") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

# Variáveis do quarto grupo
grid.arrange(p13, p14, p15, p16, ncol=2)

p17 <- ggplot(df, aes(x=romantic)) + 
  ggtitle("Romantic") + 
  xlab("Em Relacionamento") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

p18 <- ggplot(df, aes(x=absencesLow)) + 
  ggtitle("Absences Low") + 
  xlab("Baixa Falta") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + 
  ylab("Percentual") + 
  coord_flip() + 
  theme_minimal()

# Variáveis do último grupo
grid.arrange(p17, p18, ncol=2)


library(caret)

# Modelo 1 ------------------------------

df <- df0

df$NotaFinal <- df$G3
df$G3 <- NULL

str(df)

aplica_lm(df$NotaFinal, NotaFinal ~ ., df)

# Modelo 2: Altera o tipo do resultado ---------
df2 <- df0

df2$NotaFinal <- sapply(df2$G3, Nota2)
df2$G3 <- NULL


aplica_lm(df2$NotaFinal, NotaFinal ~ ., df2)

# Modelo 3: Elevar Idade ao Quadrado no Modelo 2----------------
df3 <- df2

df3$age2 <- df3$age ^ 2
df3$age <- NULL

aplica_lm(df3$NotaFinal, NotaFinal ~ ., df3)

# Modelo 4: Remover os itens mais pertos de 1 --------------
df4 <- df3

df4$age2 <- NULL
df4$school <- NULL
df4$address <- NULL
df$guardian <- NULL
df$sex <- NULL

aplica_lm(df4$NotaFinal, NotaFinal ~ ., df4)

# Modelo5: Tranformar M3 em factor -----------
df5 <- df3

# 7 Medu       - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
df5$MeduF <- factor(df5$Medu, 
                  levels = c(0, 1, 2, 3, 4), 
                  labels = c("None", "Basico", "Primario", "Medio", "Superior"))
df5$Medu <- NULL

# 13 traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
df5$traveltimeF <- factor(df5$traveltime,
                         levels = c(1, 2, 3, 4),
                         labels = c("~15m", "~30m", "~60m", ">60m")
                         )

df5$traveltime <- NULL

# 14 studytime  - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
df5$studytimeF <- factor(df5$studytime,
                       levels = c(1,2,3,4),
                       labels = c("0~2h", "2~5h", "5~10h", ">10h")
                       )
df5$studytime <- NULL

# 15 failures   - number of past class failures (numeric: n if 1<=n<3, else 4)
df5$failuresF <- factor(df5$failures,
                       levels = c(0, 1, 2, 3),
                       labels = c("0","1","2","3")
                      )

df5$failures <- NULL

# 24 famrel     - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
df5$famrelF <- factor(df5$famrel,
                       levels = c(1, 2, 3, 4, 5),
                       labels = c("Péssimo", "Razoável", "Bom", "Ótimo", "Excelente")
                     )
df5$famrel <- NULL

# 25 freetime   - free time after school (numeric: from 1 - very low to 5 - very high)
df5$freetimeF <- factor(df5$freetime,
                       levels = c(1, 2, 3, 4, 5),
                       labels = c("Muito Pouco", "Pouco", "Médio", "Alto", "Muito Alto")
                       )

df5$freetime <-  NULL

# 26 goout      - going out with friends (numeric: from 1 - very low to 5 - very high)
df5$gooutF <- factor(df5$goout,
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("Muito Pouco", "Pouco", "Médio", "Alto", "Muito Alto")
                   )

df5$goout <- NULL

# 29 health     - current health status (numeric: from 1 - very bad to 5 - very good)
df5$healthF <- factor(df5$health,
                    levels = c(1, 2, 3, 4, 5),
                    labels = c("Muito Ruim", "Ruim", "Médio", "Bom", "Muito Bom")
)

df5$health <- NULL

str(df5)

aplica_lm(df5$NotaFinal, NotaFinal ~ ., df5)


# Modelo 6 -----------------------
df6 <- df0

str(df6)

df6$NotaFinal <- df6$G3 ^ 2
df6$G3 <- NULL

# Alteração do Modelo 3
df6$age2 <- df6$age ^ 2
df6$age <- NULL

# Alteração do Modelo 5

# 7 Medu       - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
df6$MeduF <- factor(df6$Medu, 
                    levels = c(0, 1, 2, 3, 4), 
                    labels = c("None", "Basico", "Primario", "Medio", "Superior"))
df6$Medu <- NULL

# 13 traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
df6$traveltimeF <- factor(df6$traveltime,
                          levels = c(1, 2, 3, 4),
                          labels = c("~15m", "~30m", "~60m", ">60m")
)

df6$traveltime <- NULL

# 14 studytime  - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
df6$studytimeF <- factor(df6$studytime,
                         levels = c(1,2,3,4),
                         labels = c("0~2h", "2~5h", "5~10h", ">10h")
)
df6$studytime <- NULL

# 15 failures   - number of past class failures (numeric: n if 1<=n<3, else 4)
df6$failuresF <- factor(df6$failures,
                        levels = c(0, 1, 2, 3),
                        labels = c("0","1","2","3")
)

df6$failures <- NULL

# 24 famrel     - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
df6$famrelF <- factor(df6$famrel,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("Péssimo", "Razoável", "Bom", "Ótimo", "Excelente")
)
df6$famrel <- NULL

# 25 freetime   - free time after school (numeric: from 1 - very low to 5 - very high)
df6$freetimeF <- factor(df6$freetime,
                        levels = c(1, 2, 3, 4, 5),
                        labels = c("Muito Pouco", "Pouco", "Médio", "Alto", "Muito Alto")
)

df6$freetime <-  NULL

# 26 goout      - going out with friends (numeric: from 1 - very low to 5 - very high)
df6$gooutF <- factor(df6$goout,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("Muito Pouco", "Pouco", "Médio", "Alto", "Muito Alto")
)

df6$goout <- NULL

# 29 health     - current health status (numeric: from 1 - very bad to 5 - very good)
df6$healthF <- factor(df6$health,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("Muito Ruim", "Ruim", "Médio", "Bom", "Muito Bom")
)

df6$health <- NULL


aplica_lm(vetor_saida = df6$NotaFinal, formula = NotaFinal ~ ., dtf = df6)

# Modelo 07 --------------- 
ol <- function(dtf, fld){
  o <- boxplot(fld, plot = F)$out
  if (length(o) > 0){
    dtf[-which(fld %in% o),]
  }else{
    dtf
  }
}


df7 <- df0

# Remover os outliers
dim(df7)

for (n in names(df7)) {
  if (is.integer(df7[[n]]) ){  
    df7 <- ol(df7, df7[[n]])
  }
}

dim(df7)

# aplica-se as correções do modelo 6
df7$NotaFinal <- df7$G3 ^ 2
df7$G3 <- NULL

# Alteração do Modelo 3
df7$age2 <- df7$age ^ 2
df7$age <- NULL

# Alteração do Modelo 5

# 7 Medu       - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
df7$MeduF <- factor(df7$Medu, 
                    levels = c(0, 1, 2, 3, 4), 
                    labels = c("None", "Basico", "Primario", "Medio", "Superior"))
df7$Medu <- NULL

# 13 traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
df7$traveltimeF <- factor(df7$traveltime,
                          levels = c(1, 2, 3, 4),
                          labels = c("~15m", "~30m", "~60m", ">60m")
)

df7$traveltime <- NULL

# 14 studytime  - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
df7$studytimeF <- factor(df7$studytime,
                         levels = c(1,2,3,4),
                         labels = c("0~2h", "2~5h", "5~10h", ">10h")
)
df7$studytime <- NULL

# 15 failures   - number of past class failures (numeric: n if 1<=n<3, else 4)
# Após limpeza, apenas valores 0' ficaram
df7$failures <- NULL

# 24 famrel     - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
df7$famrelF <- factor(df7$famrel,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("Péssimo", "Razoável", "Bom", "Ótimo", "Excelente")
)
df7$famrel <- NULL

# 25 freetime   - free time after school (numeric: from 1 - very low to 5 - very high)
df7$freetimeF <- factor(df7$freetime,
                        levels = c(1, 2, 3, 4, 5),
                        labels = c("Muito Pouco", "Pouco", "Médio", "Alto", "Muito Alto")
)

df7$freetime <-  NULL

# 26 goout      - going out with friends (numeric: from 1 - very low to 5 - very high)
df7$gooutF <- factor(df7$goout,
                     levels = c(1, 2, 3, 4, 5),
                     labels = c("Muito Pouco", "Pouco", "Médio", "Alto", "Muito Alto")
)

df7$goout <- NULL

# 29 health     - current health status (numeric: from 1 - very bad to 5 - very good)
df7$healthF <- factor(df7$health,
                      levels = c(1, 2, 3, 4, 5),
                      labels = c("Muito Ruim", "Ruim", "Médio", "Bom", "Muito Bom")
)

df7$health <- NULL


aplica_lm(vetor_saida = df7$NotaFinal, 
          formula = NotaFinal ~ .
          , dtf = df7)

# Respsta DSA -------------------------
library(caTools)

# Criando as amostras de forma randômica
set.seed(101)
?sample.split

# cria um índice na variável age
amostras <- sample.split(df$age, SplitRatio = 0.70)

# *** Treinamos nosso modelo nos dados de treino ***
# *** Faze,ps as perdições nos dados de teste ***

# Criando dados de treino - 70% dos dados
treino <- subset(df, amostras == T)

# Criando dados de teste - 30 % dos dados
teste <- subset(df, amostras == F)

# Gerando o modelo (Usando todos os atributos)
modelo_v1 <- lm(G3 ~., treino)
modelo_v2 <- lm(G3 ~ G2 + G1, treino)
modelo_v3 <- lm(G3 ~ absences, treino)
modelo_v4 <- lm(G3 ~ Medu, treino)
modelo_v5 <- lm(G3 ~ absences + famrel, treino)

# interpretando o modelo
summary(modelo_v1)
summary(modelo_v2)
summary(modelo_v3)
summary(modelo_v4)
summary(modelo_v5)

# - - - - - - - - - 
# Histograma dos resíduos
# obtendo os resíduos
res <- residuals(modelo_v1)

# converte o objeto para um dataframe
res <- as.data.frame(res)
head(res)

# histograma dos resíduos
ggplot(res,
       aes(res)) +
  geom_histogram(fill='blue',
                 alpha=0.5,
                 binwidth = 1
                 )

# plot do modelo
plot(modelo_v1)

# Fazendo as predições
modelo_v1 <- lm(G3 ~ ., treino)
prevendo_G3 <- predict(modelo_v1, teste)

prevendo_G3

# Visualizando valores previstos e observados
resultados <- cbind(prevendo_G3, teste$G3)
colnames(resultados) <- c('Previsto', 'Real')
resultados <- as.data.frame(resultados)
resultados

min(resultados)

# Tratando os valores negativos
trata_zero <- function(x){
  if (x < 0){
    return(0)
  }else{
    return(x)
  }
}

# aplicando a função para tratar valores negativos em nossa previsão
resultados$Previsto <- sapply(resultados$Previsto, trata_zero)
resultados


# Calculando o erro médio
# Quão distantes seus valores previstos estão dos valores observados
# MSE-
mse <- mean((resultados$Real - resultados$Previsto) ^ 2)
print(mse)

# RMSE
rmse <- mse ^ 0.5
rmse

# Calculando o R Squared
SSE <- sum((resultados$Previsto - resultados$Real) ^ 2)
SST <- sum((mean(df$G3) - resultados$Real) ^ 2)

# R - Squared
# Ajuda a avaliar o nível de precisão do nosso modelo.
# Quanto maior, melhor,
R2 <- 1 - (SSE / SST)
R2
