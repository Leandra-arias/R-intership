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


