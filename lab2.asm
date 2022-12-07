# lab2.asm
# Kyle Nguyen

.intel_syntax noprefix
.data

NAME:
    .byte 'K'
    .byte 'y'
    .byte 'l'
    .byte 'e'
    .byte ' '
    .byte 'N'
    .byte 'g'
    .byte 'u'
    .byte 'y'
    .byte 'e'
    .byte 'n'
    .byte 0 #Marks the end of this string

MONTHLY:
    .ascii "\n\nHow much do you earn each month?\n\0"
INCOME:
    .quad 0   #Creates a quad with inital value of 0 and will be assigned the inputted monthly earnings

SPENDINGS:
    .ascii "\nHow much do you spend on food, rent, etc...\n\0"
EXPENSES:
    .quad 0 #Creates a quad with initial value of 0 and will be assigned the inputted spendings

RESULT:
    .ascii "\nSo, your cash flow is $\0"

.text
.global _start

_start:
    lea rdx, NAME
    call PrintZString

    lea rdx, MONTHLY
    call PrintZString
    call ScanInt
    mov INCOME, rdx
    
    lea rdx, SPENDINGS
    call PrintZString
    call ScanInt  #Asks for the input
    mov EXPENSES, rdx 

    lea rdx, RESULT
    call PrintZString

    mov rdx, INCOME
    sub rdx, EXPENSES 
    call PrintInt

    call Exit

