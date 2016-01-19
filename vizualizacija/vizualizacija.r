# 3. faza: Izdelava zemljevida

# Uvozimo zemljevid.


# 3. faza: Izdelava zemljevida
# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")
# Uvozimo zemljevid.
cat("Uvazam zemljevid sveta...\n")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_map_units.zip",
                        "svet", "ne_110m_admin_0_map_units.shp", mapa = "zemljevid",
                        encoding = "Windows-1252")
svet1<- svet[svet$continent %in% c("Europe", "Africa","South America","Asia","North America"),]

drzave <- table(IGRALCI$Nationality)

