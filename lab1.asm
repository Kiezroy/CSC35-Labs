# lab1.asm
# Kyle Nguyen
#
# 1. Assemble : as -o lab1.o lab1.asm
# 2. Link : ld -o a.out lab1.o csc35.o
# 3. Execute : ./a.out

.intel_syntax noprefix
.data
Greeting:
    .ascii "Helloooooo, world!!!!\n\0"

Name:
    .ascii "My name is Kyle Nguyen!\n\0"

Quote:
    .ascii "When you get tired, learn to rest, not to quit!\n\0"

HistoricalYear:
    .ascii "In the year 2003, I was born!\n\0"

.text 
.global _start

_start:
    lea rdx, Greeting
    call PrintZString
    lea rdx, Name
    call PrintZString
    lea rdx, Quote
    call PrintZString
    lea rdx, HistoricalYear
    call PrintZString

    call Exit
