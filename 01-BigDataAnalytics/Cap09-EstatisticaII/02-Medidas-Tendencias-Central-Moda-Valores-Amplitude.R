setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()


##### Moda #####

# Exemplo: Uma loja de calçados quer saber qual o tamanho mais comprado em um dia de vendas. 
# A partir dos dados coletados a seguir, determine o tamanho mais pedido. 
tamanhos = c(38, 38, 36, 37, 36, 36, 40, 39, 36, 35, 36)
mean(tamanhos)  
median(tamanhos)

moda = function(dados) {
  vetor = table(as.vector(dados))
  names(vetor)[vetor == max(vetor)]
}

moda(tamanhos)

?table

##### Valores Máximo e Mínimo #####

# Exemplo: Quais são os valores máximo e mínimo dos tamanhos de sapatos do item anterior.
tamanhos = c(38, 38, 36, 37, 36, 36, 40, 39, 36, 35, 36)
max(tamanhos)
min(tamanhos)


##### Amplitude #####

# Exemplo: Bob quer aprender a voar com asa delta, e ele quer saber qual a amplitude máxima que um voo pode ter. 
# A partir dos dados de outros praticantes de voo livre, determine qual a amplitude. 
dados = c(28, 31, 45, 58, 22, 33, 42, 68, 24, 37)
range(dados)
diff(range(dados))

# Amplitude dos calçãdos
range(tamanhos)
diff(range(tamanhos))
