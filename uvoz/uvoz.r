library(rvest)
library(dplyr)
library(gsubfn)
library(ggplot2)

html <- html_session("https://en.m.wikipedia.org/wiki/List_of_Chelsea_F.C._players#List_of_players") %>% read_html()
html_tabela <- html %>% html_nodes(xpath="//table[1]") %>% .[[1]]
tabela <- html_tabela %>% html_table()
tabela[grep(",", tabela[[1]]), 1] <- html_tabela %>%
  html_nodes(xpath="//span[@class='vcard']//a[@title]") %>%
  html_text()
Encoding(tabela[[1]]) <- "UTF-8"
Encoding(tabela[[2]]) <- "UTF-8"
Encoding(tabela[[4]]) <- "UTF-8"

attach(tabela)
kategorije <- c('Začetnik v Chelsea','Izkušeni Član','Legenda kluba')
status <- character(nrow(tabela))
status[Appearances <150]<-'Začetnik v Chelsea'
status[Appearances >=150 & Appearances<300]<-'Izkušeni Član'
status[Appearances >=300]<-'Legenda kluba'
STATUS<-factor(status,levels=kategorije,ordered=TRUE)
detach(tabela)
IGRALCI <- data.frame(tabela, STATUS)

IGRALCI$Chelsea.zacetek <- IGRALCI$Chelsea.career %>% strapplyc("^([0-9]*)") %>% as.numeric()
IGRALCI$Chelsea.konec <- IGRALCI$Chelsea.career %>% strapplyc("([0-9]*)$") %>% as.numeric()
IGRALCI$Chelsea.konec[is.na(IGRALCI$Chelsea.konec)] <- 2015
as.numeric(IGRALCI$Appearances)
as.numeric(IGRALCI$Goals)


html2 <- html_session("https://en.wikipedia.org/wiki/List_of_Chelsea_F.C._seasons") %>% read_html()
html_tabela2 <- html2 %>% html_nodes(xpath="//table[3]") %>% .[[1]]
tabela2 <- html_tabela2 %>% html_table(fill= TRUE)

Encoding(tabela2[[2]]) <- "UTF-8"
Encoding(tabela2[[3]]) <- "UTF-8"
Encoding(tabela2[[1]]) <- "UTF-8"

tabela2[[1, 1]] <- ("SEZONA")
tabela2[[1, 2]] <- ("LIGA")

tabela2[[1, 3]] <- ("TEKME")
tabela2[[1, 4]] <- ("ZMAGE")
tabela2[[1, 5]] <- ("NEODLOČENO")
tabela2[[1, 6]] <- ("PORAZ")
tabela2[[1, 7]] <- ("DANI GOLI")
tabela2[[1, 8]] <- ("PREJETI GOLI")
tabela2[[1, 9]] <- ("TOČKE")
tabela2[[1, 11]] <- ("POKAL FA")
tabela2[[1, 10]] <- ("UVRSTITEV")
tabela2[[1, 12]] <- ("LIGAŠKI POKAL")
tabela2[[1, 14]] <- ("LIGA PRVAKOV")
tabela2[[1, 20]] <- ("NAJBOLJŠI STRELEC")
tabela2[[1, 21]] <- ("DOSEŽENI GOLI")

newtabela2 <- tabela2[c(-12, -33, -34, -104, -105, -106), c(-11, -12, -13, -14, -15, -16, -17, -18, -19)]

stolpci <- newtabela2[1, ]
colnames(newtabela2)<- stolpci
newtabela2[[10]] <- strapply(newtabela2[[10]], "([0-9]+)")

newtabela2 <- newtabela2[c(-1), c(-2, -11,-12)]
newtabela2$SEZONA <- newtabela2$SEZONA %>% strapplyc("^([0-9]*)")
newtabela2 <- apply(newtabela2, 2, as.numeric) %>% as.data.frame()

graf1 <- ggplot(data = newtabela2, aes(x=SEZONA, y=TOCKE))+geom_line(size=1, color='red')+
  ggtitle("TOCKE")
  