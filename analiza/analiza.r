# 4. faza: Analiza podatkov

#Iščemo, kdo je bil najbolj uspešen v klubu
normaliziran <- scale(as.matrix(IGRALCI[c(3:4, 8)]))
matrikarazdalj<-dist(normaliziran)
razdelitev<- hclust(matrikarazdalj, method = "complete")
plot(razdelitev, hang=-1, cex=0.6, main = "USPEŠNOST")
rect.hclust(razdelitev,k=4,border="red")
#Iz tabele vidimo, da so gralci, ki so se najbolj izkazali Dennis Wise,
#George Mills, Dick Spence in Frank Lampard

p <- cutree(razdelitev, k=4)
barve=c("red", "green", "blue","yellow")
table(p)
barve



pairs(normaliziran, col = barve[p])

IGRALCI[p %in% c(1),]

razdelitev1 <- hclust(matrikarazdalj, method = "single")
plot(razdelitev1, hang=-1, cex=0.6, main = "USPEŠNOST 1")
rect.hclust(razdelitev1,k=4,border="red")

#Iščemo najboljšo sezono po uspešnosti
#Normaliziramo število zmag, danih golov in doseženih točk
normaliziran2 <- scale(as.matrix(ZGODOVINA[c(2,5,7)]))
matrikarazdalj2<-dist(normaliziran2)
razdelitev2<- hclust(matrikarazdalj2, method = "complete")
plot(razdelitev2, hang=-1, cex=0.6, main = "USPEŠNOST2")
rect.hclust(razdelitev2,k=4,border="red")
#Vidimo, da so bili najbolj uspešni v letih 1983, 1988 in 2009, ko so tudi osvojili prvo mesto
p2 <- cutree(razdelitev2, k=4)
barve2=c("red", "green", "blue","yellow")
table(p2)
barve2
pairs(normaliziran2, col = barve[p2])
