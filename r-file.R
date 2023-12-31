R version 4.3.1 (2023-06-16 ucrt) -- "Beagle Scouts"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R es un software libre y viene sin GARANTIA ALGUNA.
Usted puede redistribuirlo bajo ciertas circunstancias.
Escriba 'license()' o 'licence()' para detalles de distribucion.

R es un proyecto colaborativo con muchos contribuyentes.
Escriba 'contributors()' para obtener más información y
'citation()' para saber cómo citar R o paquetes de R en publicaciones.

Escriba 'demo()' para demostraciones, 'help()' para el sistema on-line de ayuda,
o 'help.start()' para abrir el sistema de ayuda HTML con su navegador.
Escriba 'q()' para salir de R.


 ### "Quantium Virtual Internship - Retail Strategy and Analytics - Task 1"
 
 ### install packages and libraries
 
install.packages("data.table")
Installing package into ‘C:/Users/USUARIO/AppData/Local/R/win-library/4.3’

library(ggplot2)
library(data.table)

### download dataset transaction and customer format csv
data <- fread(input= "C:/Users/USUARIO/Downloads/QVI_transaction_data2.csv",
+ sep = ";",
+ dec = ".")

customer <- fread( input = "C:/Users/USUARIO/Downloads/QVI_purchase_behaviour.csv", 
+ sep = ";", 
+ dec = ".")

### estructura data
str(data)
str(customer)

Classes ‘data.table’ and 'data.frame':  264836 obs. of  8 variables:
 $ DATE          : int  43390 43599 43605 43329 43330 43604 43601 43601 43332 43330 ...
 $ STORE_NBR     : int  1 1 1 2 2 4 4 4 5 7 ...
 $ LYLTY_CARD_NBR: int  1000 1307 1343 2373 2426 4074 4149 4196 5026 7150 ...
 $ TXN_ID        : int  1 348 383 974 1038 2982 3333 3539 4525 6900 ...
 $ PROD_NBR      : int  5 66 61 69 108 57 16 24 42 52 ...
 $ PROD_NAME     : chr  "Natural Chip        Compny SeaSalt175g" "CCs Nacho Cheese    175g" "Smiths Crinkle Cut  Chips Chicken 170g" "Smiths Chip Thinly  S/Cream&Onion 175g" ...
 $ PROD_QTY      : int  2 3 2 5 3 1 1 1 1 2 ...
 $ TOT_SALES     : chr  "6" "6,3" "2,9" "15" ...
 - attr(*, ".internal.selfref")=<externalptr> 
### 10 row of data 
head(data)
    DATE STORE_NBR LYLTY_CARD_NBR TXN_ID PROD_NBR                                PROD_NAME PROD_QTY TOT_SALES
1: 43390         1           1000      1        5   Natural Chip        Compny SeaSalt175g        2         6
2: 43599         1           1307    348       66                 CCs Nacho Cheese    175g        3       6,3
3: 43605         1           1343    383       61   Smiths Crinkle Cut  Chips Chicken 170g        2       2,9
4: 43329         2           2373    974       69   Smiths Chip Thinly  S/Cream&Onion 175g        5        15
5: 43330         2           2426   1038      108 Kettle Tortilla ChpsHny&Jlpno Chili 150g        3      13,8
6: 43604         4           4074   2982       57 Old El Paso Salsa   Dip Tomato Mild 300g        1       5,1

### transform number DATE in format dates
data$DATE <- as.Date(data$DATE, origin = "1899-12-30")
 
head(data$DATE)
[1] "2018-10-17" "2019-05-14" "2019-05-20" "2018-08-17" "2018-08-18" "2019-05-19"

 ### summary PROD_NAME
summary(data$PROD_NAME)
   Length     Class      Mode 
   264836 character character

### examine incorrect entries in column PROD_NAME
words <- data.table(unlist(strsplit(unique(data[, PROD_NAME]), " ")))
setnames(words, 'words')
 
