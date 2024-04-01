# Esse script serve para testes de uso a base de dados usando o R-Studio
# Baseado no exemplo do livto
#   Machine Learning with R - https://subscription.packtpub.com/book/big_data_and_business_inteliigence/9781782162148/2/ch02lvl1sec17/factors
# Com a explicação do site:
#   https://www.dataanalytics.org.uk/r-object-elements-brackets-double-brackets-and/
# ----------------------------------------------------------------------

subject_name <- c("John Doe", "Jane Doe", "Steve Graves")
temperature <- c(98.1, 98.6, 101.4);flu_status <- c(FALSE, FALSE, TRUE)
gender <- factor(c("MALE", "FEMALE", "MALE"))
blood <- factor(c("O", "AB", "A"),
levels = c("A", "B", "AB", "O"))
pt_data <- data.frame(subject_name, temperature, flu_status,gender, blood, stringsAsFactors = FALSE)

head(pt_data)

# retorna como um tipo list 
a <- pt_data['temperature']
is.list(a)
is.vector(a)
is.matrix(a)

# Tuplas 1 e 3- formato [Linhas,Colunas] -> estilo vetor
a <- pt_data[c(1, 3), 'temperature']
is.list(a)
is.vector(a)
is.matrix(a)


# Imprimindo os dados sobre temperaturas -> retorna estilo vetor
a <- pt_data$temperature
is.list(a)
is.vector(a)
is.matrix(a)


# Retorna no estilo Vetor
a <- pt_data[['temperature']] 
is.list(a)
is.vector(a)
is.matrix(a)
