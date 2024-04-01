setwd("~/Documentos/dsa/BigDataAnalytics/Cap04-Graficos")
getwd()

cores = c("red", "green", "blue", "yellow", "orange", "brown", "cyan", "black", 
          "brown", "gray", "whitesmoke")

# library(plotrix)
# ablineclip(v=4, lty=3, col="paleturquoise4", lwd = 1)

# install.packages('lattice')
library(lattice)

# ScatterPlot com Lattice
xyplot(data = iris,
       groups = Species,
       Sepal.Length ~ Petal.Length)

# BarPlots com dataset Titanic
?Titanic

barchart(Class ~Freq | Sex + Age,
        data = as.data.frame(Titanic),
        groups = Survived,
        stack = T,
        layout = c(4,1),
        auto.key = list(title= "Dados Titanic", columns = 2)
        )

barchart(Class ~Freq | Sex + Age,
         data = as.data.frame(Titanic),
         groups = Survived,
         stack = T,
         layout = c(4,1),
         auto.key = list(title= "Dados Titanic", columns = 2),
         scales = list(x = "free")
)

# Contagem de elementos
PetalLength <- equal.count(iris$Petal.Length, 4)
PetalLength

# ScatterPlots
xyplot(Sepal.Length ~ Sepal.Width | PetalLength, 
       data = iris)

xyplot(Sepal.Length ~ Sepal.Width | PetalLength, 
       data = iris,
       panel = function(...){
         panel.grid(h = -1, v = -1, col.line = "skyblue")
         panel.xyplot(...)
       })

xyplot(Sepal.Length ~ Sepal.Width | PetalLength, 
       data = iris,
       panel = function(x,y,...){
         panel.grid(h = -1, v = -1, col.line = "skyblue")
         panel.xyplot(x,y,...)
         mylm <- lm(y~x)
         panel.abline(mylm)
       })

histogram(~Sepal.Length | Species,
          xlab = "",
          data = iris,
          layout = c(3,1),
          type = "density",
          main = "Histograma Lattice",
          sub = "Iris Dataset, Sepal Length")

# Distribuição de dados
qqmath(~ Sepal.Length | Species, data = iris, distribution = qunif)

# Boxplot
bwplot(Species ~ Sepal.Length, data = iris)

# ViolinPlot
bwplot(Species~Sepal.Length,
       data = iris,
       panel = panel.violin)
