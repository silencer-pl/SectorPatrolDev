/client/proc/admin_blurb()
	set name = "Global Blurb Message"
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN|R_DEBUG))
		return FALSE
	var/duration = 5 SECONDS
	var/message = "ADMIN TEST"
	var/text_input = tgui_input_text(usr, "Announcement message", "Message Contents", message, timeout = 5 MINUTES)
	message = text_input
	duration = tgui_input_number(usr, "Set the duration of the alert in deci-seconds.", "Duration", 5 SECONDS, 5 MINUTES, 5 SECONDS, 20 SECONDS)
	var/confirm = tgui_alert(usr, "Are you sure you wish to send '[message]' to all players for [(duration / 10)] seconds?", "Confirm", list("Yes", "No"), 20 SECONDS)
	if(confirm != "Yes")
		return FALSE
	show_blurb(GLOB.player_list, duration, message, TRUE, "center", "center", "#bd2020", "ADMIN")
	message_admins("[key_name(usr)] sent an admin blurb alert to all players. Alert reads: '[message]' and lasts [(duration / 10)] seconds.")

/client/proc/admin_song_blurb()
	set name = "Song Blurb Message"
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN|R_DEBUG))
		return FALSE

	var/song_name = tgui_input_text(usr, message = "Song In-Game Name - Displayed BOLDED on top.", title = "Song Title", timeout = null)
	if (song_name == null) return
	var/song_artist = tgui_input_text(usr, message = "Song Artist - Second line, left.", title = "Song Artist", timeout = null)
	if (song_artist == null) return
	var/song_title = tgui_input_text(usr, message = "Song Title - Second line, after dash on right. LAST CHANCE TO CANCEL.", title = "Song Name", timeout = null)
	if (song_title == null) return
	var/song_album = tgui_input_text(usr, message = "Song Album. Optional, Third line.", title = "Song Album", timeout = null)
	show_blurb_song(name = "[song_name]", artist = "[song_artist]", title = "[song_title]", album = "[song_album]")
	message_admins("[key_name(usr)] sent an admin song blurb. Strings sent: '[song_title]', '[song_artist]', '[song_name]', '[song_album]'")

/client/proc/cmd_admin_pythia_say() // Checks for a Pythia reciever and talks as it and any of its voices.
	set name = "Speak As Pythia"
	set category = "Admin.Events"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	for (var/obj/structure/eventterminal/puzzle05/testament_of_sacrifice/T in world)
		if(!T)
			to_chat(usr, SPAN_WARNING("Error: Pythia reciever not spawned. Cannot pass say."))
			return
		var/pythia_say = tgui_input_text(src, "What to say as Pythia and its voices.", "Pythia Say Text", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, encode = FALSE, timeout = 0)
		if(!pythia_say) return
		T.pythiasay(pythia_say)
		return

/client/proc/cmd_start_sequence()
	set name = "Start Sequence"
	set category = "Admin.Events"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	var/puzzlebox_admin_option = tgui_input_list(usr, "Select a Sequence", "Start Sequence", list("None - Leave", "Open Hideaway Podlocks", "Open TOS Outer Podlocks", "Open TOS Inner Podlocks"), 0)
	if (!puzzlebox_admin_option) return
	switch(puzzlebox_admin_option)
		if("None - Leave")
			return
		if("Open Hideaway Podlocks")
			for (var/obj/structure/machinery/door/poddoor/almayer/locked/A in world)
				if(A.id == "crypt-a")
					A.open()
		if("Open TOS Outer Podlocks")
			for (var/obj/structure/machinery/door/poddoor/almayer/locked/A in world)
				if(A.id == "crypt-b")
					A.open()
		if("Open TOS Inner Podlocks")
			for (var/obj/structure/machinery/door/poddoor/almayer/locked/A in world)
				if(A.id == "crypt-c")
					A.open()

/client/proc/cmd_save_turfs()

	set name = "Peristancy - Save Modular Turfs"
	set category = "Admin.SectorPatrol"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	to_chat(world, SPAN_BOLDWARNING("Saving modular turf data..."))
	sleep(5)
	for(var/area/ovpst/A in GLOB.all_areas)
		A.Write()
	to_chat(usr, SPAN_BOLDWARNING("Turf data saved."))

/client/proc/cmd_load_turfs()

	set name = "Peristancy - Load Modular Turfs"
	set category = "Admin.SectorPatrol"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	to_chat(world, SPAN_BOLDWARNING("Loading modular turf data..."))
	sleep(5)
	for(var/area/ovpst/A in GLOB.all_areas)
		A.Read()
	for(var/turf/open/floor/plating/modular/T in GLOB.turfs_saved)
		T.update_icon()
	to_chat(usr, SPAN_BOLDWARNING("Modular turf data restored."))
