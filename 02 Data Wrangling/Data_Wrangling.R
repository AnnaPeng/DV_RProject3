require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot")
# Change the USER and PASS below to be your UTEid
bank <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from BANKLIST_N"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
bank

nasq <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from NASDAQ100_N"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
nasq

djia <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DJIA_N"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
djia

#Inner Join & Its Data Wrangling
dplyr::inner_join(nasq, djia, by="DATE_1")  %>% tbl_df
tbl_df %>% select(VALUE_NASQ, VALUE_DJIA) %>% filter(VALUE_NASQ>=1500, VALUE_DJIA>=8000) %>% ggplot(aes(x = DATE_1, y = VALUE_NASQ)) + geom_point()

#Outer Join
outerJoin <- dplyr::full_join(nasq, djia, by="DATE_1")
outerJoin

#Extra data wrangling

