# 3. faza: Izdelava zemljevida

# Uvozimo zemljevid.


# 3. faza: Izdelava zemljevida
# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
library(ggplot2)
library(dplyr)

# Uvozimo zemljevid.
cat("Uvazam zemljevid sveta...\n")


svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_map_units.zip",
                         "ne_110m_admin_0_map_units", encoding = "Windows-1252")

svet1<- svet[svet$continent %in% c("Europe", "Africa","South America","Asia","North America", "Oceania"),]




drzave <- table(IGRALCI$Nationality)
names(drzave)[names(drzave) == "England/New Zealand"] <- "New Zealand"
names(drzave)[names(drzave) == "Ivory Coast"] <- "Côte d'Ivoire"

imenadrzav<-names(drzave)
stevilo <- unique(drzave)
stevilo <- stevilo[order(stevilo)]
barve <- topo.colors(length(stevilo))[match(drzave, stevilo)]
names(barve) <- names(drzave)
barve.zemljevid <- barve[as.character(svet1$name_long)]
barve.zemljevid[is.na(barve.zemljevid)] <- "white"


mojsvet <- svet1[svet1$name_long %in% imenadrzav, ]
koordinate <- coordinates(mojsvet)
imena.drzav <- as.character(mojsvet$name_long)
rownames(koordinate) <- imena.drzav

ab <- plot(svet1, xlim=c(-50, 30), ylim=c(-33,70), col=barve.zemljevid, bg="lightblue")
text(koordinate,labels=imena.drzav,pos = 1, cex = 0.5,)
legend("topleft", title = 'število igralcev po državah', bg = "#EEEEEE", text.font = 3,legend = stevilo, fill = topo.colors(length(stevilo)))


