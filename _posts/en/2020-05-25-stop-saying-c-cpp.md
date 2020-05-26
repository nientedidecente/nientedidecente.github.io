---
layout: post
title:  "Please, stop saying you know C/C++!"
date:   2020-05-16 00:00:00 +0200
categories: c cpp development
series: c cpp
author: slaierno
lang: en
lang-ref: stop-saying-c-cpp
---

(Note: this is _not_ a rant, but I am going to rant during the short preface. Sorry.)

## Preface

Ok, relax. Take a deep breath. Now, listen (read) to me: _there is no such language as C/C++_. There is the C, there _are_ the C++_s_ and they are _all different languages_. 

You may know one of them, you may know all of them, but saying "C/C++" just doesn't make any sense.  
Would you ever write in your résumé that you know, e.g., "C/Objective-C"? Or "Java/Kotlin"? If your answer is _"of course not, they are different languages!"_, such answer is correct and you should stop writing "C/C++". Put a damn comma between two different languages.

Hold on, I can sense some of you saying "but in _my_ case it makes sense because...". The general answer is that it would also make sense to write "C, C++". Maybe in your very own case it makes sense...I will address that at the appendix of this article. Please, bear with me until the end.

### Why this article

It happened countless times that I saw resumes, curricula, presentation pages and whatnot saying that a particula person knows "C/C++". I can't state for every one of them, but the people I had to deal with in real life, either knew a decent C and a little bit of C++98 or they knew C++98 (maybe C++11) and they were sure they could write C code with little-to-no adjustments.

The formere where _not_ C++ developers. the latter where _not_ C developers. And I will explain why is that so.  
It is not a crime to not know a language or to know just a little bit of it. But you should at least know what you know and what you do not know.

A lot of this confusion comes from schools and university, so it is very likely not your fault.

### What does it have to do with videogames?

Some of the most widespread programming languages in the videogame industry are C++_s_. It will help to know at least the main differences and how to distinguish between C and C++_s_.

### Why are you repeating C++_s_?

I will explain that.

## Is every C code valid C++ code?

Ok, here is a very simple snippet:

```c
int bar(int* arr, const int size);

int foo(const int size) {
    int arr[size];
    for(int i = 0; i < size; i++) arr[i] = 0;
    return bar(arr, size);
}
```

We do not care about what `bar()` does, just concentrate on `foo()`. Here are two questions:

1. Is this valid C code?
2. Is this valid C++ code?

If you answered anything but:

1. _It depends_. 
2. _It depends_.

...you were wrong.

----

But let us say that we want to be _pedantic_, i.e. strictly following the ISO specifications. You can just add `-pedantic` to any compiler (but MSVC, more on that later).  
The answer are now:

1. It _still_ depends
2. No

Did you get them right? No and you do not even believe me? Here you are:

<iframe width="100%" height="600px" src="https://godbolt.org/e?hideEditorToolbars=true#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:c%2B%2B,selection:(endColumn:24,endLineNumber:9,positionColumn:1,positionLineNumber:1,selectionStartColumn:24,selectionStartLineNumber:9,startColumn:1,startLineNumber:1),source:'int+bar(int*+arr,+const+int+size)+%7B+return+0%3B+%7D%0A%0Aint+foo(const+int+size)+%7B%0A++++int+arr%5Bsize%5D%3B%0A++++for(int+i+%3D+0%3B+i+%3C+size%3B+i%2B%2B)+arr%5Bi%5D+%3D+0%3B%0A++++return+bar(arr,+size)%3B%0A%7D%0A%0Aint+main()+%7B+return+0%3B%7D'),l:'5',n:'0',o:'C%2B%2B+source+%231',t:'0')),k:100,l:'4',m:43.976702281313365,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:g101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:c%2B%2B,libs:!(),options:'-pedantic+-Werror',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C%2B%2B',t:'0')),header:(),l:'4',m:29.946601553494887,n:'0',o:'',s:0,t:'0'),(g:!((h:output,i:(compiler:1,editor:1,fontScale:12,wrap:'1'),l:'5',n:'0',o:'%231+with+x86-64+gcc+10.1',t:'0')),l:'4',m:26.076696165191738,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

