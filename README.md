# Overview
Tekka is a simple and mode-less Japanese input method in Squeak/Pharo environment.
It's fully implemented in Smalltalk.
Tekka uses a Japanese vocabulary dictionary SKK-JISYO.L, which is NOT included in this package because the dictionary file is distributed under GPL. Tekka's installation script will help you download it.

Tekka is mode-less in the sense that it has neither "alphabet mode", "hiragana mode" nor "katakana mode". It does NOT have an input buffer. Every character typed with the keyboard is inserted into the text. Pressing cmd-j (or ctrl-j) will turn a phrase into a japanese word. There's no distinction between "determined text" and "under conversion text". Every character you see on the screen is already a part of the text.

Tekka is deeply inspired by SKK and Sekka: their simplicity and less-modal human interfaces.
Tekka is partly supported by Japanese MEXT/JSPS KAKENHI Grant Number 23650077.

# INSTALL
* Plan A: Use Iceberg to load this. Choose "default" to install Tekka, or "Tekkazan" to install extension for Google IME API.
* Plan B: 
```
Metacello new
	baseline: 'Tekka';
	repository: 'github://tomooda/tekka/repository';
	load.
```

# DEMO
## Tekka, converting roman letters into Japanese kanjis
[![Tekka, converting roman letters into Japanese kanjis.](http://img.youtube.com/vi/jpehr7-YRSY/0.jpg)](http://www.youtube.com/watch?v=jpehr7-YRSY)

## Tekka, converting English words into Japanese
[![Tekka, converting English words into Japanese](http://img.youtube.com/vi/3jPvuXk6LZk/0.jpg)](http://www.youtube.com/watch?v=3jPvuXk6LZk)

## Tekka, for typing math symbols
[![Tekka, for typing math symbols](http://img.youtube.com/vi/IP2t49TlE5k/0.jpg)](http://www.youtube.com/watch?v=IP2t49TlE5k)

## Tekkazan, an extension package to convert longer phrases with Google IME API
[![Tekkazan, an extension package to convert longer phrases with Google IME API](http://img.youtube.com/vi/3E3fTPEN9Yw/0.jpg)](http://www.youtube.com/watch?v=3E3fTPEN9Yw)
