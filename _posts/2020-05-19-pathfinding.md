---
layout: post
title:  "La strada, parte prima: i grafi"
date:   2020-05-19 00:00:00 +0200
categories: gamedev update
series: pathfinding
author: kmfrick
---

{% include mathjs %}

Sei un videogiocatore, no?
Lo hai visto succedere almeno una volta. 
Ne sono sicuro.

"Mi si è incastrato il personaggio."

Può succedere per qualunque motivo. 
Una porta, un altro personaggio, una serie di altri personaggi, o semplicemente il nulla cosmico.
Magari il personaggio che si è incastrato sta continuando a ripetere l'animazione della camminata, che neanche Michael Jackson ai tempi d'oro. 
Eppure tu lo sai cosa dovrebbe fare: andare dal punto A al punto B. 
Lo sai perché lo fai ogni giorno: quando vai a correre, quando esci con i tuoi amici, quando fai la spesa. 
Vai dal punto A al punto B e (quasi sempre) non sbatti contro le cose. 

C'è una parte del codice di ogni gioco che si occupa proprio di questo. 
È uno di quei problemi "risolti", in cui le soluzioni sono algoritmi sviluppati quando gli anni iniziavano ancora per 19 e potevi ancora avere Tanenbaum come relatore di tesi. 
Però pensaci un attimo: ti sarà capitato, una volta nella vita almeno, di scontrarti con qualcuno per strada per un motivo o per l'altro. 
Siamo veramente sicuri che sia un "problema risolto" allora?

Beh, ho una buona notizia per te: i computer sono molto più bravi a non sbattere contro le cose rispetto a noi. 
In questa serie di articoli vedremo come fanno a essere così bravi, ma purtroppo non potrai applicare queste conoscenze in modo da non trovarti mai più a dover dire "scusi, potrei passare?" al gruppo di turisti che camminano lenti davanti a te occupando tutta la strada quando sei in ritardo per andare a lezione. 
Però, se riesco a spiegarmi, capirai cosa succede quando il GPS del 2005 montato sulla tua automobile inizia a dirti in continuazione di girare a U, e perché fai bene a lasciarlo sempre spento e usare invece il tuo smartphone.

Il problema in esame si chiama "ricerca del cammino", o più comunemente "pathfinding" o "path planning" per gli amici controllisti. 
È nato nel contesto della robotica, dalla quale derivano molte delle assunzioni alla base, e dei controlli automatici, con i quali ha molti più rapporti di quanto piacerebbe a ogni informatico che si rispetti il quale, per legge, deve odiare i controllisti e tutto ciò che li riguarda. 

Nei successivi articoli di questa serie ci saranno un po' di controlli automatici, ma mi ritengo un informatico che si rispetti, quindi ne parlerò molto male, puoi stare tranquillo. 


## Rappresentazione delle mappe

In questo articolo ci saranno pochi controlli automatici, grazie al cielo. 
Però ci saranno i grafi, e quelli piacciono a persone orribili, come i controllisti, i matematici e gli statistici.
Per qualche motivo, però, anche gli informatici sono riusciti a farseli piacere un sacco, forse perché sono così dannatamente utili. 
Ma cos'è un grafo? 

### Elementi di teoria dei grafi

Non me ne vogliano i matematici per quelllo che sto per dire: un *grafo* è un insieme di *nodi* associati tra di loro in una maniera particolare. 
Un'associazione tra due nodi si chiama *arco* e può avere o meno una *direzione* e un *peso*.
Due nodi associati si dicono *vicini*.

"Eh?"

Ci riprovo.
Questo è un grafo (immagine da Wikipedia):

![graph]({{site.baseurl}}/assets/img/graph.png){:width="30%"}

In particolare, è un grafo *non diretto* perché gli archi non hanno una direzione, quindi se A è vicino di B allora anche B è vicino di A.
Se fosse *diretto* gli archi avrebbero delle freccine a uno dei propri terminali e l'associazione tra archi non sarebbe (necessariamente) simmetrica. 

Questo è anche un grafo *non pesato* perché un nodo può solo essere o non essere vicino di un altro. 
Se fosse *pesato* gli archi avrebbero dei numeri in mezzo e A potrebbe essere vicino a B con peso 15, mentre C potrebbe essere vicino a D con peso 18.
La cosa interessante è che nei grafi diretti pesati, A può essere vicino a B con peso 16 e B può essere vicino ad A con peso 29.

Non preoccuparti, comunque: nei videogiochi, nella maggior parte dei casi, i grafi sono tutti non diretti, pesati, con due soli valori dei pesi: 1 e $$\sqrt{2}$$. 

Perché la radice?
Eh, arrivo. 
Tienila a mente, ma sopporta un altro po' di definizioni.

Un insieme di archi che parte da un nodo A e arriva a un nodo B si chiama *cammino*. 
Un cammino ha una certa *lunghezza* o *costo*, che nel caso dei grafi non pesati è il numero di archi che compongono il cammino mentre nei grafi pesati è la somma dei pesi degli archi che compongono il cammino.
Ad esempio, nel grafo mostrato in figura esiste un cammino di lunghezza 3 tra i nodi 1 e 6: 1->5->4->6. 
Ovviamente puoi arrivare da 1 a 6 anche passando per i nodi 1->2->3->4->6. 
Questo cammino ha lunghezza 4.
Il grafo non è diretto, quindi puoi tranquillamente arrivare da 1 a 6 seguendo 1->2->1->2->1->2->5->4->3->4->6.
Questo cammmino ha lunghezza 10.

