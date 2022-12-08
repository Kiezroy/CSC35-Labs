#Kyle Nguyen
#CSC35 Fall 2022 Project

.intel_syntax noprefix
.data

Intro:
	.ascii "-------------------------------------------------------------------------------------------\n"
	.ascii "\nWelcome to the Cat Battle Royale! You can battle aginst up 9 other cats to the death!\n\0"

Credit:
	.ascii "\nCreated by Kyle Nguyen\n\0"

AskPlayers:
	.ascii "\nHow many players? (Players 0-9)\n\0"

DisplayPlayer:
	.ascii "\n\nPLAYER \0"

DisplayHealth:
	.ascii "\nHealth: \0"

DisplayTarget:
	.ascii "\nYour Target: \0"

DisplayOutput:
	.ascii "\nInflicted: \0"

DisplayOutputCont:
	.ascii " points of damage to your opponent!\n\0"

DisplayHeal:
	.ascii "\nHealed: \0"

DisplayHealCont:
	.ascii " points of health to yourself!\n\0"

#Surviving:
#	.ascii "\nSurviving: \n\0"

WinningPlayer:
	.ascii "\nWINNING PLAYER: \0" 



#Names of Players 0-9
Whiskers:
	.ascii "Whiskers\n\0"
Mittens:	
	.ascii "Mittens\n\0"
Fluffy:	
	.ascii "Fluffy\n\0"
Cheddar:	
	.ascii "Cheddar\n\0"
Garfield:
	.ascii "Garfield\n\0"
Figaro:
	.ascii "Figaro\n\0"
Mochi:
	.ascii "Mochi\n\0"
Toulouse:
	.ascii "Toulouse\n\0"
Oliver:
	.ascii "Oliver\n\0"
Cheshier:
	.ascii "Cheshire\n\0"


#Different Attack Labels
PrintGunshot:
	.ascii "1. Gunshot (Inflicts >= 75 damage with 75% chance of missing)\n\0"
PrintSlash:
	.ascii "2. Slash (Inflicts <= 50 damage with 25% chance of missing)\n\0"
PrintHeal:
	.ascii "3. Cat Nap (Heal yourself ? points with 50% chance of missing)\n\0"

AskChoice:
	.ascii "\nYour Choice: \0"


Colon:
	.ascii ": \0"


#Ascii art
GunshotArt:
	.ascii "	                  _    _    _\n"
	.ascii "	                 |_)=A=0=A=(_|                 |\\_/,|   (`\\\n"
	.ascii " ____	 A___________________H___H___o    _____        |o o |__ _)  \n"
	.ascii "|BANG|~ O___________<^         ===__~`\\_/    /'~~|   _.( T  )  '   /\n"
	.ascii "		     '\\__________(_)>.  ___--'   |  ((_ `^--' /_<  \\\n"
	.ascii "			      	 \\/  `-----' '' '-'      (((/   (((/\n\0"
