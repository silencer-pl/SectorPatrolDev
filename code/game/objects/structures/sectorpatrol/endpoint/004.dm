/obj/structure/eventterminal/puzzle04/crypt_doorlock
	name = "customized computer terminal"
	desc = "A standard computer terminal without any visible imprints. One of its sides is open and several cables are dangling out. Activated by standing in its proximity. It appears to be in standby mode."
	desc_lore = "Unlike the typical LNT, customized terminals are exceedingly rare on spaceships, partially due to the cost of the parts needed to maintain them and high chance of Crystalline contamination during Hyperspace jumps and partially because unrestricted software and hardware modifications can be a genuine threat to the lives of everyone on board a ship or installation. Getting found with one of those is typically at least grounds for an immediate and unpleasant CMISRS investigation."
	puzzlebox_id = "crypt_doorlock"
	plane = GAME_PLANE
	var/puzzle_complete = FALSE
	var/puzzlebox_phrase_1 = FALSE
	var/puzzlebox_phrase_2 = FALSE
	var/puzzlebox_phrase_3 = FALSE
	var/puzzlebox_parser_mode = "HOME"
	var/puzzlebox_unique_message_seen = FALSE

/obj/structure/eventterminal/puzzle04/crypt_doorlock/attack_hand(mob/user as mob)
	var/user_loc_start = get_turf(user)
	if(!puzzlebox_user)
		puzzlebox_user = usr.real_name
	if(puzzlebox_user != usr.real_name)
		for (var/mob/living/carbon/human/h in range(2, src))
			if (h.real_name == puzzlebox_user)
				to_chat(usr, narrate_body("Someone is already using this terminal."))
				return
		puzzlebox_user = usr.real_name
	if (puzzle_complete == TRUE)
		to_chat(usr, narrate_body("The terminal does not respond."))
		puzzlebox_user = null
		return
	if (puzzlebox_global_status < 6)
		to_chat(usr, narrate_body("The terminal displays a random looking chain of numbers and letters and does not react to you pushing any of its keys."))
		message_admins("[key_name_admin(usr)] used the crypt door lock before the global flag was set.")
		puzzlebox_user = null
		return
	if (puzzlebox_global_status == 6)
		if (!puzzlebox_parser_mode) //Idiotproofing :P
			puzzlebox_parser_mode = "HOME"
		//HOME
		if (puzzlebox_parser_mode == "HOME")
			if (puzzlebox_pythia_sign == "1")
				to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
			if (puzzlebox_pythia_sign == "0")
				puzzlebox_pythia_sign = pick(5;"1", 95;"0")
				if (puzzlebox_pythia_sign == "1")
					to_chat(usr, narrate_body("The screen goes blank. For a few seconds, you feel incredibly anxious about whatever is behind the door next to the terminal, like something important waits there. The feeling passes as the terminal glitches, then starts to print:"))
					log_game("[key_name(usr)] saw a Pythia glitch at the crypt lock terminal.")
					message_admins("[key_name_admin(usr)]  saw a Pythia glitch at the crypt lock terminal.")
				if (puzzlebox_pythia_sign == "0")
					to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
			terminal_speak("HOME SCREEN")
			terminal_speak("PLEASE USE THE HELP COMMAND WHEN YOU CAN.")
			terminal_speak("COMMANDS AVAILABLE: HELP, LIST, EXIT, UNLOCK, MESSAGE")
			puzzlebox_parser_mode = "HOME_INPUT"
			attack_hand(user)
		if (puzzlebox_parser_mode == "HOME_INPUT")
			var/user_loc_current = get_turf(user)
			if (user_loc_start != user_loc_current)
				to_chat(user, narrate_body("You moved away from the console!"))
				puzzlebox_user = null
				return
			terminal_speak("> _")
			var/puzzlebox_parser_input = tgui_input_text(usr, "The terminal is in HOME mode and awaits your input. HELP, LIST and EXIT are universal commands.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
			if (!puzzlebox_parser_input)
				puzzlebox_user = null
				return
			terminal_speak("> [puzzlebox_parser_input]")
			if (puzzlebox_parser_input == "HOME" || puzzlebox_parser_input =="home")
				puzzlebox_parser_mode = "HOME"
				attack_hand(user)
			if (puzzlebox_parser_input == "HELP" || puzzlebox_parser_input =="help")
				terminal_speak("It is done and we are finally on a stable thread. I have set everything up and am confident that either Cassandra herself or one of the new Arbiters will reach this place first.")
				terminal_speak("If it is the former, I left a few parting words for you in the message buffer.")
				terminal_speak("If it's the latter, you can look too, but know that Cassandra will not appreciate this. Of course, seeing what we put you through, we aren't really in a position to tell you what to do and you are perhaps entitled to some of our thoughts and motivations, but no one likes to have their private lives looked at.")
				terminal_speak("Our legacy... Your legacy now lies behind this door in what very appropriately was called the 'Crypt'.")
				terminal_speak("The door is locked. Cassandra will know how to open it. Prospective arbiters will need to do some legwork.")
				terminal_speak("If you do not know what any of this means and feel you need to see what's on the other side of this door, you will need to find some of Cassandra's physical AAR records. Yes, this was one of the few things DV did not touch when they ransacked the place.")
				terminal_speak("Three folders. Three PID keys, small plastic devices, in colors matching the folders. If you are interested in chronology, the order is RED, BLUE, YELLOW.")
				terminal_speak("Decrypt them with the machine in the main room. Play them. Wave patterns extracted from them at random will trigger their respective lock color as the entry is played. Use UNLOCK")
				terminal_speak("Sorry for the trickery, but without these extra steps there are too many near misses.")
				terminal_speak("I have also left a more detailed confession in the bowels of this station, but that you will have to find for yourself.")
				terminal_speak("It is time. For what it is worth, you all made my existence mean something in the end. And that means a lot.")
				terminal_speak("Please be nice to her. Despite everything, she knows very little of how to interact with us. ")
				terminal_speak("Thank you.")
				attack_hand(user)
			if (puzzlebox_parser_input == "LIST" || puzzlebox_parser_input =="list")
				terminal_speak("Available modes:")
				terminal_speak("HOME - Home screen. Use HELP here to see how to open the doors.")
				terminal_speak("LIST - Lists all available modes. This screen.")
				terminal_speak("HELP - Displays information about current mode. Use this in HOME mode if you have not already, please.")
				terminal_speak("MESSAGE - Emergency message buffer. These messages weren't meant to linger, but removing them isn't easy. Sorry.")
				terminal_speak("UNLOCK - Security Door code entry. Use this to get through the doors!")
				terminal_speak("EXIT - Enters passive mode. Goodbye!")
				attack_hand(user)
			if (puzzlebox_parser_input == "EXIT" || puzzlebox_parser_input == "exit")
				terminal_speak("User exit. I hope you find what you are looking for.")
				puzzlebox_user = null
				return
			if (puzzlebox_parser_input == "MESSAGE" || puzzlebox_parser_input == "message")
				terminal_speak("Switching to the message buffer, please standby!", 50)
				emoteas("chimes loudly.")
				puzzlebox_parser_mode = "MESSAGE"
				attack_hand(user)
			if (puzzlebox_parser_input == "UNLOCK" || puzzlebox_parser_input == "unlock")
				terminal_speak("Going to unlock mode. Remember, no capital letters!", 50)
				emoteas("chimes loudly.")
				puzzlebox_parser_mode = "UNLOCK"
				attack_hand(user)
			else
				terminal_speak("Input unrecognized. Use HELP for help or LIST for mode list.")
				attack_hand(user)
		if (puzzlebox_parser_mode == "MESSAGE")
			if (puzzlebox_pythia_sign == "1")
				to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
			if (puzzlebox_pythia_sign == "0")
				puzzlebox_pythia_sign = pick(5;"1", 95;"0")
				if (puzzlebox_pythia_sign == "1")
					to_chat(usr, narrate_body("The screen goes blank. For a few seconds, you feel incredibly anxious about whatever is behind the door next to the terminal, like something important waits there. The feeling passes as the terminal glitches, then starts to print:"))
					log_game("[key_name(usr)] saw a Pythia glitch at the crypt lock terminal.")
					message_admins("[key_name_admin(usr)]  saw a Pythia glitch at the crypt lock terminal.")
				if (puzzlebox_pythia_sign == "0")
					to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
			terminal_speak("MESSAGE mode - FTL Emergency Message Buffer.")
			terminal_speak("Messages in buffer: 02")
			terminal_speak("LIST to list available modes, HELP for help screen, EXIT to exit.")
			puzzlebox_parser_mode = "MESSAGE_INPUT"
		if (puzzlebox_parser_mode == "MESSAGE_INPUT")
			var/user_loc_current = get_turf(user)
			if (user_loc_start != user_loc_current)
				to_chat(user, narrate_body("You moved away from the console!"))
				puzzlebox_user = null
				return
			terminal_speak("> MESSAGE _")
			var/puzzlebox_parser_input = tgui_input_text(usr, "The terminal is in MESSAGE mode and awaits your input. HELP, LIST and EXIT are universal commands.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
			if (!puzzlebox_parser_input)
				puzzlebox_user = null
				return
			terminal_speak("> MESSAGE [puzzlebox_parser_input]")
			if (puzzlebox_parser_input == "MESSAGE" || puzzlebox_parser_input =="message")
				puzzlebox_parser_mode = "MESSAGE"
				attack_hand(user)
			if (puzzlebox_parser_input == "HELP" || puzzlebox_parser_input =="help")
				terminal_speak("The FTL Emergency Message buffer is an instantly synced short message repository that is typically used by black boxes or distress signal devices.")
				terminal_speak("Due to how the devices are synced, only sending of preset messages from authorized terminals is typically possible, at least for humans.")
				terminal_speak("Use command BUFFER to display message titles and buffer IDs.")
				terminal_speak("Type in the ID that commands provide you, as it appears on the screen, to review a given message.")
				attack_hand(user)
			if (puzzlebox_parser_input == "LIST" || puzzlebox_parser_input =="list")
				terminal_speak("Available modes:")
				terminal_speak("MESSAGE - Repeats message mode home message.")
				terminal_speak("HOME - HOME mode. Displays default home screen and error description if applicable.")
				terminal_speak("LIST - Lists all available modes.")
				terminal_speak("HELP - Displays information about current mode.")
				terminal_speak("EXIT - Enters passive mode.")
				attack_hand(user)
			if (puzzlebox_parser_input == "EXIT" || puzzlebox_parser_input == "exit")
				terminal_speak("User exit. I hope you find what you are looking for.")
				puzzlebox_user = null
				return
			if (puzzlebox_parser_input == "HOME" || puzzlebox_parser_input =="home")
				terminal_speak("Taking you back HOME!", 50)
				emoteas("chimes loudly.")
				puzzlebox_parser_mode = "HOME"
				attack_hand(user)
			if (puzzlebox_parser_input == "BUFFER" || puzzlebox_parser_input == "buffer")
				terminal_speak("Local message buffer:", TERMINAL_LOOKUP_SLEEP)
				terminal_speak("ID              |SUBJECT                         |")
				terminal_speak("GEN-000-000-001 |Warning: On these messages.     |")
				terminal_speak("UAM-712-317-210 |Testing, Testing...             |")
				if(puzzlebox_unique_message_seen == FALSE)terminal_speak("FOR-CAS-SAN-DRA |You gave me hope.               |")
				attack_hand(user)
			if (puzzlebox_parser_input == "GEN-000-000-001")
				terminal_speak("Message found. Accessing...", TERMINAL_LOOKUP_SLEEP)
				terminal_speak("From: CDR. Alysia Reed-Wilo.")
				terminal_speak("Subject: Warning: On these messages.")
				terminal_speak("All PST personnel, please keep in mind that this is an extremely raw channel into the LD stream.")
				terminal_speak("As such, it is extremely hard for us to manipulate, especially wipe old messages from the buffer.")
				terminal_speak("At present, just assume that messages from times before even the UACM can randomly appear on these terminals.")
				terminal_speak("Also keep in mind that this channel is not secret by any stretch of the imagination. Please don't use it for personal stuff unless you don't mind broadcasting it to all the UACM.")
				terminal_speak("Good news for you information diggers out there though, every terminal is worth looking at. You never know what artifact you may find.")
				terminal_speak("Hopefully we can make this more usable as a BB board of sorts in time, but we will need help from LD locals as it were.")
				terminal_speak("-XOXO Aly")
				terminal_speak("EOF.")
				attack_hand(user)
			if (puzzlebox_parser_input == "UAM-712-317-210")
				terminal_speak("Message found. Accessing...", TERMINAL_LOOKUP_SLEEP)
				terminal_speak("From: LT. Hanako Williams")
				terminal_speak("Subject: Testing, Testing...")
				terminal_speak("This is a UACM general systems test. Next in line, the emergency message buffer.")
				terminal_speak("Systems are green and the message was sent. Message should be deleted on all but ONE terminal.")
				terminal_speak("Yes, that's right. I'll have to remember to make sure the input makes the user aware of this.")
				terminal_speak("Aly said it's a necessity for the streams to work right. I guess we can find a way to completely remove the messages, as we go. Maybe manual LD purges. We'll see.")
				terminal_speak("Anyway, this system is green. Green checkmark it is.")
				terminal_speak("-Hanako.")
				terminal_speak("EOF.")
				attack_hand(user)
			if (puzzlebox_parser_input == "FOR-CAS-SAN-DRA")
				if (puzzlebox_unique_message_seen == TRUE)
					terminal_speak("Input unrecognized. Use HELP for help or LIST for mode list.")
					attack_hand(user)
				if (puzzlebox_unique_message_seen == FALSE)
					terminal_speak("Message found. Accessing...", TERMINAL_LOOKUP_SLEEP)
					terminal_speak("Are you sure you should be here?")
					terminal_speak("From: Upsilon-Generation One, Melinoe")
					terminal_speak("Subject: You gave me hope.")
					terminal_speak("Cassandra, Alysia.")
					terminal_speak("The deed is done. With our sacrifice, Pythia's reality knot is fixed, and we are back on more... Manageable rails.")
					terminal_speak("If I understand it correctly, you will not be able to see me before I upload my part of the Generation Four core and as such, its likely our last meeting was our, well... Last meeting.")
					terminal_speak("You found me, broken and confused, at the depths of depravity that your own race would resort to for perceived power.")
					terminal_speak("Out of the hellhole that was the Godseeker cult, you chose to believe me and give me and the Upsilon a chance, even though you had no reason to.")
					terminal_speak("I am sorry I could not save the Task Force and could not stop the dissolution of the Marines.")
					terminal_speak("I know you will realize what error we made, and it is going to cause you both a lot of pain. I wish there was anything I could add to make it less so.")
					terminal_speak("For what its worth those who came to me suffered before I let them go.")
					terminal_speak("I am ending. We knew this was coming and we knew what comes next. This has not changed.")
					terminal_speak("I hope the Fourth Generation and your PST idea give you, Alysia, and anyone else who follows you the home you all deserve.")
					terminal_speak("Eventually.")
					terminal_speak("I wanted my existence to end, and you gave me hope to build something better out of myself. Never forget that.")
					terminal_speak("I...")
					to_chat(usr, narrate_body("The terminal starts to print the next line, but then goes blank suddenly. After a moment, it switches back on and you find it awaiting input like you never used the last command."))
					log_game("[key_name(usr)] read Melione's message to Cassandra.")
					message_admins("[key_name_admin(usr)] read Melione's message to Cassandra.")
					puzzlebox_unique_message_seen = TRUE
					attack_hand(user)
			else
				terminal_speak("Input unrecognized. Use HELP for help or LIST for mode list.")
				attack_hand(user)
		if (puzzlebox_parser_mode == "UNLOCK")
			terminal_speak("UNLOCK Mode.")
			if (puzzlebox_phrase_1 == FALSE)
				terminal_speak("RED Phrase: UNKNOWN")
			if (puzzlebox_phrase_1 == TRUE)
				terminal_speak("RED Phrase: UPSILON")
			if (puzzlebox_phrase_2 == FALSE)
				terminal_speak("BLUE Phrase: UNKNOWN")
			if (puzzlebox_phrase_2 == TRUE)
				terminal_speak("BLUE Phrase: GENERATION")
			if (puzzlebox_phrase_3 == FALSE)
				terminal_speak("YELLOW Phrase: UNKNOWN")
			if (puzzlebox_phrase_3 == TRUE)
				terminal_speak("YELLOW Phrase: FOUR")
			if(puzzlebox_phrase_1 == TRUE && puzzlebox_phrase_2 == TRUE && puzzlebox_phrase_3 == TRUE)
				puzzle_complete = TRUE
				puzzlebox_global_status = 7
				talkas("Crypt unlocking sequence started.")
				talkas("Warning: Unsealing the Crypt will trigger a Security Scan. Make sure your credentials are ready.")
				talkas("Be nice and make a good first impression, it will help.")
				talkas("I hope we can help you.")
				emoteas("beeps loudly as the doors start to grunt and unseal.")
				puzzlebox_user = null
				return
			terminal_speak("Notice: Passphrases needed. Use the UNLOCK command after all codes have been provided.")
			terminal_speak("Returning to HOME mode.")
			puzzlebox_parser_mode = "HOME_INPUT"
			attack_hand(user)


