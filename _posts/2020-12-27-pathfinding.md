---
layout: post
title:  "La strada, parte seconda: i cammini minimi"
date:   2020-12-27 00:00:00 +0200
categories: gamedev update
series: pathfinding
author: kmfrick
---

{% include mathjs %}

Parte seconda. 
Ci siamo.

"Oh Kevin ma che stavi facendo?"

Mi sono laureato in triennale e sono stato in vacanza con i miei amici - facendo attenzione a non diffondere la COVID-19. 

Ci eravamo lasciati sui grafi, giusto? 
Non ti ricordi cos'è un grafo? 
Male! Fila a (ri-)leggere [il primo articolo]({% link _posts/2020-05-19-pathfinding.md %})!

Nel primo articolo avevo accennato che "ci saranno un po’ di controlli automatici", ma non è ancora arrivato quel momento, per fortuna.
Tua e mia.

In questo articolo trattiamo di come effettivamente si cerca la strada più breve dal punto A al punto B.
Per i colleghi e le colleghe che già si stanno sfregando le mani e oliando la tastiera: non ho *alcuna* pretesa di rigore matematico o informatico in questo articolo.
Niente notazione O grande, niente dimostrazioni, niente sproloqui su come l'algoritmo di Dijkstra sia un ottimo esempio di applicazione ai grafi della programmazione dinamica. 
L'obiettivo di questa serie è dare una introduzione divulgativa alla teoria dei grafi a un "pubblico profano, ma attento", citando un mio professore, cercando di spiegare a livello intuitivo alcune delle idee che stanno dietro alla programmazione di videogiochi, in particolare al codice che fa muovere i personaggi. 

Andiamo avanti? Andiamo avanti. 

## Esplorazione di un grafo in profondità

Ipotizziamo che tu abbia appena traslocato in una nuova città.
Per lavoro, per studiare, non è importante.

Ipotizziamo anche che non ci sia un'emergenza sanitaria globale in corso che obbliga chiunque a barricarsi in casa, e che tu voglia "scoprire" questa nuova città.
Esci da casa tua e prendi una strada a caso. 
Al primo incrocio prendi un'altra strada a caso, e così via finché non ti trovi al punto oltre il quale iniziano a esserci solo case e nulla di interessante da vedere.
A quel punto ti giri, prendi un'altra strada a caso e continui finché non hai visto più o meno tutto il centro, che in praticamente ogni cittadina di questo Paese è tutto quello che si può avere di interessante.

Se ti avventuri in questo modo per la città probabilmente ti troverai a metterci un mucchio di tempo per vederla tutta, passando e ripassando più volte per lo stesso punto.
C'è un modo più "metodico" di vedere una città. 
Non ti consiglio di applicarlo la prossima volta che vedi una città d'arte, ma ehi, se vuoi provarci fai pure.

Esci da casa tua e prendi *la strada più a sinistra*. 
Quando vedi un'intersezione, prendi ancora la strada più a sinistra, e così via.

A un certo punto raggiungerai la periferia e tornerai indietro sui tuoi passi fino all'incrocio precedente.
A quell'incrocio però hai già preso la strada più a sinistra: non la riprendere, prendi *la seconda* da sinistra, e continua a prendere la prima o la seconda da sinistra finché non arrivi in periferia.
Se, a un certo punto, ti trovi a un'intersezione e hai già preso sia la prima che la seconda strada da sinistra, prendi *la terza*. 
Se hai già preso tutte le strade possibili, torna indietro fino all'incrocio ancora precedente, e così via finché non avrai visto tutta la città.

Congratulazioni. 
Hai appena esplorato la tua nuova città mediante una *ricerca in profondità*, o nell'inglese che tanto ci piace *depth-first search* (DFS).
Sei partito da un "nodo radice" (casa tua) e a ogni nuovo nodo (intersezione) hai scelto di continuare secondo un arco (una strada) ben preciso (la strada più a sinistra possibile) tornando indietro solo quando arrivi a un nodo senza figli (in periferia) o di cui hai già visitato tutti i figli. 

Questa immagine (Alexander Drichel, CC BY-SA 3.0)  mostra come si applica la DFS su un grafo.
I nodi verdi sono quelli che vengono esplorati di volta in volta. 

