# Para executar no spark stand-alone:
#	spark-submit app.py

# Lembrar de desmarcar as variáveis de PYSPARK para rodar no console

import sys

from pyspark import SparkContext, SparkConf

if __name__ == '__main__':

	# Criar SparkContext
	conf = SparkConf().setAppName('Conta Palavras').setMaster('spark://192.168.1.84:7077')
	sc = SparkContext(conf = conf)

	# Carregar o arquivo
	palavras = sc.textFile('file:///tmp/input.txt').flatMap(lambda line: line.upper().split(' '))	

	# Conta a ocorrência de palavras
	contagem = palavras.map(lambda palavra: (palavra, 1)).reduceByKey(lambda a, b: a + b)

	# salvar o resultado
	contagem.saveAsTextFile('/tmp/saida02')