setwd("~/Documentos/dsa/BigDataAnalytics/Cap07-ManipulacaoDados")
getwd()

library(plyr)
#install.packages('gapminder')
library(gapminder)
# www.gapminder.org

?gapminder

# Split - Apply - Combine
?ddply
head(gapminder)
df <- ddply(gapminder,
            ~ continent,
            summarize,
            max_le = max(lifeExp))
str(df)
head(df)
View(df)
levels(df$continent)

# Split-Apply-Combine
ddply(gapminder,
      ~continent,
      summarize,
      n_uniq_countries = length(unique(country)))

# Utilizando funções do usuário
ddply(gapminder,
      ~ continent,
      function(x) c(n_uniq_countries = length(unique(x$country))))

# Vários retornos
ddply(gapminder,
      ~ continent,
      summarize,
      min = min(lifeExp),
      max = max(lifeExp),
      median = median(gdpPercap))


# Usando um dataset do ggplot
library(ggplot2)
data(mpg)
str(mpg)
?mpg

# Trabalhando com um subset do dataset
data <- mpg[,c(1, 7:9)]
data
str(data)

# Summarizando e agregando dados
ddply(data,
      .(manufacturer),
      summarize,
      avgcty = mean(cty))

# Várias funções em uma única chamada
ddply(data,
      .(manufacturer),
      summarize,
      avgcty = mean(cty),
      sdcty = sd(cty),
      maxhwy = max(hwy))

# Summarizando os dados pela combinação de variáveis/fatores
ddply(data,
      .(manufacturer, drv),
      summarize,
      avgcty = mean(cty),
      sdcty = sd(cty),
      maxhwy = max(hwy))
