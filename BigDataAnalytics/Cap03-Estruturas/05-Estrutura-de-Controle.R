setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap03-Estruturas")
getwd()

# if - else
x = 25

# sem uso de chaves e parenteses, deve selecionar a linha inteira para executar
# com chaves e parentes, não precisa selecionar a linha
if x < 30
 print('x<30')

if (x < 30){
  print('x < 30')
}

# Sempre usar as chaves, existe um bug se não usá-las
if (x > 3)
  print("x é maior q 3")
else
  print("x é menor q 3")

# Erro sem uso de parentes
if x > 7{
  print("é maior")
}else{
  print("é menor")
}

# MELHOR SEMPRE USAR PARENTESES E CHAVES
if (x == 30) {
  print(30)
}else{
  print(x)
}
  
# Comandos aninhados
x = 7
if (x < 7){  
  "Este número é menor do que 7"
} else if(x == 7) {
  "Este número é o 7"
} else {
  "Este número é maior do que 7"
}


# Ifelse
x = 5
ifelse(x < 6, "Correto", NA)

x = 9
ifelse(x < 6, "Correto", NA)

# Expressões Ifelse aninhadas
x = c(7, 5, 4)
ifelse(x < 5, "Menor que 5",
       ifelse(x == 5, "Igual a 5", "Maior que 5"))

# If dentro de funções
func1 <- function (x,y){
  ifelse(y < 7, x + y, "Não encontrado")
}

func1(4,2)
func1(40,7)

# Rep
rep(rnorm(10), 5)

# Repeat
x = 1
repeat{
  x = x + 3
  if (x > 99){
    break
  }
  print(x)
}

# loop for
for (i in 1:20) { print(i) }
print(i)

for (q in rnorm(10)) { print(q)}

# Ignora alguns elementos dentro do loop
for (i in 1:22){
  if (i == 13 | i == 15){
    next
  }
  print(i)
}

# Interrompendo o loop
for (i in 1:22){
  if (i == 13){
    break
  }
  print(i)
}

# Loop while
x = 1
while(x < 5){
  x = x + 1
  print(x)
}

# Não entra no loop
y = 6
while (y < 5){
  y = y + 10
  print(y)
}
