# https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset

setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap14-Regressao")
getwd()

# Variável de controle de execução do script
Azure <- F

source('src/Tools.R')
if (Azure) {
  # source('src/Tools.R')
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
} else {
  # source('src/Tools.R')
  bikes <- bikes
}

head(bikes, 5)


# Definindo as colunas para a análise de correlação
cols <- c('mnth', 'hr', 'holiday', 'workingday', 
          'weathersit', 'temp', 'hum', 'windspeed',
          'isWorking', 'monthCount', 'dayWeek', 
          'workTime', 'xformHr', 'cnt')

# Métodos de Correlação
# Pearson - coeficiente usado para medir o grau de relacionamento entre duas variáveis com relação linear
# Spearman - teste não paramétrico, para medir o grau de relacionamento entre duas variaveis
# kendall - teste não paramétrico, para medir a força de dependẽncia entre duas variaveis

# Vetor com os métodos de correlação
metodos <- c('pearson', 'spearman')

# aplicando os métodos de correlação com a função cor()
cors <- lapply(metodos, function(method)
  (cor(bikes[,cols], method = method)))

head(cors)

# preparando o plot
require(lattice)
plot.cors <- function(x, labs){
  diag(x) <- 0.0
  plot(levelplot(x,
                 main = paste('Plot de Correlação usando Método', labs),
                 scales = list(x = list(rot = 90), cex = 1.0)) )
}

# Mapa de Correlação
Map(plot.cors, cors, metodos)
