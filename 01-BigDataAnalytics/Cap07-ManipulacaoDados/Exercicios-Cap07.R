# Solução Lista de Exercícios - Capítulo 7

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap07-ManipulacaoDados")
getwd()

# Uso de bibliotecas --------
library(rvest)
library(stringr)
library(tidyr)
library(dplyr)

# Exercício 1 - Faça a leitura da url abaixo e grave no objeto pagina --------
# http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I
pagina <- read_html("http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I")
pagina

# Exercício 2 - Da página coletada no item anterior, extraia o texto que contenha as tags: --------
# "#detailed-forecast-body b  e .forecast-text" 
d <- html_nodes(pagina, '#detailed-forecast-body b')
str_c(d)

f <- pagina %>%  html_nodes('.forecast-text')
str_c(f)

# RESPOSTA
previsao <- html_nodes(pagina, 'detailed-forecast-body b  , .forecast-text')
str_c(previsao)

# Exercício 3 - Transforme o item anterior em texto --------
records <- vector('list', length = length(d))  

for (i in seq_along(d)){
  day <-xml_contents(d[i]) %>% html_text(trim = T)
  
  forecast <- xml_contents(f[i]) %>% html_text(trim = T)
  
  records[[i]] <- data.frame(day = day,
                             forecast = forecast)
}

head(records)

# RESPOSTA
texto <- html_text(previsao)
paste(texto, collapse = "")

# Exercício 4 - Extraímos a página web abaixo para você. Agora faça a coleta da tag "table" --------
url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)

tbl <- pagina %>% html_nodes('table')

lines <- tbl %>% xml_contents()

# Remover as duas primeiras linhas que são referentes ao título e ao cabeçalho
# tem um exercício abaixo para isso
lines <- lines[(c(-1, -2))]

# Preparar a lista pare receber os dados
records <- vector('list', length = length(lines))  

for (i in seq_along(lines)){
  l <- lines[i] %>% 
    html_text(trim = T) %>% 
    strsplit('\n')
  
  records[[i]] <- data.frame(NO = l[[1]][[1]],
                             DATE = l[[1]][[2]],
                             SITE = l[[1]][[3]],
                             RESULT = l[[1]][[4]])
}
head(records)

# RESPOSTA
tabela <- html_nodes(pagina, 'table')
class(tabela)

# Exercício 5 - Converta o item anterior em um dataframe
df <-bind_rows(records)

# RESPOSTA
tab <- html_table(tabela)[[1]]
class(tab)
head(tab)

# Exercício 6 - Remova as duas primeiras linhas e adicione nomes as colunas
# df <- df[-c(1, 2)] : Removido anteriormente
colnames(df) <- c('Id', 'Data', 'Local' , 'Partida')

# RESPOSTA
tab <- tab[-(1:2),]
names(tab) <- c('number', 'date', 'site', 'result')

# Exercício 7 - Converta de algarismos romanos para números inteiros
df$Id <- as.numeric(as.roman(df$Id))
head(df)

# RESPOSTA
tab$number <- 1:54
tab$Date <- as.Date(tab$date, "%B. %d, Y%")
head(tab)

# Exercício 8 - Divida as colunas em 4 colunas
# Já possui 4 colunas

# RESPOSTA -> Dividir em 2 colunas, vencedores e perdedores
tab <- separate(tab, result, c('vencedor', 'perdedor'), sep = ', ', remove = T)
head(tab)


# Exercício 9 - Inclua mais 2 colunas com o score dos vencedores e perdedores
# Dica: Você deve fazer mais uma divisão nas colunas
# https://stackoverflow.com/questions/952275/regex-group-capture-in-r-with-multiple-capture-groups
rgx <- '(.*[\\w\\s\\-\\..*]*)\\s(.*\\d+.*),\\s(.*[\\w\\s\\-\\.]*.*)\\s(.*\\d+.*)'

f <- function(a){
  b = str_split(a, ' x ')
  v = b[[1]][[1]]
  p = b[[1]][[2]]
  
  return <- as.integer(v) - as.integer(p)
}

df$Campeao <- gsub(rgx, '\\1', df$Partida)
df$ViceCampeao <- gsub(rgx, '\\3', df$Partida)
df$Placar <- gsub(rgx, '\\2 x \\4', df$Partida)
df$Saldo <- sapply(df$Placar, f)

head(df)

# RESPOSTA
pattern <- " \\d+$"
# EXTRAI
tab$pontosVencedor <- as.numeric(str_extract(tab$vencedor, pattern))
tab$pontosPerdedor <- as.numeric(str_extract(tab$perdedor, pattern))
head(tab)

# SUBSTITUI
tab$vencedor <- gsub(pattern, '', tab$vencedor)
tab$perdedor <- gsub(pattern, '', tab$perdedor)
head(tab)

# Exercício 10 - Grave o resultado em um arquivo csv

readr::write_csv(df, 'campeoes.csv')

