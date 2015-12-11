library(rvest)
library(dplyr)
library(gsubfn)

html <- html_session("https://en.m.wikipedia.org/wiki/List_of_Chelsea_F.C._players#List_of_players") %>% read_html()
html_tabela <- html %>% html_nodes(xpath="//table[1]") %>% .[[1]]
tabela <- html_tabela %>% html_table()
tabela[grep(",", tabela[[1]]), 1] <- html_tabela %>%
  html_nodes(xpath="//span[@class='vcard']//a[@title]") %>%
  html_text()
Encoding(tabela[[1]]) <- "UTF-8"
Encoding(tabela[[2]]) <- "UTF-8"
Encoding(tabela[[4]]) <- "UTF-8"

