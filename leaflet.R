library(leaflet) #glowny pakiet

library(raster)#
library(dplyr) #przetwarzanie potokowe
library(tidyverse)
library(leaflet.minicharts) # male koleczka

# podstawowa mapa
m <- leaflet() %>%
  addTiles()# podklad 

#wyswietlenie mapy
m

#wspolrzedne geograficzne srodka Rzeszowa
#(50.0413200,  21.9990100)


m <- leaflet() %>%
  addTiles() %>%  # Domyslny podklad OpenStreetMap
  addCircleMarkers(lat=50.0413200, lng =21.9990100, popup="Rzeszow")
m  # wywolanie mapy


m <- leaflet() %>%
  addTiles() %>% # dodanie domyœlnego podk³adu OpenStreetMap 
  addMarkers(lng=174.768, lat=-36.852, popup="Miejsce narodzin R") #dodanie punktu o okreœlonych wspó³rzêdnych 
  m  # wyœwietlenie mapy




# opcje wyswietlania mapy
  m <- leaflet() %>% addTiles() %>% setView(-71.0382679, 42.3489054, zoom = 18)
  m  # the RStudio 'headquarter'
  m %>% fitBounds(-72, 40, -70, 43)
  m %>% clearBounds()  # widok œwiata
  
  
  #########rozne podklady pod mape
  m %>% addTiles()
  
  m %>% addProviderTiles(providers$TomTom)
  m %>% addProviderTiles(providers$CartoDB.Positron)
  m %>% addProviderTiles(providers$Esri.NatGeoWorldMap)
  
  providers
  https://leaflet-extras.github.io/leaflet-providers/preview/
    

# co mozemy dodawac na mape?
  
# kolka
df = data.frame(lng = runif(100,15,22.3),lat = runif(100,49,55))
df$lat=as.numeric(df$lat)
df$lng=as.numeric(df$lng)

m <- leaflet() %>%
  addTiles() %>% 
  addCircles(df$lng,df$lat)
m




addCircles(map,lng,lat,radius,layerId,group,stroke = TRUE,color,weight,opacity,fill,fillColor,fillOpacity , popup ,popupOptions,label)
#lng, lat to wspolrzedne gdzie ma byæ srodek kolka
#radius to promien kola 
#stroke -czy rysowaæ obrys/kreske wzd³u¿ œcie¿ki (np. granice wielok¹tów lub okrêgów)
#color to kolor okregu
#weight to szerokosc kreski w pikselach
#opacity to nasycenie koloru okregu
#fill=T lub F tzn czy okrag w srodku tez ma byc pokolorowany
#fillColor,fillOpacity to kolor i nasycenie wypelnienia okregu
#popup, label to etykiety
#popupOptions


#addCircleMarkers()

m <- leaflet() %>%
  addTiles() %>% 
  addCircles(m,lng=df$lng,lat=df$lat, color = "red", radius=10,weight = 10)
m




m <- leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(m,lng=df$lng,lat=df$lat, color = "red", radius=10,weight = 10)
m



# znaczniki pinezki
leaflet(df) %>% addMarkers()%>%addTiles()  



m <- leaflet() %>%
  addTiles() %>% 
  addMarkers(m,lng=df$lng,lat=df$lat,  clusterOptions = markerClusterOptions())
m

# klastry
df = data.frame(lng = runif(100,15,22.3),lat = runif(100,49,55))
df$lat=as.numeric(df$lat)
df$lng=as.numeric(df$lng)
leaflet(df) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)




#dodajmy dodatkowa kolumne do zbioru danych - size i color

df$size=runif(100,10,20)
df$color=rep(c("red","orange","green","blue"),times=25)
##############



m <- leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(m,lng=df$lng,lat=df$lat, radius = df$size, color = df$color,weight = 1)
m


#bez wypelnienia

m =leaflet(df) %>% addTiles()%>% addCircleMarkers(radius = ~size, color = ~color, fill = FALSE)
m
###########




