# ConvertFrom-ItermColoursToHex

Given an iTerm colour scheme outputs the colours in standard hex RGB format to allow easier conversion to other terminals.

## Installation
```
PS> Import-Module ./ConvertFrom-ItermColoursToHex.psm1
```

## Usage
```
PS> [xml](Get-Content ./deuteranopia.itermcolors) | ConvertFrom-ItermColoursToHex

Black                : #000000
Red                  : #999900
Bright Green         : #0000FF
Bright Yellow        : #FFFFBF
Bright Blue          : #8080FF
Bright Magenta       : #FFFF80
Bright Cyan          : #BFBFFF
Bright White         : #FFFFFF
Green                : #000099
Yellow               : #999973
Blue                 : #4D4D99
Magenta              : #99994D
Cyan                 : #737399
White                : #C4C4C4
Bright Black         : #6C6C6C
Bright Red           : #FFFF00
Background           : #000000
Bold Text            : #C4C4C4
Cursor Background    : #C4C4C4
Cursor Foreground    : #000000
Text                 : #C4C4C4
Selected Foregrond   : #C4C4C4
Selection Background : #000000
```
