/obj/structure/eventterminal/civnet
	name = "CivNet access terminal"
	desc = "A standard computer terminal with the words 'CNT' imprinted on its side. Activated by standing in its proximity. It appears to be in standby mode."
	desc_lore = "CivNet is the public, universe spanning network where anything goes and generally does. While most dismiss CivNet content as garbage, its very vastness, and the fact that it transcends planetary boundaries means that you can likely find almost anything you can imagine. Small interplanetary skirmishes were fought over CivNet content before, they surely will again.  "
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
	icon_state = "open_ok"
	puzzlebox_id = "civnet"
	item_serial = "UACM-OVPST-DRM37-CIVNET"

/obj/structure/eventterminal/civnet/attack_hand(mob/user as mob)
	if(!puzzlebox_user)
		puzzlebox_user = usr.real_name
	if(puzzlebox_user != usr.real_name)
		to_chat(usr, SPAN_WARNING("Someone is already using this terminal!"))
		return
	terminal_speak("Welcome to the Outer Veil PST CivNet Access Terminal!")
	terminal_speak("User verified! Welcome, [usr.name]!")
	if(usr.civnet_answer != null)
		terminal_speak("CivNet query fulfilled. Printing answer:")
		terminal_speak("[usr.civnet_answer]")
		terminal_speak("Answer complete. Have a nice day!")
		usr.civnet_answer = null
		usr.civnet_query = null
		puzzlebox_user = null
		return
	terminal_speak("Please submit a CivNet query!")
	if(usr.civnet_query == null)
		var/puzzlebox_civnet_query = tgui_input_text(usr, "Please enter a query for the terminal. Notice that more complex queries may take several hours to complete and may not be available as an answer this round.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE, timeout = 0)
		if (!puzzlebox_civnet_query)
			puzzlebox_user = null
			return
		playsound(src, soundin = get_sfx("keyboard"), vol = 25, vary = 1)
		terminal_speak("> [puzzlebox_civnet_query]")
		usr.civnet_query = "[puzzlebox_civnet_query]"
		log_game("[key_name(usr)] submitted the Civnet query: [puzzlebox_civnet_query]")
		message_admins("[key_name(usr)] submitted the Civnet query: [puzzlebox_civnet_query]")
		terminal_speak("Query accepted. You will be notified when results are available!")
		puzzlebox_user = null
		return
	if(usr.civnet_query != null)
		if(tgui_alert(usr,"You have already submitted a query, which reads: '[usr.civnet_query]'. Do you wish to cancel this query?", "Query Found", list("Yes", "No"), timeout = 0) == "No") return
		usr.civnet_query = null
		puzzlebox_user = null
		return
