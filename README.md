Cheating hangman player
=======================

Prerequisites:

* ruby
* `/usr/share/dict/words`

Example game:

```
$ ruby lib/play.rb
________ (used: )
Your guess? i
________ (used: i)
Your guess? a
________ (used: ai)
Your guess? e
______e_ (used: aei)
Your guess? d
______e_ (used: adei)
Your guess? r
______e_ (used: adeir)
Your guess? n
______e_ (used: adeinr)
Your guess? l
______e_ (used: adeilnr)
Your guess? s
______es (used: adeilnrs)
Your guess? c
c_____es (used: acdeilnrs)
Your guess? h
c_____es (used: acdehilnrs)
Your guess? o
co____es (used: acdehilnors)
Your guess? u
co__u_es (used: acdehilnorsu)
Your guess? t
co__utes (used: acdehilnorstu)
Your guess? m
com_utes (used: acdehilmnorstu)
Your guess? p
computes - you got it!
```