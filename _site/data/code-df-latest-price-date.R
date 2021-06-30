library(readr)
library(dplyr)
# DSE data
read_table2("https://www.dsebd.org/datafile/quotes.txt", 
            skip = 2) %>% 
  select(1,2) %>% 
  rename(trading_code = 1, market_price = 2) -> df_price

date_latest <- colnames(read_table2("https://www.dsebd.org/datafile/quotes.txt"))[6] 
saveRDS(df_price, "./data/df_price.RDS")
saveRDS(date_latest, "./data/date_latest.RDS")
