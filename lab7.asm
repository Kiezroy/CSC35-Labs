#Kyle Nguyen
#CSC35-01 Lab 7

.intel_syntax noprefix
.data

askUser:
	.ascii "How many bubblegum sticks were in the bill?\n\0"

askSplit:
	.ascii "How many bubblegum chewers are splitting the bill?\n\0"
numberSplit:
	.ascii "Okay, ladies and gentlemen, please give \0"
numberSplitCont:
	.ascii " bubblegum sticks each!\n\0"


.text
.global _start
_start:
	lea rdx, askUser
	call PrintZString

	call ScanInt		#Asks for input to user
	mov rcx, rdx		#Stores rcx as user input
	
Do:	
	lea rdx, askSplit
	call PrintZString

	call ScanInt
	mov rbx, rdx		#Stores rbx as number of people

	cmp rbx, 0		#Do While loop, if user enters input <=0, it keeps asking for another input
	jle Do

	mov rax, rcx		#Allows rax to be divided rather than rdx
	cqo			#Sign extend
	idiv rbx		#Divides rax by number stored in rbx (num of ppl)

	lea rdx, numberSplit
	call PrintZString

	mov rdx, rax		# rdx=rax so can be displayed			
	call PrintInt	

	lea rdx, numberSplitCont
	call PrintZString


	
	call Exit

