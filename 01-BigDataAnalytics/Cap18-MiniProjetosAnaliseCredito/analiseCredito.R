setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")
setwd("~/Documentos/dsa/BigDataAnalytics/Cap18-MiniProjetosAnaliseCredito")

library(data.table)
#system.time(dados <- fread("creditcard.csv", stringsAsFactors = F, sep = ",", header =T)
system.time(df <- fread("credit_dataset.csv"))


# Verificar Correlações
show_info_dados(df)
show_correlacao(df)

# Converter para data frame
df <- as.data.frame(df)

# credit.duration.months
# credit.amount
# age

# Analise feita no livro --------------
source('analiseCredito_00')