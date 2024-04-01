source('function_gera_cor.R')

library(stringr)

# ------------------------------------------------------------------
# ENCONTRA A MODA
# ------------------------------------------------------------------
moda = function(dados) {
  vetor = table(as.vector(dados))
  names(vetor)[vetor == max(vetor)]
}

# ------------------------------------------------------------------
# PADRONIZA NOME
# ------------------------------------------------------------------
padroniza_str <- function(texto, tamanho = 18){
  paste(
    str_pad(texto, tamanho, "right", '.'),
    ': '
    )
}

# ------------------------------------------------------------------
# ESTATISTICA
# ------------------------------------------------------------------
estatisticas <- function(variavel, nome_variavel = '', precisao = 3){
  if (nome_variavel == ''){
    nome_variavel = typeof(variavel)
  }
  
  cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
            'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')
  
  result = 'Estatisticas'
  
  # ------------------------------------------------------------------------------------------------
  ## Tendencia Central
  result = paste(result, '\n\n\r- Tendência Central -')
  
  # Media
  media = mean(variavel)
  result = paste(result, "\n", padroniza_str('Media'), round(media, precisao))
 
  # Mediana
  mediana = median(variavel)
  result = paste(result, "\n", padroniza_str('Mediana'), round(mediana, precisao))
  
  # Relação Média/Mediana
  result = paste(result, "\n", padroniza_str('Media/Mediana'), round(media/mediana, precisao))
  
  # Moda
  moda_str = '['
  for (m in moda(variavel)){
    moda_str = paste(moda_str, m, ' ')
  }
  moda_str = paste(str_trim(moda_str), ']')
  result = paste(result, "\n", padroniza_str('Moda'), moda_str)
  
  # Max e Min
  result = paste(result, "\n", padroniza_str('MinMax'), '[', min(variavel), ':' , max(variavel), ']')
   
  # Amplitude
  amplitude <- diff(range(variavel))
  result = paste(result, "\n", padroniza_str('Amplitude'), amplitude)
  
  # Verificar campos NA
  total_na <- sum(is.na(variavel))
  result = paste(result, "\n", padroniza_str('Total NA'), total_na)
  
  # Perc campos NA
  perc_na <- total_na / length(variavel)
  result = paste(result, "\n", padroniza_str('Perc. NA'), perc_na * 100, '%')
  
  # Valores únicos
  total_un <- length(unique(variavel))
  result = paste(result, "\n", padroniza_str('Total Unicos'), total_un)
  
  # Percentagem de valores únicos
  perc_un <- total_un / length(variavel)
  result = paste(result, "\n", padroniza_str('Perc. Unicos'), perc_un * 100, '%')
  
  # ------------------------------------------------------------------------------------------------
  ## Medidas de Dispersão Relativas
  result = paste(result, '\n\n\r- Medidas de Dispersão Relativas -')
  # Quartis 1/5
  qnt = ''
  qtl <- quantile(variavel, probs = seq(from = 0, to = 1, by = 1/5))
  for (i in seq(1, length(qtl))){
    qnt = paste(qnt,
                '{',
                names(qtl)[i],
                ' = ',
                qtl[i],
                '}'
    )
  }
  
  result = paste(result, "\n", padroniza_str('Quartis 1/5'), str_trim(qnt))
  
  # Quartis
  qnt = ''
  qtl <- quantile(variavel)
  for (i in c(1:5)){
    qnt = paste(qnt,
                '{',
                names(qtl)[i],
                ' = ',
                qtl[i],
                '}'
                )
  }
  result = paste(result, "\n", padroniza_str('Quartis default'), str_trim(qnt))
  
  # intervalo interquartil ( IQR )
  qnt = '['
  qnt = paste(qnt, 'Min-Q1 =', qtl[2] - qtl[1], '|')
  qnt = paste(qnt, 'Q1-Q3 =', IQR(variavel), '|')
  #qnt = paste(qnt, 'Q2-M-Q4 =', qtl[3]-qtl[2], '|')
  qnt = paste(qnt, 'Q3-Max =', qtl[5] - qtl[4], ']')
  result = paste(result, "\n", padroniza_str('TnterQuartil (IQR)'), qnt)
  
  minOutlier <- qtl[2] - 1.5 * IQR(qtl)
  maxOutilier <- qtl[4] + 1.5 * IQR(qtl)
  qnt = '['
  qnt = paste(qnt, '<', minOutlier, '||')
  qnt = paste(qnt, '>', maxOutilier, ']')
  
  result = paste(result, "\n", padroniza_str('Outlier'), qnt)
  
  #result = paste(result, "\n", padroniza_str('TnterQuartil (IQR)'), round(IQR(variavel), precisao))
  
  # ------------------------------------------------------------------------------------------------
  ## Medidas de Dispersão Relativas
  result = paste(result, '\n\n\r- Medidas de Dispersão Relativas -')
  # Desvio Padrão = grau de dispesão [Menor melhor]
  desvio = sd(variavel)
  result = paste(result, "\n\r", padroniza_str('Desvio'), round(desvio, precisao))
  result = paste(result, '-', 'grau de dispesão - difere da média [Menor melhor]')

  # Variância = variabilidade do conjunto
  result = paste(result, "\n", padroniza_str('Variancia'), round(var(variavel), precisao))
  result = paste(result, '-', 'variabilidade do cnjto -> Maior mais espalhado em torno da média')

  # CV = (desvio/media) * 100 = consistência dos dados qto maior o CV, menor a consistência
  result = paste(result, "\n", padroniza_str('Coef. Variação'), round((desvio/media) * 100, precisao))
  result = paste(result, '-', 'consistência dos dados qto maior o CV, menor a consistência')
  
  # Coeficiente de Assimetria -> valor próximo a 0 = dados simétricos -> cauda do histograma
  # Ele fala sobre a posição da maioria dos valores de dados na distribuição em torno do valor médio.
  result = paste(result, "\n", padroniza_str('Coef. Assimetria') , round(moments::skewness(variavel), precisao))
  result = paste(result, '-', '< 0: - [cauda E]  | ~ 0 : Dados Simétricos | > 1 + [cauda D]')
  
  # Curtose -> distribuição dos dados -> achatamento do histograma
  # Curtose é um método numérico em estatística que mede a nitidez do pico na distribuição de dados.
  result = paste(result, "\n", padroniza_str('Curtose'), round(moments::kurtosis(variavel), precisao))
  result = paste(result, '-', '< 3: | ~ 3: DN | > 3: Pico Acentuado')
  cat(result, "\n\n")
 
  # -------------------------------------------------------------------------------------------------
  # - Graficos
  
  par(mfrow = c(2,1))
  
  cor_box = c("magenta", "blue", "tomato2", "green", "khaki")
  line_type = c(1, 3, 2, 2)
  
  hist(variavel,
       col = cores,
       labels = T,
       main = paste('Histograma da variável:', nome_variavel),
       breaks = max(5, amplitude)
  )
  

  plotrix::ablineclip(v=media, 
                      lty=line_type[1], 
                      col=cor_box[1], 
                      lwd = 1)
  
  plotrix::ablineclip(v=mediana, 
                      lty=line_type[2], 
                      col=cor_box[2], 
                      lwd = 1)
  
  
  plotrix::ablineclip(v=minOutlier, 
                      lty=line_type[3], 
                      col=cor_box[3], 
                      lwd = 1)
  
  plotrix::ablineclip(v=maxOutilier, 
                      lty=line_type[4], 
                      col=cor_box[4], 
                      lwd = 1)
  
  boxplot(variavel,
          col = 'seagreen')
  
  
  plotrix::ablineclip(h=media, 
                      lty=line_type[1], 
                      col=cor_box[1], 
                      lwd = 1)
  
  plotrix::ablineclip(h=mediana, 
                      lty=line_type[2], 
                      col=cor_box[2], 
                      lwd = 1)
  
  plotrix::ablineclip(h=minOutlier, 
                      lty=line_type[3], 
                      col=cor_box[3], 
                      lwd = 1)
  
  plotrix::ablineclip(h=maxOutilier, 
                      lty=line_type[4], 
                      col=cor_box[4], 
                      lwd = 1)
  
  legend("topleft",
         legend = c(paste(padroniza_str('Media', 9), round(media, 2)) , 
                    paste(padroniza_str('Mediana', 8), round(mediana, 2)),
                    paste(padroniza_str('min O.L', 8), round(minOutlier, 2)),
                    paste(padroniza_str('max O.L', 8), round(maxOutilier, 2))
                    ),
         col = cor_box,
         lty = line_type,
         cex = 0.8,
         pch=18,
         bg = 'lightyellow')
  
  # Volta para o padrão 1x1
  par(mfrow = c(1,1))

}