Using the latest `gcc` and building with `-pedantic -Werror`...VLAs (Variable-Length Arrays) are just not valid ISO C++ code. In another words, if you declare a C-style array, its size must be known at compile time, you cannot use a variable.

Ok, but this is valid C code, right? Well...

<iframe width="100%" height="600px" src="https://godbolt.org/e#z:OYLghAFBqd5QCxAYwPYBMCmBRdBLAF1QCcAaPECAM1QDsCBlZAQwBtMQBGAFlICsupVs1qgA%2BhOSkAzpnbICeOpUy10AYVSsArgFtaIAEy9V6ADJ5amAHJ6ARpmIgAnKQAOqaYSW1NO/Ua8Hl6KdBZWtroOTq6y8qG0DATMxAR%2BegbGMnKYCj5JKQThNvaOLjLJqekBWdKVRZYlUWXOAJQyqNrEyBwA5JYEANR2KRADAFSDKWSDaLR1gwODXgBemK2DAKQA7ABCg8SYBF20gwAMmwDM%2BzsAIptnAIIPj0s0qBBzC0ur61t7L0GQMW9CmxGImwArLtflD7tdAcCaMQxqC8FtLrdzld9uiruplng1jjFptDLsybsNtMobs8HCMViLginsCDkcTsNRtNSIS1q0cS87kKnktdMxLBANjt9odjsRTsyKdtbr12qwQL1Ib1SAZemcdahNQTpJ1upgtoZLpwdQRNQbWu0ANZcM5nISa7g63QgS7OAB0kLOnG2bu2kMMhgAHIZnAA2Xh6g2kI29HXSEDuu36tWkOCwJBoXRuPDsMgUT6oYulsrIYCcYOkKilgiODMQOz2nV2SwpACemptpCLulUBAA8rRWAOc6QsOLROwu3O8Ic8gA3TAZ2eYAAeuW0rcHOoGcmXrDwdmI/c0WGPpAIxDwPpz7Ro9CYbA4PH4gmEohACQxCkC87AzSB2lQNwEm3ABaNxMHQERFGQQZYIAdUcYgSDQup0CuW5kGcZM4lyBIVDUaoDE4UhTGKSJokEYJvDoKimM8FjaHo0onBo0i8joAoqi0DJBH4hIhIaCIeLE%2Bo2L4%2BpuOaXj2lNLoei4dVNW1XVl1TXcozjWCE0GYBkFQht/U4QYIFwQgcLJa1eU0asy0ta0NnUW0u0dUgEEwZgsCcKUPV6L1SB9aN/WcbZnE4QwIzOBNODi3TZ1TdNMwfHy8xgRAUCrEsy3ISgiyK2t60bZtWFbYh207Wce1oft7xHMdJ2nZd5xEYAl1nfA10UTdt2TPcDyPXoh1PDVZ1A69iD7W8%2BiHR9n2PN86EYFglx/ARDCEHrAMkIRL3AkKoJgzV4MQ5C8FQjCsJw2C8IIojnHTHIBIMCBTHk2i1CUxiaOYhI/pBnxAbKPjPokuSRICaH4nyRTGgYqGKkKP66kKSGVI6dTvy0rUdSTQ1NQMoyTLMiyzismy7KIYh3JowYXPKpnHMMTzvNfInwp9a1AxSkNuDObh4pi5xLkTPTNUyrMfKJy4SdltNst50hNzqnwQG4IA%3D%3D"></iframe>

...it is not always the case. If you are stuck with C90 you are out of luck, VLAs are not valid C90 code. Actually, GCC will allow you to do that if you are not `-pedantic`, but you are out of luck if you are using MSVC, no VLAs allowed whatsoever, neither in C nor in C++.