SlashArt:
	.ascii "\n"
	.ascii " _._     _,-'""""`-._\n"
	.ascii "(,-.`._,'(      |\\'-/|\n"
	.ascii "    `-.- \\ )-'( , o o)         SLASH!!!\n"
	.ascii "           `-  \\'_'\"'-\n\0"
HealArt:
	.ascii "\n"
	.ascii "        |\\      _,,,---,,_\n"
	.ascii "ZZZzzz  /, `.-'''    -.  ;-;;,_\n"
	.ascii "       |,4-  ) )-,_. ,\\ (  `'-'\n"
	.ascii "      '---`'(_/--'   '-'\\_)\n\0"

Options:
	.ascii "\nSELECT AN OPTION...\n\0"

Missed:
	.ascii "\n        Missed!\n"
	.ascii "	/\\_____/\\\n"
	.ascii "       /  o   o  \\\n"
	.ascii "      ( ==  ^  == )\n"
	.ascii "      )           (\n"
	.ascii "     (             )\n"
	.ascii "    ( (  )     (  ) )\n"
	.ascii "   (__(__)_____(__)__)\n"


NamesTable:
	.quad Whiskers
	.quad Mittens
	.quad Fluffy
	.quad Cheddar
	.quad Garfield
	.quad Figaro
	.quad Mochi
	.quad Toulouse
	.quad Oliver
	.quad Cheshier

HealthTable:
	.quad 100
	.quad 100
	.quad 100
	.quad 100
	.quad 100
	.quad 100
	.quad 100
	.quad 100
	.quad 100
	.quad 100

Damage:
	.quad 0

Healed:
	.quad 0

PlayerAmt:
	.quad 0

SurvivingPlayers:
	.quad 0

AttackChoice:
	.quad 0

.text
.global _start
_start:

	lea rdx, Intro
	call PrintZString

	lea rdx, Credit
	call PrintZString

	lea rdx, AskPlayers
	call PrintZString

	call ScanInt
	mov PlayerAmt, rdx		#PlayerAmt = User input (rdx) 
	
	mov SurvivingPlayers, rdx	#SurvivingPlayers set to PlayerAmt

	mov rax, 0			#Current player (rax) = 0

While:
#	lea rdx, Surviving			#Can uncomment to test amount of surviving players
#	call PrintZString

	mov rdx, SurvivingPlayers
#	call PrintInt

	cmp rdx, 2			#Checks if surviving is <2, if so, jumps to End
	jl End	

	mov rdx, [HealthTable + rax * 8]	#Checks if current player's health < 1 (dead), if so, jumps to NextPlayer
	cmp rdx, 1
	jl NextPlayer

	lea rdx, DisplayPlayer		#Displays current player
	call PrintZString
	mov rdx, rax
	call PrintInt

	lea rdx, Colon			#Inserts a colon in between player number and their name
	call PrintZString

	mov rdx, [NamesTable + rax * 8]	#Access table to display the special name of current player
	call PrintZString

	lea rdx, DisplayHealth		#Displays current player's health
	call PrintZString
	mov rdx, [HealthTable + rax * 8]
	call PrintInt	

	Target:				#Label here provided to go back just in case user inputs incorrect target out of index

	lea rdx, DisplayTarget		#Prints and asks for target
	call PrintZString

	call ScanInt
	mov rcx, rdx			#Stores target as rcx = rdx

	cmp rcx, 0			#If user enters negative number or out of bounds, jumps back to target
	jl Target

	cmp rcx, PlayerAmt
	jge Target

	lea rdx, Options		#Displays "SELECT AN OPTION..." to the screen
	call PrintZString

	lea rdx, PrintGunshot		#Prints the attack options
	call PrintZString

	lea rdx, PrintSlash
	call PrintZString

	lea rdx, PrintHeal
	call PrintZString
	
	Choice:				#Label here is provided to go back just in case user inputs incorrect number
	
	lea rdx, AskChoice		#Asks user to choose attack
	call PrintZString

	call ScanInt
	mov AttackChoice, rdx		#Moves user input into AttackChoice

	jmp GenerateRandom		#Generates a random damage based on attack choices

	
	Continue:


	mov rdx, [HealthTable + rcx * 8] 	#Access target's health
	sub rdx, Damage				#Subtracts current health by Damage
	mov [HealthTable + rcx * 8], rdx	#Updates target's health

	NextPlayer:				#Checks if the next player (rax) = PlayerAmt, if so jumps to Reset back to 0

		add rax, 1
		cmp rax, PlayerAmt
		
		je Reset

	ContinueTwo:

	#For Loop to count surviving players

	mov rbx, 0		#Counts surviving players
	mov rdi, 0		#Acts as i counter
	mov rsi, 0		#counter for current surviving player

	jmp Loop

	Loop:
		cmp rdi, PlayerAmt		#If counter = PlayerAmt, terminates
		je EndLoop

		mov rdx, [HealthTable + rdi * 8]	#Loops through all players to check if alive
		cmp rdx, 1
		jge Alive				#If alive, will increment counter (rbi) and ppl alive (rbx)

		add rdi, 1			#If not alive, increments counter and goes back to Loop
		jmp Loop
	EndLoop:
		mov SurvivingPlayers, rbx	#Updates surviving as SurvivingPlayers = rbx

	jmp While

Alive:
	add rbx, 1		#Increments the amount of surviving players
	add rdi, 1		#Increments the i counter

	mov rsi, rdi		#Makes the current i counter the current surviving player (helps to be displayed in the screen)
	jmp Loop

Reset:	
	mov rax, 0		#Resets to player 0 and jumps to continue in order to count surviving players
	jmp ContinueTwo		

GenerateRandom:			#Generates random number

#	mov rdx, 100		#rdx = 100				#Uncomment to make all attacks have random number btw 1-100
#	call Random		#Range of 0-99
#	add rdx, 1		#Range of 1-100
#	mov Damage, rdx		#Stores the randomly generated number

	#Now compares user's attack choice and jumps to appropriate attack

	mov rdx, AttackChoice

	cmp rdx, 1
	je GenerateGunshot
	
	cmp rdx, 2
	je GenerateSlash

	cmp rdx, 3
	je GenerateHeal

	jmp Choice		#If user has invalued input (not 1-3) asks to re-enter by jumping to Choice (above)


#Setting color codes that can be called to change color of text (damage is in red, healed is in green, white return to OG text)
Red:
	mov rdx, 1
	call SetForeColor
	ret
Green:
	mov rdx, 2
	call SetForeColor
	ret
White:
	mov rdx, 7
	call SetForeColor
	ret



MissedAttack:			#Attack is missed so damage becomes 0
	lea rdx, Missed
	call PrintZString

	mov rdx, 0
	mov Damage, rdx
	mov Healed, rdx
	ret


#Generates random numbers for each type of attack and displays it

GenerateGunshot:

	#Make call to GunshotChance and returns (continues)
	call GunshotChance 

	lea rdx, DisplayOutput
	call PrintZString

	call Red		#Makes all text red

	mov rdx, Damage
	call PrintInt

	call White		#Makes all text white again

	lea rdx, DisplayOutputCont
	call PrintZString

	jmp Continue

GunshotChance:			#25% chance of landing the attack and damage ranges from 75-100
	mov rdx, 100
	call Random		#Number range of 0-100

	cmp rdx, 25		#If number is < 25, execute attack 
	jge MissedAttack	#If number is >= 25 (25-100) (75% chance of missing attack), jumps to missed attack

	mov rdx, 25		#Random number of 0-25 to subtract from 100 (creates a range of >=75 damage done)
	call Random

	mov rbp, 100
	sub rbp, rdx		#Gunshot number is btw 100-75

	mov Damage, rbp

	lea rdx, GunshotArt	#Prints ascii art b/c attack landed!
	call PrintZString

	ret
		

GenerateSlash:
	#Make call to SlashChance and returns (continues)
	call SlashChance

	lea rdx, DisplayOutput
	call PrintZString

	call Red

	mov rdx, Damage
	call PrintInt

	call White

	lea rdx, DisplayOutputCont
	call PrintZString

	jmp Continue

SlashChance:			#75% chance of landing attack and damage ranges from 1-50
	mov rdx, 100		
	call Random		#Number range of 0-100

	cmp rdx, 25		#If number is < 25 (0-24), will jump to MissedAttack
	jl MissedAttack	        #Skips over if random number rdx is >= 25 (25-100)

	mov rdx, 50
	call Random
	add rdx, 1		#Number range of 1-50

	mov Damage, rdx

	lea rdx, SlashArt	#Prints ascii art b/c attack landed
	call PrintZString

	ret

GenerateHeal:
	#Make call to HealChance and returns (continues)
	call HealChance

	lea rdx, DisplayHeal
	call PrintZString

	call Green

	mov rdx, Healed
	call PrintInt

	call White

	lea rdx, DisplayHealCont
	call PrintZString

	jmp NextPlayer

HealChance:			#50% chance of landing attack and heal is a random number btw 1-100
	mov rdx, 100
	call Random		#Number range 0-100
	
	cmp rdx, 50		
	jl MissedAttack

	mov rdx, 100
	call Random
	add rdx, 1		#Healing range of 1-100

	mov Healed, rdx

	add [HealthTable + rax * 8], rdx	#Adds random number to health of current player
	mov rdx, [HealthTable + rax * 8]

	cmp rdx, 100
	jg Modify			#If added health > 100, sets the Health to max of 100

	lea rdx, HealArt
	call PrintZString

	ret
Modify:
	mov rdx, 100
	mov [HealthTable + rax * 8], rdx 

	lea rdx, HealArt
	call PrintZString

	ret
	

End:
	lea rdx, WinningPlayer
	call PrintZString

	mov rdx, [NamesTable + (rsi - 1) * 8]		#Access table of winning name and displays, -1 b/c index starts at Player 0
	call PrintZString
	
	call Exit
