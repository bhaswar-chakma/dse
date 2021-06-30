library(tidyverse)
library(rvest)
# 2020
# H2
dsex_url <- "https://www.dsebd.org/day_end_archive.php?startDate=2020-07-01&endDate=2020-12-31&inst=All%20Instrument&archive=data"
dsex_table_2020_h2 <- dsex_url %>%
  read_html() %>% 
  html_table(fill = TRUE) 
h2_20 <- dsex_table_2020_h2[[368]]
saveRDS(h2_20,"./Data/DSEX/RDS-DSEX-Day-End-Archive/DSEX-2020-H2.RDS")