But...what are VLAs? They are just variable-length arrays (*sic!*) allocated on the stack. Have you ever heard about `alloca()`? Unless you had to deal with some reasonably-big ANSI C code (not school assignments), probably not, and for a good reason.

`alloca` is just like `malloc`, but on the stack! Nice, now we can simulate VLAs in plain old C90, right...?

<iframe width="100%" height="600px" src="https://godbolt.org/e#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:___c,selection:(endColumn:24,endLineNumber:10,positionColumn:24,positionLineNumber:10,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:'%23include+%3Calloca.h%3E%0Aint+bar(int*+arr,+const+int+size)+%7B+return+0%3B+%7D%0A%0Aint+foo(const+int+size)+%7B%0A++++int+*arr+%3D+alloca(sizeof(int)*size)%3B%0A++++for(int+i+%3D+0%3B+i+%3C+size%3B+i%2B%2B)+arr%5Bi%5D+%3D+0%3B%0A++++return+bar(arr,+size)%3B%0A%7D%0A%0Aint+main()+%7B+return+0%3B%7D'),l:'5',n:'0',o:'C+source+%231',t:'0')),k:100,l:'4',m:35.30631624818282,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:cg101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:___c,libs:!(),options:'-pedantic+-Werror+-std%3Dc90',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C',t:'0')),header:(),l:'4',m:31.36035041848386,n:'0',o:'',s:0,t:'0'),(g:!((h:output,i:(compiler:1,editor:1,fontScale:14,wrap:'1'),l:'5',n:'0',o:'%231+with+x86-64+gcc+10.1',t:'0')),l:'4',m:33.33333333333333,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

...uh‽‽‽

Well, if you are accostumed to MSVC or to C99 code, or you just thought that knowing C++ code was enough to write C code...here we are.

In C90 you could not declare variable in the loop declaration. And that is not all, you are only allowed to declare variables at the very beginning of a block. Every declaration must happen before any statement.

This is not a valid C90 snippet either:

```c
{
    int i = 0;
    foo(i);
    int j = 1
    bar(j);
}
```

Because we declared `j` after the statement `foo(i)`.

Now, here is the cursed code adjusted for C90:

<iframe width="100%" height="400px" src="https://godbolt.org/e?hideEditorToolbars=true#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:___c,selection:(endColumn:15,endLineNumber:5,positionColumn:15,positionLineNumber:5,selectionStartColumn:15,selectionStartLineNumber:5,startColumn:15,startLineNumber:5),source:'%23include+%3Calloca.h%3E%0Aint+bar(int*+arr,+const+int+size)+%7B+return+0%3B+%7D%0A%0Aint+foo(const+int+size)+%7B%0A++++int+i+%3D+0%3B%0A++++int+*arr+%3D+alloca(sizeof(int)*size)%3B%0A++++for(%3B+i+%3C+size%3B+i%2B%2B)+arr%5Bi%5D+%3D+0%3B%0A++++return+bar(arr,+size)%3B%0A%7D%0A%0Aint+main()+%7B+return+0%3B%7D'),l:'5',n:'0',o:'C+source+%231',t:'0')),k:100,l:'4',m:48.18288393903868,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:cg101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:___c,libs:!(),options:'-pedantic+-Werror+-std%3Dc90',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C',t:'0')),header:(),l:'4',m:51.81711606096131,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

Confused? Well, that's for a good reason. Maybe you think that C90 is old and deprecated...well, in 2015 I had to work with C90 code written in that very year. We soon migrated to C99...but still I had to deal with it for a while.

_NOTE:_ if we want to be _really_ pedantic, in C11 VLAs are optional, not mandatory. But I did not manage to find any C11 compiler not supporting them. We were lucky this time.

## Dive into the differences

> All right! I will just write in my CV that I know "C, C++" and I will be fine.