print(head(words))
     
### FRECUENCY WORDS IN DATASET
palabras <- data.table(unlist(strsplit(data$PROD_NAME, " ")))
frecuency <- table(palabras)
print(frecuency)

### Removing special characters
data$PROD_NAME <- gsub("[^[:alnum::] ]", "", data$PROD_NAME)
head(data$PROD_NAME)
[1] "Natural Chip        Compny SeaSalt175g"  
[2] "CCs Nacho Cheese    175g"                
[3] "Smiths Crinkle Cut  Chips Chicken 170g"  
[4] "Smiths Chip Thinly  S/Cream&Onion 175g"  
[5] "Kettle Tortilla ChpsHny&Jlpno Chili 150g"
[6] "Old El Paso Salsa   Dip Tomato Mild 300g"

### removing salsa products
data[, SALSA:= grepl("salsa", tolower(PROD_NAME))]
data <- data[SALSA == FALSE, ][, SALSA:= NULL]
head(data$PROD_NAME)

summary(data$PROD_NAME)
   Length     Class      Mode 
   246742 character character 

### checking null values
valoresNulos <- sum(is.na(data))
print(valoresNulos)


## filter the datset to find the outlier
transaction_chips <- subset( data, PROD_QTY == 200)
print(transaction_chips)

## Verify values outlier in PROD_QTY
Q1 <- quantile(data$PROD_QTY, 0.25)
Q3 <- quantile(data$PROD_QTY, 0.75)
QF<- Q3-Q1
lower_bound <- Q1 -1.5 * QF
upper_bound <- Q3 + 1.5 * QF
 
outlier <- subset(data, PROD_QTY < lower_bound | PROD_QTY > upper_bound)
 
print("Transaccion con 200 paquetes de chips:")
[1] "Transaccion con 200 paquetes de chips:"
print(transaction_chips)
Empty data.table (0 rows and 8 cols): DATE,STORE_NBR,LYLTY_CARD_NBR,TXN_ID,PROD_NBR,PROD_NAME...
print(outlier)
           DATE STORE_NBR LYLTY_CARD_NBR TXN_ID PROD_NBR
  1: 2018-08-17         2           2373    974       69
  2: 2018-08-20         8           8294   8221      114
  3: 2018-08-18        20          20418  17413       94
  4: 2019-05-15        43          43227  40186       26
  5: 2019-05-16        74          74336  73182       84
 ---                                                    
784: 2018-08-15       200         200248 199694        3
785: 2018-08-20       203         203253 203360       28
786: 2019-05-16       208         208205 207318       37
787: 2019-05-14       238         238169 242560       44
788: 2019-05-14       264         264149 262909       25
                                    PROD_NAME PROD_QTY TOT_SALES
  1:   Smiths Chip Thinly  S/Cream&Onion 175g        5        15
  2:    Kettle Sensations   Siracha Lime 150g        5        23
  3:                        Burger Rings 220g        4       9,2
  4:             Pringles Sweet&Spcy BBQ 134g        4      14,8
  5:    GrnWves Plus Btroot & Chilli Jam 180g        5      15,5
 ---                                                            
784: Kettle Sensations   Camembert & Fig 150g        4      18,4
785:     Thins Potato Chips  Hot & Spicy 175g        5      16,5
786: Smiths Thinly       Swt Chli&S/Cream175G        5        15
787:           Thins Chips Light&  Tangy 175g        4      13,2
788:           Pringles SourCream  Onion 134g        5      18,5

## filter customer loyalty number card
loyalty_number <- "226000"
filtered_data <- subset(data, LYLTY_CARD_NBR != loyalty_number)
 
head(filtered_data)
         DATE STORE_NBR LYLTY_CARD_NBR TXN_ID PROD_NBR                                PROD_NAME PROD_QTY TOT_SALES
