# Informaçõe iniciais da base carregada, antes de "ajustes"

info_bd <- function(df){
  # mostrar as dimensões
  cat('Dimensões:\n')
  print(dim(df))
  
  
  # mostrar a estrura
  cat('\nEstrutura:\n' )
  print(str(df))
       
  
  # mostrar os 5 primeiros registros
  cat('\nPrimeiros 5 registros:\n')
  print(head(df, 5))
  
  # verificar se tem registros nulos
  cat('\nTotal Registros Nulos:\n')
  print(sum(is.na(df)))
}
