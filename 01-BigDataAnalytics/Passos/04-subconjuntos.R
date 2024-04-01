# subconjuntos pode ser feitos de 5 maneiras
# extraído de https://www.r-bloggers.com/2016/11/5-ways-to-subset-a-data-frame-in-r/

# Filtro por subset
sc_subset <- function(df, colunas = NaN){
  if (is.nan(colunas)){
    colunas = c('credit.amount', 'account.balance', 'credit.duration.months', 'tem.telefone')
  }
  
  return(subset(df,
                credit.amount == 841,
                select = colunas
                )
         )
}

# subset por indices, não funciona em data-tabel
sc_indices<- function(df){
  if (is.data.table(df)){
    df <- as.data.frame(df)
  }
  
  linhas = c(1, 3, 4, 5, 6, 7, 8)
  colunas = c(1, 2, 7, 6)
  
  return(df[linhas, colunas])
}

# Igual ao anterior, mas o negativo remove as informações
sc_indices_neg <- function(df){
  if (is.data.table(df)){
    df <- as.data.frame(df)
  }
    
  linhas = c(1, 3, 4, 5, 6, 7, 8)
  colunas = c(1, 2, 7, 6)
    
  return(df[-linhas, -colunas])
} 

# filtrando por nome da coluna
sc_nome_col <- function(df){
  if (is.data.table(df)){
    df <- as.data.frame(df)
  }
  
  colunas <- c('credit.amount', 'savings', 'age')
  
  return (df[, colunas])
}

# Utilização which
# -> which retorna um índice com a posição em q a condição é verdadeira
sc_which <- function(df, campo, valor, colunas){
  if (is.data.table(df)){
    df <- as.data.frame(df)
  }
  
  return (df[which(df[[campo]] == valor), 
             colunas])
}

# Filtro condicional, sem o which
sc_sem_which <- function(df){
  return (df[df$credit.amount < 1841 & df$age < 22, c('age', 'credit.amount')])
}

# Utilizando dplyr
sc_dplyr <- function(df){
  require("dplyr")
  
  select(
    filter(df, credit.amount == 841),
    c('credit.amount', 'account.balance', 'credit.duration.months', 'tem.telefone')
  )
}

sc_dplyr2 <- function(df){
  require("dplyr")
  
  df %>% filter(credit.amount > 2000 & age < 22) %>% select(age, credit.amount)
}