1: 2018-10-17         1           1000      1        5   Natural Chip        Compny SeaSalt175g        2         6
2: 2019-05-14         1           1307    348       66                 CCs Nacho Cheese    175g        3       6,3
3: 2019-05-20         1           1343    383       61   Smiths Crinkle Cut  Chips Chicken 170g        2       2,9
4: 2018-08-17         2           2373    974       69   Smiths Chip Thinly  S/Cream&Onion 175g        5        15
5: 2018-08-18         2           2426   1038      108 Kettle Tortilla ChpsHny&Jlpno Chili 150g        3      13,8
6: 2019-05-16 

### count the number transaction by date
transaction_date <- aggregate(TXN_ID~DATE, data= filtered_data, FUN= length)
print(transaction_date)

 ### sequency of dates 
dates <- seq(as.Date("2018-07-01"), as.Date("2019-06-30"), by= "day")

## dataframe con fechas
dates_df <- data.frame(DATE = dates)
 
## join count of transaction by date
colum_dates <- merge(date_df, transaction_date, by= "DATE", all.x = TRUE)
print(colum_dates)

### graph 
p <- ggplot(colum_dates, aes( x= DATE, y= TXN_ID))+
+ geom_line()+
+ labs( x= "DATES", y="TRANSACTION")+
+ theme_minimal()
print(p)

### filter december by day
december <- subset(colum_dates, format(DATE, "%m")== "12"

## graph december                   
p_december <- ggplot(december, aes(x= "DATE", y= "TXN_ID"))+
+ geom_line()+
+ labs( x = "fecha", y= "transactions")+
+ theme_minimal()

## interactive graph
p_december_inter<- ggplotly(p_december)
p_december_inter

## create pack sizes
install.packages("readr")
library(readr)
                   
filtered_data[, pack_size := parse_number(PROD_NAME)]

###check if the pack sizes look sensible
summary(filtered_data$pack_size)
                   
## histogram of number of transaction
hist(filtered_data$pack_size, main= "number of transactions", xlab= "pack size", ylab="frecuency", col="skyblue")

### filter brand by prod_name                   
filtered_data$BRAND <- sub("^(\\w+).*", "\\1", filtered_data$PROD_NAME)

## checkin dataset
head(filtered_data, 25)

### merge dataset customer with filtered data 
data_f <- merge(filtered_data, customer, all.x= TRUE)
data_f  
                   
 ### checking null values to customer
customer_null <- data_f[is.na(data_f$LYLTY_CARD_NBR.y), "LYLTY_CARD_NBR"]
customer_null
                   
### save our dataset in format csv
write.csv(data_f, "data_final.csv", row.names = FALSE)
                   
                  
### data analyst on customer segments
### who spend the most on chip
                   
install.packages("dplyr")
library(dplyr)

 data_group <- data_final %>%
+ group_by(LYLTY_CARD_NBR, LIFESTAGE, PREMIUM_CUSTOMER) %>%
+ summarise( TOTAL = sum(TOT_SALES))       

                
##highest Total Sales
top_customer <- data_group %>%
+ arrange(desc(TOTAL)) %>%
+ slice(1)
top_customer                   

### customers are in each segment
count_ls <- table(data_group$LIFESTAGE)
head(count_ls)    

### bar graph
ggplot( data= data_group, aes(x= LIFESTAGE))+
+ geom_bar()+
+ labs( title = "number of customer by segment of lifestage", x = "Lifestage segment")

### Total sales by LIFESTAGE and PREMIUM_CUSTOMER
library(dplyr)
sales_bysegment <- data_final %>%
+ group_by(LIFESTAGE, PREMIUM_CUSTOMER)%>%
+ summarise(sales = sum(TOT_SALES))
sales_bysegment 
                   
ggplot(sales_bysegment, aes(x= LIFESTAGE, y= sales, fill= LIFESTAGE))+
+ geom_bar(stat = "identity")+
+ labs(title = "Total Sales by segment",
+ x = "Lifestage",
+ y = "Total sales")+
+ theme_minimal()

                   
