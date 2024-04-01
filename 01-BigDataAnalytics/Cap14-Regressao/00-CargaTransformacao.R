# https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset

setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap14-Regressao")
getwd()

# Variável de controle de execução do script
Azure <- F

# Execução de acordo com o local

source('src/Tools.R')
if (Azure) {
  # source('src/Tools.R')
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
} else {
  # source('src/Tools.R')
  bikes <- read.csv('bikes.csv',
                    sep = ',',
                    header = T,
                    stringsAsFactors = F)
  
  colnames(bikes)
  
  # Selecionar as variáveis que serão utilizadas
  cols <- c('dteday', 'mnth', 'hr', 'holiday', 
            'workingday', 'weathersit', 'temp', 
            'hum', 'windspeed', 'cnt')
  
  # Criando um subset dos dados
  bikes <- bikes[, cols]
  
  colnames(bikes)
  
  # Transformar o objeto de data
  bikes$dteday <- char.toPOSIXct(bikes)
  
  
  # A linha acima gera dois valores NA
  # A linha abaixo corrige
  bikes <- na.omit(bikes)
  
  # Normalizar as variaveis preditoras numericas
  cols <- c('temp', 'hum', 'windspeed')
  bikes[, cols] <- scale(bikes[,cols])
}


# Criar uma nova variável para indicar o dia da semana (workday)
bikes$isWorking <- ifelse(bikes$workingday & !bikes$holiday, 1, 0)

# Adicionar uma coluna com a quantidade de meses, o que vai ajudar a criar o modelo
bikes <- month.count(bikes)

# Criar um fator ordenado para o dia da semana, comecando por segunda-feira
# Neste fator, é convertido para ordenado numerico para ser compativel com os tipos
# de dados
bikes$dayWeek <- as.factor(weekdays(bikes$dteday, abbreviate = T))

head(bikes, 4)
####### ATENÇÃO #######

# Analise o dataframe bikes
# Irá verificar como foi salvo as informações de dia da semana
library(dplyr)

if(bikes %>% filter(dayWeek == 'ter')  %>% summarise(n = n()) > 0){
  dias_semanas = c('seg', 'ter', 'qua', 'qui', 'sex', 'sáb', 'dom')
} else { # if(bikes %>% filter(dayWeek == 'Monday')  %>% summarise(n = n()) > 0)
  dias_semanas = c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')
}

bikes$dayWeek <- as.numeric(ordered(bikes$dayWeek,
                                    levels = dias_semanas))

head(bikes, 4)

# Adiciona uma variável com valores únicos para o horário do dia em dias de semana e dias de fim de semana
# Com isso diferenciamos as horas dos dias de semana, das horas em dias de fim de semana
bikes$workTime <- ifelse(bikes$isWorking, bikes$hr, bikes$hr + 24)

# Transforma os valores de hora na madrugada, quando a demanda por bicicletas é praticamente nula
bikes$xformHr <- ifelse(bikes$hr > 4, bikes$hr - 5, bikes$hr + 19)

# Adiciona uma variável com valores únicos par ao horário do dia para dias da semana e dias de fim de semana
# Considerando horas da madrugada
bikes$xformWorkHr <- ifelse(bikes$isWorking, bikes$xformHr, bikes$xformHr + 24)

# o que fizemos até aqui também é conhecido como Feature Engineering ou Engenharia de atributos

if (Azure) maml.mapOutputPort('bikes')