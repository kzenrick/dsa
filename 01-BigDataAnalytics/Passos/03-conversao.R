# Algumas funções de conversão estão :
# ~/Documentos/dsa/BigDataAnalytics/Cap13-DataMunging/Tools.R
# 

# Conversão de Data
converte_str_data <- function(str){
  as.POSIXct('str')
}

# Conversão para factor
converte_factor <- function(inVec, lista){
  outVec <- as.factor(inVec)
  levels(outVec) <- lista
  outVec
}

# Mostrar informações de fatores
# Mais informações de fatores, Cap03-Estruturas/03-Fatores.R
mostre_info_fatores <- function(campo){
  if (!is.factor(campo)){
    print("não é um fator válido")
  } else{
    cat('Níveis:', levels(campo))
    cat('\nOrdenado:', is.ordered(campo))
    cat('\nResumo:', summary(campo))
  }
}
