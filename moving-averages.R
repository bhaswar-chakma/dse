library(tidyverse)
library(lubridate)
options(scipen=999)
# DS30 Code----------------
ds30code <- c("ACMELAB", "BATBC", "BBSCABLES", "BEACONPHAR", "BEXIMCO", "BRACBANK", 
              "BSCCL", "BSRMLTD", "BXPHARMA", "CITYBANK", "CONFIDCEM", "EBL", 
              "GP", "IDLC", "IFADAUTOS", "LANKABAFIN", "LHBL", "MPETROLEUM", 
              "NATLIFEINS", "NBL", "OLYMPIC", "PADMAOIL", "PTL", "PUBALIBANK", 
              "RENATA", "SINGERBD", "SQURPHARMA", "SUMITPOWER", "TITASGAS", 
              "UPGDCL")
# add dse30 column
df_price <- readRDS("data/DF-HISTORICAL-PRICE.RDS") %>%
  # Sector
  inner_join(readRDS("data/sector/DF-SECTOR.RDS")) %>% 
  # PE
  left_join(readRDS("data/DF-PE.RDS")) %>% 
  # DSE30
  mutate(ds30 = ifelse(code %in% ds30code, TRUE, FALSE)) %>% 
  select(date, code, sector, ds30, everything()) %>% 
  arrange(desc(date))

# Moving Average ----------------------

df_ma_long <- df_price %>%
  group_by(code) %>% 
  arrange(code, date) %>%
  mutate(t = row_number(), T = n()) %>% 
  filter(T > 100) %>% 
  # Moving Average
  mutate(sma26 = TTR::SMA(price, 26),
         sma12 = TTR::SMA(price, 12)) %>% 
  na.omit() %>% 
  select(date, code, ds30, sector, price, sma12, sma26) %>% 
  # Reshape 
  pivot_longer(
    cols = price:sma26,
    names_to = "price_type",
    values_to = "price"
  )
saveRDS(df_ma_long, "data/moving-averages.RDS")
