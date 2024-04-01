setwd("~/Documentos/dsa/BigDataAnalytics/Cap06-BDR_E_NoSQL")
getwd()

#install.packages('devtools')
library(devtools)
# -------------------
# Caso de erro na instalação do pacote: 
# sh: 1: /bin/gtar: not found
# Executar o comando abaixo
# ln -s /bin/tar /bin/gtar
# ------------------
# install_github(repo = "mongosoup/rmongodb")

library(rmongodb)

# Criando a Conexão -----------
help("mongo.create")
mongo <- mongo.create(host = '127.0.0.1')
mongo

# Checando Conexão ----------
mongo.is.connected(mongo)

if (mongo.is.connected(mongo) == T){
  mongo.get.databases(mongo)
}

# Armazenando o nome de uma das coleções --------
coll <- 'users.contatos'

# Contanto os registros de uma das coleções ------------
help('mongo.count')

mongo.count(mongo, coll)

# Buscando 1 registro na coleção ----------
mongo.find.one(mongo, coll)

# Obtendo um vetor de valores distintos das chaves de uma coleção 
res <- mongo.distinct(mongo, coll, 'city')
head(res)

# Obtendo um vetor de valores distintos das chaves de uma coleção 
# E gerando um histograma
pop <- mongo.distinct(mongo, coll, 'pop')
hist(pop)
hist(pop, breaks = 3)

# contanto os elementos -> $lte comando do mongo
# parametros query mongo.bson.from.list
hr <- mongo.count(mongo, coll, list('pop' = list('$lte' = 2)))
hr

# buscando todos os elementos ------
pops <- mongo.find.all(mongo, coll, list('pop' = list('$lte' = 2)))
head(pops)

# Encerrar a conexão -------
mongo.destroy(mongo)

# Criando e validando um arquivo JSON
library(jsonlite)
json_arquivo <- '{"prop":{"$lte":2}, "pop":{"$gte":1}}'
cat(prettify(json_arquivo))

validate(json_arquivo)
