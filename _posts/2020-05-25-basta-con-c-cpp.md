---
layout: post
title:  "Ti prego, smettila di dire che conosci il C/C++!"
date:   2020-05-26 16:00:00 +0200
categories: c cpp development
series: rant
author: slaierno
lang: it
lang-ref: stop-saying-c-cpp
---

(Nota: questo *non* è uno sproloquio, ma sproloquierò nella prefazione. Mi dispiace.)

## Prefazione

Ok, rilassati. Fai un respiro profondo. Ora, ascoltami (leggimi): _non esiste nessun linguaggio denominato C/C++_. C'è il C, ci sono _i_ C++, e sono tutti _linguaggi diversi_.

Potresti conoscerne uno di questi, forse anche tutti, ma dire che conosci il "C/C++" non ha nessun senso.  
Scriveresti mai nel tuo curriculum che conosci, ad esempio, il "C/Objective-C"? O il "Java/Kotlin"? Se la tua risposta è _"certo che no, sono linguaggi diversi!"_, la risposta è giusta e quindi dovresti anche smetterla di scrivere "C/C++". Mettici una maledetta virgola per separare due linguaggi diversi.

Aspetta, percepisco qualcuno dire:
>Ma nel _mio_ caso ha senso perché...

In generale, se ha senso, ha senso anche scrivere "C, C++". Forse nel tuo caso specifico ha davvero senso...ne parlerò nell'appendice di questo articolo. Sopportami fino ad allora, per favore.

## Perché scrivere questo articolo.

Mi è capitato innumerevoli volte di vedere curricula, pagine personali e quant'altro in cui una persona dicesse di conoscere il "C/C++". Non posso generalizzare per ognuna di queste, ma per le persone con le quali ho avuto a che fare di persona, o conoscevano decentemente il C e un po' di C++98, oppure conoscevano il C++98 (a volte il C++11) ed erano convinti di poter scrivere codice in C con un minimo sforzo.

I primi _non_ erano sviluppatori C++. I secondi _non_ erano sviluppatori C.  
Non è un crimine non conoscere un linguaggio o conoscerlo solo in minima parte, sia chiaro. Ma a mio avviso ognuno dovrebbe almeno sapere _cosa sa e cosa non sa_.

## Cosa ha a che fare tutto ciò con i videogiochi?

Alcuni dei più diffusi linguaggi di programmazione nell'industria dei videogiochi sono _i_ C++, soprattutto i motori grafici. Sapere le principali differenze e riuscire a distinguere _i vari_ C++ può essere di grande aiuto.

Non mi metterò a parlare di quali siano queste differenze (non ora, almeno!), ma spero almeno di far luce sulla loro esistenza.

## Perché continui a dire _i_ C++

Ci arriveremo.

## Il codice C è sempre codice valido in C++?

Ok, ecco un piccolo snippet:

```c
int bar(int* arr, const int size);

int foo(const int size) {
    int arr[size];
    for(int i = 0; i < size; i++) arr[i] = 0;
    return bar(arr, size);
}
```

Lasciamo perdere cosa faccia la funzione `bar()` e concentriamoci su `foo()`. Facciamoci quindi due domande:

1. È codice C valido?
2. È codice C++ valido?

Se le risposte non sono state:

1. _Dipende_.
2. _Dipende_.

...be', avete sbagliato.

----

Diciamo che vogliamo essere _pedanti_, cioè vogliamo attenerci strettamente alle specifiche ISO dei linguaggi. Possiamo aggiungere `-pedantic` a qualunque compilatore vogliamo (tranne MSVC, ne parleremo dopo).

Ora le risposte sono:

1. Dipende, _di nuovo_.
2. No.

Hai indovinato? Non hai indovinato e non mi credi? Ecco qui:

<iframe width="100%" height="600px" src="https://godbolt.org/e?hideEditorToolbars=true#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:c%2B%2B,selection:(endColumn:24,endLineNumber:9,positionColumn:1,positionLineNumber:1,selectionStartColumn:24,selectionStartLineNumber:9,startColumn:1,startLineNumber:1),source:'int+bar(int*+arr,+const+int+size)+%7B+return+0%3B+%7D%0A%0Aint+foo(const+int+size)+%7B%0A++++int+arr%5Bsize%5D%3B%0A++++for(int+i+%3D+0%3B+i+%3C+size%3B+i%2B%2B)+arr%5Bi%5D+%3D+0%3B%0A++++return+bar(arr,+size)%3B%0A%7D%0A%0Aint+main()+%7B+return+0%3B%7D'),l:'5',n:'0',o:'C%2B%2B+source+%231',t:'0')),k:100,l:'4',m:43.976702281313365,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:g101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:c%2B%2B,libs:!(),options:'-pedantic+-Werror',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C%2B%2B',t:'0')),header:(),l:'4',m:29.946601553494887,n:'0',o:'',s:0,t:'0'),(g:!((h:output,i:(compiler:1,editor:1,fontScale:12,wrap:'1'),l:'5',n:'0',o:'%231+with+x86-64+gcc+10.1',t:'0')),l:'4',m:26.076696165191738,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