Cos'ha di speciale il cammino 1->5->4->6 allora?
È il più breve. 
In teoria dei grafi, questo si chiama *cammino minimo* e il problema di trovare, se esiste, il cammino minimo tra una coppia arbitraria di nodi si chiama *ricerca del cammino minimo*.

La maggior parte degli algoritmi per la ricerca del cammino minimo sono costruiti per trovarlo tra un nodo e tutti gli altri (*single source shortest path*, SSSP) oppure tra tutte le possibili coppie di nodi (*all pairs shortest path*, APSP). 

I grafi sono ottimi per modellare la realtà, in particolare tutto ciò che assomiglia a una rete: i nodi possono essere incroci tra strade, rappresentate da archi il cui peso è la densità del traffico, oppure possono essere serbatoi collegati da tubi, anch'essi rappresentati da archi il cui peso è la capienza.

Noi però stiamo creando videogiochi, quindi ci concentreremo sulla corrispondenza tra griglie e grafi.

### Griglie e grafi

Torniamo indietro a prima che inventassero Pong e facciamo una partita a scacchi.
In questo gioco, i vari pezzi si muovono su una griglia secondo precise regole. 
In particolare, il re può muoversi di un solo quadretto in qualunque delle 8 direzioni che lo circondano: in alto, in alto a destra, a destra, in basso a destra e così via. 
Immaginando una scacchiera 4x4 con solo un re sopra di essa, una cosa del genere:

![grid](https://etc.usf.edu/clipart/42600/42668/grid_42668_lg.gif){:width="30%"}

Quella scacchiera diventa questo grafo qua:

![grid_graph](https://i.stack.imgur.com/3RZ5R.png){:width="30%"}

Bruttino, eh? 
E non ci sono nemmeno i pesi, perché per il re muoversi in alto a destra o solo a destra è indifferente.
Però ha senso, no? Se sei nell'angolo in alto a sinistra (quadretto 0) puoi andare a destra nel quadretto 1, in basso nel quadretto 4 e così via. Se sei in uno dei quadretti centrali (5, 6, 9, 10) puoi andare in qualunque direzione. 

Questa è una semplice mappa quadrata 4x4. 
Nei videogiochi ovviamente ci sono mappe molto complesse, dungeon arzigogolati e labirinti inestricabili, ma il principio è sempre quello: prendi la mappa della zona, ci disegni sopra una griglia arbitrariamente fine, e ogni quadretto della griglia diventa un nodo, con archi che la collegano a quelle adiacenti.

E se c'è un ostacolo? 
O un quadretto non accessibile, perché per esempio c'è l'iconica pila di massi che blocca una porta?
Quel quadretto sarà sempre un nodo, che però non sarà collegato a nessun altro.
Può esistere un nodo senza archi?
Certo che sì.
Sarà un po' solo, ma può esistere.

Ora però, come promesso, ti spiego la radice.

Immagina di essere in una stanza quadrata, di lato 10 metri.
Se ti sposti da un angolo della stanza a un altro adiacente, quanta strada percorri?
Beh...10 metri.
Fin qui ci siamo.
Cosa succede se invece ti sposti da un angolo della stanza a quello di fronte, non adiacente? 
Quanta strada percorri? 
Più di 10 metri, in particolare circa 14 metri, per la precisione $$10\sqrt{2}$$ metri. 

Sì, ho appena usato un paragrafo intero per enunciare l'espressione della diagonale di un quadrato.
Il mio prof di lettere al liceo mi diceva che i miei temi erano troppo lunghi, in effetti.

In ogni caso, ecco quindi come vengono rappresentate le mappe nei videogiochi, nella loro forma più semplice: grafi non diretti, pesati, nei quali gli archi che collegano due quadretti che hanno in comune un lato hanno peso 1 e queli che collegano quadretti che hanno in comune un vertice hanno peso $$\sqrt{2}$$.

Bene, ora abbiamo un modo per rappresentare il mondo che ci circonda. 
Ce ne sono molti altri, con nomi che attizzano un sacco tipo *navmesh*, ma per lo scopo di questo articolo le griglie bastano e avanzano. 
Però ti rovinerò la sorpresa: per quanto riguarda la ricerca del cammino minimo, tutto ciò che si applica alle griglie si applica anche alle navmesh, perché entrambe le strutture vengono comunque convertite in grafi. 
Ciò che cambia è il *grado* di questi grafi e il *controllo* del movimento, ma non è il caso di occuparcene qui.

Nei prossimi articoli vedremo di *fare* qualcosa con queste griglie e questi grafi.

Intanto, ecco cosa fa il tuo GPS: rappresenta la rete stradale del mondo come un grafo in cui alcuni particolari punti di interesse (per semplificare, possiamo pensare siano gli incroci) sono nodi e le strade sono archi, e cerca il cammino minimo tra la tua posizione e la tua destinazione. 

E perché fai bene a tenerlo spento e usare il tuo smartphone? 
Beh, perché il tuo GPS non ha una connessione a internet - di solito - quindi i pesi degli archi sono statici. 
Magari il peso di una strada è semplicemente la sua lunghezza in chilometri, e tu lo sai bene che non sempre la strada più corta è anche quella più veloce. 

I servizi di mappe online, invece, possono aggiornare in tempo reale i pesi degli archi in base ai più disparati fattori: traffico, lavori, eventuali incidenti eccetera eccetera, in modo da fornirti sempre la strada più veloce. 

Non sono stato pagato da nessuna azienda di mappe online per scrivere questo articolo, giuro.
Purtroppo.
