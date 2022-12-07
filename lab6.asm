.intel_syntax noprefix
.data

Introduction:
	.ascii "\nWelcome to my guessing game! \nTo win a prize, guess the number I am thinking of between 1 and 100!\n\0"
AskInput:
	.ascii "\nGuess: \0"
Winner:
	.ascii "\nYOU WON! Here's a lollipop!\n\0"
Greater:
	.ascii "\nNumber is too high!\n\0"
Less:
	.ascii "\nNumber is too low!\n\0"

RandomNum:			#Creates a label to store the random number generated
	.quad 0

.text
.global _start
_start:

	lea rdx, Introduction	#Introduces the program to the user
	call PrintZString

	mov rdx, 100		#Puts a range of 100 into rdx
	call Random		#Creates a number 0-99
	add rdx, 1		#Makes range 1-100 now
	mov RandomNum, rdx	#Stores random number as RandomNum = rdx (user input)
	
	
While:
	lea rdx, AskInput	#Displays text for user to guess
	call PrintZString

	call ScanInt		#Asks for the user to guess
 
	cmp rdx, RandomNum	#compares input value to RandomNum
	je Correct		#If correct, exits while loop and jumps to Correct label

	cmp rdx, RandomNum	#If wrong and input was larger than random num, jumps to PrintGreater
	jg PrintGreater

	cmp rdx, RandomNum	#If wrong and input was less than random num, jumps to PrintLess
	jl PrintLess

	jmp While		#Keeps the while loop functioning until a jump executes

PrintGreater:
	lea rdx, Greater	#Displays text that user input was greater than random num
	call PrintZString
	
	jmp While		#Goes back to While loop

PrintLess:
	lea rdx, Less		#Displays text that user input was less than random num
	call PrintZString
	
	jmp While		#Goes back to While loop

Correct:
	lea rdx, Winner		#Displays text declaring the user the winner
	call PrintZString
	call End

End:
	call Exit 		#Exits the program
