library(tidyverse)
library(rvest)
#end_date <- lubridate::today()
end_date <- as.Date("2021-03-21")
start_date <- as.Date("2021-01-01") #****
u1 <- "https://www.dsebd.org/old_news.php?startDate="
u2 <- "&endDate="
u3 <- "&criteria=4&archive=news"
dsex_url_news <- paste0(u1,start_date,u2,end_date,u3)
# Get data  
dsex_news <- dsex_url_news %>%
  read_html() %>% 
  html_table(fill = TRUE)

# Extract and Clean: list number may change***we are looking for 2-column df
dsex_news[[358]] %>% 
  filter(X1 != "") %>%
  ## assign a (temporary) unique identifier to each trading code ..
  mutate(id = cumsum(X1 == "Trading Code:")) %>% 
  pivot_wider(names_from = X1,
              values_from = X2,
  ) %>% 
  ## remove the temporary id
  select(-id) %>%
  ## clean the column names w/ the janitor package
  janitor::clean_names() -> df_news_clean
saveRDS(df_news_clean, "data/market/df_news_clean.RDS")

# df_toy %>%
#   slice(475) %>% 
#   dput()
# 
# str_replace(df_toy$news, "<U+009D>", "'") 

# df_toy %>% 
#   mutate(news = str_replace(news, "<U+009D>", "'")) %>% # "2021-03-03"EMERALDOIL
#   DT::datatable()

df_news_clean %>% 
  select(post_date)
