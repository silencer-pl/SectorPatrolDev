/obj/structure/eventterminal/puzzle01/endpoint
	icon = 'icons/obj/structures/machinery/clio_maint_dark.dmi'
	name = "closed maintenance terminal hatch"
	desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
	desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."

/obj/structure/eventterminal/puzzle01/endpoint/attack_hand(mob/user as mob)

		//Activation and basic status check
	if (puzzlebox_global_status != 1)
		if(icon_state != "closed")
			to_chat(narrate_body("You push a random key to activate the terminal, but its hatch slides shut and audibly locks!"))
			icon_state = "closed"
			playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
			name = "closed maintenance terminal hatch"
			desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."
			item_serial = null
			update_icon()
			return
		if(icon_state == "closed")
			to_chat(usr, narrate_body("The hatch does not budge. It seems locked from the other side."))
			return
	if (puzzlebox_global_status == 1)
		//Opening conditions
		if(icon_state == "closed")
			to_chat(narrate_body("The hatch unlocks and slides open, revealing the terminal underneath!"))
			icon_state = "open_err"
			name = "open maintenance terminal hatch"
			desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be flashing a red error message."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Red error messages typically indicate that the terminal is the end point of a diagnostic issue and will typically require information from other terminals displaying a yellow error screen."
			item_serial = "UACM-OVPST-L533-CENT"
			playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
			update_icon()
			sleep(5)
		if (puzzlebox_pythia_sign == "1")
			to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
		if (puzzlebox_pythia_sign == "0")
			puzzlebox_pythia_sign = pick(5;"1", 95;"0")
			if (puzzlebox_pythia_sign == "1")
				to_chat(usr, narrate_body("The terminal flickers and prints random code. You could swear you saw your name among the letters and symbols, but when you try to focus on that segment, the display blinks, erases itself and after a moment, starts printing:"))
			if (puzzlebox_pythia_sign == "0")
				to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))

		terminal_speak("ERROR: Anomalous landing vector information data pairs detected. Landing vector pair critical mismatch. Accessing information…")
		to_chat(usr, narrate_body("The terminal displays a diagram of the shuttle and what looks like a schematic of the PST. A crossed out arrow blinks between the shuttle and the station."))
		terminal_speak("Diagnosis: Invalid data pair matches sent to forward and rear calibration systems. Manual paring required.")
		terminal_speak("To manually pair landing vectors, manually enter following vector pair matches:")
		terminal_speak("Left sequence: Terminal UACM-OVPST-L533-LEFT , COLUMN: LEFT, ROW: 5.")
		terminal_speak("Right sequence: Terminal UACM-OVPST-L533-RGHT , COLUMN: RIGHT, ROW: 2.")
		terminal_speak("Note: Terminal serial numbers can be read after opening maintenance hatches.")
		terminal_speak("Final string should contain 'EIGHT LETTERS AND NUMBERS', '-', 'EIGHT LETTERS AND NUMBERS' with no spaces.")
		terminal_speak("Autocalibration should occur in about 10 minutes.")
		terminal_speak("Awaiting proper vector pair.")
		if(tgui_alert(user, "Do you want to type something into the terminal?", "The Terminal", list("Yes", "No")) == "No")
			return
		var/puzzlebox_given_answer = tgui_input_text(usr, "The terminal awaits your input,", "Terminal", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
		if (!puzzlebox_given_answer) return
		usr.visible_message(narrate_body("[usr] types something on the maitenance console."), narrate_console("> [puzzlebox_given_answer]"))
		sleep(TERMINAL_LOOKUP_SLEEP)
		if(puzzlebox_given_answer != "41524249-54455253")
			usr.visible_message(narrate_body("The terminal buzzes and shows a quick animation of the shuttle crashing into the station, followed by a red X blinking a few times. The console then flashes and goes back to its previous display, awaiting input."))
			log_game("[key_name(usr)] used phrase '[puzzlebox_given_answer]' and failed a puzzle. Expected answer: '1A0310FF-54455253'")
			message_admins("[key_name_admin(usr)] used phrase '[puzzlebox_given_answer]' and failed a puzzle.")
			playsound(src.loc, 'sound/machines/terminal_error.ogg', 25)
			puzzlebox_given_answer = null
			return
		if(puzzlebox_given_answer == "41524249-54455253")
			usr.visible_message(narrate_body("The terminal beeps and displays a short animation of the shuttle docking safely at 'Dock 31' of the Outer Veil PST. A green checkmark blinks across the screen a few times, then the display turns off."))
			log_game("[key_name(usr)] used phrase '[puzzlebox_given_answer]' and solved a puzzle.")
			message_admins("[key_name_admin(usr)] used phrase '[puzzlebox_given_answer]' and solved a puzzle.")
			playsound(src.loc, 'sound/machines/terminal_success.ogg', 25)
			icon_state = "open_off"
			update_icon()
			desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks. There is nothing visible on the display."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. While the display is off, the console is functional, which means that a maintenance cycle was recently performed on this terminal."
			to_chat(usr, narrate_body("The code dances before your eyes. For a split second, you feel like its talking to you, saying your name. The sensation passes quickly. Maybe the montony of space travel is getting to you."))
			to_chat(world, narrate_head("The shuttle engines begin to hum as it appears to be ready to fly again."))
			puzzlebox_global_status = 2
			return

/obj/structure/eventterminal/puzzle01/info_left
	icon = 'icons/obj/structures/machinery/clio_maint_dark.dmi'
	name = "closed maintenance terminal hatch"
	desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
	desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."

/obj/structure/eventterminal/puzzle01/info_left/attack_hand(mob/user as mob)
	//Activation and basic status check
	if (puzzlebox_global_status != 1)
		if(icon_state != "closed")
			to_chat(narrate_body("You push a random key to activate the terminal, but its hatch slides shut and audibly locks!"))
			icon_state = "closed"
			playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
			name = "closed maintenance terminal hatch"
			desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."
			item_serial = null
			update_icon()
			return
		if(icon_state == "closed")
			to_chat(usr, narrate_body("The hatch does not budge. It seems locked from the other side."))
			return
	if (puzzlebox_global_status == 1)
		//Opening conditions
		if(icon_state == "closed")
			to_chat(narrate_body("The hatch unlocks and slides open, revealing the terminal underneath!"))
			icon_state = "open_hang"
			name = "open maintenance terminal hatch"
			desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be flashing a red error message."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Blue error screens typically mean that an AI process is stuck in an endless loop and will provide critical diagnostic information, usually used on yellow error screen terminals."
			item_serial = "UACM-OVPST-L533-LEFT"
			playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
			update_icon()
			sleep(5)
		if (puzzlebox_pythia_sign == "1")
			to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
		if (puzzlebox_pythia_sign == "0")
			puzzlebox_pythia_sign = pick(5;"1", 95;"0")
			if (puzzlebox_pythia_sign == "1")
				to_chat(usr, narrate_body("For a split second, the sound around you seems muffled as you stare at the terminal. Your ears audibly pop."))
			if (puzzlebox_pythia_sign == "0")
				to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
		terminal_speak("Maintenance mode instructions received:")
		terminal_speak("SHUTTLE L-533 REAR THRUSTER VECTOR PATTERNS")
		terminal_speak("20594F55-20415245")
		terminal_speak("46494E41-4C4C5920")
		terminal_speak("48455245-20202020")
		terminal_speak("A88629FA-CC6743A9")
		terminal_speak("41524249-00F813FB")
		terminal_speak("C4BF53D4-B5A8A6C1")
		terminal_speak("55577C4C-595524AA")
		terminal_speak("4C68B88F-BA4A4DA2")
		return

/obj/structure/eventterminal/puzzle01/info_right
	icon = 'icons/obj/structures/machinery/clio_maint_dark.dmi'
	name = "closed maintenance terminal hatch"
	desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
	desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."

/obj/structure/eventterminal/puzzle01/info_right/attack_hand(mob/user as mob)
	//Activation and basic status check
	if (puzzlebox_global_status != 1)
		if(icon_state != "closed")
			to_chat(narrate_body("You push a random key to activate the terminal, but its hatch slides shut and audibly locks!"))
			icon_state = "closed"
			playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
			name = "closed maintenance terminal hatch"
			desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."
			item_serial = null
			update_icon()
			return
		if(icon_state == "closed")
			to_chat(usr, narrate_body("The hatch does not budge. It seems locked from the other side."))
			return
	if (puzzlebox_global_status == 1)
		//Opening conditions
		if(icon_state == "closed")
			to_chat(narrate_body("The hatch unlocks and slides open, revealing the terminal underneath!"))
			icon_state = "open_hang"
			name = "open maintenance terminal hatch"
			desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be flashing a red error message."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Blue error screens typically mean that an AI process is stuck in an endless loop and will provide critical diagnostic information, usually used on yellow error screen terminals."
			item_serial = "UACM-OVPST-L533-RGHT"
			playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
			update_icon()
			sleep(5)
		if (puzzlebox_pythia_sign == "1")
			to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
		if (puzzlebox_pythia_sign == "0")
			puzzlebox_pythia_sign = pick(5;"1", 95;"0")
			if (puzzlebox_pythia_sign == "1")
				to_chat(usr, narrate_body("For a split second, the sound around you seems muffled as you stare at the terminal. Your ears audibly pop."))
			if (puzzlebox_pythia_sign == "0")
				to_chat(usr, narrate_body("The display on the terminal flickers for a moment, then starts printing:"))
		terminal_speak("Maintenance mode instructions received:")
		terminal_speak("SHUTTLE L-533 FRONT THRUSTER VECTOR PATTERNS")
		terminal_speak("851D1C5F-C06FEFD5")
		terminal_speak("6EA133F1-54455253")
		terminal_speak("FFC6D480-FEA21B58")
		terminal_speak("496E2061-7A757265")
		terminal_speak("50797468-69612073")
		terminal_speak("6C656570-7320616E")
		terminal_speak("64206472-65616D73")
		terminal_speak("B5AC9EB0-F47A4ABE")
		return
