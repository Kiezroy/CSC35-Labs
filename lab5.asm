#Kyle Nguyen CSC35-01

.intel_syntax noprefix
.data

Introduction:
	.ascii "\nWelcome to the Ancient War! \nIt is your patriotic duty to contribute to the war efforts. \nYou will be sorted into one of four roles to participate in the fight against goblins!\n\0"
FightQuestion:
	.ascii "\nDo you wish to fight on the front lines? (y/n)\n\0"
RangedQuestion:
	.ascii "Do you perform well with ranged weapons? (y/n)\n\0"
MedicineQuestion:
	.ascii "Are you interested in medicine? (y/n)\n\0"

Knight:
	.ascii "You are a knight! Here is your sword, slash them down!\n\0"
Archer:
	.ascii "You are an archer! Here are your bow and arrows, shoot well!\n\0"
Healer:
	.ascii "You are a healer! Here are bandages to heal our wounded!\n\0"
Builder:
	.ascii "You are a builder! Build walls with these bricks to defend our city!\n\0"

.text
.global _start
_start:

	lea rdx, Introduction		#Prints introduction to lab
	call PrintZString
	lea rdx, FightQuestion		#Asks user if they want to fight
	call PrintZString

	call ScanChar			#Gets input from user and compares ascii value
	cmp dl, 121
	je AskRanged			#If user entered y, jumps to AskRanged and skips the rest
	
	jmp AskMedicine			#If user entered n, jumps to AskMedicine

AskRanged:				#User entered y = asks if they do well with ranged weapons
	lea rdx, RangedQuestion
	call PrintZString

	call ScanChar			#Asks for user input and compares to ascii value 
	cmp dl, 121
	je PrintArcher 			#jumps to PrintArcher if = y

	jmp PrintKnight			#jumps to PrintKnight if = n

AskMedicine:
	lea rdx, MedicineQuestion	#User entered n = asks if they are interested in medicine
	call PrintZString

	call ScanChar			#Asks for user input and compares to ascii value
	cmp dl, 121
	je PrintHealer			#jumps to PrintHealer if = y

	jmp PrintBuilder		#jumps to PrintBuilder if = n

#Below code prints all the roles possible

PrintArcher:
	lea rdx, Archer
	call PrintZString
	call Exit

PrintKnight:
	lea rdx, Knight
	call PrintZString
	call Exit

PrintHealer:
	lea rdx, Healer
	call PrintZString
	call Exit

PrintBuilder:
	lea rdx, Builder
	call PrintZString
	call Exit



End: 
	call Exit
