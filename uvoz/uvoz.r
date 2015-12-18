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


html2 <- html_session("https://en.wikipedia.org/wiki/List_of_Chelsea_F.C._seasons") %>% read_html(encoding="UTF-8")
html_tabela2 <- html2 %>% html_node(xpath="//table[@class='wikitable plainrowheaders']")
tabela2 <- html_tabela2 %>% html_table(fill = TRUE)
Encoding(tabela2[[1]]) <- "UTF-8"
Encoding(tabela2[[2]]) <- "UTF-8"


colnames(tabela2 ) -> imena
tabela2 <- tabela2[-c(12, 33, 104,  105, 106), -c( 12, 13,14,  15, 16, 17, 18,19)]
imena <- c("Sezona", "Liga", "Št. tekem", "Zmage", "izenačeno", "Porazi", "št. zadetih golov", "Št danih golov", "Točke", "Položaj", "FA pokal", "Najboljši strelec", "Št. golov")


