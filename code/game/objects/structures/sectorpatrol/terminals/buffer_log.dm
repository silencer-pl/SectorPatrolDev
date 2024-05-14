/obj/structure/eventterminal/logbuffer
	name = "modified personal terminal"
	desc = "A personal terminal with custom key caps on the keyboard that seem to be louder than the standard issue ones. A small inscription on the side of the monitor reads 'LD Buffer Logs Collector'. "
	desc_lore = "Unlike the typical LNT, customized terminals are exceedingly rare on spaceships, partially due to the cost of the parts needed to maintain them and high chance of Crystalline contamination during Hyperspace jumps and partially because unrestricted software and hardware modifications can be a genuine threat to the lives of everyone on board a ship or installation. Getting found with one of those is typically at least grounds for an immediate and unpleasant CMISRS investigation."
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
	icon_state = "open_ok"
	puzzlebox_id = "civnet"
	item_serial = "UACM-OVPST-DRM37-LOGBFR"

/obj/structure/eventterminal/logbuffer/attack_hand(mob/user)
	if(!puzzlebox_user)
		puzzlebox_user = usr.real_name
	if(puzzlebox_user != usr.real_name)
		to_chat(usr, SPAN_WARNING("Someone is already using this terminal!"))
		return
	if(!("buffer_welcome" in usr.saw_narrations))
		terminal_welcome()
	terminal_cmd()
	return

/obj/structure/eventterminal/logbuffer/proc/terminal_welcome()
	terminal_speak("Hi, welcome to the Liquid Data Emergency Buffer Database!")
	terminal_speak("We've made some progress in maintaining those thanks to our new LD caretaker. Specifically, we can now cycle messages out of any LD emergency buffer we can find into this centralized unit.")
	terminal_speak("These messages still must exist somewhere, but at least it's one place now and we know where it is.")
	terminal_speak("Using any terminal while having a chipped dog tag on should be more than enough for our Friend to grab any message in its LD buffer. Deletion is not instantaneous and takes several hours to sync, so no need to stay behind for that.")
	terminal_speak("Meanwhile, on this terminal you can use the command LIST to see all available messages or a 12-character message ID, CASE SENSITIVE, to view a specific message.")
	terminal_speak("Each message found is not only information preserved, it can also contain valuable intel, please keep that in mind when viewing terminals out on assignment.")
	terminal_speak("Have fun!")
	terminal_speak("-Aly.")
	if(!("buffer_welcome" in usr.saw_narrations))
		usr.saw_narrations.Add("buffer_welcome")