Well...no. Not yet.

### C


Here is another question for you:

1. Does C support function overload?

And the answer, again, is:

1. _It depends._

----

First of all, clang has [`__attribute__((overloadable))`](https://clang.llvm.org/docs/AttributeReference.html#overloadable). GCC on the other side, does not have such a wonderful attribute.

But we were `-pedantic` right? 

1. Does ISO C support function overload?

Of course...

1. _It depends._

----

Have you ever heard of `_Generic` selection? Are you familiar with such syntax?

```c
#define foo(val) _Generic((val),      \
                           int: foo_i, \
                          char: foo_c,  \
                        double: foo_d    )(val)
```

If not, you do not know C11. (And of course, this is NOT valid C++ code, no matter how many flags you set)

Now, if we stay in the realm of C, which is such a slow-changing language, if you just write that you know "C" is ok. Maybe you are not familiar with C11 features, but since the only new _syntax_ you should learn is the `_Generic` one...you can adjust pretty quickly. If you are an experienced C99 developer and I want to hire someone for my C11 project, you are pretty much as valuable as a C11 developer with the same experience.

## C++

Ok, maybe you are a decently-experienced C developer, and during a college course you learned about classes, objects and used them with a C++ compiler (maybe [Dev-C++](https://en.wikipedia.org/wiki/Dev-C%2B%2B)!).

You know what a class and a method are. But since your C++ course, you moved into Java, C#, or something else "higher level". And since you know about OOP, you know C and you worked with C++ in the past, you write that "C++" entry in your CV.

If someone read that CV, they would immediately know that you do *not* know C++ and that maybe you know a little bit of C++98 mixed with C. Or, if lucky enough, a little bit of C++11.

Do you remember that I kept writing C++_s_ instead of just C++? Now you will understand why.

Here is a list of some features available as of C++20, without any specific order (count how many of them you know):
* Classes and objects
* Templates
* `constexpr`
* `consteval`
* Static assertions
* Lambdas
* Templated lambdas
* Fold expressions
* Concepts
* Non-type template parameters
* Smart pointers
* `std::variant`
* Structured binding
* `auto`

How was your score? Here is a little table to look at:

| Score | Comment                                                           |
| ----- | ----------------------------------------------------------------- |
| 0     | You do not know any C++ (ok, you are not the target of this post) |
| 1     | You do not know any valuable amount of C++                        |
| 2     | You know C++98                                                    |
| 3-8   | Likely, you know C++11                                            |
| 9-10  | Likely, you know C++14                                            |
| 11-12 | Likely, you know C++17                                            |
| 13-14 | Ok, you know C++20, you won.                                      |

Now, you may think that I am being overly pedantic, that you can move from a version to the other without a little bit of effort.

While that is true, it is true for *any* language. And if I need to hire someone already experienced with C++17, your knowledge of a subset of C++98 is by no means enough. Because nowaday, C++ code can look like:

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

And such a snippet will generate only four line of assembly, only for the `foo()` function, and it will return just 4, without any run-time calculation. Everything is done at compile-time. **Without any optimization activated.** It is all compile-time by standard, every compiler *must* generate such assembly.

Here it is, built with GCC 10.1, with `-std=c++20 -fconcepts -O0 -pedantic -Werror`

<iframe width="100%" height="500px" src="https://godbolt.org/e?hideEditorToolbars=true#g:!((g:!((g:!((h:codeEditor,i:(fontScale:14,j:1,lang:c%2B%2B,selection:(endColumn:2,endLineNumber:13,positionColumn:2,positionLineNumber:13,selectionStartColumn:2,selectionStartLineNumber:13,startColumn:2,startLineNumber:13),source:'template%3Ctypename+T%3E%0Aconcept+Meowable+%3D+requires(T+a)+%7B+a.meow()%3B+%7D%3B%0A%0Atemplate%3CMeowable+...Args%3E%0Aconsteval+int+meow_count(Args%26%26...+args)+%7B%0A++++return+(args.meow()+%2B+...)%3B%0A%7D%0A%0Astruct+Cat+%7B+constexpr+int+meow()+%7B+return+1%3B+%7D+%7D%3B%0A%0Aint+foo()+%7B%0A++++return+meow_count(Cat%7B%7D,+Cat%7B%7D,+Cat%7B%7D,+Cat%7B%7D)%3B%0A%7D'),l:'5',n:'0',o:'C%2B%2B+source+%231',t:'0')),k:100,l:'4',m:50,n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:g101,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'1',trim:'0'),fontScale:14,j:1,lang:c%2B%2B,libs:!(),options:'-std%3Dc%2B%2B20+-fconcepts+-O0+-pedantic+-Werror',selection:(endColumn:1,endLineNumber:1,positionColumn:1,positionLineNumber:1,selectionStartColumn:1,selectionStartLineNumber:1,startColumn:1,startLineNumber:1),source:1),l:'5',n:'0',o:'x86-64+gcc+10.1+(Editor+%231,+Compiler+%231)+C%2B%2B',t:'0')),header:(),l:'4',m:50,n:'0',o:'',s:0,t:'0')),l:'3',n:'0',o:'',t:'0')),version:4"></iframe>

That is not anything remotely similar to what a C++ developer could have seen in the '90s. It's a whole different monstrousity, whether it is a good or a bad thing.

To be honest, that is nothing similar to C++14 code either.

## Epilogue

I hope that you now understand how much difference there is between C and C++ and between C++ versions.

Of course, it is not necessary to write every single version of the language in your CV. It is reasonable e.g. to say you know C++11/14 or C++17/20.

And it is perfectly fine to say that you just know C++98 because you attended that OOP crash course during college. If you are versed in other languages and experienced overall developer, you could be an equally valuable C++20 developer with a little bit of effort.

But it is also important to state what you know and to know what you do not know (how many time did I say the word "know" until now?). Because maybe you cannot go up to the newest version of C++, but it also likely that you are not able to go *down* to the oldest version.

If I ever found myself stuck with an old compiler limited to C++98, I would just switch to C. Not because C++98 is a bad language, but because I work mainly with C (for a living) and C++17/20 (in my side projects). And I honestly do not know what would my toolset be in C++98. Do I have non-type template parameters? What parts of STL are available? Smart pointers are not present...can I use [boost](https://www.boost.org) for them? Delegate constructors are not available...right?

In the end, just a suggestion: if you need to learn C++ in order to enter into the gamedev scene, learn a *modern* C++ and jump right into C++17, at least.

* [Godot](https://godotengine.org) builds flawlessly with C++17.
* [Unreal Engine 4](https://www.unrealengine.com/en-US/) too (well, maybe a little less flawlessly)

Want some open-source stuff? We've got you covered!
* [OpenRCT2](https://github.com/OpenRCT2/OpenRCT2#31-building-prerequisites) _requires_ C++17!
* [Halley](https://github.com/amzeratul/halley) is another very interesting engine built upon C++17.
* [`EnTT`](https://github.com/skypjack/entt) requires C++17 too. Well there is the `cpp14` tag, but last commit was [Sep 2, 2018](https://github.com/skypjack/entt/commits/cpp14).

## TL;DR

**Please, just stop writing C/C++ and state which C++ version you know.**

## Appendix: mixing C and C++

Maybe you use a lot `extern "C" {} ` and mix together C and C++ code for whatever reason. Embedded programming, dealing with old libraries...

Maybe you are really specialized in mixing together C and C++, which is not something anyone can do.

In you case "C/C++" would be actually the right thing to write. But we all know that it is not what the vast majority of people intend. Sadly, since the abuse of such notation, it is a better idea to write something more creative (and verbose):

> Programming languages: C, C++14, C/C++ interface

Here you are.