library(tidyverse)
library(rvest)
library(lubridate)

# Historical Prices -------------------------------------------------------
# Scrap DSEX Data 
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
list_extracted_dsex <- dsex_price_all[dfcols_dsex == 12] # Extract the list with 11 columns

df_price_dsex <- list_extracted_dsex[[1]] %>% as_tibble()

df_price_latest <- df_price_dsex %>%
  # Except the first 3 columns:
  # data types keep changing
  # parse number if character
  mutate(
    across(where(is.character) & !c(1:3),
           parse_number)
  ) %>% 
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
# Save RDS: Binded Historical Prices
df_historical_prices <- bind_rows(df_price_historical, df_price_latest)
saveRDS(df_historical_prices, "data/DF-HISTORICAL-PRICE.RDS")

# PE ----------------------------------------------------------------------
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
# Save RDS: PE with Sector
df_pe %>% 
  #add sector
  inner_join(readRDS("data/sector/DF-SECTOR.RDS"), by  = "code") %>% 
  saveRDS(., "data/DF-PE.RDS")


# Block Trade -------------------------------------------------------------

mst <- readr::read_csv("https://www.dsebd.org/mst.txt", 
                       skip = 91) %>%  #*** previously was 89
  slice(1:(nrow(.)-3))

# Clean
# https://community.rstudio.com/t/tidyr-separate-one-character-var-and-many-numerical-vars/107452/6
df_block <- mst %>% 
  separate(col = 1, 
           into = c("code",    "Max Price",    "Min Price",
                    "Trades",    "Quantity",   "Value (in millions)"),
           sep = "\\s+", 
           convert = TRUE) %>%
  inner_join(readRDS("data/sector/DF-SECTOR.RDS"), by  = "code")

saveRDS(df_block, "data/DF-Block.RDS")

###################
# Gainers-Losers 
####################
# Gainers----
dsex_price_today_url <- "https://www.dsebd.org/top_ten_gainer.php"
dsex_price_today <- dsex_price_today_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 

# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols_today <- lapply(dsex_price_today, ncol) # Find number of columns for each element of DSEX list
list_extracted_today <- dsex_price_today[dfcols_today == 7] # Extract the list with 7 columns

df_gainers <- list_extracted_today[[1]] %>%
  as_tibble() %>% 
  select(-1) #%>%
  #Check which vars should not change ***
  #Then parse number
  #mutate(across(- c(`TRADING CODE`,  `% CHANGE`), parse_number)) %>% 
  #% CHANGE remains character
  #mutate(`% CHANGE` = as.numeric(`% CHANGE`))


# Losers----
dsex_price_today_url <- "https://www.dsebd.org/top_ten_loser.php"
dsex_price_today <- dsex_price_today_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 

# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols_today <- lapply(dsex_price_today, ncol) # Find number of columns for each element of DSEX list
list_extracted_today <- dsex_price_today[dfcols_today == 7] # Extract the list with 7 columns

df_losers <- list_extracted_today[[1]] %>%
  as_tibble() %>% 
  select(-1) #%>%
#Check which vars should not change ***
#Then parse number
#mutate(across(- c(`TRADING CODE`,  `% CHANGE`), parse_number)) %>% 
#% CHANGE remains character
#mutate(`% CHANGE` = as.numeric(`% CHANGE`))

# Bind
bind_rows(df_gainers, df_losers, .id = c("id")) %>%
  rename(code = 2) %>% 
  inner_join(readRDS("data/sector/DF-SECTOR.RDS"), by  = "code") %>% 
  saveRDS(., "data/DF-GAINERS-LOSERS.RDS")
  
#--------------------
# Recent Market Info
#--------------------
# Scrap Data----
url_market_info <- "https://www.dsebd.org/recent_market_information.php"
market_info <- url_market_info %>%
  rvest::read_html() %>% 
  rvest::html_table(fill = TRUE) 
# We need the table with 9 columns
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
# Step 1: Find number of columns for each element the market_info list
columns_market_info <- lapply(market_info, ncol)
# Step 2: Extract the list with 9 columns
list_market_info <- market_info[columns_market_info  == 9] # Extract the list with 7 columns
# Step 3: Convert to dataframe
df_market_info <- list_market_info[[1]] %>%
  as_tibble() %>% 
  select(-9) #remove DEGEN index

# Step 4: Rename
colnames(df_market_info)<- c("Date","Total Trade", "Total Volume",
                             "Total Value in Taka(mn)",
                             "Total Market Cap. in Taka(mn)",
                             "DSEX Index", "DSES Index", "DS30 Index")
# Reshape 
df_marekt_info <- df_market_info %>% 
  pivot_longer(cols = -1,
               names_to = 'items',
               values_to = 'Actual') %>% 
  mutate(Date = lubridate::dmy(Date))
saveRDS(df_marekt_info, "data/df_marekt_info.RDS")
