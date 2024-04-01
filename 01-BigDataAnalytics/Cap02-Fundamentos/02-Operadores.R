# Operadores básicos, relacionais e lógicos em R
setwd("~/Documentos/dsa/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# ----------------------
# Operadores básicos
1 + 1
2 - 1
3 * 2
4 / 2
5 / 2

# potencialização
3 ** 2
2 ^ 3

# raiz quadrada
2 ** 0.5

# Não reconhece os seguintes módulos
# 5 // 3
# 5 % 3
5 %% 3
5%/%3

# ----------------------
# Operadores Relacionais

# Atribuindo variáveis
x = 7
y <- 5

# Operadores
x > y
x < y
x == y
x >= y
x <=y
x != y

# Operadores Lógicos
# AND
(x == 8) & (y == 5)
(x == 7) & (y >= 5)
(x == 8) & (x == 6)

# OR
(x == 8) | (x > 5)
(x == 8) | (x >= 5)

# Not
x > 8
!(x > 8)

