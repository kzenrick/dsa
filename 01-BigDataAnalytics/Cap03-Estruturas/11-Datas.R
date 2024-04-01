setwd("~/Documentos/dsa/BigDataAnalytics/Cap03-Estruturas")
getwd()

hoje <- Sys.Date()
hoje
class(hoje)
Sys.time()
Sys.timezone()

? strptime

# Formatando as saída - as.Date()
as.Date("2018-06-28")
as.Date("Jun-28-18", format="%b-%d-%y")
as.Date("28 Jun, 2018", format="%d %B,%Y")

# Função Format
Sys.Date()
?format

format(Sys.Date(), format="%d %B, %Y")
format(Sys.Date(), format="Hoje é %A")

# Convertendo datas - as.POSIXct
date1 <- "June 13, '96 hours:23 minutes:01 seconds:45"
date1_convert <- as.POSIXct(date1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
date1_convert

# operação com datas
data_de_hoje <- as.Date("2016-06-25", format="%Y-%m-%d")
data_de_hoje
data_de_hoje + 1

my_time <- as.POSIXct("2016-05-14 11:24:13")
my_time
my_time + 1

data_de_hoje - as.Date(my_time)
data_de_hoje - my_time

# Convertendo datas em formatos específicos
dts = c(1127056501, 1104295502, 1129233601, 1113547501, 1119826801, 1132519502, 1125298801, 11132289201)
mydates = dts
class(mydates)

mydates
class(mydates) = c("POSIXT", "POSIXct")
mydates

mydates = structure(dts, class = c("POSIXT", "POSIXct"))
mydates

# Função ISODate
b1 = ISOdate(2011, 3, 23)
b1
b2 = ISOdate(2012, 9, 19)
b2 - b1

b3 = ISOdate(1976, 11, 2, 13, 32)
b3

difftime(b2, b1, units = "weeks")

require("lubridate")
?lubridate

ymd("20180604")
mdy("06-04-2018")
dmy("06/04/2018")

chegada <- ymd_hms("2016-06-04 12:00:00", tz="Pacific/Auckland")
saida <- ymd_hms("2011-08-10 14:00:00", tz="Pacific/Auckland")

chegada
saida

second(chegada)
second(chegada) <- 23
chegada
wday(chegada)
wday(chegada, label=T)
class(chegada)

# Cria um objeto que específica a data de início e data de fim
interval(chegada, saida)
?interval

tm1.lub <- ymd_hms("2020-05-24 23:55:26")
tm1.lub

tm2.lub <- mdy_hm("05/25/2020 08:32")
tm2.lub

year(tm1.lub)
week(tm1.lub)
tm1.dechr <- hour(tm1.lub) + minute(tm1.lub)/60 + second(tm1.lub)/3600
tm1.dechr

tm1.lub
force_tz(tm1.lub, "Pacific/Auckland")


# Gerando um dataframe de datas
sono <- data.frame(bed.time = ymd_hms("2013-09-01 23:05:24", "2013-09-02 22:51:09", 
                                      "2013-09-04 00:09:16", "2013-09-04 23:43:31", 
                                      "2013-09-06 00:17:41", "2013-09-06 22:42:27", 
                                      "2013-09-08 00:22:27"), 
                   rise.time = ymd_hms("2013-09-02 08:03:29", "2013-09-03 07:34:21",
                                       "2013-09-04 07:45:06", "2013-09-05 07:07:17", 
                                       "2013-09-06 08:17:13", "2013-09-07 06:52:11",
                                       "2013-09-08 07:15:19"), 
                   sleep.time = dhours(c(6.74, 7.92, 7.01, 6.23, 6.34, 7.42, 6.45)))
sono
sono$eficiencia <- round(sono$sleep.time/(sono$rise.time - sono$bed.time) * 100, 1)
sono


# Gerando um plot a partir de datas
par(mar = c(5, 4, 4, 4))
plot(round_date(sono$rise.time, "day"), sono$eficiencia, type = "o", col = "blue", xlab = "Manhã", ylab = NA)
par(new = TRUE)
plot(round_date(sono$rise.time, "day"), sono$sleep.time/3600, type = "o", col = "red", axes = FALSE, ylab = NA, xlab = NA)
axis(side = 4)
mtext(side = 4, line = 2.5, col = "red", "Duração do Sono")
mtext(side = 2, line = 2.5, col = "blue", "Eficiência do Sono")


