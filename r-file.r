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

[Previously saved workspace restored]

 ### "Quantium Virtual Internship - Retail Strategy and Analytics - Task 1"
 
 ### install packages and libraries
 
install.packages("data.table")
Installing package into ‘C:/Users/USUARIO/AppData/Local/R/win-library/4.3’
(as ‘lib’ is unspecified)

package ‘data.table’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\USUARIO\AppData\Local\Temp\RtmpKsb7o6\downloaded_packages
library(ggplot2)
library(data.table)
### download dataset transaction format csv
data <- fread(input= "C:/Users/USUARIO/Downloads/QVI_transaction_data2.csv",
+ sep = ";",
+ dec = ".")

### estructura data
str(data)
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
     words
1: Natural
2:    Chip
3:        
4:        
5:        
6:    
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







