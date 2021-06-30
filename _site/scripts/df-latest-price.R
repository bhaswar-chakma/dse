library(tidyverse)
library(rvest)
library(lubridate)
###########################
# HISTORICAL PRICE
###########################
df_sector <- readRDS("data/sector/DF-SECTOR.RDS")# to be joined
df_15_20 <- readRDS("data/archives/DSEX-2015-2020-CLEAN.RDS")# to be binded

#-----------
# DS30 Codes
#------------
ds30code <- c("ACMELAB", "BATBC", "BBSCABLES", "BEACONPHAR", "BEXIMCO", "BRACBANK", 
              "BSCCL", "BSRMLTD", "BXPHARMA", "CITYBANK", "CONFIDCEM", "EBL", 
              "GP", "IDLC", "IFADAUTOS", "LANKABAFIN", "LHBL", "MPETROLEUM", 
              "NATLIFEINS", "NBL", "OLYMPIC", "PADMAOIL", "PTL", "PUBALIBANK", 
              "RENATA", "SINGERBD", "SQURPHARMA", "SUMITPOWER", "TITASGAS", 
              "UPGDCL")
###########################
#       Scrap 
##########################
end_date <- today()
start_date <- as.Date("2021-01-01") #****
u1 <- "https://www.dsebd.org/day_end_archive.php?startDate="
u2 <- "&endDate="
u3 <- "&inst=All%20Instrument&archive=data"
dsex_url_all <- paste0(u1,start_date,u2,end_date,u3)
# Get data  
dsex_price_all <- dsex_url_all %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols_all <- lapply(dsex_price_all, ncol) # Find number of columns for each element of DSEX list
list_extracted_all <- dsex_price_all[dfcols_all == 12] # Extract the list with 11 columns

df_price_all <- list_extracted_all[[1]] %>% as_tibble()

df_price_latest_clean <- df_price_all %>% 
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
##############################
# Bind with 2015-2020 Data
###########################
df_prices_binded  <- bind_rows(df_15_20, df_price_latest_clean)
###################
# Join Sector Info
###################
inner_join(df_prices_binded, df_sector, by = "code") %>% 
  mutate(ds30 = ifelse(code %in% ds30code, TRUE, FALSE)) %>% 
  select(date, code, sector, ds30, everything()) %>% 
  arrange(desc(date)) -> df_all_prices


###############################
#          PE
###############################
dsex_pe_url <- "https://dsebd.org/latest_PE.php"
dsex_pe_list <- dsex_pe_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols_pe <- lapply(dsex_pe_list, ncol) # Find number of colums for each element of DSEX list
list_pe_extracted <- dsex_pe_list[dfcols_pe == 10] # Extract the list with 11 columns
df_pe <- list_pe_extracted[[1]] %>%
  as_tibble() %>% 
  rename(code = 2,
         pe0 = 5) %>% 
  select(code, pe0) %>% 
  mutate(pe = as.numeric(pe0)) %>% 
  select(code, pe) %>% 
  filter(!is.na(pe))

df_all_final <- left_join(df_all_prices, df_pe, by = "code")
saveRDS(df_all_final, "data/price-latest/DF-PRICE-LATEST.RDS")



# df_all_final %>% 
#   filter(code == "SQURPHARMA") %>% 
#   ggplot(aes(x = date, y = price)) +
#   geom_line()


###############
# Sinlge URL
###############
# name_security <- "SQURPHARMA"
# end_date <- today()
# start_date <- end_date - 30
# url1 <- "https://www.dsebd.org/day_end_archive.php?startDate="
# url2 <- "&endDate="
# url3 <- "&inst="
# url4 <- "&archive=data"
# dsex_url_single <- paste0(url1,start_date,url2,end_date,url3,name_security,url4)
# # Get data  
# dsex_price_single <- dsex_url_single %>%
#   read_html() %>% 
#   html_table(fill = TRUE) 
# # See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
# dfcols_single <- lapply(dsex_price_single, ncol) # Find number of colums for each element of DSEX list
# list_extracted_single <- dsex_price_single[dfcols_single == 12] # Extract the list with 11 columns
# df_price_single <- list_extracted_single[[1]] 




                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
  