Usando l'ultima versione di `gcc` e compilando con `-pedantic -Werror`...i VLA (Variable-Length Array) non sono codice ISO C++ valido. In altre parole, se dichiariamo un array C-style in C++, la sua dimensione deve essere nota a _compile time_, non possiamo dichiararla tramite variabile.

Ok, ma è codice C valido, giusto? Be'....

<iframe width="100%" height="600px" src="https://godbolt.org/e#z:OYLghAFBqd5QCxAYwPYBMCmBRdBLAF1QCcAaPECAM1QDsCBlZAQwBtMQBGAFlICsupVs1qgA%2BhOSkAzpnbICeOpUy10AYVSsArgFtaIAEy9V6ADJ5amAHJ6ARpmIgAnKQAOqaYSW1NO/Ua8Hl6KdBZWtroOTq6y8qG0DATMxAR%2BegbGMnKYCj5JKQThNvaOLjLJqekBWdKVRZYlUWXOAJQyqNrEyBwA5JYEANR2KRADAFSDKWSDaLR1gwODXgBemK2DAKQA7ABCg8SYBF20gwAMmwDM%2BzsAIptnAIIPj0s0qBBzC0ur61t7L0GQMW9CmxGImwArLtflD7tdAcCaMQxqC8FtLrdzld9uiruplng1jjFptDLsybsNtMobs8HCMViLginsCDkcTsNRtNSIS1q0cS87kKnktdMxLBANjt9odjsRTsyKdtbr12qwQL1Ib1SAZemcdahNQTpJ1upgtoZLpwdQRNQbWu0ANZcM5nISa7g63QgS7OAB0kLOnG2bu2kMMhgAHIZnAA2Xh6g2kI29HXSEDuu36tWkOCwJBoXRuPDsMgUT6oYulsrIYCcYOkKilgiODMQOz2nV2SwpACemptpCLulUBAA8rRWAOc6QsOLROwu3O8Ic8gA3TAZ2eYAAeuW0rcHOoGcmXrDwdmI/c0WGPpAIxDwPpz7Ro9CYbA4PH4gmEohACQxCkC87AzSB2lQNwEm3ABaNxMHQERFGQQZYIAdUcYgSDQup0CuW5kGcZM4lyBIVDUaoDE4UhTGKSJokEYJvDoKimM8FjaHo0onBo0i8joAoqi0DJBH4hIhIaCIeLE%2Bo2L4%2BpuOaXj2lNLoei4dVNW1XVl1TXcozjWCE0GYBkFQht/U4QYIFwQgcLJa1eU0asy0ta0NnUW0u0dUgEEwZgsCcKUPV6L1SB9aN/WcbZnE4QwIzOBNODi3TZ1TdNMwfHy8xgRAUCrEsy3ISgiyK2t60bZtWFbYh207Wce1oft7xHMdJ2nZd5xEYAl1nfA10UTdt2TPcDyPXoh1PDVZ1A69iD7W8%2BiHR9n2PN86EYFglx/ARDCEHrAMkIRL3AkKoJgzV4MQ5C8FQjCsJw2C8IIojnHTHIBIMCBTHk2i1CUxiaOYhI/pBnxAbKPjPokuSRICaH4nyRTGgYqGKkKP66kKSGVI6dTvy0rUdSTQ1NQMoyTLMiyzismy7KIYh3JowYXPKpnHMMTzvNfInwp9a1AxSkNuDObh4pi5xLkTPTNUyrMfKJy4SdltNst50hNzqnwQG4IA%3D%3D"></iframe>

...non è sempre così. Se siamo vincolati a usare il C90 c'è poco da fare, i VLA non sono codice C90 valido. In realtà, GCC ci permette di usarli se non siete `-pedantic`, ma se stiamo usando un compilatore come MSVC non possiamo proprio farci niente, niente VLA, né in C né in C++.

