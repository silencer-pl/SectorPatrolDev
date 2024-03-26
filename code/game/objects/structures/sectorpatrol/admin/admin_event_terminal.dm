/obj/structure/eventterminal/admin_event_terminal
	name = "local network terminal"
	desc = "A standard computer terminal with the words 'LNT' imprinted on its side. Activated by standing in its proximity. It appears to be in standby mode."
	desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs."
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
	req_access = list(ACCESS_SP_ADMIN)

/obj/structure/eventterminal/admin_event_terminal/attack_hand(mob/user as mob)

	if(!puzzlebox_id)
		to_chat(user, narrate_head("Error. This admin control terminal has no id. This is most likely a mapping error. Admins have been notified, but just in case, please ahelp and laugh at silencer."))
		message_admins("[key_name_admin(usr)] has found an admin terminal with no puzzlebox subtype set during an event state.")
		return
	if(puzzlebox_id == "shuttle")
		var/puzzlebox_admin_option = tgui_input_list(usr, "Select a function", "Admin Terminal", list("Start landing puzzle"), 0)
		if (!puzzlebox_admin_option) return
		if (puzzlebox_admin_option == "Start landing puzzle")
			if (puzzlebox_global_status > 1)
				to_chat(narrate_head("Error: Status already above 1, expected value."))
				return
			if (puzzlebox_global_status == 1)
				to_chat(narrate_head("Error: Landing puzzle already started."))
				return
			if (puzzlebox_global_status == 0)
				puzzlebox_global_status = 1
				to_chat(narrate_head("Landing puzzle started."))
				return
	if(puzzlebox_id == "scn1")
		var/puzzlebox_admin_option = tgui_input_list(usr, "Select a function", "Admin Terminal", list("RFID Sequence"), 0)
		if (!puzzlebox_admin_option) return
		if (puzzlebox_admin_option == "RFID Sequence")
			change_lights(lights_id = "sec-1", lights_color = "#9300b8" )
			usr.visible_message(narrate_body("[usr] pushes a few buttons on the console and the scanner activates. The whole area seems unnaturally silent for a moment. You can almost feel something watching through the security bulb for a split second, but it must just be the long hours spent travelling in space. The console beeps after a few seconds and the light changes back to normal."), narrate_console("> PROCESSING..."))
			sleep (3 SECONDS)
			change_lights(lights_id = "sec-1", lights_color = LIGHT_COLOR_WHITE)
			return
	if(puzzlebox_id == "scn2")
		var/puzzlebox_admin_option = tgui_input_list(usr, "Select a function", "Admin Terminal", list("Start Second Puzzle Sequence", "Open Scanner Doors"), 0)
		if (!puzzlebox_admin_option) return
		if (puzzlebox_admin_option == "Start Second Puzzle Sequence")
			if (puzzlebox_global_status >= 3)
				to_chat(user, narrate_body("Second puzzle already started."))
				return
			if (puzzlebox_global_status >= 5)
				to_chat(user, narrate_body("Second puzzle already complete."))
				return
			if (puzzlebox_global_status == 2)
				puzzlebox_global_status = 3
				return
			else
				to_chat(user, narrate_head("Exception. Invalid global status."))
				return
		if (puzzlebox_admin_option == "Open Scanner Doors")
			if (puzzlebox_global_status >= 5)
				open_doors()
			else
				to_chat(user, narrate_body("Puzzlebox state below 5."))
	if(puzzlebox_id == "crypt_airlock")
		if(puzzlebox_global_status != 8)
			to_chat(usr, narrate_body("Error: Global status not 8. It's not time."))
			return
		var/puzzlebox_admin_option = tgui_input_list(usr, "Select a function", "Admin Terminal", list("Annouce Crypt Security Scan", "Adjust Crypt Secuirty Scan", "Begin final stage"), 0)
		if (!puzzlebox_admin_option) return
		if (puzzlebox_admin_option == "Annouce Crypt Security Scan")
			var/puzzlebox_admin_option_number = tgui_input_number(usr, "How many PCs?", "PC Input", timeout = 0)
			if(!puzzlebox_admin_option_number) return
			to_chat(world, narrate_head("The loudspeaker system on the dorm level and inside the crypt comes alive and announces with a male, robotic voice:"))
			to_chat(world, narrate_body("Attention. Class S Security Scan Triggered. Location: Crypt Entrance Chamber."))
			to_chat(world, narrate_body("To resolve: [puzzlebox_admin_option_number] RFID confirmed personnel matching condition 'ARBITER' must report for stationary scan in scan location."))
			to_chat(world, narrate_body("Awaiting appropriate personnel quota."))
			return
		if (puzzlebox_admin_option == "Adjust Crypt Secuirty Scan")
			var/puzzlebox_admin_option_number = tgui_input_number(usr, "How many PCs?", "PC Input", timeout = 0)
			to_chat(world, narrate_head("The loudspeaker system on the dorm level and inside the crypt comes alive and announces with a male, robotic voice:"))
			to_chat(world, narrate_body("Attention: Crypt Security Scan Adjustment Detected. Current quota: [puzzlebox_admin_option_number]"))
			to_chat(world, narrate_body("Awaiting appropriate personnel quota."))
			return
		if (puzzlebox_admin_option == "Begin final stage")
			puzzlebox_global_status = 9
			for (var/obj/structure/eventterminal/puzzle04/final_log/T in world)
				INVOKE_ASYNC(T, TYPE_PROC_REF(/obj/structure/eventterminal/puzzle04/final_log, play_final_log))
			return
