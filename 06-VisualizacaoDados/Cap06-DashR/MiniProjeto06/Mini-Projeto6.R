# Mini-Projeto 6 - Dashboard Estatístico Para Automação da Análise Exploratória

# Pacotes (instale o pacote que não estiver instalado no seu ambiente)
library(MASS)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(dashboardthemes)
library(shinyjs)
library(ggplot2)

# UI
# Aqui é onde configuramos o design, UI (User Interface), do Dashboard
# Aqui você encontra todas as opções de definição da UI: https://cran.r-project.org/web/packages/dashboardthemes/dashboardthemes.pdf

# Função UI com dashboardPage
ui <- dashboardPage(
                    # Título
                    dashboardHeader(title = "Dashboard Estatístico"),
                    
                    # Barra lateral
                    dashboardSidebar(collapsed = T,
                                     sidebarMenu(menuItem("Correlação", tabName = "corr", selected = T),
                                                 menuItem("Estatística 2",tabName = "ols1"),
                                                 menuItem("Estatística 3",tabName = "ols"))),
                    
                    # Corpo do dashboard
                    dashboardBody(shinyjs::useShinyjs(),
                                  shinyDashboardThemes(theme = "blue_gradient"),
                                  tabItems(tabItem(tabName = "start"),
                                           tabItem(tabName = "ols1",
                                                   fluidRow(column(width = 11,
                                                                   box(width = NULL, title = 'Oi Mundo')
                                                                   )
                                                            )
                                                   ),
                                           tabItem(tabName = "corr",
                                                   fluidRow(column(width = 4,
                                                                   box(width = NULL,title = "Coeficiente de Correlação", collapsible = F,
                                                                       solidHeader = F, 
                                                                       HTML("<p>O coeficiente de correlação é uma medida de quão fortemente 
                                                                       duas variáveis quantitativas estão associadas uma com a outra.</p>
                                                                       <p>O computador irá gerar duas variáveis para você com nível aleatório
                                                                       de correlação entre elas. Para começar, clique no botão 'Gere Alguns Números'. 
                                                                       Para gerar novas variáveis, basta clicar no botão novamente.</p>
                                                                       <p>O dashboard mostrará a solução correta se você clicar no botão 'Mostre a Solução'</p>
                                                                        <p>Adicione outras estatísticas a este Dashboard!</p>")),
                                                                   box(width = NULL, 
                                                                       title = "Controles", 
                                                                       collapsible = F, 
                                                                       solidHeader = F,
                                                                       actionBttn(inputId = "sim",
                                                                                  label = "Gere Alguns Números",
                                                                                  style = "material-flat",
                                                                                  color = "success",
                                                                                  size = "xs"),
                                                                       br(),
                                                                       br(),
                                                                       disabled(actionBttn(inputId = "solution",
                                                                                           label = "Mostre a Solução",
                                                                                           style = "material-flat",
                                                                                           color = "warning",
                                                                                           size = "xs"))),
                                                                   box(width = NULL,
                                                                       title = "Resultado",
                                                                       collapsible = F,
                                                                       solidHeader = F,
                                                                       textOutput(outputId = "result"))),
                                                            column(width = 8,
                                                                   box(width = NULL,
                                                                       title = "Dados",
                                                                       collapsible = F,
                                                                       solidHeader = F,
                                                                       column(3, tableOutput(outputId = "tab")),
                                                                       column(9, plotOutput(outputId = "plot"))))),
                                                   fluidRow(box(width = 12,
                                                                title = "Solução Detalhada",
                                                                collapsible = T,
                                                                collapsed = T,
                                                                solidHeader = F,
                                                                
                                                                # Para cada bloco teremos dados a serem preenchidos
                                                                uiOutput("cor_detail1"),
                                                                uiOutput("cor_detail2"),
                                                                uiOutput("cor_detail3"),
                                                                uiOutput("cor_detail4"),
                                                                tableOutput("cor_tab1"),
                                                                uiOutput("cor_detail5"),
                                                                tableOutput("cor_tab2"),
                                                                uiOutput("cor_detail6"),
                                                                uiOutput("cor_detail7"),
                                                                uiOutput("cor_detail8"),
                                                                uiOutput("cor_detail9"),
                                                                uiOutput("cor_detail10")
                                                                )
                                                            )
                                                   )
                                           )
                                  )
                    )

# Server
# Aqui colocamos a "inteligência" do dashboard com o tratamento e análise dos dados
server <- function(input, output, session){
  vals <- reactiveValues()
  
  # Eventos observados
  observeEvent(input$sim, {
    rho <- runif(n = 1, min = 0, max = 1)
    vals$data <- as.data.frame(mvrnorm(n = 10, mu = c(0,0), Sigma = matrix(c(1, rho, rho, 1), ncol = 2), empirical = T))
    vals$data$X <- round((vals$data$V1 - min(vals$data$V1))*10+10, digits = 0)
    vals$data$Y <- round((vals$data$V2 - min(vals$data$V2))*20+20, digits = 0)  
    output$tab <- renderTable(vals$data[,c("X","Y")], digits = 0, rownames = T)
    enable("solution")
    
    # Output (gráficos)
    output$plot <- renderPlot({
      ggplot(vals$data, aes(x = X, y = Y)) +
      geom_point() +
      geom_smooth(method='lm', se = F, color = "gray", linetype = "dashed")
  })
})
  
observeEvent(input$solution,{

  # Solução Simples
  res <- isolate(round(cor(vals$data$X,vals$data$Y, method = "pearson"), digits = 2))
  
  # Estatística t
  t <- round((res*sqrt(10-2))/(sqrt(1-res^2)),digits=3)
  
  # Valor-p
  p_val <- round(1 - pt(t, 8, lower.tail = T),digits = 3)
  
  output$result <- renderText(paste0("O coeficiente de correlação é: ",res," e o valor-t é: ",t,".\nO valor-p corespondente é: ",p_val))
  
# Solução detalhada - Parte 1
output$cor_detail1 <- renderUI({withMathJax(helpText("A primeira etapa é calcular a covariância entre X e Y. 
                                                     A fórmula para calcular a covariância é a seguinte: $$cov_{X,Y} = \\frac{\\sum_{i=1}^n (X_i - \\bar X)(Y_i - \\bar Y)}{n}$$"))
})

# Solução detalhada - Parte 2
output$cor_detail2 <- renderUI({HTML("<p>A variância é calculada como o desvio de cada observação dentro de uma variável da média dessa variável dividido pelo
                           número total de observações (menos 1). O cálculo da covariância é
                           semelhante, mas temos que fazer algumas etapas extras.</p>")
})

# Solução detalhada - Parte 3
output$cor_detail3 <- renderUI({HTML(paste0("<p>Primeiro, calculamos os valores médios de X e Y, que são:</p>
       <p><strong>Média de X: ",isolate(round(mean(vals$data$X),digits = 3)),"</strong></p>
       <p><strong>Média de Y: ",isolate(round(mean(vals$data$Y),digits = 3)),"</strong></p>"))  
})

# Solução detalhada - Parte 4
output$cor_detail4 <- renderUI({HTML(paste0("<p>Em seguida, calculamos os desvios de cada observação dos valores médios.
                                             Por exemplo, para a primeira observação, obtemos os seguintes resultados:</p>
                                             
              <p><strong>Desvio da média de X: ", isolate(vals$data[1,c("X")]), " - ",isolate(round(mean(vals$data$X),digits = 3)), " = ", isolate(round(vals$data[1,3] - round(mean(vals$data$X), digits = 3), digits = 3)),"</strong></p>
              <p><strong>Desvio da média de Y: ", isolate(vals$data[1,c("Y")]), " - ",isolate(round(mean(vals$data$Y),digits = 3)), " = ", isolate(round(vals$data[1,4] - round(mean(vals$data$Y), digits = 3), digits = 3)),
              "</strong></p>
              
              <p>A tabela a seguir exibe os desvios para cada uma das observações em nosso conjunto de dados.</p>"))
})

# Dados
vals$cordata <- vals$data

# Média
vals$cordata$meanX <- isolate(round(mean(vals$cordata$X),digits = 3))
vals$cordata$meanY <- isolate(round(mean(vals$cordata$Y),digits = 3)) 
  
# Desvio padrão
vals$cordata$deviationX <- isolate(vals$cordata[,c("X")] - round(vals$cordata[,c("meanX")],3))
vals$cordata$deviationY <- isolate(vals$cordata[,c("Y")] - round(vals$cordata[,c("meanY")],3))
   
# Tabela 
output$cor_tab1 <- renderTable(vals$cordata[,c("X", "Y", "meanX", "meanY", "deviationX", "deviationY")], digits = 3, rownames = T)
  
# Solução detalhada - Parte 5
output$cor_detail5 <- renderUI({HTML(paste0("<p>Na próxima etapa, multiplicamos o desvio para cada uma das observações em nossos dados.</p>
              <p>Começamos novamente com a primeira observação:</p>
              <p><strong>Desvio de X vezes Desvio de Y: ", isolate(round(vals$cordata[1,c("deviationX")], digits = 3)), " x ", isolate(round(vals$cordata[1,c("deviationY")],digits=3))," = ",round(round(vals$cordata[1,c("deviationX")],digits=3)*round(vals$cordata[1,c("deviationY")],digits=3),digits=3),"</strong></p>
              <p>E, novamente, imprimimos isso para todas as observações em uma tabela:</p>"))
})

# Tabela
vals$cordata$DevX_times_DevY <- round(vals$cordata[c("deviationX")], digits = 3)*round(vals$cordata[c("deviationY")], digits = 3)
output$cor_tab2 <- renderTable(vals$cordata[,c("X", "Y", "meanX", "meanY", "deviationX", "deviationY", "DevX_times_DevY")], digits = 3, rownames = T)

# Solução detalhada - Parte 6
output$cor_detail6 <- renderUI({
  HTML(paste0("<strong>Quase pronto! </strong> Agora que temos as pontuações de desvio multiplicadas, simplesmente
               somamos-os sobre todas as observações e, em seguida, divida pelo número de observações menos 1. Importante: no cálculo aqui,
               dividimos por n-1 em vez de n; isso ocorre porque é assim que R o calcula e também porque estamos lidando aqui com uma amostra bem pequena de 10 observações.
               Em um conjunto de dados maior (várias centenas ou milhares de observações, isso não deve fazer diferença, mas aqui faz).</p>
              <p><strong>A soma de todas as pontuações (a coluna mais à direita na tabela acima) é: ", round(sum(vals$cordata[,c("DevX_times_DevY")]), digits = 3),"</strong></p>
              <p><strong>E isso dividido pelo número de observações menos 1 - a covariância - é: ", round(round(sum(vals$cordata[,c("DevX_times_DevY")]), digits = 3)/9, digits = 3),"</strong></p>"))
})

# Solução detalhada - Parte 7
output$cor_detail7 <- renderUI({withMathJax(helpText("Agora temos a covariância - mas, na verdade, queremos a correlação! Para
                        calcular o coeficiente de correlação (r), pegamos a covariância e dividimos
                        pela raiz quadrada do produto das variâncias das duas variáveis:
                       $$r = \\frac{cov_{X,Y}}{\\sqrt{var_X \\times var_Y}}$$"))
})

# Solução detalhada - Parte 8
output$cor_detail8 <- renderUI({HTML(paste0("<p>Em nosso exemplo, a variância de X é: ", round(var(isolate(vals$cordata[,c("X")])), digits = 3)," e a variância de Y é: ",round(var(isolate(vals$cordata[,c("Y")])), digits = 3),"</strong></p>
              <p>Se agora inserirmos esses valores na equação acima, obteremos:</p>"))
})

# Solução detalhada - Parte 9
output$cor_detail9 <- renderUI({HTML(paste0("<p><strong> r = <math><mfrac><mn>", round(round(sum(vals$cordata[,c("DevX_times_DevY")]), digits = 3)/9, digits = 3),"</mn><msqrt><mn>",round(var(isolate(vals$cordata[,c("X")])),digits = 3),"</mn><mo>*</mo><mn>",round(var(isolate(vals$cordata[,c("Y")])),digits = 3),"</mn></msqrt></mfrac></math> =",round(round(round(sum(vals$cordata[,c("DevX_times_DevY")]),digits=3)/9,digits=3)/(sqrt(round(var(isolate(vals$cordata[,c("X")])),digits = 3)*round(var(isolate(vals$cordata[,c("Y")])),digits = 3))),digits = 2),"</strong></p>"))
})

# Solução detalhada - Parte 10
output$cor_detail10 <- renderUI({HTML(paste0("<p>Agora que temos o coeficiente de correlação, também queremos saber: Obtivemos esse resultado simplesmente por acaso?
        (Tecnicamente, a resposta é claro que sim - o computador gerou alguns números aleatórios para nós. Mas vamos apenas fingir que temos
        alguns dados reais com significado real diante de nós.)</p>
       
       Para realizar um teste formal, calculamos a estatística t para nosso coeficiente de correlação. A fórmula para este cálculo é a seguinte:</p>
       
       <p> <math> <msub><mi>t</mi><mi>r</mi></msub> <mo>=</mo>  <mfrac><mrow> <mi>r</mi><msqrt><mi>n</mi><mo>-</mo><mn>2</mn></msqrt> </mrow> <mrow> <msqrt><mn>1</mn><mo>-</mo><msup><mi>r</mi><mn>2</mn></sup></msqrt></mrow></mfrac></math></p>
              
       <p>Com nossos valores inseridos na fórmula, obtemos:</p>
              
       <p> <math> <msub><mi>t</mi><mi>r</mi></msub> <mo>=</mo>  <mfrac><mrow><mn>",isolate(round(cor(vals$cordata$X,vals$cordata$Y,
                                                                                                 method = "pearson"),digits=2)),"</mn><msqrt><mn>10</mn><mo>-</mo><mn>2</mn></msqrt> </mrow> <mrow> <msqrt><mn>1</mn><mo>-</mo><msup><mn>",isolate(round(cor(vals$cordata$X,vals$cordata$Y,
                                                                                                                                                                                                                                                            method = "pearson"),digits=2)),"</mn><mn>2</mn></sup></msqrt></mrow></mfrac> <mo>=</mo><mn>",
              round(isolate(round(cor(vals$cordata$X,vals$cordata$Y,
                                method = "pearson"), digits=2))*sqrt(10-2)/(sqrt(1-(isolate(round(cor(vals$cordata$X,vals$cordata$Y,
                                                                                                      method = "pearson"),digits=2)))^2)),digits = 3),"</mn></math></p>
              
        <p>R nos diz que o valor-p correspondente é ", p_val,".</p>
        <p>Valor-p menor que 0.05 indica que há significância estatística para afirmarmos que há correlação entre as variáveis.</p>
        <p>Valor-p maior que 0.05 indica que não há significância estatística para afirmarmos que há correlação entre as variáveis.</p>
        <p>Valor-p igual a 0.05 fica a cargo do analista decidir ou realizar mais testes.</p>"))
})

})
  
}

# Executa a app
shinyApp(ui = ui, server = server)




