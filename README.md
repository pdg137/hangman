Cheating hangman player
=======================

Prerequisites:

* ruby
* `/usr/share/dict/words`

Example game:

```
$ ruby lib/play.rb
_____ (used: )
Your guess? a
_____ (used: a)
Your guess? e
_____ (used: ae)
Your guess? i
_____ (used: aei)
Your guess? o
_____ (used: aeio)
Your guess? u
_u___ (used: aeiou)
Your guess? y
_u___ (used: aeiouy)
Your guess? b
_u___ (used: abeiouy)
Your guess? t
_u___ (used: abeiotuy)
Your guess? s
_u__s (used: abeiostuy)
Your guess? r
_u__s (used: abeiorstuy)
Your guess? d
_u__s (used: abdeiorstuy)
Your guess? c
_u__s (used: abcdeiorstuy)
Your guess? f
_u__s (used: abcdefiorstuy)
Your guess? g
_u__s (used: abcdefgiorstuy)
Your guess? h
_u__s (used: abcdefghiorstuy)
Your guess? j
_u__s (used: abcdefghijorstuy)
Your guess? k
_u__s (used: abcdefghijkorstuy)
Your guess? l
_ulls (used: abcdefghijklorstuy)
Your guess? p
_ulls (used: abcdefghijkloprstuy)
Your guess? m
_ulls (used: abcdefghijklmoprstuy)
Your guess? n
nulls - you got it!
```