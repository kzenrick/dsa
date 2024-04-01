# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap15-Classificacao")
getwd()

# Carregar o dataset antes da transformação
df <- read.csv('credito.csv', header = F)
View(df)
str(df)

# apenas para comparar que o AML não utiliza as variáveis como factor, mas como string

# Nome das variáveis
# Nome das variáveis
# CheckingAcctStat, Duration, CreditHistory, Purpose, CreditAmount, SavingsBonds, Employment, InstallmentRatePecnt, SexAndStatus, OtherDetorsGuarantors, PresentResidenceTime, Property, Age, OtherInstallments, Housing, ExistingCreditsAtBank, Job, NumberDependents, Telephone, ForeignWorker, CreditStatus

colnames(df) <-  c('CheckingAcctStat', 'Duration', 'CreditHistory', 'Purpose', 
                   'CreditAmount', 'SavingsBonds', 'Employment', 'InstallmentRatePecnt', 
                   'SexAndStatus', 'OtherDetorsGuarantors', 'PresentResidenceTime', 
                   'Property', 'Age', 'OtherInstallments', 'Housing', 'ExistingCreditsAtBank', 
                   'Job', 'NumberDependents', 'Telephone', 'ForeignWorker', 'CreditStatus')

head(df, 7)

show_info_dados(df)

# Converter as variáveis com muitos valores numéricos únicos para variáveis categóricas
