library(readr)
library(tidyverse)
# Latest Price----
link_latest_price <- "https://www.dsebd.org/datafile/quotes.txt"
df_quote <- read_csv(link_latest_price) %>% 
  slice(-1) %>%
  rename(code_price = 1) %>% 
  separate(code_price,
           into = c("code", NA, "price"),
           sep = " ") %>% 
  mutate(price = parse_number(price))


