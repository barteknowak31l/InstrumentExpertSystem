
   
(deftemplate send-to-java
	(slot tresc)
	(slot asercja)
	(slot ile  (default 0))
	(slot odp1 (default -))
	(slot odp2 (default -))
	(slot odp3 (default -))
	(slot wynik (default Nie))
)
  
(deffacts start
(start)  
)

;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule start-up
  ?f <- (start)
  =>
  (retract ?f)
  (assert (send-to-java 
  			(tresc Powitanie)
  			(asercja pytanie1)
  			(ile 0)
  			(wynik Nie)
  
  )))
  
  
;******************************************************************
;Pytania
;******************************************************************
  
  (defrule ile-masz-lat
  ?f1 <- (pytanie1)
  ?f2 <-  (send-to-java)
  =>
  (retract ?f1 ?f2)
  (assert (send-to-java 
  			(tresc pIleLat)
  			(asercja aWiek)
  			(ile 3)
  			(odp1 oMniejNiz6)
  			(odp2 oMniejNiz13WiecejNiz5)
  			(odp3 oWiecejNiz13)
  			(wynik Nie)
  
  )))
  
  (defrule czy-cudowne-dziecko
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aWiek oMniejNiz6)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyCudowneDziecko)
  			(asercja aCzyCudowne)
  			(ile 2)
  			(odp1 oTak)
  			(odp2 oNiePoprostuChceGrac)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  
  (defrule czy-duzo-czasu-na-trening
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (or (aWiek oMniejNiz13WiecejNiz5) (aCzyCudowne oNiePoprostuChceGrac))
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyDuzoCzasu)
  			(asercja aCzyDuzoCzasu)
  			(ile 2)
  			(odp1 oTak)
  			(odp2 oNieChceJakNajszybciej)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-chcesz-denerwowac-rodzine
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyDuzoCzasu oNieChceJakNajszybciej)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyDenerwujeszRodzine)
  			(asercja aCzyDenerwujeszRodzine)
  			(ile 2)
  			(odp1 oNiePrzeszkadaMiTo)
  			(odp2 oNieJestemBachorem)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-masz-nieograniczony-czas
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aWiek oWiecejNiz13)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyMaszNielimitowanyCzas)
  			(asercja aCzyMaszNielimitowanyCzas)
  			(ile 2)
  			(odp1 oTakNawetMamSzofera)
  			(odp2 oNieZaBardzo)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-masz-zdolnosci-muzyczne
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszNielimitowanyCzas oNieZaBardzo)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyMaszZdolnosciMuzyczne)
  			(asercja aCzyMaszZdolnosciMuzyczne)
  			(ile 3)
  			(odp1 oTakJestemWspanialy)
  			(odp2 oTylkoTroche)
  			(odp3 oWcale)
  			(wynik Nie)
  
  )))
  
  (defrule czy-nerwy-ze-stali
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszZdolnosciMuzyczne oTakJestemWspanialy)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyNerwyZeStali)
  			(asercja aCzyNerwyZeStali)
  			(ile 2)
  			(odp1 oBrzmiJakJa)
  			(odp2 oNiezbyt)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  
  (defrule czy-kompozytor
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszZdolnosciMuzyczne oTylkoTroche)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyKompozytor)
  			(asercja aCzyKompozytor)
  			(ile 2)
  			(odp1 oBeethoven)
  			(odp2 oWcale)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-w-centrum-uwagi
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyKompozytor oWcale)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyWCentrumUwagi)
  			(asercja aCzyWCentrumUwagi)
  			(ile 2)
  			(odp1 oTakBedeGwiazda)
  			(odp2 oNieJestemGraczemZespolowym)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule mozart-czy-mccartney
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyKompozytor oBeethoven)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pMozartCzyMcCartney)
  			(asercja aMozartCzyMcCartney)
  			(ile 2)
  			(odp1 oMozart)
  			(odp2 oMcCartney)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-masz-duzy-dom
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (or (aCzyWCentrumUwagi oNieJestemGraczemZespolowym) (aCzyDenerwujeszRodzine oNieJestemBachorem))
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyMaszDuzyDom)
  			(asercja aCzyMaszDuzyDom)
  			(ile 3)
  			(odp1 oZyjeWKosciele)
  			(odp2 oMamDuzoMiejsca)
  			(odp3 oMaleMieszkanie)
  			(wynik Nie)
  
  )))
  
  (defrule czy-chcesz-grac-w-orkiestrze
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszDuzyDom oMamDuzoMiejsca)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyChceszGracWOrkiestrze)
  			(asercja aCzyChceszGracWOrkiestrze)
  			(ile 3)
  			(odp1 oZaDuzoLudziIHalasu)
  			(odp2 oMojeZycieToSymfonia)
  			(odp3 oTylkoBarok)
  			(wynik Nie)
  
  )))
  
  (defrule czy-lubisz-podnosic-ciezary
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyChceszGracWOrkiestrze oMojeZycieToSymfonia)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyLubiszPodnosicCiezary)
  			(asercja aCzyLubiszPodnosicCiezary)
  			(ile 2)
  			(odp1 oSuperman)
  			(odp2 oNiezbyt)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-lubisz-jazz
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszPodnosicCiezary oSuperman)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyLubiszJazz)
  			(asercja aCzyLubiszJazz)
  			(ile 2)
  			(odp1 oJazzToNieMuzyka)
  			(odp2 oPewnie)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-awersja-do-plucia
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszPodnosicCiezary oNiezbyt)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyAwersjaDoPlucia)
  			(asercja aCzyAwersjaDoPlucia)
  			(ile 2)
  			(odp1 oMuzykaPonadHigiene)
  			(odp2 oWoleBycSuchy)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-lubisz-byc-obiektem-zartow
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyAwersjaDoPlucia oWoleBycSuchy)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyLubiszBycObiektemZartow)
  			(asercja aCzyLubiszBycObiektemZartow)
  			(ile 2)
  			(odp1 oLubieSiePosmiac)
  			(odp2 oJestemWrazliwy)
  			(odp3 -)
  			(wynik Nie)
  
  )))
  
  (defrule czy-lubisz-wyzwania
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyAwersjaDoPlucia oMuzykaPonadHigiene)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyLubiszWyzwania)
  			(asercja aCzyLubiszWyzwania)
  			(ile 3)
  			(odp1 oZycieJestZaKrotkie)
  			(odp2 oLubieWyzwania)
  			(odp3 oChcePrawdziweWyzwanie)
  			(wynik Nie)
  
  )))
  
 (defrule czy-grzebiesz-w-trzcinie
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszWyzwania oZycieJestZaKrotkie)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyGrzebieszWTrzcinie)
  			(asercja aCzyGrzebieszWTrzcinie)
  			(ile 2)
  			(odp1 oZaDuzoRoboty)
  			(odp2 oLubieFrustrujaceZadania)
  			(odp3 -)
  			(wynik Nie)
  
  ))) 
  
   (defrule czy-chcesz-w-zespole-z-lat-80
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyGrzebieszWTrzcinie oLubieFrustrujaceZadania)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyChceszGracWZespoleZLat80)
  			(asercja aCzyChceszGracWZespoleZLat80)
  			(ile 2)
  			(odp1 oJesliDostaneSolowke)
  			(odp2 oZdecydowanieNie)
  			(odp3 -)
  			(wynik Nie)
  
  ))) 
  
     (defrule glosno-czy-elegancko
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyGrzebieszWTrzcinie oZaDuzoRoboty)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pGlosnoCzyElegancko)
  			(asercja aGlosnoCzyElegancko)
  			(ile 2)
  			(odp1 oGlosniej)
  			(odp2 oElegancko)
  			(odp3 -)
  			(wynik Nie)
  
  ))) 
  
  
       (defrule wolisz-stac-czy-siedziec
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyChceszGracWOrkiestrze oTylkoBarok)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pWoliszStacCzySiedziec)
  			(asercja aWoliszStacCzySiedziec)
  			(ile 2)
  			(odp1 oStac)
  			(odp2 oSiedziec)
  			(odp3 -)
  			(wynik Nie)
  
  ))) 
  
         (defrule czy-nienawidzisz-sasiadow
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszDuzyDom oMaleMieszkanie)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyNienawidziszSasiadow)
  			(asercja aCzyNienawidziszSasiadow)
  			(ile 2)
  			(odp1 oZPasja)
  			(odp2 oSaCalkiemMili)
  			(odp3 -)
  			(wynik Nie)
  
  ))) 
  
           (defrule czy-masz-poczucie-rytmu
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyNienawidziszSasiadow oZPasja)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyMaszPoczucieRytmu)
  			(asercja aCzyMaszPoczucieRytmu)
  			(ile 2)
  			(odp1 oLudzkiMetronom)
  			(odp2 oTroche)
  			(odp3 -)
  			(wynik Nie)
  
  ))) 
  
             (defrule czy-lubisz-muzyke-folkowa
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyNienawidziszSasiadow oSaCalkiemMili)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc pCzyLubiszMuzykeFolkowa)
  			(asercja aCzyLubiszMuzykeFolkowa)
  			(ile 2)
  			(odp1 oNieJestemHipisem)
  			(odp2 oNoszeKwiatkiWeWlosach)
  			(odp3 -)
  			(wynik Nie)
  
  ))) 
  
  
