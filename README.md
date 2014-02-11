HBG Scraped
==========

APIer baserat på skrapad data från helsingborg.se som en del av [Öppna Helsingborg Labs](https://oppna.helsingborg.se/?page_id=29), Helsingborgs stads experimentverkstad för öppna data. Alla dessa APIer används på egen risk och bör **inte** användas i produktion då de absolut inte är gjorda för det och kan förändras när som helst. Använd dem istället som exempel på vad Helsingborgs stad kan publicera om intresset finns och [låt oss därför veta vad du tycker](https://oppna.helsingborg.se/?page_id=33). 

Följ Öppna Helsingborg på Twitter: [@oppnadatahbg](https://twitter.com/oppnadatahbg)

##Applikationen
Detta är en Ruby on Rails applikation som hämtar information från helsingborg.se och gör den tillgänglig i JSON-foramt via ett API. Applikationen finns tillgänglig på Heroku för den som vill testa APIerna själv. Notera att vi använder Herokus gratisversion och att prestandan därför är relativt dålig. 

##Detaljplaner API v1
URL: [hbgscraped.herokuapp.com/v1/detaljplaner](http://hbgscraped.herokuapp.com/v1/detaljplaner)

Hämtar information från [helsingborg.se/Medborgare/Trafik-och-stadsplanering/Oversiktsplan-och-detaljplaner/Detaljplanering/detaljplaner-under-arbete](http://www.helsingborg.se/Medborgare/Trafik-och-stadsplanering/Oversiktsplan-och-detaljplaner/Detaljplanering/detaljplaner-under-arbete/).

##Skolmat API v1
URL: [hbgscraped.herokuapp.com/v1/skolmat](http://hbgscraped.herokuapp.com/v1/skolmat)

Hämtar information från [helsingborg.se/Medborgare/Utbildning-och-barnomsorg/Skolmat-lunch-helsingborg/maltidsservice-meny](http://www.helsingborg.se/Medborgare/Utbildning-och-barnomsorg/Skolmat-lunch-helsingborg/maltidsservice-meny/)

##Evenemang API v1
URL: [hbgscraped.herokuapp.com/v1/evenemang](http://hbgscraped.herokuapp.com/v1/evenemang)

Hämtar information från [helsingborg.se/Besokare/gora/listar-interna-evenemang](http://www.helsingborg.se/Besokare/gora/listar-interna-evenemang)

Ange query parametrarna *to* och *from* i formatet YYYY-MM-DD för att begränsa sökningen till vissa datum.