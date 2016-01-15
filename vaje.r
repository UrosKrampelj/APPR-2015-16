require(dplyr)
require(rvest)
require(gsubfn)

url <- "http://www.sicris.si/public/jqm/rsr_list.aspx?lang=slv&opdescr=rsrSearch&opt=2&subopt=3&code1=rsr&code2=nameadvanced&search_term=name=&psize=%s&hits=36635&page=%s&slng="

podatki <- data.frame()
page <- 100
for (i in 1:2) {
  link <- sprintf(url, page, i)
  stran <- html_session(link) %>% read_html(encoding = "UTF-8")
  tabela <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[1]] %>% html_table() 
  podatki <- bind_rows(podatki, tabela)
}
  
stran %>% html_nodes(xpath="//table[1]//tbody//a[@rel]/@href") %>% 
html_text() %>%
strapplyc("id=(\\d+)") %>%
sapply(. %>% .[[1]] ) %>% as.numeric()

link <- "http://www.sicris.si/public/jqm/rsr.aspx?lang=slv&opdescr=rsrSearch&opt=2&subopt=300&code1=rsr&code2=nameadvanced&psize=100&hits=36635&page=335&count=24&search_term=name=&id=33614&slng=slv&order_by="
podstran <- html_session(link) %>% read_html(encoding="UTF-8")
tocke <- podstran %>% html_nodes(xpath="//table[@id='recap-table']") %>% .[[1]] %>% html_table(dec=",") %>% .[1,]
citati <- podstran %>% html_nodes(xpath="//table[@id='citations-table']") %>% .[[1]] %>% html_table() %>% .[1,]
raziskovalec <- cbind(tocke, citati)
