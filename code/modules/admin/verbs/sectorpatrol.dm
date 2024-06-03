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

	set name = "Peristancy - Save Turfs and Objects"
	set category = "Admin.SectorPatrol"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	to_chat(world, SPAN_BOLDWARNING("Persistancy save initiated. Game may stop responding..."))
	sleep(5)
	GLOB.savefile_number += 1
	//Savefile number reference
	var/savefile/G = new("data/persistance/turf_obj_globals.sav")
	G["current_save"] << GLOB.savefile_number
	//Turfs
	to_chat(world, SPAN_BOLDWARNING("Saving modular turf data..."))
	sleep(5)
	var/savefile/S = new("data/persistance/turf_ovpst_[GLOB.savefile_number].sav")
	var/tile_xyz
	for(var/turf/open/floor/plating/modular/T in GLOB.turfs_saved)
		tile_xyz = "[T.x]-[T.y]-[T.z]"
		S.cd = "/[tile_xyz]"
		S["tile_top_left"] << T.tile_top_left
		S["tile_top_rght"] << T.tile_top_rght
		S["tile_bot_left"] << T.tile_bot_left
		S["tile_bot_rght"] << T.tile_bot_rght
		S["tile_seal"] << T.tile_seal
	to_chat(world, SPAN_BOLDWARNING("Turf data saved."))
	//Objects
	to_chat(world, SPAN_BOLDWARNING("Saving object data..."))
	var/savefile/I = new("data/persistance/objects_ovpst_[GLOB.savefile_number].sav")
	var/item_index = 0
	for(var/obj/obj in GLOB.objects_saved)
		var/turf/groundloc = get_turf(obj)
		if (groundloc != null)
			item_index += 1
			I.cd = "/[item_index]"
			I["objtype"] << obj.type
			I["name"] << obj.name
			I["desc"] << obj.desc
			I["desc_lore"] << obj.desc_lore
			I["x"] << groundloc.x
			I["pixel_x"] << obj.pixel_x
			I["y"] << groundloc.y
			I["pixel_y"] << obj.pixel_y
			I["z"] << groundloc.z
			I["customizable"] << obj.customizable
			I["customizable_desc"] << obj.customizable_desc
			I["customizable_desc_lore"] << obj.customizable_desc_lore
	I.cd = "/general"
	I["item_index_max"] << item_index
	to_chat(world, SPAN_BOLDWARNING("Object data saved."))
	to_chat(world, SPAN_BOLDWARNING("Persistancy save complete. You may resume playing."))

/client/proc/cmd_load_turfs()

	set name = "Peristancy - Load Turfs and Objects"
	set category = "Admin.SectorPatrol"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	to_chat(world, SPAN_BOLDWARNING("Performing persistant data load. The game may stop responidng..."))
	sleep(5)
	var/savefile/G = new("data/persistance/turf_obj_globals.sav")
	G["current_save"] >> GLOB.savefile_number
	to_chat(world, SPAN_BOLDWARNING("Loading turfs..."))
	var/savefile/S = new("data/persistance/turf_ovpst_[GLOB.savefile_number].sav")
	var/tile_xyz
	for(var/turf/open/floor/plating/modular/T in GLOB.turfs_saved)
		tile_xyz = "[T.x]-[T.y]-[T.z]"
		S.cd = "/[tile_xyz]"
		S["tile_top_left"] >> T.tile_top_left
		S["tile_top_rght"] >> T.tile_top_rght
		S["tile_bot_left"] >> T.tile_bot_left
		S["tile_bot_rght"] >> T.tile_bot_rght
		S["tile_seal"] >> T.tile_seal
		T.update_icon()
	to_chat(usr, SPAN_BOLDWARNING("Modular turf data restored."))
	to_chat(usr, SPAN_BOLDWARNING("Restoring item data..."))
	var/savefile/I = new("data/persistance/objects_ovpst_[GLOB.savefile_number].sav")
	var/item_index
	var/current_index = 0
	var/item_x
	var/item_y
	var/item_z
	var/item_type
	I.cd = "/general"
	I["item_index_max"] >> item_index
	while(current_index < item_index)
		current_index += 1
		I.cd = "/[current_index]"
		I["objtype"] >> item_type
		I["x"] >> item_x
		I["y"] >> item_y
		I["z"] >> item_z
		var/obj/newitem = new item_type(locate(item_x, item_y, item_z))
		I["name"] >> newitem.name
		I["desc"] >> newitem.desc
		I["desc_lore"] >> newitem.desc_lore
		I["pixel_x"] >> newitem.pixel_x
		I["pixel_y"] >> newitem.pixel_y
		I["customizable"] >> newitem.customizable
		I["customizable_desc"] >> newitem.customizable_desc
		I["customizable_desc_lore"] >> newitem.customizable_desc_lore
		newitem.update_icon()
		newitem.update_custom_descriptions()
	to_chat(world, SPAN_BOLDWARNING("Object data loaded."))
	to_chat(world, SPAN_BOLDWARNING("Persistancy load complete. You may resume playing."))

