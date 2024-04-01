
# Função abrir texto
abrir_txt_f <- function(arquivo){
  library(data.table)

  #system.time(dados <- fread("creditcard.csv", stringsAsFactors = F, sep = ",", header =T)
  system.time(df <- fread(arquivo))
  #   usuário   sistema   decorrido 
  #     5,787     0,379      24,241 
  #     2,399     0,052       1,250 
  
  return(df) # 459.7 MB
}

abrir_csv <- function(arquivo){
  # parametros para a leitura
  df <- read.csv("arquivo",
                 sep = ",",
                 header = T,
                 stringsAsFactors = F)
  
  return (df)
}

demais_abrir_csv <- function(arquivo){
  # Carrega o pacote readr
  library(readr)
  system.time(df <- read_csv(arquivo))
  #usuário   sistema  decorrido 
  #  8,091     0,269      8,230 
  #  8,829     0,340      9,010 
  rm(df) # 459.5 MB
  
  # Biblioteca readr
  system.time(df <- read_csv2(arquivo))
  # usuário   sistema   decorrido 
  #   6,539     0,187       6,727 
  #   6,389     0,124       6,462 
  rm(df) # 1.1 Gb
  
  # biblioteca readr
  system.time(df <- read.table(arquivo))
  #  usuário   sistema  decorrido 
  #  192,039     0,304    192,311 
  #  156,248     0,454    156,759 
  rm(df) # 1.1 Gb
  
  # Biblioteca utils
  system.time(df <- read.csv(arquivo))
  # usuário   sistema   decorrido 
  #  20,086     1,852      23,794 
  #  15,653     0,087      15,731 
  rm(df) # 295.8 MB
  
  system.time(df <- read.csv2(arquivo))
  #  usuário   sistema    decorrido 
  #  201,572     0,953      204,547
  #  209,153     1,086      210,552 
  rm(df) # 1.2 GB
}