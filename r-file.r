
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