# ------------------------------------------------------------------
# Mostra os gráficos numéricos
# ------------------------------------------------------------------
show_dados_numericos <- function(df){
  a = F
  for (n in names(df)) {
    if (is.integer(df[[n]]) || is.numeric(df[[n]])) {  
      cat('- - - - - -\t', n, '\t- - - - - -\n')
      estatisticas(df[[n]], n)
      cat("\n")
      
      if (!a)  {
        letra = readline("Qualquer tecla para mostrar próximo ou 'a' para pular todos: ")
        a = toupper(letra) == toupper("a")
      }
    }
  }
}

# ------------------------------------------------------------------
# GRÁFICOS RELACIONAMENTOS
# ------------------------------------------------------------------
relacionamento <- function(variavel, dependente, titulo, label_variavel, label_dependente){
  
  plot(x = variavel,
       y = dependente,
       main = titulo,
       xlab = label_variavel,
       ylab = label_dependente
  )
}

# ------------------------------------------------------------------
# GRÁFICOS CORRELACIONA
# ------------------------------------------------------------------
show_correlacao <- function(df){
  library(corrplot)
  numeric.var <- sapply(df, is.numeric)
  corr.matrix <- cor(df[, numeric.var])
  
    
  corrplot(corr.matrix, 
           main = "Correlação numérica",
           method = "number", 
           type = "upper")
  
  
  library(psych)
  pairs.panels(df[, numeric.var], scale = T)
}


