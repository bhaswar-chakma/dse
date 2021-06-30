# Block Trade----
mst <- readr::read_csv("https://www.dsebd.org/mst.txt", 
               skip = 89) %>% 
  slice(1:(nrow(.)-3))

# Clean
# https://community.rstudio.com/t/tidyr-separate-one-character-var-and-many-numerical-vars/107452/6
mst %>% 
  separate(col = 1, 
           into = c("code",    "Max Price",    "Min Price",
                    "Trades",    "Quantity",   "Value (in millions)"),
           sep = "\\s+", 
           convert = TRUE) %>%
  inner_join(readRDS("data/sector/DF-SECTOR.RDS"), by  = "code") %>%
  ggplot(aes(x = reorder(code, `Value (in millions)`),
             y = `Value (in millions)`,
             fill = sector,
             label = round(`Value (in millions)`, 1))) +
  geom_col() +
  coord_flip() +
  labs(x = "",
       fill = "Sector",
       title = "Block Trade") +
  geom_text(size = 2) +
  theme(axis.text.y = element_text(size = 6))
