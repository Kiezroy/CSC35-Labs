#Kyle Nguyen
#CSC35-01

.intel_syntax noprefix
.data

#PART 1: Print Menu

Welcome:
    .ascii "Welcome to Vietnam Express!\n\0"
Pho:
    .ascii "1. Pho (5000 VND)\n\0"
BanhXeo:
    .ascii "2. Banh Xeo (5500 VND)\n\0"
CheThai:
    .ascii "3. Che Thai (2000 VND)\n\0"
Cancel:
    .ascii "4. Order Canceled!\n\0"

#PART 2: Get Selection

AskSelection:
    .ascii "\nEnter your selection:\n\0"

Selection:
    .quad 0

#PART 3: Print Selection

Names:
   .quad Pho
   .quad BanhXeo
   .quad CheThai
   .quad Cancel

Costs:
   .quad 5000
   .quad 5500
   .quad 2000
   .quad 0

YouSelected:
   .ascii "\nYou Selected:\n\0"

#PART 4: Get Money
Input:
    .ascii "\nHow much VND will you be inserting?\n\0"

MoneyInput:
    .quad 0

#PART 5: Print Change

Change:
    .ascii " VND is your change!\n\0"

.text
.global _start
_start:

#Part 1: Prints all the menu options and a welcome text
lea rdx, Welcome
call PrintZString
lea rdx, Pho
call PrintZString
lea rdx, BanhXeo
call PrintZString
lea rdx, CheThai
call PrintZString
lea rdx, Cancel
call PrintZString


#Part 2: Asks for user to select menu item
lea rdx, AskSelection
call PrintZString
call ScanInt
mov Selection, rdx 			  #moves the input into the Selection label

#Part 3: Prints out selection using table 
lea rdx, YouSelected
call PrintZString
mov rdx, Selection     			  #grab the data (1,2,3, or 4) from the label Selection
sub rdx, 1             			  #Subtracts index by 1
mov rsi, rdx           			  #Moves Selection data value into register rsi
mov rdx, [Names + rsi * 8]                #Accesses the Names Table at its location (every 8 bytes b/c its a quad)
call PrintZString

#Part 4: Input amt of money from user
lea rdx, Input
call PrintZString
call ScanInt
mov MoneyInput, rdx

#Part 5: Calculating the change and returning it
mov rdx, MoneyInput
mov rax, [Costs + rsi * 8]                #Access Costs table 
sub rdx, rax                              
call PrintInt
lea rdx, Change
call PrintZString

call Exit

