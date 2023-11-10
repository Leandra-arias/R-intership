### "Quantium Virtual Internship - Retail Strategy and Analytics - Task 2"

### Load libraries required
library(data.table)
library(ggpplot2)
library(tidyr)

### Download dataset QVI_data format csv
data_qvi<- fread(input = "C:/Users/USUARIO/Downloads/QVI_DATA.csv",
+ sep = ",",
+ dec = ".")

### set themes for plot
theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))

### select control stores
## filter number store 77, 86, 88
stores <- subset(data_qvi, STORE_NBR %in% c(77, 86, 88))
 
head(stores)
   LYLTY_CARD_NBR       DATE STORE_NBR TXN_ID PROD_NBR                               PROD_NAME PROD_QTY TOT_SALES
1:          77000 2019-03-28        77  74911       18          Cheetos Chs & Bacon Balls 190g        1       3.3
2:          77000 2019-04-13        77  74912       69  Smiths Chip Thinly  S/Cream&Onion 175g        1       3.0
3:          77000 2018-09-26        77  74910       36                      Kettle Chilli 175g        2      10.8
4:          77001 2019-02-27        77  74913        7       Smiths Crinkle      Original 330g        2      11.4
5:          77001 2019-01-21        77  74914        9 Kettle Tortilla ChpsBtroot&Ricotta 150g        2       9.2
6:          77002 2019-05-17        77  74915       63            Kettle 135g Swt Pot Sea Salt        1       4.2
   PACK_SIZE   BRAND              LIFESTAGE PREMIUM_CUSTOMER
1:       190 CHEETOS MIDAGE SINGLES/COUPLES           Budget
2:       175  SMITHS MIDAGE SINGLES/COUPLES           Budget
3:       175  KETTLE MIDAGE SINGLES/COUPLES           Budget
4:       330  SMITHS         YOUNG FAMILIES       Mainstream
5:       150  KETTLE         YOUNG FAMILIES       Mainstream
6:       135  KETTLE               RETIREES           Budget

# Create new month ID column in the data with the format yyyymm.
stores$MONTH_ID <- format(stores$DATE, "%Y%m")

# Define the measure calculations to use during the analysis.
measureOvertime <- data[ , .(
+ total_sales = sum(TOT_SALES),
+ nCustomer = uniqueN(LYLTY_CARD_NBR),
+ nTperCust = .N/ uniqueN(LYLTY_CARD_NBR),
+ nChips = sum(PROD_QTY)/.N,
+ avgPrice = mean(TOT_SALES/PROD_QTY)
+ ),
+ by = .(STORE_NBR, MONTH_ID)][order(STORE_NBR, MONTH_ID)]  ## GROUP BY STORE NUMBER AND MONTH ID