/client/proc/cmd_set_time_date_loc()

	set name = "Set Statpanel IC information"
	set category = "Admin.SectorPatrol"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	var/oldvalue = GLOB.ingame_date
	GLOB.ingame_date = tgui_input_text(usr, message = "Enter Date to display:", title = "Date Entry", default = "[GLOB.ingame_date]", timeout = 0)
	if(GLOB.ingame_date == null) GLOB.ingame_date = oldvalue

	oldvalue = GLOB.ingame_time
	var/newtime_hrs = tgui_input_number(usr, message = "In-game time, HOURS:", title = "Time Entry HOURS", timeout = 0)
	var/newtime_min = tgui_input_number(usr, message = "In-game time, MINUTES:", title = "Time Entry MINUTES", timeout = 0)
	GLOB.ingame_time = ((newtime_hrs * 36000) + (newtime_min * 600)) - world.time
	if(GLOB.ingame_time == null) GLOB.ingame_time = oldvalue

	oldvalue = GLOB.ingame_location
	GLOB.ingame_location = tgui_input_text(usr, message = "Enter Location to display:", title = "Location Entry", default = "[GLOB.ingame_location]", timeout = 0)
	if(GLOB.ingame_location == null) GLOB.ingame_location = oldvalue

	oldvalue = GLOB.start_narration_header
	GLOB.start_narration_header = GLOB.ingame_location = tgui_input_text(usr, message = "Start Narration Header:", title = "Narration Entry", default = "[GLOB.start_narration_header]", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, timeout = 0)
	if(GLOB.start_narration_header == null) GLOB.start_narration_header = oldvalue

	oldvalue = GLOB.start_narration_body
	GLOB.start_narration_body = GLOB.ingame_location = tgui_input_text(usr, message = "Start Narration Header:", title = "Narration Entry", default = "[GLOB.start_narration_body]", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, timeout = 0)
	if(GLOB.start_narration_body == null) GLOB.start_narration_body = oldvalue

	oldvalue = GLOB.start_narration_footer
	GLOB.start_narration_footer = GLOB.ingame_location = tgui_input_text(usr, message = "Start Narration Header:", title = "Narration Entry", default = "[GLOB.start_narration_footer]", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, timeout = 0)
	if(GLOB.start_narration_footer == null) GLOB.start_narration_footer = oldvalue

	oldvalue = GLOB.end_narration_header
	GLOB.end_narration_header = GLOB.ingame_location = tgui_input_text(usr, message = "Start Narration Header:", title = "Narration Entry", default = "[GLOB.end_narration_header]", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, timeout = 0)
	if(GLOB.end_narration_header == null) GLOB.end_narration_header = oldvalue

	oldvalue = GLOB.end_narration_body
	GLOB.end_narration_body = GLOB.ingame_location = tgui_input_text(usr, message = "Start Narration Header:", title = "Narration Entry", default = "[GLOB.end_narration_body]", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, timeout = 0)
	if(GLOB.end_narration_body == null) GLOB.end_narration_body = oldvalue

/client/proc/cmd_save_general()

	set name = "Peristancy - Save General Status"
	set category = "Admin.SectorPatrol"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	var/savefile/G = new("data/persistance/globals.sav")
	G["Date"] << GLOB.ingame_date
	var/saved_time = (GLOB.ingame_time - SSticker.round_start_time)+ world.time
	G["Time"] << saved_time
	G["Location"] << GLOB.ingame_location
	G["start_narration_header"] << GLOB.start_narration_header
	G["start_narration_footer"] << GLOB.start_narration_footer
	G["start_narration_body"] << GLOB.start_narration_body
	G["end_narration_header"] << GLOB.end_narration_header
	G["end_narration_body"] << GLOB.end_narration_body
	to_chat(src, SPAN_BOLDWARNING("General data saved."))

/client/proc/cmd_load_general()

	set name = "Peristancy - Load General Status"
	set category = "Admin.SectorPatrol"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	var/savefile/G = new("data/persistance/globals.sav")
	G["Date"] >> GLOB.ingame_date
	G["Time"] >> GLOB.ingame_time
	G["Location"] >> GLOB.ingame_location
	G["start_narration_header"] >> GLOB.start_narration_header
	G["start_narration_footer"] >> GLOB.start_narration_footer
	G["start_narration_body"] >> GLOB.start_narration_body
	G["end_narration_header"] >> GLOB.end_narration_header
	G["end_narration_body"] >> GLOB.end_narration_body
	to_chat(src, SPAN_BOLDWARNING("General data loaded."))