;******************************************************************
;Odpowiedzi
;******************************************************************

  (defrule odp-violin
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyCudowne oTak)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpViolin)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-recorder
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyDenerwujeszRodzine oNiePrzeszkadaMiTo)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpRecorder)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-harp
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszNielimitowanyCzas oTakNawetMamSzofera)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpHarp)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  
  (defrule odp-comb-and-tissue-paper
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszZdolnosciMuzyczne oWcale)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpCombAndTissuePaper)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-french-horn
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyNerwyZeStali oBrzmiJakJa)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpFrenchHorn)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-organ
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszDuzyDom oZyjeWKosciele)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpOrgan)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-piano
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (or (aCzyChceszGracWOrkiestrze oZaDuzoLudziIHalasu) (aCzyDuzoCzasu oTak) (aCzyNerwyZeStali oNiezbyt) (aCzyWCentrumUwagi oTakBedeGwiazda) (aMozartCzyMcCartney oMozart))
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpPiano)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-tuba
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszJazz oJazzToNieMuzyka)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpTuba)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-double-bass
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszJazz oPewnie)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpDoubleBass)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  
  (defrule odp-viola
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszBycObiektemZartow oLubieSiePosmiac)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpViola)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-cello
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszBycObiektemZartow oJestemWrazliwy)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpCello)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-oboe
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszWyzwania oChcePrawdziweWyzwanie)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpOboe)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  (defrule odp-basson
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszWyzwania oLubieWyzwania)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpBasson)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
    (defrule odp-clarinet
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyChceszGracWZespoleZLat80 oZdecydowanieNie)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpClarinet)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
      (defrule odp-saxophone
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyChceszGracWZespoleZLat80 oJesliDostaneSolowke)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpSaxophone)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
        (defrule odp-trumpet
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aGlosnoCzyElegancko oGlosniej)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpTrumpet)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
          (defrule odp-flute
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aGlosnoCzyElegancko oElegancko)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpFlute)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
            (defrule odp-lute
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aWoliszStacCzySiedziec oSiedziec)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpLute)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
              (defrule odp-harpisord
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aWoliszStacCzySiedziec oStac)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpHarpisord)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
                (defrule odp-percussion
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszPoczucieRytmu oLudzkiMetronom)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpPercussion)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
                  (defrule odp-trombone
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyMaszPoczucieRytmu oTroche)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpTrombone)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
                    (defrule odp-digital-piano
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (aCzyLubiszMuzykeFolkowa oNieJestemHipisem)
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpDigitalPiano)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
                      (defrule odp-acoustic-guitar
  ?f0 <- (czekaj-na-input)
  ?f1 <- (send-to-java)
  (or (aCzyLubiszMuzykeFolkowa oNoszeKwiatkiWeWlosach) (aMozartCzyMcCartney oMcCartney))
  =>
  (retract ?f0 ?f1)
  (assert (send-to-java 
  			(tresc odpAcousticGuitar)
  			(asercja -)
  			(ile 0)
  			(odp1 -)
  			(odp2 -)
  			(odp3 -)
  			(wynik Tak)
  
  )))
  
  
  