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
	terminal_speak("ID              |SUBJECT                         |DATE RECOVERED|")
	terminal_speak("GEN-000-000-001 |Warning: On these messages.     |    MM/DD/YYYY|")

// MESSAGE PROCS START HERE
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
