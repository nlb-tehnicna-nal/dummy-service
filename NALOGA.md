# Naloga

1) GitHub organizacija in repozitorij
    - Na svojem GitHub profilu ustvari novo začasno organizacijo.
    - V organizaciji dodaj uporabnika `mhlyak` kot člana organizacije.
    - Ustvari nov repozitorij iz priložene kode: [https://github.com/mhlyak-nlb-naloga/dummy-service](https://github.com/mhlyak-nlb-naloga/dummy-service).
    - Lahko si zamisliš nekaj osnovnih pravil za `main` branch zaščito.

2) Docker Image
    - Implementiraj `./Dockerfile`, ki zgradi sliko za Python aplikacijo v repozitoriju.
    - Uporabi dobre prakse nastavitev in varnostna priporočila, ki se jih spolneš.

3) Docker Compose
    - Implementiraj `./docker-compose.yaml`, ki bo pognal prej zgrajeno Docker sliko.
    - Za verzijo Docker slike uporabi okoljsko spremenljivko.
    - Lokalno zagotovi, da bo storitev na naslovu `http://localhost:8000/health` vrnala rezultat 200.

4) GitHub Actions
    - Implementiraj enostaven GitHub Actions workflow, ki:
        - se sproži na push v `main` branch,
        - zgradi Docker sliko s tagom npr.: `ghcr.io/<tvoj-namespace>/dummy-service:<version>`,
        - zgrajeno Docker sliko naloži v GitHub Packages prej narejene organizacije.
    - Dodaj nov job, ki:
        - prebere točno isto verzijo Docker slike, ki je bila zgrajena v prejšnjem koraku,
        - zažene `docker-compose.yaml` s podano prebrano verzijo,
        - počaka, da je storitev pripravljena, nato preveri `GET http://localhost:8000/health`,
        - če health-check ne vrne OK statusa, naj job vrne napako.

5) To je osnovni pipeline, ki zgradi in zažene service in je primeren za domačo uporabo. Kakšne prilagoditve ali dodatne korake bi predlagal, če veš, da na tem servisu dela več ljudi in teče v okolju, kjer so varnost, zanesljivost in sledljivost izjemno pomembni?
    - Če bi na servisu delalo več ljudi bi dodal še nekaj omejitev:
        - Povečal bi število approvalov za sprejem PR ali pa bi dodal "Code Ownerje" 
        - Ustvaril bi ACC in TEST okolje, razvijalci vse svoje spremembe najprej "zmergali" v ACC pred produkcijskim okoljem
        - Vse okoljske spremeljivke bi hranil v HashiCorp Vault ali GitHub Secrets
        - V pipeline bi dodal bi orodje za skeniranje ranljivost (Trivy ali Snyk)
        - Implementiral bi Blue-Green Deployment strategijo 
        - Omejil bi CPU in RAM v docker-compose ali Kubernetes (da zaščitim ostale servise)
        - Dodal bi logging in metrike (Prometheus in Graphana)
        