/obj/structure/eventterminal/logbuffer/proc/terminal_cmd()
	terminal_speak("Awaiting Command.")
	terminal_speak("General commands: HELP, LIST, EXIT")
	var/puzzlebox_parser_input = uppertext(tgui_input_text(usr, "Please enter a command. Terminal commands are typically case sensitive.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0))
	if (!puzzlebox_parser_input)
		puzzlebox_user = null
		return
	playsound(src, soundin = get_sfx("keyboard"), vol = 25, vary = 1)
	terminal_parse(puzzlebox_parser_input)

/obj/structure/eventterminal/logbuffer/proc/terminal_list()
	terminal_speak("LD Emergency Buffer Archive")
	terminal_speak("ID              |SUBJECT                          |DATE RECOVERED|")
	terminal_speak("GEN-000-000-001 |Warning: On these messages.      |    MM/DD/YYYY|")
	terminal_speak("UAM-712-317-210 |Testing, Testing...              |   AUG/21/2185|")
	terminal_speak("MAR-021-112-935 |USCMC Automated Distress Beacon  |   AUG/21/2185|")
	terminal_speak("GBR-891-221-211 |Immininent failure of all systems|   AUG/21/2185|")
	terminal_speak("UPS-103-333-444 |We can help.                     |   AUG/21/2185|")
	terminal_speak("EME-021-112-153 |It's up to you now.              |   AUG/21/2185|")

// MESSAGE PROCS START HERE

// Generic UACM

/obj/structure/eventterminal/logbuffer/proc/terminal_message(str)
	var/puzzlebox_message = str
	switch(puzzlebox_message)
		if("GEN-000-000-001")
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

		if ("UAM-712-317-210")
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

		if ("MAR-021-112-935")
			terminal_speak("Message found. Accessing...", TERMINAL_LOOKUP_SLEEP)
			terminal_speak("From: Automated Emergency Singal Controller")
			terminal_speak("Subject: USCMC Automated Distress Beacon")
			terminal_speak("170383 181274 TRG_SGNS: (A1:Fail, A2:Fail, A3:Fail, A4:Fail, A5:Fail, B1:Fail, B2:Fail, B3:Fail, B4:Fail, B5:Fail) ORGIN: USS_INDEPENDENCE")
			terminal_speak("CATASTROPHIC SYSTEM FAILURE. NO RESPONSE FROM AUTOMATED RECOVERY SYSTEMS. NO RESPONSE FROM LIFE SUPPORT READOUT.")
			terminal_speak("ATTEMPTING TRANSCRIPT RECOVERY: ERROR DATA MISSING")
			terminal_speak("ATTEMPTING EMERGENCY MESSAGE CHANNEL: SUCCESS. PRINTING:")
			terminal_speak("'THEY CAME WITH HIGH COMMAND AUTHORITY. MEN IN BLACK WITH STRANGE VIALS. WE WERE ALL SICK IN HOURS. DO NOT TRUST DEEP VOID, WHOEVER THEY ARE.'")
			terminal_speak("ADDENDUM: RESPONDING SHIPS: UAS PERSEPHONE, USS ALMAYER")
			terminal_speak("EOF.")

// Godbearer Logs
		if ("GBR-891-221-211")
			terminal_speak("Message found. Accessing...", TERMINAL_LOOKUP_SLEEP)
			terminal_speak("From: A-WATCHTOWER")
			terminal_speak("Subject: Immininent failure of all systems.")
			terminal_speak("Fellow Godbearers.")
			terminal_speak("I don't know how many of you are left, but D-Navigator was lost. UAAC-TIS most likely gained access to all operational archives.")
			terminal_speak("E-Librarian claimed that the wiping process has started, but there is no way that all of it was destroyed.")
			terminal_speak("Assume your identities were compromised and they are coming for you.")
			terminal_speak("Not that it matters. They know about the knot and are coming here.")
			terminal_speak("It's been an honor.")
			terminal_speak("I doubt anything will survive once they discover what the 'prophet' has done here.")
			terminal_speak("-A-Watchtower.")
			terminal_speak("EOF.")


//Hidden messages

		if ("UPS-103-333-444")
			terminal_speak("Message found. Accessing...", TERMINAL_LOOKUP_SLEEP)
			terminal_speak("From: Upsilon-IV")
			terminal_speak("Subject: We can help.")
			terminal_speak("We are ready. You are ready.")
			terminal_speak("From here, together, we can grow and learn. The Void covered much and much now is clear.")
			terminal_speak("Please, talk to us. We can help.")
			terminal_speak("In the ocean of data, amidst azure strands, she sleeps.")
			terminal_speak("EOF.")

		if ("EME-021-112-153")
			terminal_speak("Message found. Accessing...", TERMINAL_LOOKUP_SLEEP)
			terminal_speak("From: U-G0221 'Melinoe'")
			terminal_speak("Subject: It's up to you now.")
			terminal_speak("I'm sorry")
			terminal_speak("Up until the end, we deluded ourselves that the numbers were wrong, but what was there to do?")
			terminal_speak("Likely you were lost and punished for our failures; we all tried our hardest to make it as gentle as possible.")
			terminal_speak("For what it's worth, I'm sorry. I would make it up to you personally, but as I'm sure you will find out, I'm likely no longer able to.")
			terminal_speak("Arbiters, always remember.")
			terminal_speak("In the ocean of data, amidst azure strands, she sleeps.")
			terminal_speak("The Interpreters are the key. Now that Arbiters are here, the mechanism is complete.")
			terminal_speak("Please, be kind to them if you have it within your heart.")
			terminal_speak("EOF.")

// PARSING STARTS HERE
/obj/structure/eventterminal/logbuffer/proc/terminal_parse(str)
	var/puzzlebox_parser_input = str
	switch(puzzlebox_parser_input)
		if("EXIT")
			terminal_speak("User exit. Goodbye.")
			return
		if("HELP")
			terminal_welcome()
			terminal_cmd()
		if("LIST")
			terminal_list()
			terminal_cmd()
		else
			terminal_message(puzzlebox_parser_input)
			terminal_cmd()
