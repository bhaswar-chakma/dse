library(dplyr)
library(rvest)
###############################
# BANK
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=11"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_bank <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Bank")

###############################
# CEMENT
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=21"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_cement <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Cement")

###############################
# Ceramics
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=24"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_ceramics <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Ceramics")

###############################
# Engineering
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=13"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_eng <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Engineering")

###############################
# Financial Institutions
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=28"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_fin <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Financial Institutions")

###############################
# Food & Allied
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=14"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_food <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Food & Allied")

###############################
# Fuel & Power
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=15"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_fuel <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Fuel & Power")

###############################
# Insurance
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=25"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_ins <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Insurance")

###############################
# IT
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=22"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_it <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "IT")

###############################
# Jute
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=16"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_jute <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Jute")

###############################
# Miscellaneous
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=99"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_misc <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Miscellaneous")

###############################
# Mutual Funds
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=12"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_mf <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Mutual Funds")

###############################
# Paper & Printing
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=19"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_pp <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Paper & Printing")


###############################
# Pharmaceuticals & Chemicals
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=18"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_pharma <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Pharmaceuticals & Chemicals")

###############################
# Services & Real Estate
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=20"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_service <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Services & Real Estate")

###############################
# Tannery Industries
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=23"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_tannery <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Tannery Industries")

###############################
# Telecommunication
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=27"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_tele <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Telecommunication")

###############################
# Textile 
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=17"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_textile <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Textile")

###############################
# Travel & Leisure
###############################
dsex_url <- "https://www.dsebd.org/ltp_industry.php?area=29"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of columns for each element of DSEX list
list_extracted <- dsex_list[dfcols == 11] # Extract the list with 11 columns
df_travel <- list_extracted[[1]] %>% select("TRADING CODE") %>%  
  mutate(sector = "Travel & Leisure")

#===========================================================================
df_trading_code_sector <- bind_rows(df_bank, df_cement, df_ceramics, df_eng, df_fin, 
                                    df_food, df_fuel, df_ins, df_it, df_jute, df_mf, 
                                    df_misc, df_pharma, df_pp, df_service, df_tannery, 
                                    df_tele, df_textile, df_travel) %>% 
  rename(code = `TRADING CODE`)

saveRDS(df_trading_code_sector, "data/sector/DF-SECTOR.RDS")
