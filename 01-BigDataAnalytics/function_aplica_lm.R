library (caret)

aplica_lm <- function(vetor_saida, formula, dtf){
  
  # Dividimos os dados em conjuntos de treinamento e testes
  # Informo 70% para treinamento
  intrain <- createDataPartition(dtf$NotaFinal, # Vetor de saída
                                 p = 0.7, # Percentagem dos dados que serão treinados
                                 list = F # Se Retorno deve ser uma lista
  )
  # Reproduzir o mesmo resultado
  set.seed(2017)
  training <- dtf[intrain,]
  testing <- dtf[-intrain,]
  
  # Confirma se a divisão está correta
  dim(training); dim(testing)
  
  
  modelo <- lm(formula, data = training)
  previsao <- predict(modelo)
  
  summary(modelo)
}