# ------------------------------------------------------------------
# CATEGÓRICAS
# ------------------------------------------------------------------
categoricas <- function(variavel, nome_variavel = '', precisao = 4){
  if (nome_variavel == ''){
    nome_variavel = typeof(variavel)
  }
  
  cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
            'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')
  
  cat('Categóricas\n\n')
  
  cat('table(', nome_variavel, '):')
  a <- table(variavel, useNA = "ifany")
  print(a)
  
  cat('\n\r', 'prop.table(',  nome_variavel, '):')
  print(round(prop.table(a), precisao) * 100)
  
  barplot(round(prop.table(a), precisao) * 100)
}


# ------------------------------------------------------------------
# Mostra os dados Categóricos
# ------------------------------------------------------------------
show_dados_categoricos <- function(df){
  a = F
  for (n in names(df)) {
    if (is.factor(df[[n]])) {
      cat('- - - - - -\t', n, '\t- - - - - -\n')
      categoricas(df[[n]], n)
      cat("\n")
      
      if (!a)  {
        letra = readline("Qualquer tecla para mostrar próximo ou 'a' para pular todos: ")
        a = toupper(letra) == toupper("a")
      }
    }
  }
}


# ------------------------------------------------------------------
# Mostra Todos os tipos de dados
# ------------------------------------------------------------------
show_info_dados <- function(df){
  show_dados_numericos(df)
  show_dados_categoricos(df)
}


# ------------------------------------------------------------------
# Função de normalização
# ------------------------------------------------------------------
normalize <- function(x){
  return((x - min(x)) / (max(x) - min(x)))
}

# ------------------------------------------------------------------
# Função de normalização usada na DSA
# ------------------------------------------------------------------
normalizeDSA <- function(df){
  maxs <- apply(df, 2, max)
  mins <- apply(df, 2, min)
  
  return (
    as.data.frame(
      scale(
        df,
        center = mins,
        scale = maxs - mins
        )
      )
    )
}



# ------------------------------------------------------------------
# Função para remoção de Outliers
# ------------------------------------------------------------------
remover_ol <- function(dtf, fld){
  o <- boxplot(fld, plot = F)$out
  if (length(o) > 0){
    dtf[-which(fld %in% o),]
  }else{
    dtf
  }
}