#dodawanie obrazkow z biblioteki ikon
setwd("//Vmfrze01/dsm/=Agnieszka G=/Ikony")
Icons <- iconList(
  cloud = makeIcon("cloud-outline.svg", 18, 18),
  flower = makeIcon("flower-outline.svg", 18, 18),
  restaurant = makeIcon("restaurant-outline.svg", 18, 18),
  snow = makeIcon("snow-outline.svg", 18, 18),
  storefront = makeIcon("storefront-outline.svg", 18, 18)
)

df$icon=sample(c("cloud","flower","restaurant","snow","storefront"),100,replace=T)


leaflet(df) %>% addTiles() %>%
  # wybieramy ikone dla ka¿dego punktu
  addMarkers(icon = Icons[df$icon])


#modyfikacja awesomemakrers
# ikony mo¿na dodawaæ tak¿e bezpoœrednio z biblioteki

icon.glyphicon <- makeAwesomeIcon(icon = "heart", markerColor = "blue",
                                  iconColor = "red", library = "glyphicon",
                                  squareMarker =  TRUE)
icon.fa <- makeAwesomeIcon(icon = "flag", markerColor = "red", library = "fa",
                           iconColor = "black",spin=T)
icon.ion <- makeAwesomeIcon(icon = "home", markerColor = "green",
                            library = "ion")

icons <- awesomeIcons(
  icon = "ios-close",
  iconColor = 'black',
  library = 'ion',
  markerColor = df$color
)
# biblioteka glyphicon
leaflet(df) %>% addTiles() %>%
  addAwesomeMarkers(~lng, ~lat, icon=icon.glyphicon, label=paste("(lng= ",round(df$lng,3),",lat= ",round(df$lat,3)," )"))
# biblioteka fontawesome
leaflet(df) %>% addTiles() %>%
  addAwesomeMarkers(~lng, ~lat, icon=icon.fa, label=paste("(lng= ",round(df$lng,3),",lat= ",round(df$lat,3)," )"))
#biblioteka ionicon
leaflet(df) %>% addTiles() %>%
  addAwesomeMarkers(~lng, ~lat, icon=icon.ion, label=paste("(lng= ",round(df$lng,3),",lat= ",round(df$lat,3)," )"))
 # rozne kolory markerów
leaflet(df) %>% addTiles() %>%
  addAwesomeMarkers(~lng, ~lat, icon=icons, label=paste("(lng= ",round(df$lng,3),",lat= ",round(df$lat,3)," )"))


# opis nazw poszczegolnych ikon jest dostêpny na stronie
https://collections.lib.purdue.edu/vizwall/shortcode_icon_fa.html


library(rgdal)# do pobierania ksztaltow 
wojewodztwa<- getData("GADM", country = "PL", level = 1)
# wizualizacje dla danych dla powiatow/ gmin/ wojewodztw

#mozna skorzystac alternatywne z pakietu geodata
library(geodata)
wojewodztwa=gadm(country="PL", level=1,path=tempdir())
############# rysowanie ksztaltów

#wojewodztwa <- readRDS("~/gadm36_POL_1_sp.rds")


#podstawowa mapa bez wypelnienia dla wojewodztw
m<-leaflet()%>%
  addTiles()%>%
  addPolygons(data=wojewodztwa,color="black",weight = 1, fill=F)
 
m



setwd("//vmfrze01/DSM/=Agnieszka G=/Wizualizacje leaflet")
baza<-read.csv2("baza_do_cwiczen.csv")

#bazy trzeba najpierw polaczyc
baza$Kod<-baza$Kod/100000
wojewodztwa$CC_1<-as.numeric(wojewodztwa$CC_1)

wojewodztwa$wynagrodzenie<-0
wojewodztwa$malzenstwa<-0
wojewodztwa$mieszkania<-0

#polaczenie
for (i in 1:16){
  wojewodztwa$wynagrodzenie[i]<-baza$Przeciêtne.miesiêczne.wynagrodzenia.brutto[which(wojewodztwa$CC_1[i]==baza$Kod)]
  wojewodztwa$malzenstwa[i]<-baza$Ma³¿eñstwa.na.1000.ludnoœci.wg.lokalizacji[which(wojewodztwa$CC_1[i]==baza$Kod)]
  wojewodztwa$mieszkania[i]<-baza$przeciêtna.powierzchnia.u¿ytkowa.1.mieszkania[which(wojewodztwa$CC_1[i]==baza$Kod)]
  
}





