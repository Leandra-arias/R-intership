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
 salesOvertime <- stores %>%
+ group_by(STORE_NBR, MONTH_ID) %>%
+ summarize( 
+ total = sum(TOT_SALES),
+ nCustomer = uniqueN(LYLTY_CARD_NBR),
+ transaction = n()/uniqueN(LYLTY_CARD_NBR),
+ chips_Customer = sum(PROD_NBR)/uniqueN(LYLTY_CARD_NBR),
+ avg_price = mean(TOT_SALES)
+ )  ## GROUP BY STORE NUMBER AND MONTH ID

 head(salesOvertime)
# A tibble: 6 × 7
# Groups:   STORE_NBR [1]
  STORE_NBR MONTH_ID total nCustomer transaction
      <int>    <int> <dbl>     <int>       <dbl>
1        77   201807  297.        51        1.08
2        77   201808  256.        47        1.02
3        77   201809  225.        42        1.05
4        77   201810  204.        37        1.03
5        77   201811  245.        41        1.07
6        77   201812  267.        46        1.07



### filter pre trial period 
end_pre_trial_period <- as.Date('2019-02-01')

store_obs_counts <- unique(stores[, .N, by = STORE_NBR]) 
full_obs_stores <- store_obs_counts[N == 12, STORE_NBR]
pre_trial_measures <- stores[
+ MONTH_ID < 201902 & STORE_NBR %in% full_obs_stores
+ ]
head(full_obs_stores)
integer(0)
head(pre_trial_measures)

##function to calculate correlation for a measure, looping through each control store

calculatecorrelation <- function(inputTable, metriCol, storeComparason){
+ calcCorr = data.table( Store1= numeric(), store2 = numeric(), corr_measure = numeric())
+ storeNumber <-
+ for (i in storeNumber){
+ calculateMeasure = data.table("Store2" = , "Store2" = , "corr_measure" = )
+ calcCorr <- rbind(calcCorr, calculateMeasure)
+ }
+ return(calcCorr)
+ }