![wiki-dfs](https://upload.wikimedia.org/wikipedia/commons/7/7f/Depth-First-Search.gif){:width="30%"}

Puoi usare le DFS su qualunque cosa che possa essere schematizzato come un grafo o un albero, tipo le cose che potrebbero succedere durante un appuntamento.
Non te lo consiglio, però, di nuovo.

![xkcd-dfs](https://imgs.xkcd.com/comics/dfs.png){:width="100%"}

Immagino sia abbastanza chiaro che trovare la strada per raggiungere un certo punto di interesse da casa tua esplorando l'intera città con una DFS non sia proprio la cosa più efficace. 
Il caffè in cui devi vedere quella tua amica potrebbe trovarsi al lato opposto della città rispetto al punto da cui parti a esplorare, e non puoi mica uscire tre ore prima, siamo seri, su!

Nessun problema. 
Ci viene in soccorso un altro algoritmo a cui vogliamo molto bene.

## Esplorazione di un grafo in ampiezza

C'è un altro modo in cui puoi esplorare la città.
Esci di casa, prendi la prima strada a sinistra, arrivi a un incrocio e prendi nota delle strade che partono da esso. 
Poi torni indietro, sotto casa tua, e prendi la seconda strada da sinistra. 
Arrivi a un incrocio, prendi nota, torni indietro, prendi la terza strada da sinistra e così via finché non finisci le strade che puoi prendere partendo da casa tua. 
A quel punto torni sotto casa tua, riprendi la prima strada da sinistra, arrivi all'incrocio e provi a prendere tutte le strade di cui hai preso nota prima. 
Poi torni indietro fino a casa tua, riprendi la seconda strada da sinistra, arrivi all'altro incrocio e provi a prendere tutte le strade che partono da *quell'incrocio*.

Poi torni indietro, e così via. 
Ancora una volta ci viene in aiuto un'animazione (Blake Matheny, CC BY-SA 3.0):

![wiki-bfs](https://upload.wikimedia.org/wikipedia/commons/4/46/Animated_BFS.gif){:width="30%"}

Questo metodo si chiama *ricerca in ampiezza*, o *breadth-first search* (BFS), e ha pregi e difetti.
Se il bar in cui devi arrivare è subito all'incrocio a cui arrivi prendendo la terza strada da sinistra partendo da casa tua, ci arriverai molto prima con una BFS, mentre con una DFS arriverai fino in periferia due volte e dovrai tornare indietro, mettendoci un sacco di tempo. 
Se invece il bar è quasi in periferia e ci arrivi prendendo sempre la strada più a sinistra, ci arriverai in un battibaleno con una DFS, mentre ti girerai praticamente tutto il centro se volessi applicare una BFS per trovarlo.

Ma allora perché, tornando al nostro esempio di prima, i personaggi nei videogiochi non si fanno questi giri dell'oca prima di arrivarti addosso e picchiarti?

Eh.
Devi ringraziare un informatico olandese.
Signore e signori, a voi...

## Dijkstra

Si pronuncia "dèixtra", con la E aperta e accentata. 
Fisico di formazione, risolutore del problema della concorrenza e tanto altro, ma ti lascerò il piacere di leggere [la pagina di Wikipedia su di lui](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra) e di sentirti assolutamente nessuno.

A lui dobbiamo l'ideazione dell'algoritmo che porta il suo nome e che permette al tuo GPS e ai personaggi dei videogiochi di muoversi in maniera intelligente.
La base è la stessa di una BFS: ogni volta che arrivi a un incrocio, prendi nota degli incroci che potrai raggiungere, poi torni indietro e li esplori in ordine.
L'idea di Dijkstra è di aggiungere un piccolo vincolo: prendi una strada *solo se è una scorciatoia*, e da quel punto in poi *raggiungi quel punto solo con quella scorciatoia*, a meno che non ne trovi *un'altra, ancora più corta*.

Mi spiego meglio: come ben sai, ci sono tanti modi di arrivare a uno stesso punto.
Ti sarà capitato, nella tua vita, di trovare per caso, o perché ti è stato detto, una scorciatoia per arrivare da qualche parte: alla tua università, a casa di tua zia, qualunque posto.
In assenza di fattori esterni che ti portino a non prenderla (ci sono dei lavori, è una strada un po' malfamata ed è buio, devi passare per un altro posto, eccetera) prenderai sempre quella e mai un'altra strada più lunga, il che ha senso: perché dovresti metterci di più per niente?

L'intuizione dietro l'algoritmo di Dijkstra è che prendere quella scorciatoia è anche più vantaggioso per raggiungere *qualunque altro posto* partendo da quel nodo.
Se c'è un supermercato a cento metri da casa di tua zia, e vuoi andare al supermercato, ti conviene usare la scorciatoia e poi fare quei cento metri piuttosto che la strada più lunga e poi, comunque, quei cento metri!

E...niente. 
Fine.
Questo era il difficilissimo e noiosissimo algoritmo di Dijkstra! 
Ecco un'animazione (Ibmua, dominio pubblico) per chiarire meglio:

![wiki-dijkstra](https://upload.wikimedia.org/wikipedia/commons/5/57/Dijkstra_Animation.gif)

...cioè, in realtà no, nel senso che manca un pezzo: il metodo "prendi nota degli incroci che puoi raggiungere e visitali nell'ordine in cui hai preso nota" presuppone l'utilizzo di una *coda*, mentre l'algoritmo di Dijkstra si implementa con le *code di priorità*, che sono un modo per rappresentare un vettore sempre ordinato.
Puoi immaginartelo come un'altra miglioria al metodo di esplorazione: non solo imbocchi una strada solo se rappresenta una scorciatoia, ma quando arrivi da qualche parte che hai già visto, o in periferia, torni indietro fino all'incrocio *più vicino a casa tua* e torni a esplorare da lì. 

Si può dimostrare che, facendo così, *appena arrivi* alla tua destinazione hai *anche trovato la strada più corta*.
Sembra un po' magico, ma spiegarlo e dimostrarlo per bene richiederebbe cose che hanno nomi brutti come "equazione di Bellman nei sistemi a tempo discreto".
Sono cose che piacciono molto ai controllisti, ma noi informatici *odiamo* i controllisti, quindi non ci importa nulla delle loro spoche equazioni!

Scherzo, ovviamente.
I controlli automatici sono una disciplina molto interessante.
Ne vedremo un po' nel prossimo articolo, l'ultimo di questa serie! (Per ora)

