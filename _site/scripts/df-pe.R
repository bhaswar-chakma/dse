library(dplyr)
library(rvest)
###############################
#          PE
###############################
dsex_url <- "https://dsebd.org/latest_PE.php"
dsex_list <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
# See https://community.rstudio.com/t/extract-data-frame-from-a-list-with-condition/78086/2
dfcols <- lapply(dsex_list, ncol) # Find number of colums for each element of DSEX list
list_extracted <- dsex_list[dfcols == 10] # Extract the list with 11 columns
df_pe <- list_extracted[[1]] %>%
  as_tibble() %>% 
  rename(code = 2,
         pe0 = 5) %>% 
  select(code, pe0) %>% 
  mutate(pe = as.numeric(pe0)) %>% 
  select(code, pe) %>% 
  filter(!is.na(pe))

saveRDS(df_pe, "./data/DF-PE.RDS")

     