Ma...cosa sono i VLA? Sono solo array di lunghezza variabile (*sic!*) allocati sullo stack. Hai mai sentito parlare della funzione [`alloca()`](https://www.man7.org/linux/man-pages/man3/alloca.3.html)? A meno che tu non abbia dovuto avere a che fare con qualche progetto in ANSI C abbastanza corposo, probabilmente no, e ne hai ben donde.

`alloca` funziona come `malloc`, ma sullo stack! Bello, possiamo simulare i VLA nel caro vecchio C90, giusto...?

<iframe width="100%" height="600px" src="https://godbolt.org/e#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:___c,selection:(endColumn:24,endLineNumber:10,positionColumn:24,positionLineNumber:10,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:'%23include+%3Calloca.h%3E%0Aint+bar(int*+arr,+const+int+size)+%7B+return+0%3B+%7D%0A%0Aint+foo(const+int+size)+%7B%0A++++int+*arr+%3D+alloca(sizeof(int)*size)%3B%0A++++for(int+i+%3D+0%3B+i+%3C+size%3B+i%2B%2B)+arr%5Bi%5D+%3D+0%3B%0A++++return+bar(arr,+size)%3B%0A%7D%0A%0Aint+main()+%7B+return+0%3B%7D'),l:'5',n:'0',o:'C+source+%231',t:'0')),k:100,l:'4',m:35.30631624818282,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:cg101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:___c,libs:!(),options:'-pedantic+-Werror+-std%3Dc90',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C',t:'0')),header:(),l:'4',m:31.36035041848386,n:'0',o:'',s:0,t:'0'),(g:!((h:output,i:(compiler:1,editor:1,fontScale:14,wrap:'1'),l:'5',n:'0',o:'%231+with+x86-64+gcc+10.1',t:'0')),l:'4',m:33.33333333333333,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

...come scusa‽‽‽

Be', se sei abituato a MSVC (in modalità C++) o al C99, o se pensavi di poter scrivere codice in C perché conosci il C++...siamo arrivati al punto della questione.

In C90 non possiamo dichiarare variabili nella dichiarazione di un ciclo `for`. E non è tutto, non possiamo dichiarare variabili da nessuna parte se non all'inizio di un blocco. Tutte le dichiarazioni devono avvenire prima di qualunque _statement_

Nemmeno questo snippet è valido in C90:

```c
{
    int i = 0;
    foo(i);
    int j = 1
    bar(j);
}
```

Perché abbiamo dichiarato `j` dopo lo _statement_ `foo(i)`.

Ora, finalmente, ecco il maledetto codice sistemato per funzionare in C90:

<iframe width="100%" height="400px" src="https://godbolt.org/e?hideEditorToolbars=true#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:___c,selection:(endColumn:15,endLineNumber:5,positionColumn:15,positionLineNumber:5,selectionStartColumn:15,selectionStartLineNumber:5,startColumn:15,startLineNumber:5),source:'%23include+%3Calloca.h%3E%0Aint+bar(int*+arr,+const+int+size)+%7B+return+0%3B+%7D%0A%0Aint+foo(const+int+size)+%7B%0A++++int+i+%3D+0%3B%0A++++int+*arr+%3D+alloca(sizeof(int)*size)%3B%0A++++for(%3B+i+%3C+size%3B+i%2B%2B)+arr%5Bi%5D+%3D+0%3B%0A++++return+bar(arr,+size)%3B%0A%7D%0A%0Aint+main()+%7B+return+0%3B%7D'),l:'5',n:'0',o:'C+source+%231',t:'0')),k:100,l:'4',m:48.18288393903868,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:cg101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:___c,libs:!(),options:'-pedantic+-Werror+-std%3Dc90',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C',t:'0')),header:(),l:'4',m:51.81711606096131,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

Confusi? Be', è comprensibile. Si potrebbe pensare che il C90 è vecchio e deprecato...ma non è così. Nel 2015 ho dovuto lavorare con del codice in C90 scritto quello stesso anno. Certo, abbiamo migrato poco dopo al C99, ma per un po' ci ho dovuto avere a che fare. Ed era codice che doveva girare su una normalissima e recente piattaforma x86-64. Un normalissimo PC.

_NOTA:_ se volessimo essere _davvero_ pedanti, in C11 i VLA sarebbero opzionali e non obbligatori. Ma non sono riuscito a trovare un singolo compilatore C11 che non li supportasse. Siamo stati fortunati.

## Approfondiamo le differenze.

> Bene! Scriverò sul mio CV che conosco il "C, C++" e sarò a posto!

Be'...no. Non ancora.

### C

Ecco un'altra domanda.

1. Il C supporta l'overload?

La risposta, di nuovo, è:

1. _Dipende._

----

Innanzitutto, clang ha [`__attribute__((overloadable))`](https://clang.llvm.org/docs/AttributeReference.html#overloadable). GCC, purtroppo, non ha questo fantastico attributo.

Ma eravamo `-pedantic` giusto?

1. L'ISO C supporta l'overload?

Ovviamente...

1. _Dipende._

----

Mai sentito parlare delle `_Generic` _selections_? Ti suona familiare questa sintassi?

```c
#define foo(val) _Generic((val),      \
                           int: foo_i, \
                          char: foo_c,  \
                        double: foo_d    )(val)
```

Se la risposta è no, non conosci il C11. (E ovviamente, questo _non_ è codice C++ valido, non importa quante _flag_ proviamo a settare.)

Se restiamo nel territorio del C, un linguaggio che evolve molto lentamente, scrivere semplicemente che si conosce il "C", va benissimo. Anche se non si è abituati alle nuove caratteristiche del C11, siccome l'unica nuova _sintassi_ da imparare sarebbe quella delle `_Generic`...ci si adatta abbastanza in fretta. Se tu fossi un esperto sviluppatore C99 e avessi bisogno di qualcuno per il mio progetto in C11, saresti più o meno allo stesso livello di uno sviluppatore C11 di pari esperienza.

## C++

Diciamo che sei uno sviluppatore C di media esperienza e che durante l'università hai imparato cosa sono classi e oggetti e le hai usate con un compilatore C++ (magari [Dev-C++](https://en.wikipedia.org/wiki/Dev-C%2B%2B)!).

Quindi sai cosa sono classi e metodi. Ma da quel corso in C++ sei passato a Java, C# o qualche altro linguaggio di livello "più alto". E visto che la OOP non ti è ignota, che conosci il C e che hai lavorato un po' col C++ in passato, scrivi quel bel "C++" nel tuo CV.

Se qualcuno lo leggesse saprebbe immediatamente che *non* conosci il C++ e che forse conosci un po' C++98 mischiato col C. O, con un po' di fortuna, un po' di C++11.

Ti ricori quando continuavo a scrivere _i_ C++ invece de _il_ C++?

Ecco una lista di qualche _feature_ disponibile ad oggi, con il C++20, senza nessun ordine specifico (contate quante ne conoscete):
* Classi e oggetti
* Template
* `constexpr`
* `consteval`
* Static assertions
* Lambda
* Templated lambda
* Fold expressions
* Concepts
* Non-type template parameters
* Smart pointers
* `std::variant`
* Structured binding
* `auto` (non nel senso di _automatic storage_)

Quanti punti hai fatto? Se meno di 8, non conosci completamente nemmeno il C++11. Inoltre, considera che queste caratteristiche sono state introdotte in diverse versioni, quindi avrai a disposizione un sottoinsieme diverso per ogni versione scelta.

Potresti pensare che sono troppo pignolo, e che puoi tranquillamente muovervi da una versione all'altra con un po' di sforzo.

Il che è vero (soprattutto che sono pignolo), ma sarebbe vero per *qualunque* linguaggio. E se avessi bisogno di assumere qualcuno con una buona esperienza in C++17, la conoscenza di un sottoinsieme del C++98 non sarebbe nemmeno lontanamente sufficiente. Perché oggi, il codice C++ può essere una roba del genere:

```c++
template<typename T>
concept Meowable = requires(T a) { a.meow(); };

template<Meowable ...Args>
consteval int meow_count(Args&&... args) {
    return (args.meow() + ...);
}

struct Cat { constexpr int meow() { return 1; } };

int foo() {
    return meow_count(Cat{}, Cat{}, Cat{}, Cat{});
}
```

E questo snippet genererebbe solo quattro (4) righe di assembly e solo per la funzione `foo()`, e ritornerebbe semplicemente 4, senza nessun calcolo a _run-time_. Sarebbe fatto tutto a _compile-time_. **E senza il bisogno di attivare alcuna ottimizzazione**. Sarebbe _compile-time_ per standard, nel senso che ogni compilatore *deve* generare quel tipo di assembly.

Ecco questo snippet compilato con `gcc` 10.1 e con le flag `-std=c++20 -fconcepts -O0 -pedantic -Werror`

<iframe width="100%" height="500px" src="https://godbolt.org/e?hideEditorToolbars=true#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:c%2B%2B,selection:(endColumn:2,endLineNumber:13,positionColumn:2,positionLineNumber:13,selectionStartColumn:2,selectionStartLineNumber:13,startColumn:2,startLineNumber:13),source:'template%3Ctypename+T%3E%0Aconcept+Meowable+%3D+requires(T+a)+%7B+a.meow()%3B+%7D%3B%0A%0Atemplate%3CMeowable+...Args%3E%0Aconsteval+int+meow_count(Args%26%26...+args)+%7B%0A++++return+(args.meow()+%2B+...)%3B%0A%7D%0A%0Astruct+Cat+%7B+constexpr+int+meow()+%7B+return+1%3B+%7D+%7D%3B%0A%0Aint+foo()+%7B%0A++++return+meow_count(Cat%7B%7D,+Cat%7B%7D,+Cat%7B%7D,+Cat%7B%7D)%3B%0A%7D'),l:'5',n:'0',o:'C%2B%2B+source+%231',t:'0')),k:100,l:'4',m:50,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:g101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:c%2B%2B,libs:!(),options:'-std%3Dc%2B%2B20+-fconcepts+-O0+-pedantic+-Werror',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C%2B%2B',t:'0')),header:(),l:'4',m:50,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

Questa "roba" non assomiglia nemmeno da lontano a quello che avrebbe potuto vedere un programmatore C++ degli anni '90. È un mostro completamente diverso, nel bene o nel male.

In realtà, quella roba lì non assomiglia nemmeno a codice C++14.

## Postfazione

Spero che ora sia più chiaro quanta differenza esiste tra il C e il C++ e tra le varie versioni di C++.

Ovviamente non è necessario scrivere nel CV ogni singola maledetta versione di C++ che si conosce. Mi sembra ragionevole, ad esempio, scrivere che si conosce il C++11/14 o il C++17/20.

E non fraintendermi, va _benissimo_ conoscere solo il C++98 perché hai frequentato un corso di OOP al primo anno di università. Se hai esperienza con altri linguaggi e come sviluppatore in generale, potresti essere un valido sviluppatore C++20 con un minimo di impegno.

Ma è anche importante sapere _cosa si sa e cosa non si sa_ (quante volte ho usato il verbo _sapere_ finora?). Questo perché non solo è difficile avanzare verso le versioni più recenti di C++, ma è anche parimenti difficile "regredire" verso le più vecchie.

Se mai dovessi trovarmi obbligato a usare un vecchio compilatore limitato al C++98, cercherei di utilizzare direttamente il C. Non perché il C++98 sia un brutto linguaggio, ma perché io lavoro principalmente con il C (per lavoro) e con il C++17/20 (nei miei _side project_). E onestamente non ho idea di come sia composta la mia "cassetta degli attrezzi" in C++98. Ci sono i _non-type template parameter_? Quali parti della STL sono disponibili? So che non ci sono gli _smart pointer_...ma posso usare [boost](https://www.boost.org)? I _delegate constructor_ non ci sono...giusto?

Infine, un suggerimento: se devi imparare il C++ per entrare nella scena dello sviluppo videoludico, impara un C++ *moderno* e tuffati direttamente nel C++17, almeno. Anche il C++20, visto che ormai è completo e il supporto nei maggiori compilatori è alle battute finali.

Un paio di motori grafici _C++17-ready_:

* [Godot](https://godotengine.org) compila senza problemi in C++17.
* Anche [Unreal Engine 4](https://www.unrealengine.com/en-US/).

Qualcosa di open-source? Eccoti accontentato!
* [OpenRCT2](https://github.com/OpenRCT2/OpenRCT2#31-building-prerequisites) _richiede_ C++17!
* [Halley](https://github.com/amzeratul/halley) è un altro motore interessanto, fatto in C++17.
* Anche [`EnTT`](https://github.com/skypjack/entt) richiede C++17. Be', in realtà c'è il tag `cpp14`, ma l'ultimo commit è del [2 Settembre 2018](https://github.com/skypjack/entt/commits/cpp14).

## TL;DR

**Ti prego, smettila di scrivere "C/C++" e specifica quale versione del C++ conosci!**

## Appendice: unire C e C++

Magari usi un sacco di `extern "C" {}` e mischi codice C e C++ per una qualunque ragione. Programmazione embedded, vecchie librerie...

Magari sei specializzato nel combinare codice C e C++, una cosa che non tutti sanno fare...

Nel tuo caso, "C/C++" sarebbe effettivamente la cosa giusta da scrivere. Ma tutti sappiamo che non è quello che la maggior parte delle persone intende. Tristemente, a causa dell'abuso che si fa di questa notazione, sarebbe megliore scrivere qualcosa di più originale (e verboso):

> Linguaggi di programmazione: C, C++14, interfaccia C/C++

Ecco fatto.
