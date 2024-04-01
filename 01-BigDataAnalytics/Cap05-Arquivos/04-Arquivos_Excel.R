setwd("~/Documentos/dsa/BigDataAnalytics/Cap05-Arquivos")
getwd()

#install.packages('rJava')
install.packages("XLConnect")
install.packages("xlsx")
#install.packages("readxl")
install.packages("gdata")

# Carregar todos os pacotes de acesso Excel pode dar conflito de namespace e depois
# descarrega para não dar problema

# Setar o arquivo que irá ser usado nos testes
file <- "UrbanPop.xlsx"

library(rJava)
library(readxl)

# Lista as worksheet no arquivo Excel
excel_sheets(file)

# Lendo a planilha do excel
read_excel(file)
head(read_excel(file))
read_excel(file, sheet = "Period2")
read_excel(file, sheet = 3)
read_excel(file, sheet = 4)

# Importando uma worksheet para um data frame
df <- read_excel(file, sheet = 3)
head(df)

# Importando todas as worksheets
df_todas <- lapply(excel_sheets(file), 
                   read_excel,
                   path = file)

df_todas
class(df_todas)

# Descarregar o pacote anterior
detach(package:readxl)
library(XLConnect)

# Usando namespace
arq1 <- XLConnect::loadWorkbook(file)

df1 <- readWorksheet(arq1, sheet = 'Period1', header = T)
df1
class(df1)

# Pacote xlsx
detach(package:XLConnect)
library(xlsx)
?xlsx

?read.xlsx
?read.xlsx2
df2 <- read.xlsx(file, sheetIndex = 1)

# Pacote gdata
detach(package:xlsx)
library(gdata)

arq1 <- xls2csv('planilha1.xlsx',
                sheet = 1,
                na.strings = 'EMPTY')
arq1
read.csv(arq1)
