#Kyle Nguyen
#CSC35-01

.intel_syntax noprefix
.data

PetQuestion:
	.ascii "Did you get an animal pet? (1=yes, 2=no)\n\0"

HouseQuestion:
	.ascii "Are you afraid of what house you will be sorted into? (1=yes, 2=no)\n\0"

MuggleQuestion:
	.ascii "Are you a muggle-born? (1=yes, 2=no)\n\0"

WandQuestion:
	.ascii "Oh, did you get a wand yet? (1=yes, 2=no)\n\0"

Stress:
	.ascii "\nYour total stress level is at \0"

Encourage:
	.ascii "\nYou got this! Use that wizard brain of yours and keep pushing through!\n\0"

Cocoa:
	.ascii "\nWOW! Much stress! Here is some delicious hot cocoa to soothe your nerves!\n\0"

.text
.global _start
_start:
	lea rdx, PetQuestion	#Asks the user if they received a pet yet
	call PrintZString	#Prints the question out
	call ScanInt		#Asks for user input
	cmp rdx, 1		#Compares user input in rdx to 1
	je Question2		#If user enters 1, skips over add and jumps to Question2
	add rax, 15 		#If user entered 2, je is not executed and 15 is added to a new register storing the total

Question2:
	lea rdx, HouseQuestion
	call PrintZString
	call ScanInt
	cmp rdx, 2
	je Question3
	add rax, 30

Question3:
	lea rdx, MuggleQuestion
	call PrintZString
	call ScanInt
	cmp rdx, 2
	je Question4
	add rax, 30

Question4:
	lea rdx, WandQuestion
	call PrintZString
	call ScanInt
	cmp rdx, 1
	je Level
	add rax, 25

Level:
	lea rdx, Stress		#Prints the total amount of stress
	call PrintZString

	mov rdx, rax		#Prints the numberical value of stress
	call PrintInt

#Use an if else statement to determine if student should be given hot cocoa	
Compare:
	mov rdx, rax   		#Gets the running total
	cmp rdx, 50    		#Compares running total to 50
	jge Then		#If running total >= 50 then it jumps to Then and dispenses cocoa
	
	lea rdx, Encourage	#If running total < 50 then Encourage label is printed 
	call PrintZString
	jmp End			#Jumps to the End
	
Then:	
	lea rdx, Cocoa		#Prints out hot cocoa line
	call PrintZString

End:
	call Exit
	
	
