setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()


# Exemplo: Imagine que um investidor está decidindo se compra ações da Nike ou Adidas na bolsa de valores. 
# O valor médio da ação de cada empresa e o desvio padrão, são dados a seguir. 
# Qual deve ser a escolha do investidor?

# Nike ==> Valor médio da ação = $55.62 / desvio padrão = $5.10 
# Adidas ==> Valor médio da ação = $24.86 / desvio padrão = $3.60 

# CV = (desvio/media) * 100
CV_Nike   = (5.10/55.62) * 100
CV_Adidas = (3.60/24.86) * 100

print(CV_Nike)
print(CV_Adidas)

# Conclusão

# Um investidor se sentiria mais seguro em adquirir ações da Nike, pois o preço das ações 
# teria uma variação menor, podendo assim evitar perdas e permitindo ao investidor ter 
# um investimento mais seguro.


