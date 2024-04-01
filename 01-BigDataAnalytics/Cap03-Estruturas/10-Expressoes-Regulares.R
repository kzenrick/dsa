setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap03-Estruturas")
getwd()

# Busca os pacotes carregados
str <-c("Expressões", "regulares em", "linguagem R",
        "permitem a busca de padrões", "e exploração de textos",
        "podemos buscar padrões em dígitos",
        "como por exemplo",
        "10992451280"
        )

length(str)
str

library("stringr")
str_length(str)

# grep
?grep
grep("ex",str,value = F)
grep("ex",str,value = T)
grep("\\d", str, value = F)
grep("\\d", str, value = T)

# grepl
?grepl
grepl("\\d+", str)
grepl("\\D", str)

# gsub
?gsub
gsub("em", "***", str)
gsub("ex", "EX", str, ignore.case = T)
str

# sub()
sub("em", "EM", str)

# regexpr()
frase <- "Isso é uma string"
regexpr(pattern = "u", frase)
regexpr(pattern = "s", frase)

#gregexpr
gregexpr(pattern = "u", frase)

str2 <- c("2678 é maior que 45 - @???!$#",
          "Vamos escrever 14 scripts R")

str2

# gsub
gsub("\\d", "", str2)
gsub("\\D", "", str2)

gsub("\\s", "", str2)
gsub("[iot]", "Q", str2)
gsub("[[:punct:]]", "", str2)
