# Scrap DSEX Data ----
df_price_historical <- readRDS("data/DF-HISTORICAL-PRICE.RDS")
start_date <- df_price_historical %>% # start date
  arrange(desc(date)) %>%
  slice(1) %>%
  mutate(date = date + 1) %>% 
  pull(date)
end_date <- lubridate::today() # end date
u1 <- "https://www.dsebd.org/day_end_archive.php?startDate="
u2 <- "&endDate="
u3 <- "&inst=All%20Instrument&archive=data"
dsex_url_all <- paste0(u1,start_date,u2,end_date,u3)
# Get data  
dsex_price_all <- dsex_url_all %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols_dsex <- lapply(dsex_price_all, ncol) # Find number of columns for each element of DSEX list
list_extracted_dsex <- dsex_price_all[dfcols_all == 12] # Extract the list with 11 columns

df_price_dsex <- list_extracted_all[[1]] %>% as_tibble()

df_price_latest <- df_price_dsex %>% 
  mutate_at(4:12, parse_number) %>% 
  rename(date = "DATE",
         code = "TRADING CODE",
         price = `CLOSEP*`,
         trade = `TRADE`,
         value = `VALUE (mn)`,
         volume = `VOLUME`,
         ltp = "LTP*",
         high = HIGH,
         low = LOW,
         open = "OPENP*",
         ycp = YCP
  ) %>% 
  mutate(date = ymd(date)) %>% 
  select(-1)
# Save RDS ----
bind_rows(df_price_historical, df_price_latest) %>% 
  saveRDS(., "data/DF-HISTORICAL-PRICE.RDS")
