# Primeiro script R
# teste de utilização de acentuação

# Configuração da pasta de trabalho
# Não utilizar espaço no nome do diretório
setwd("~/Documentos/dsa/BigDataAnalytics/Cap02-Fundamentos")

# Nome dos contribuidores
contributors()
# Licença
license()

# Informação sobre a sessão
sessionInfo()

# Imprimir algo na tela
print('Olá mundo, iniciando na caminhada para mudança de rumo')

# Criar gráficos
plot(1:25)

# Instalar pacotes
install.packages('randomForest')
install.packages('ggplot2')
install.packages('dplyr')
install.packages('devtools')

# Carregar o pacote
library('ggplot2')
library("caret", lib.loc="~/anaconda3/envs/dsa/lib/R/library")

# Descarregar o pacote
detach('ggplot2')
detach("package:caret", unload = TRUE)


# ajudar, se souber o nome da função
help(mean)
?mean

# Para mais informações, use o SOS
install.packages('sos')
library('sos', lib.loc = "~/anaconda3/envs/dsa/lib/R/library")
findFn("fread")

# Se não souber o nome da função
help.search('randomForest')
help.search("matplot")
??matplot

RSiteSearch('matplot')
example("matplot")

# sair
q()
