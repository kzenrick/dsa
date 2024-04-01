setwd("~/Documentos/dsa/01-BigDataAnalytics")
source("~/Documentos/dsa/01-BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/01-BigDataAnalytics/Cap17-MiniProjetosTwitter")
getwd()

# ------- Conexão com o twitter
# -- Baseado em https://www.r-bloggers.com/2014/04/twitter-sentiment-analysis-with-r/ 
library("twitteR")
source("access.R")

# Conectar no twitter
setup_twitter_oauth(consumerKey,
                    consumerSecret,
                    accessToken,
                    accessTokenSecret)

# Meu teste -------------------
busca <- function(termo, qtde = 3500, lang = 'pt-br'){
  searchTwitter(termo, n=qtde, lang=lang)
}

list <- busca('Vasco da Gama')

# converte a lista para dataframe
df <- twListToDF(list)
#str(df)
#colnames(df)

# Ordenar o nome das colunas
#df <- df[, order(names(df))]
#colnames(df)

# Converter o campo de 
#df$created <- strftime(df$created, '%Y-%m-%d %H:%M')
#str(df)

# Limpa o texto - retirando
df$text1 <- sapply(df$text, 
                   function(sentence){
                     # Para testes
                     #sentence <- df$text[c(1054)]
                     #print(sentence)
                     
                     # Retirada do RT
                     sentence <- gsub('^RT?\\s?\\@\\w+\\s?\\:? ', "", sentence)
                     #print(sentence)
                     
                     # Retirada das menções no começo das frases
                     sentence <- gsub('\\@\\w+\\_?\\s?\\:? ', "", sentence)
                     #print(sentence)
                     
                     # Retirada de urls
                     sentence <- gsub("https+\\:\\/+([[:alnum:]]*[[:punct:]]*)+", "", sentence)
                     #print(sentence)
                     
                     # Retirada de pontuações - será deixada para o tm
                     #sentence <- gsub('[[:punct:]]', " ", sentence)
                     #print(sentence)
                     
                     # Retirada de carcacteres de controle
                     sentence <- gsub('[[:cntrl:]]', " ", sentence)
                     #print(sentence)
                     
                     # remover duplos espaços
                     sentence <- gsub('\\s{2,}', " ", sentence)
                     #print(sentence)
                     
                     # remover espaço do final
                     sentence <- gsub('\\s*$', "", sentence)
                     #print(sentence)
                     
                     # remover espaço do começo
                     sentence <- gsub('^\\s', "", sentence)
                     #print(sentence)
                     
                     # Retirada de números
                     #sentence <- gsub('\\d+', "", sentence)
                     
                     # Alteração para caixa baixa
                     sentence <- tolower(sentence)
                     #print(sentence)
                     
                     return(sentence)
                   }
                   )
                    

df$words <- sapply(df$text, 
                   function(sentence){
                     word.list <- str_split(tolower(sentence), '\\s+')
                     palavras <- unlist(word.list)
                     return (palavras)
                     
                   }
                   )


# remover os duplicados
df1 <- as.data.frame(df[!duplicated(df$text1), c('text1')])
colnames(df1) <- c('text1')
dim(df1)

# Apensar de já ter separado as palavras em grupos, 
# no primeiro teste apenas text será salvo em um documento
# e depois carregado para ser usado com a biblioteca tm

# Analise feita a partir de outro site
# http://rstudio-pubs-static.s3.amazonaws.com/200720_296c620ed1ad4e96beb93f9b7737254d.html

# Salvar a coluna Texto como arquivo para ser carregado pelo tm
library(SnowballC)   
library(tm)

# inspecionar os valores dos documentos
insp <- function(){
  inspect(docs[c(1, 123, 334, 666)])
}

docs <- Corpus(VectorSource(df1$text1))
insp()

# Preprocessamento

# remover acentuação
docs <- tm_map(docs, removePunctuation)
insp()

# remover as stopwords
docs <- tm_map(docs, removeWords, stopwords("portuguese"))
insp()

# remover extra de espaços após remoção da acentuação
docs <- tm_map(docs, stripWhitespace)   
insp()

# palavras com o mesmo final
# library(SnowballC)   
docs <- tm_map(docs, stemDocument, "portuguese")
#docs <- tm_map(docs, stemDocument)
insp()

# removes espaços desnecessáriso
docs <- tm_map(docs, stripWhitespace)  
insp()

# remover espaço em branco do começo
docs <- tm_map(docs, function(sentence) sentence <- gsub('^\\s', "", sentence))
insp()

# Matrix de termos de documentos
dtm <- DocumentTermMatrix(docs, control=list(wordLengths=c(4, 12)))
inspect(dtm)

library(sentiment)
??sentiment
