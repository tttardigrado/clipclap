# ClipClap
A terminal based clipboard manager

## Why
There are 2 reasons I made this app:
* At the time I was testing nim, so any kind of app I could made with it I would try to make.
* I had just moved from Gnome to BSPWM, and I lost my clipboard manager (since it was a Gnome extension)

## Stack
### Languages
[Nim](https://nim-lang.org/) - Awesome compiled language with a python like syntax and C like performance. Compiles to C and JavaScript.

### Libraries
[NimClipBoard](https://github.com/genotrance/nimclipboard) - libclipboard wrapper for the nim language

[IllWill](https://github.com/johnnovak/illwill) - Nim library for writing terminal apps

## Commands
### Copy
Copy the currently selected text
* C
* Enter
* Space

### Delete
Delete the currently selected text
* D
* Delete
* BackSpace

### Erase / Clear
Clear the clipboard
* E
* !

### Quit
Quit the app
* Q
* Escape

### Moving
* Down:
    * Down
    * J

* Up:
    * Up
    * K