###paleta kolorow
paleta<- colorNumeric(rainbow(5), domain=wojewodztwa$wynagrodzenie)
paleta<-colorNumeric(hcl.colors(5,"Pastel 1"),domain = wojewodztwa$wynagrodzenie)
paleta<-colorBin(palette.colors(4,"Dark 2"),domain = wojewodztwa$wynagrodzenie)
paleta=colorQuantile("Blues", wojewodztwa$wynagrodzenie, n = 7)


#dostêpne palety
hcl.pals()   
#hcl.colors(15)
palette.pals()
#palette.colors()

m<-leaflet()%>%
  addTiles()%>%
  addPolygons(data=wojewodztwa,color="black",weight = 1, fill=T, fillColor = paleta(wojewodztwa$wynagrodzenie),fillOpacity = 0.5)%>%
  addLegend(title = "Przecietne miesieczne wynagrodzenie brutto", values=wojewodztwa$wynagrodzenie, pal =paleta, opacity = 1)
m


# legenda mo¿e byæ tak¿e  typu factor


wojewodztwa$etykieta=0
ind=which(wojewodztwa$wynagrodzenie<5000)
wojewodztwa$etykieta[ind]="1.Poni¿ej 5000"

ind1=which(wojewodztwa$wynagrodzenie>=5000&wojewodztwa$wynagrodzenie<5500)
wojewodztwa$etykieta[ind1]="2.5000-5500"

ind2=which(wojewodztwa$wynagrodzenie>=5500&wojewodztwa$wynagrodzenie<6000)
wojewodztwa$etykieta[ind2]="3.5500-6000"

ind3=which(wojewodztwa$wynagrodzenie>=6000&wojewodztwa$wynagrodzenie<=6500)
wojewodztwa$etykieta[ind3]="6000-6500"


ind4=which(wojewodztwa$wynagrodzenie>6500)
wojewodztwa$etykieta[ind4]="4.Powy¿ej 6500"


unique(wojewodztwa$etykieta)


### z przedzialami 
###paleta kolorow
paleta<- colorFactor(rainbow(4), domain=wojewodztwa$etykieta)
m<-leaflet()%>%
  addTiles()%>%
  addPolygons(data=wojewodztwa,color="black",weight = 1, fill=T, fillColor = paleta(wojewodztwa$etykieta),fillOpacity = 0.99)%>%
  addLegend(title = "Przecietne miesieczne wynagrodzenie brutto", values=wojewodztwa$etykieta, pal =paleta, opacity = 1)
m




# sztuczne dane
sr=coordinates(wojewodztwa)# srodki wojewodztw
wojewodztwa$wsk1=runif(16,0,50)
wojewodztwa$wsk2=runif(16,0,50)
wojewodztwa$wsk3=100-wojewodztwa$wsk1-wojewodztwa$wsk2



m<-leaflet()%>%
  addTiles()%>%
  addPolygons(data=wojewodztwa,color="black",weight = 1, fill=T, fillColor = paleta(wojewodztwa$etykieta),fillOpacity = 0.99)%>%
  addMinicharts(sr[,1], sr[,2],chartdata = as.data.frame(wojewodztwa@data[,15:17]), layerId = wojewodztwa$NAME_1, type="pie",legend = F,height = 50)
%>%
addLegend(title = "Przecietne miesieczne wynagrodzenie brutto", values=wojewodztwa$etykieta, pal =paleta, opacity = 1, position="bottomright")
m

# dane o bezrobociu dla powiatow

library(raster)
powiaty<- getData("GADM", country = "PL", level = 2)
setwd("//vmfrze01/DSM/=Agnieszka G=/Wizualizacje leaflet")
baza<-read.csv2("bezrobocie.csv")
