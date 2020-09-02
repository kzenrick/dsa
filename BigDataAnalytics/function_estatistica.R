source('function_gera_cor.R')

moda = function(dados) {
  vetor = table(as.vector(dados))
  names(vetor)[vetor == max(vetor)]
}

estatisticas <- function(variavel){
  
  cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
            'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')
  
  result = 'Estatisticas'
  ## Tendencia Central
  # Media
  media = mean(variavel)
  result = paste(result, "\n", 'Media = ', media)
 
  # Mediana
  mediana = median(variavel)
  result = paste(result, "\n", 'Mediana = ', mediana)
  
  # Moda
  moda_str = '['
  for (m in moda(variavel)){
    moda_str = paste(moda_str, m, ' ')
  }
  moda_str = paste(moda_str, ']')
  result = paste(result, "\n", 'Moda = ', moda_str)
  
  # Max e Min
  result = paste(result, "\n", 'MinMax = [', min(variavel), max(variavel), ']')
  
  # Amplitude
  result = paste(result, "\n", 'Amplitude = ', diff(range(variavel)))
  
  ## Medidas de Dispersão Relativas
  # Quartis
  qnt = ''
  for (i in c(1:5)){
    qnt = paste(qnt,
                '{',
                names(quantile(variavel))[i],
                ' = ',
                quantile(variavel)[i],
                '}'
                )
  }
  result = paste(result, "\n", 'Quartis = ', qnt)
  
  ## Dispersão
  # Desvio Padrão = grau de dispesão [Menor melhor]
  desvio = sd(variavel)
  result = paste(result, "\n", 'Desvio = ', desvio)

  # Variância = variabilidade do conjunto
  result = paste(result, "\n", 'Variancia = ', var(variavel))

  # CV = (desvio/media) * 100 = consistência dos dados qto maior o CV, menor a consistência
  result = paste(result, "\n", 'Coef. Variação = ', (desvio/media) * 100)
  
  # Coeficiente de Assimetria -> valor próximo a 0 = dados simétricos -> cauda do hsitograma
  result = paste(result, "\n", 'Coef. Assimetria = ' , moments::skewness(variavel))
  
  # Curtose -> distribuição dos dados -> achatamento do histograma
  result = paste(result, "\n", 'Curtose = ', moments::kurtosis(variavel))
  
  cat(result)
 
  par(mfrow = c(2,1))
  hist(variavel,
       col = cores)
  
  plotrix::ablineclip(v=mediana, lty=3, col="grey1", lwd = 1)
  
  boxplot(variavel,
          col = 'seagreen')

}


fat <- function(i){ 
  result <- i; 
  if (i > 1) { 
    result <- i * fat(i-1); 
  } 
  result;
}


# n_loto <- 100
# s_loto <- 5
# 
# loto <- fat(n_loto)/(fat(s_loto) * fat(n_loto-s_loto))
# 
# # ---
# n_dup <- 50
# s_dup <- 6
# 
# dup <- fat(n_dup)/(fat(s_dup) * fat(n_dup-s_dup))
# 
# # ---
# n_mega <- 60
# s_mega <- 6
# 
# mega <- fat(n_mega)/(fat(s_mega) * fat(n_mega-s_mega))
# 
# # ---
# print(paste('loto/mega', 1/(loto/mega)))
# print(paste('dupla/mega', mega/dup))
# print(paste('loto/dupla' ,(loto/dup)))
# 
# loto / dup
