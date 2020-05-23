---
layout: post
title:  "Hosting per Mendicanti e Accattoni"
date:   2020-05-23 00:00:00 +0200
categories: web
series: webdev
author: vikkio
---

Come probabilmente ho detto in tutti i post che ho scritto fino ad ora, sono completamente pazzo, se per pazzo intendiamo la definizione di Einsteiniana memoria:

> Insanity is doing the same thing over and over and expecting a different result

> La follia sta nel far sempre la stessa cosa aspettandosi risultati diversi.

Ricercando un po' mentre scrivevo questo post ho visto che non ci sono nemmeno prove che il padre della relatività abbia mai detto questo, ma prendiamolo come fatto assodato.

La mia personalissima, e spero innocua, **follia** sta nel creare decine di volte lo stesso progetto in diversi linguaggi di programmazione, ogni volta che per motivi personali o di lavoro sono costretto ad impararne uno nuovo.

Citando un post nel nostro [Discord](https://discord.gg/8SywyRv), channel **#game-dev-prompts**

> in react: https://github.com/vikkio88/ads-react

> in node: https://github.com/vikkio88/ads-cli

> in react-native: https://github.com/vikkio88/ads-native

> in python: https://github.com/vikkio88/pyDsManager

> in java: https://github.com/vikkio88/mister

> in c#: https://github.com/vikkio88/dsmanager

> in php: https://github.com/vikkio88/dsManager-php 

> in vue+php: https://github.com/vikkio88/ads-web https://github.com/vikkio88/ads-api

> mortacci sua, sono 10 anni che riscrivo lo stesso gioco e poi mi annoio e passo ad altro ahahah


Ho riscritto un gioco tipo **Football Manager** almeno 6 volte, non contando quelle che non ho messo su github.

Il gioco in se in più iterazioni aveva bisogno di un posto dove essere hostato, dato che era stato sviluppato come browser game.

E dato che da bravo mendicante e accattone non voglio spendere neanche un centesimo, mi sono dovuto attrezzare in maniera adeguata per rendere questi giochi raggiungibili, senza che quel fine danneggiasse le mie finanze.

Ǹel post di oggi, vi parlerò di un esempio, puramente FrontEnd.


## Puro Fronte Fine
### (quanto fa schifo tradure in italiano termini inglesi)
[La versione React](https://github.com/vikkio88/ads-react) del gioco, gira tutta in memoria nel browser, e usa `localStorage` per i salvataggi, quindi di per se non ha bisogno di alcuna potenza computazionale server, almeno nella prima iterazione MVP (mai ultimata).

Dirai: _hai anche un sito personale, metti la `/build` là e sei a cavallo._

Risponderei: _sì ma perché non cercare, invece, di far fare il lavoro sporco dell'upload a qualcun'altro?

### Impeto
Introducing **surge**: [Surge.Sh](https://surge.sh).

- **Cos'è?**

Uno strumento **GRATUITO** che ti permette di hostare static assets su un CDN e di upparli con un semplice comando da terminale.

- **Com'è?**

È carino, per installarlo:
```
npm i -g surge
```

Adesso, se avete una serie di assets statici in una directory qualsiasi
```
vikkio@lemmiwinks [13:31:56] [~/impeto] 
-> % tree
.
├── banana.png
└── index.html

0 directories, 2 files

```

basta fare
```
vikkio@lemmiwinks [13:31:58] [~/impeto] 
-> % surge .

   Running as **********@*******.**

        project: .
         domain: efficacious-heart.surge.sh
         upload: [======] 100% eta: 0.0s (2 files, 24 bytes)
            CDN: [====================] 100%
             IP: 45.55.110.124

   Success! - Published to efficacious-heart.surge.sh

```
E il vostro sito è raggiungibile, a volo e gratuitamente. Ovviamente il domain name può anche essere personalizzato, o potete addirittura usare un CNAME personalizzato. Potete trovare tutte le info nei loro [docs](https://surge.sh/help/)

con un `list` potete anche vedere tutti quelli che avete pubblicato e se avete crato un account nessuno può sovrascrivere i vostri siti, a meno che non abbia la vostra password e accesso alla vostra email, in tal caso i sideproject sono l'ultima cosa della quale dovreste preoccuparvi.

```
vikkio@lemmiwinks [13:33:35] [~/impeto] 
-> % surge list  

   1590237045816 efficacious-heart.surge.sh             1 minute ago    surge   surge.sh   Standard 
   1589489134249 downara-test2.surge.sh                 1 week ago      surge   surge.sh   Standard 
   1588793679779 downphas2.surge.sh                     2 weeks ago     surge   surge.sh   Standard 
   1588774027365 manzomma1.surge.sh                     2 weeks ago     surge   surge.sh   Standard 
   1588703988966 test-downara-1.surge.sh                3 weeks ago     surge   surge.sh   Standard 
   1588627359988 downara-test.surge.sh                  3 weeks ago     surge   surge.sh   Standard 
   1579621480734 revorbaro-ws.surge.sh                  4 months ago    surge   surge.sh   Standard 
   1578599064171 revorbaro.surge.sh                     4 months ago    surge   surge.sh   Standard 
   1578495770512 scootalite.surge.sh                    4 months ago    surge   surge.sh   Standard 

... altri 70 domini...


   1491083256024 umparmo.surge.sh                       3 years ago     surge   surge.sh   Standard 

```

Ovviamente esiste anche il comando per rimuovere degli assets, qualora non vi servissero più: `teardown`.

- **Perchè?**
Cosa Perchè? Che domanada è? Perchè è **gratis**!

Io personalmente lo uso tantissimo, e nella maggior parte dei progetti con **react** (creati di solito con *crate-react-app*) aggiungo un piccolo npm script per fare deploy automatico post build:

```
"buildDeploy": "GENERATE_SOURCEMAP=false react-scripts build && npm run deploy",
"deploy": "mv build/index.html build/200.html && surge --domain scootalite.surge.sh build/",
```

in questo modo, posso semplicemente digitare
```
npm run buildDeploy
```
E, come potete osservare dai vari switch:
- Genero una build senza source maps (riduco la dimensione dell'artifact di qualche MB)
- Rinomino `index.html` in `200.html` in modo tale che il tutte le richieste vadano processate dal main script di react, e mi permette di avere client side routing grazie a `react-router`.


Credo che per oggi è tutto, nel prossimo articoli altri consigli su come hostare i vostri backend sull'AWS del lavoro mascherandoli come build tools (scherzo).
