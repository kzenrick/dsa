setwd("~/Documentos/dsa/BigDataAnalytics/Cap07-ManipulacaoDados")
getwd()

# Web Crawling - 'rastejar' por uma web page ou site buscando dados
# Web Scraping - 'raspar' os dados de uma web page

# Pacotes R para Web Scraping
# RCurl
# httr
# XML
# rvest

# Pacote rvest - útil para quem não conhece HTML e CSS
library(rvest)

library(stringr)
library(dplyr)
library(lubridate) # tratar datas
library(readr)

# Leitura da web page - Retorna um documento xml
webpage <- read_html("https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html")
webpage

# Extraindo os registros
# Cada elemento na web page acima tem o seguinte formato em html:
# <span class="short-desc"><strong> DATE </strong> LIE <span class="short-truth"><a href="URL"> EXPLANATION </a></span></span>
?html_nodes
results <- webpage %>% html_nodes(".short-desc")
results

# Construindo o dataset
records <- vector('list', length = length(results))  

for(i in seq_along(results)){
  date <- str_c(results[i] %>% 
                  html_nodes("strong") %>% 
                  html_text(trim = T),
                ', 2017'
                )
  
  lie <- str_sub(xml_contents(results[i])[2] %>% 
                   html_text(trim = T),
                 2,
                 -2
                 )
  
  explanation <- str_sub(results[i] %>% 
                           html_nodes('.short-truth') %>% 
                           html_text(trim = T),
                         2,
                         -2
                         )
  
  url <- results[i] %>% 
    html_nodes('a') %>% 
    html_attr('href')
  
  records[[i]] <- data_frame(date = date,
                             lie = lie,
                             explanation = explanation,
                             url = url)
}

# Dataset final
df <- bind_rows(records)
View(df)

# Transformando o campo data para o formato Date em R
df$date <- mdy(df$date)

# Exportando para CSV
write_csv(df, 'mentiras_trump.csv')

# Lendo os dados
df <- read_csv('mentiras_trump.csv')
View(df)
