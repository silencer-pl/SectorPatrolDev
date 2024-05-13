/client/proc/cmd_admin_change_custom_event()
	set name = "Setup Event Info"
	set category = "Admin.Events"

	if(!admin_holder)
		to_chat(usr, "Only administrators may use this command.")
		return

	if(!LAZYLEN(GLOB.custom_event_info_list))
		to_chat(usr, "custom_event_info_list is not initialized, tell a dev.")
		return

	var/list/temp_list = list()

	for(var/T in GLOB.custom_event_info_list)
		var/datum/custom_event_info/CEI = GLOB.custom_event_info_list[T]
		temp_list["[CEI.msg ? "(x) [CEI.faction]" : CEI.faction]"] = CEI.faction

	var/faction = tgui_input_list(usr, "Select faction. Ghosts will see only \"Global\" category message. Factions with event message set are marked with (x).", "Faction Choice", temp_list)
	if(!faction)
		return

	faction = temp_list[faction]

	if(!GLOB.custom_event_info_list[faction])
		to_chat(usr, "Error has occurred, [faction] category is not found.")
		return

	var/datum/custom_event_info/CEI = GLOB.custom_event_info_list[faction]

	var/input = input(usr, "Enter the custom event message for \"[faction]\" category. Be descriptive. \nTo remove the event message, remove text and confirm.", "[faction] Event Message", CEI.msg) as message|null
	if(isnull(input))
		return

	if(input == "" || !input)
		CEI.msg = ""
		message_admins("[key_name_admin(usr)] has removed the event message for \"[faction]\" category.")
		return

	CEI.msg = html_encode(input)
	message_admins("[key_name_admin(usr)] has changed the event message for \"[faction]\" category.")

	CEI.handle_event_info_update(faction)

/client/proc/change_security_level()
	if(!check_rights(R_ADMIN))
		return
	var sec_level = input(usr, "It's currently code [get_security_level()].", "Select Security Level")  as null|anything in (list("green","blue","red","delta")-get_security_level())
	if(sec_level && alert("Switch from code [get_security_level()] to code [sec_level]?","Change security level?","Yes","No") == "Yes")
		set_security_level(seclevel2num(sec_level))
		log_admin("[key_name(usr)] changed the security level to code [sec_level].")

/client/proc/toggle_gun_restrictions()
	if(!admin_holder || !config)
		return

	if(CONFIG_GET(flag/remove_gun_restrictions))
		to_chat(src, "<b>Enabled gun restrictions.</b>")
		message_admins("Admin [key_name_admin(usr)] has enabled WY gun restrictions.")
	else
		to_chat(src, "<b>Disabled gun restrictions.</b>")
		message_admins("Admin [key_name_admin(usr)] has disabled WY gun restrictions.")
	CONFIG_SET(flag/remove_gun_restrictions, !CONFIG_GET(flag/remove_gun_restrictions))

/client/proc/togglebuildmodeself()
	set name = "Buildmode"
	set category = "Admin.Events"
	if(!check_rights(R_ADMIN))
		return

	if(src.mob)
		togglebuildmode(src.mob)

/client/proc/drop_bomb()
	set name = "Drop Bomb"
	set desc = "Cause an explosion of varying strength at your location."
	set category = "Admin.Fun"

	var/turf/epicenter = mob.loc
	handle_bomb_drop(epicenter)

/client/proc/handle_bomb_drop(atom/epicenter)
	var/custom_limit = 5000
	var/list/choices = list("Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb")
	var/list/falloff_shape_choices = list("CANCEL", "Linear", "Exponential")
	var/choice = tgui_input_list(usr, "What size explosion would you like to produce?", "Drop Bomb", choices)
	var/datum/cause_data/cause_data = create_cause_data("divine intervention")
	switch(choice)
		if(null)
			return 0
		if("Small Bomb")
			explosion(epicenter, 1, 2, 3, 3, , , , cause_data)
		if("Medium Bomb")
			explosion(epicenter, 2, 3, 4, 4, , , , cause_data)
		if("Big Bomb")
			explosion(epicenter, 3, 5, 7, 5, , , , cause_data)
		if("Custom Bomb")
			var/power = tgui_input_number(src, "Power?", "Power?")
			if(!power)
				return

			var/falloff = tgui_input_number(src, "Falloff?", "Falloff?")
			if(!falloff)
				return

			var/shape_choice = tgui_input_list(src, "Select falloff shape?", "Select falloff shape", falloff_shape_choices)
			var/explosion_shape = EXPLOSION_FALLOFF_SHAPE_LINEAR
			switch(shape_choice)
				if("CANCEL")
					return 0
				if("Exponential")
					explosion_shape = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL

			if(power > custom_limit)
				return
			cell_explosion(epicenter, power, falloff, explosion_shape, null, cause_data)
			message_admins("[key_name(src, TRUE)] dropped a custom cell bomb with power [power], falloff [falloff] and falloff_shape [shape_choice]!")
	message_admins("[ckey] used 'Drop Bomb' at [epicenter.loc].")


/client/proc/cmd_admin_emp(atom/O as obj|mob|turf in world)
	set name = "EM Pulse"
	set category = "Admin.Fun"

	if(!check_rights(R_DEBUG|R_ADMIN))
		return

	var/heavy = input("Range of heavy pulse.", text("Input"))  as num|null
	if(heavy == null)
		return
	var/light = input("Range of light pulse.", text("Input"))  as num|null
	if(light == null)
		return

	if(!heavy && !light)
		return

	empulse(O, heavy, light)
	message_admins("[key_name_admin(usr)] created an EM PUlse ([heavy],[light]) at ([O.x],[O.y],[O.z])")
	return

/datum/admins/proc/admin_force_ERT_shuttle()
	set name = "Force ERT Shuttle"
	set desc = "Force Launch the ERT Shuttle."
	set category = "Admin.Shuttles"

	if (!SSticker.mode)
		return
	if(!check_rights(R_EVENT))
		return

	var/list/shuttle_map = list()
	for(var/obj/docking_port/mobile/emergency_response/ert_shuttles in SSshuttle.mobile)
		shuttle_map[ert_shuttles.name] = ert_shuttles.id
	var/tag = tgui_input_list(usr, "Which ERT shuttle should be force launched?", "Select an ERT Shuttle:", shuttle_map)
	if(!tag)
		return

	var/shuttleId = shuttle_map[tag]
	var/list/docks = SSshuttle.stationary
	var/list/targets = list()
	var/list/target_names = list()
	var/obj/docking_port/mobile/emergency_response/ert = SSshuttle.getShuttle(shuttleId)
	for(var/obj/docking_port/stationary/emergency_response/dock in docks)
		var/can_dock = ert.canDock(dock)
		if(can_dock == SHUTTLE_CAN_DOCK)
			targets += list(dock)
			target_names +=  list(dock.name)
	var/dock_name = tgui_input_list(usr, "Where on the [MAIN_SHIP_NAME] should the shuttle dock?", "Select a docking zone:", target_names)
	var/launched = FALSE
	if(!dock_name)
		return
	for(var/obj/docking_port/stationary/emergency_response/dock as anything in targets)
		if(dock.name == dock_name)
			var/obj/docking_port/stationary/target = SSshuttle.getDock(dock.id)
			ert.request(target)
			launched=TRUE
	if(!launched)
		to_chat(usr, SPAN_WARNING("Unable to launch this Distress shuttle at this moment. Aborting."))
		return

	message_admins("[key_name_admin(usr)] force launched a distress shuttle ([tag])")

/datum/admins/proc/admin_force_distress()
	set name = "Distress Beacon"
	set desc = "Call a distress beacon. This should not be done if the shuttle's already been called."
	set category = "Admin.Shuttles"

	if (!SSticker.mode)
		return

	if(!check_rights(R_EVENT)) // Seems more like an event thing than an admin thing
		return

	var/list/list_of_calls = list()
	var/list/assoc_list = list()

	for(var/datum/emergency_call/L in SSticker.mode.all_calls)
		if(L && L.name != "name")
			list_of_calls += L.name
			assoc_list += list(L.name = L)
	list_of_calls = sortList(list_of_calls)

	list_of_calls += "Randomize"

	var/choice = tgui_input_list(usr, "Which distress call?", "Distress Signal", list_of_calls)

	if(!choice)
		return

	var/datum/emergency_call/chosen_ert
	if(choice == "Randomize")
		chosen_ert = SSticker.mode.get_random_call()
	else
		var/datum/emergency_call/em_call = assoc_list[choice]
		chosen_ert = new em_call.type()

	if(!istype(chosen_ert))
		return
	var/quiet_launch = TRUE
	var/ql_prompt = tgui_alert(usr, "Would you like to broadcast the beacon launch? This will reveal the distress beacon to all players.", "Announce distress beacon?", list("Yes", "No"), 20 SECONDS)
	if(ql_prompt == "Yes")
		quiet_launch = FALSE

	var/announce_receipt = FALSE
	var/ar_prompt = tgui_alert(usr, "Would you like to announce the beacon received message? This will reveal the distress beacon to all players.", "Announce beacon received?", list("Yes", "No"), 20 SECONDS)
	if(ar_prompt == "Yes")
		announce_receipt = TRUE

	var/turf/override_spawn_loc
	var/prompt = tgui_alert(usr, "Spawn at their assigned spawn, or at your location?", "Spawnpoint Selection", list("Spawn", "Current Location"), 0)
	if(!prompt)
		qdel(chosen_ert)
		return
	if(prompt == "Current Location")
		override_spawn_loc = get_turf(usr)

	chosen_ert.activate(quiet_launch, announce_receipt, override_spawn_loc)

	message_admins("[key_name_admin(usr)] admin-called a [choice == "Randomize" ? "randomized ":""]distress beacon: [chosen_ert.name]")

/datum/admins/proc/admin_force_evacuation()
	set name = "Trigger Evacuation"
	set desc = "Triggers emergency evacuation."
	set category = "Admin.Events"

	if(!SSticker.mode || !check_rights(R_ADMIN))
		return
	set_security_level(SEC_LEVEL_RED)
	SShijack.initiate_evacuation()

	message_admins("[key_name_admin(usr)] forced an emergency evacuation.")

/datum/admins/proc/admin_cancel_evacuation()
	set name = "Cancel Evacuation"
	set desc = "Cancels emergency evacuation."
	set category = "Admin.Events"

	if(!SSticker.mode || !check_rights(R_ADMIN))
		return
	SShijack.cancel_evacuation()

	message_admins("[key_name_admin(usr)] canceled an emergency evacuation.")

/datum/admins/proc/add_req_points()
	set name = "Add Requisitions Points"
	set desc = "Add points to the ship requisitions department."
	set category = "Admin.Events"
	if(!SSticker.mode || !check_rights(R_ADMIN))
		return

	var/points_to_add = tgui_input_real_number(usr, "Enter the amount of points to give, or a negative number to subtract. 1 point = $100.", "Points", 0)
	if(!points_to_add)
		return
	else if((GLOB.supply_controller.points + points_to_add) < 0)
		GLOB.supply_controller.points = 0
	else if((GLOB.supply_controller.points + points_to_add) > 99999)
		GLOB.supply_controller.points = 99999
	else
		GLOB.supply_controller.points += points_to_add


	message_admins("[key_name_admin(usr)] granted requisitions [points_to_add] points.")
	if(points_to_add >= 0)
		shipwide_ai_announcement("Additional Supply Budget has been authorised for this operation.")

/datum/admins/proc/check_req_heat()
	set name = "Check Requisitions Heat"
	set desc = "Check how close the CMB is to arriving to search Requisitions."
	set category = "Admin.Events"
	if(!SSticker.mode || !check_rights(R_ADMIN))
		return

	var/req_heat_change = tgui_input_real_number(usr, "Set the new requisitions black market heat. ERT is called at 100, disabled at -1. Current Heat: [GLOB.supply_controller.black_market_heat]", "Modify Req Heat", 0, 100, -1)
	if(!req_heat_change)
		return

	GLOB.supply_controller.black_market_heat = req_heat_change
	message_admins("[key_name_admin(usr)] set requisitions heat to [req_heat_change].")


/datum/admins/proc/admin_force_selfdestruct()
	set name = "Self-Destruct"
	set desc = "Trigger self-destruct countdown. This should not be done if the self-destruct has already been called."
	set category = "Admin.Events"

	if(!SSticker.mode || !check_rights(R_ADMIN) || get_security_level() == "delta")
		return

	if(alert(src, "Are you sure you want to do this?", "Confirmation", "Yes", "No") != "Yes")
		return

	set_security_level(SEC_LEVEL_DELTA)

	message_admins("[key_name_admin(usr)] admin-started self-destruct system.")

/client/proc/view_faxes()
	set name = "View Faxes"
	set desc = "View faxes from this round"
	set category = "Admin.Events"

	if(!admin_holder)
		return

	var/list/options = list(
		"Weyland-Yutani", "High Command", "Provost", "Press",
		"Colonial Marshal Bureau", "Union of Progressive Peoples",
		"Three World Empire", "Colonial Liberation Front",
		"Other", "Cancel")
	var/answer = tgui_input_list(src, "Which kind of faxes would you like to see?", "Faxes", options)
	switch(answer)
		if("Weyland-Yutani")
			var/body = "<body>"

			for(var/text in GLOB.WYFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to Weyland-Yutani", "wyfaxviewer", "size=300x600")

		if("High Command")
			var/body = "<body>"

			for(var/text in GLOB.USCMFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to High Command", "uscmfaxviewer", "size=300x600")

		if("Provost")
			var/body = "<body>"

			for(var/text in GLOB.ProvostFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Provost Office", "provostfaxviewer", "size=300x600")

		if("Press")
			var/body = "<body>"

			for(var/text in GLOB.PressFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to Press organizations", "pressfaxviewer", "size=300x600")

		if("Colonial Marshal Bureau")
			var/body = "<body>"

			for(var/text in GLOB.CMBFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Colonial Marshal Bureau", "cmbfaxviewer", "size=300x600")

		if("Union of Progressive Peoples")
			var/body = "<body>"

			for(var/text in GLOB.UPPFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Union of Progressive Peoples", "uppfaxviewer", "size=300x600")

		if("Three World Empire")
			var/body = "<body>"

			for(var/text in GLOB.TWEFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Three World Empire", "twefaxviewer", "size=300x600")

		if("Colonial Liberation Front")
			var/body = "<body>"

			for(var/text in GLOB.CLFFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Colonial Liberation Front", "clffaxviewer", "size=300x600")

		if("Other")
			var/body = "<body>"

			for(var/text in GLOB.GeneralFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Inter-machine Faxes", "otherfaxviewer", "size=300x600")
		if("Cancel")
			return

/client/proc/award_medal()
	if(!check_rights(R_ADMIN))
		return

	give_medal_award(as_admin=TRUE)

/client/proc/award_jelly()
	if(!check_rights(R_ADMIN))
		return

	// Mostly replicated code from observer.dm.hive_status()
	var/list/hives = list()
	var/datum/hive_status/last_hive_checked

	var/datum/hive_status/hive
	for(var/hivenumber in GLOB.hive_datum)
		hive = GLOB.hive_datum[hivenumber]
		if(hive.totalXenos.len > 0 || hive.total_dead_xenos.len > 0)
			hives += list("[hive.name]" = hive.hivenumber)
			last_hive_checked = hive

	if(!length(hives))
		to_chat(src, SPAN_ALERT("There seem to be no hives at the moment."))
		return
	else if(length(hives) > 1) // More than one hive, display an input menu for that
		var/faction = tgui_input_list(src, "Select which hive to award", "Hive Choice", hives, theme="hive_status")
		if(!faction)
			to_chat(src, SPAN_ALERT("Hive choice error. Aborting."))
			return
		last_hive_checked = GLOB.hive_datum[hives[faction]]

	give_jelly_award(last_hive_checked, as_admin=TRUE)

/client/proc/give_nuke()
	if(!check_rights(R_ADMIN))
		return
	var/nukename = "Decrypted Operational Nuke"
	var/encrypt = tgui_alert(src, "Do you want the nuke to be already decrypted?", "Nuke Type", list("Encrypted", "Decrypted"), 20 SECONDS)
	if(encrypt == "Encrypted")
		nukename = "Encrypted Operational Nuke"
	var/prompt = tgui_alert(src, "THIS CAN BE USED TO END THE ROUND. Are you sure you want to spawn a nuke? The nuke will be put onto the ASRS Lift.", "DEFCON 1", list("No", "Yes"), 30 SECONDS)
	if(prompt != "Yes")
		return

	var/nuketype = GLOB.supply_packs_types[nukename]

	var/datum/supply_order/new_order = new()
	new_order.ordernum = GLOB.supply_controller.ordernum++
	new_order.object = GLOB.supply_packs_datums[nuketype]
	new_order.orderedby = MAIN_AI_SYSTEM
	new_order.approvedby = MAIN_AI_SYSTEM
	GLOB.supply_controller.shoppinglist += new_order

	marine_announcement("A nuclear device has been supplied and will be delivered to requisitions via ASRS.", "NUCLEAR ARSENAL ACQUIRED", 'sound/misc/notice2.ogg')
	message_admins("[key_name_admin(usr)] admin-spawned \a [encrypt] nuke.")
	log_game("[key_name_admin(usr)] admin-spawned \a [encrypt] nuke.")

/client/proc/turn_everyone_into_primitives()
	var/random_names = FALSE
	if (alert(src, "Do you want to give everyone random numbered names?", "Confirmation", "Yes", "No") == "Yes")
		random_names = TRUE
	if (alert(src, "Are you sure you want to do this? It will laaag.", "Confirmation", "Yes", "No") != "Yes")
		return
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(ismonkey(H))
			continue
		H.set_species(pick("Monkey", "Yiren", "Stok", "Farwa", "Neaera"))
		H.is_important = TRUE
		if(random_names)
			var/random_name = "[lowertext(H.species.name)] ([rand(1, 999)])"
			H.change_real_name(H, random_name)
			if(H.wear_id)
				var/obj/item/card/id/card = H.wear_id
				card.registered_name = H.real_name
				card.name = "[card.registered_name]'s ID Card ([card.assignment])"

	message_admins("Admin [key_name(usr)] has turned everyone into a primitive")

/client/proc/force_hijack()
	set name = "Force Hijack"
	set desc = "Force a dropship to be hijacked"
	set category = "Admin.Shuttles"

	var/list/shuttles = list(DROPSHIP_ALAMO, DROPSHIP_NORMANDY)
	var/tag = tgui_input_list(usr, "Which dropship should be force hijacked?", "Select a dropship:", shuttles)
	if(!tag) return

	var/obj/docking_port/mobile/marine_dropship/dropship = SSshuttle.getShuttle(tag)

	if(!dropship)
		to_chat(src, SPAN_DANGER("Error: Attempted to force a dropship hijack but the shuttle datum was null. Code: MSD_FSV_DIN"))
		log_admin("Error: Attempted to force a dropship hijack but the shuttle datum was null. Code: MSD_FSV_DIN")
		return

	var/confirm = tgui_alert(usr, "Are you sure you want to hijack [dropship]?", "Force hijack", list("Yes", "No")) == "Yes"
	if(!confirm)
		return

	var/obj/structure/machinery/computer/shuttle/dropship/flight/computer = dropship.getControlConsole()
	computer.hijack(usr, force = TRUE)

/client/proc/cmd_admin_create_centcom_report()
	set name = "Report: Faction"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return
	var/faction = tgui_input_list(usr, "Please choose faction your announcement will be shown to.", "Faction Selection", (FACTION_LIST_HUMANOID - list(FACTION_YAUTJA) + list("Everyone (-Yautja)")))
	if(!faction)
		return
	var/input = input(usr, "Please enter announcement text. Be advised, this announcement will be heard both on Almayer and planetside by conscious humans of selected faction.", "What?", "") as message|null
	if(!input)
		return
	var/customname = input(usr, "Pick a title for the announcement. Confirm empty text for \"[faction] Update\" title.", "Title") as text|null
	if(isnull(customname))
		return
	if(!customname)
		customname = "[faction] Update"
	if(faction == FACTION_MARINE)
		for(var/obj/structure/machinery/computer/almayer_control/C in GLOB.machines)
			if(!(C.inoperable()))
				var/obj/item/paper/P = new /obj/item/paper( C.loc )
				P.name = "'[customname].'"
				P.info = input
				P.update_icon()
				C.messagetitle.Add("[customname]")
				C.messagetext.Add(P.info)

		if(alert("Press \"Yes\" if you want to announce it to ship crew and marines. Press \"No\" to keep it only as printed report on communication console.",,"Yes","No") == "Yes")
			if(alert("Do you want PMCs (not Death Squad) to see this announcement?",,"Yes","No") == "Yes")
				marine_announcement(input, customname, 'sound/AI/commandreport.ogg', faction)
			else
				marine_announcement(input, customname, 'sound/AI/commandreport.ogg', faction, FALSE)
	else
		marine_announcement(input, customname, 'sound/AI/commandreport.ogg', faction)

	message_admins("[key_name_admin(src)] has created \a [faction] command report")
	log_admin("[key_name_admin(src)] [faction] command report: [input]")

/client/proc/cmd_admin_xeno_report()
	set name = "Report: Queen Mother"
	set desc = "Basically a command announcement, but only for selected Xeno's Hive"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	var/list/hives = list()
	for(var/hivenumber in GLOB.hive_datum)
		var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
		hives += list("[hive.name]" = hive.hivenumber)

	hives += list("All Hives" = "everything")
	var/hive_choice = tgui_input_list(usr, "Please choose the hive you want to see your announcement. Selecting \"All hives\" option will change title to \"Unknown Higher Force\"", "Hive Selection", hives)
	if(!hive_choice)
		return FALSE

	var/hivenumber = hives[hive_choice]


	var/input = input(usr, "This should be a message from the ruler of the Xenomorph race.", "What?", "") as message|null
	if(!input)
		return FALSE

	var/hive_prefix = ""
	if(GLOB.hive_datum[hivenumber])
		var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
		hive_prefix = "[hive.prefix] "

	if(hivenumber == "everything")
		xeno_announcement(input, hivenumber, HIGHER_FORCE_ANNOUNCE)
	else
		xeno_announcement(input, hivenumber, SPAN_ANNOUNCEMENT_HEADER_BLUE("[hive_prefix][QUEEN_MOTHER_ANNOUNCE]"))

	message_admins("[key_name_admin(src)] has created a [hive_choice] Queen Mother report")
	log_admin("[key_name_admin(src)] Queen Mother ([hive_choice]): [input]")

/client/proc/cmd_admin_create_AI_report()
	set name = "Report: ARES Comms"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return FALSE

	if(!ares_is_active())
		to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM] is destroyed, and cannot talk!"))
		return FALSE

	var/input = input(usr, "This is a standard message from the ship's AI. It uses Almayer General channel and won't be heard by humans without access to Almayer General channel (headset or intercom). Check with online staff before you send this. Do not use html.", "What?", "") as message|null
	if(!input)
		return FALSE

	if(!ares_can_interface())
		var/prompt = tgui_alert(src, "ARES interface processor is offline or destroyed, send the message anyways?", "Choose.", list("Yes", "No"), 20 SECONDS)
		if(prompt == "No")
			to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM] is not responding. It's interface processor may be offline or destroyed."))
			return FALSE

	ai_announcement(input)
	message_admins("[key_name_admin(src)] has created an AI comms report")
	log_admin("AI comms report: [input]")


/client/proc/cmd_admin_create_AI_apollo_report()
	set name = "Report: ARES Apollo"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return FALSE

	if(!ares_is_active())
		to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM] is destroyed, and cannot talk!"))
		return FALSE

	var/input = tgui_input_text(usr, "This is a broadcast from the ship AI to Working Joes and Maintenance Drones. Do not use html.", "What?", "")
	if(!input)
		return FALSE

	if(!ares_can_apollo())
		var/prompt = tgui_alert(src, "ARES APOLLO processor is offline or destroyed, send the message anyways?", "Choose.", list("Yes", "No"), 20 SECONDS)
		if(prompt != "Yes")
			to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM] is not responding. It's APOLLO processor may be offline or destroyed."))
			return FALSE

	ares_apollo_talk(input)
	message_admins("[key_name_admin(src)] has created an AI APOLLO report")
	log_admin("AI APOLLO report: [input]")

/client/proc/cmd_admin_create_AI_shipwide_report()
	set name = "Report: ARES Shipwide"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return
	var/input = input(usr, "This is an announcement type message from the ship's AI. This will be announced to every conscious human on Almayer z-level. Be aware, this will work even if ARES unpowered/destroyed. Check with online staff before you send this.", "What?", "") as message|null
	if(!input)
		return FALSE
	if(!ares_can_interface())
		var/prompt = tgui_alert(src, "ARES interface processor is offline or destroyed, send the message anyways?", "Choose.", list("Yes", "No"), 20 SECONDS)
		if(prompt == "No")
			to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM] is not responding. It's interface processor may be offline or destroyed."))
			return

	shipwide_ai_announcement(input)
	message_admins("[key_name_admin(src)] has created an AI shipwide report")
	log_admin("[key_name_admin(src)] AI shipwide report: [input]")

/client/proc/cmd_admin_create_predator_report()
	set name = "Report: Yautja AI"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return
	var/input = input(usr, "This is a message from the predator ship's AI. Check with online staff before you send this.", "What?", "") as message|null
	if(!input)
		return FALSE
	yautja_announcement(SPAN_YAUTJABOLDBIG(input))
	message_admins("[key_name_admin(src)] has created a predator ship AI report")
	log_admin("[key_name_admin(src)] predator ship AI report: [input]")

/client/proc/cmd_admin_world_narrate() // Allows administrators to fluff events a little easier -- TLE
	set name = "Narrate to Everyone"
	set category = "Admin.Events"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	var/narrate_body_text
	var/narrate_header_text
	var/narrate_output

	if(tgui_alert(src, "Do you want your narration to include a header paragraph?", "Global Narrate", list("Yes", "No"), timeout = 0) == "Yes")
		narrate_header_text = tgui_input_text(src, "Please type the header paragraph below. One or two sentences or a title work best. HTML style tags are available. Paragraphs are not recommended.", "Global Narrate Header", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, encode = FALSE, timeout = 0)
		if(!narrate_header_text)
			return
	narrate_body_text = tgui_input_text(src, "Please enter the text for your narration. Paragraphs without line breaks produce the best visual results, but HTML tags in general are respected. A preview will be available.", "Global Narrate Text", max_length = MAX_BOOK_MESSAGE_LEN, multiline = TRUE, encode = FALSE, timeout = 0)
	if(!narrate_body_text)
		return

	if(!narrate_header_text)
		narrate_output = "[narrate_body("[narrate_body_text]")]"
	else
		narrate_output = "[narrate_head("[narrate_header_text]")]" + "[narrate_body("[narrate_body_text]")]"

	to_chat(usr,"[narrate_output]")
	if(tgui_alert(src, "Text preview is available. Send narration?", "Confirmation", list("Yes","No"), timeout = 0) != "Yes")
		return
	to_chat(world, "[narrate_output]")


/client
	var/remote_control = FALSE

/client/proc/toogle_door_control()
	set name = "Toggle Remote Control"
	set category = "Admin.Events"

	if(!check_rights(R_SPAWN))
		return

	remote_control = !remote_control
	message_admins("[key_name_admin(src)] has toggled remote control [remote_control? "on" : "off"] for themselves")

/client/proc/enable_event_mob_verbs()
	set name = "Mob Event Verbs - Show"
	set category = "Admin.Events"

	add_verb(src, GLOB.admin_mob_event_verbs_hideable)
	remove_verb(src, /client/proc/enable_event_mob_verbs)

/client/proc/hide_event_mob_verbs()
	set name = "Mob Event Verbs - Hide"
	set category = "Admin.Events"

	remove_verb(src, GLOB.admin_mob_event_verbs_hideable)
	add_verb(src, /client/proc/enable_event_mob_verbs)

// ----------------------------
// PANELS
// ----------------------------

/datum/admins/proc/event_panel()
	if(!check_rights(R_ADMIN,0))
		return

	var/dat = {"
		<B>Ship</B><BR>
		<A href='?src=\ref[src];[HrefToken()];events=securitylevel'>Set Security Level</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=distress'>Send a Distress Beacon</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=selfdestruct'>Activate Self-Destruct</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=evacuation_start'>Trigger Evacuation</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=evacuation_cancel'>Cancel Evacuation</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=disable_shuttle_console'>Disable Shuttle Control</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=add_req_points'>Add Requisitions Points</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=check_req_heat'>Modify Requisitions Heat</A><BR>
		<BR>
		<B>Research</B><BR>
		<A href='?src=\ref[src];[HrefToken()];events=change_clearance'>Change Research Clearance</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=give_research_credits'>Give Research Credits</A><BR>
		<BR>
		<B>Power</B><BR>
		<A href='?src=\ref[src];[HrefToken()];events=unpower'>Unpower ship SMESs and APCs</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=power'>Power ship SMESs and APCs</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=quickpower'>Power ship SMESs</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=powereverything'>Power ALL SMESs and APCs everywhere</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=powershipreactors'>Repair and power all ship reactors</A><BR>
		<BR>
		<B>Events</B><BR>
		<A href='?src=\ref[src];[HrefToken()];events=blackout'>Break all lights</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=whiteout'>Repair all lights</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=comms_blackout'>Trigger a Communication Blackout</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=destructible_terrain'>Toggle destructible terrain</A><BR>
		<BR>
		<B>Misc</B><BR>
		<A href='?src=\ref[src];[HrefToken()];events=medal'>Award a medal</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=jelly'>Award a royal jelly</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=nuke'>Spawn a nuke</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=pmcguns'>Toggle PMC gun restrictions</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=monkify'>Turn everyone into monkies</A><BR>
		<A href='?src=\ref[src];[HrefToken()];events=xenothumbs'>Give or take opposable thumbs and gun permits from xenos</A><BR>
		<BR>
		"}

	show_browser(usr, dat, "Events Panel", "events")
	return

/client/proc/event_panel()
	set name = "Event Panel"
	set category = "Admin.Panels"
	if (admin_holder)
		admin_holder.event_panel()
	return


/datum/admins/proc/chempanel()
	if(!check_rights(R_MOD)) return

	var/dat
	if(check_rights(R_MOD,0))
		dat += {"<A href='?src=\ref[src];[HrefToken()];chem_panel=view_reagent'>View Reagent</A><br>
				"}
	if(check_rights(R_VAREDIT,0))
		dat += {"<A href='?src=\ref[src];[HrefToken()];chem_panel=view_reaction'>View Reaction</A><br>"}
		dat += {"<A href='?src=\ref[src];[HrefToken()];chem_panel=sync_filter'>Sync Reaction</A><br>
				<br>"}
	if(check_rights(R_SPAWN,0))
		dat += {"<A href='?src=\ref[src];[HrefToken()];chem_panel=spawn_reagent'>Spawn Reagent in Container</A><br>
				<A href='?src=\ref[src];[HrefToken()];chem_panel=make_report'>Make Chem Report</A><br>
				<br>"}
	if(check_rights(R_ADMIN,0))
		dat += {"<A href='?src=\ref[src];[HrefToken()];chem_panel=create_random_reagent'>Generate Reagent</A><br>
				<br>
				<A href='?src=\ref[src];[HrefToken()];chem_panel=create_custom_reagent'>Create Custom Reagent</A><br>
				<A href='?src=\ref[src];[HrefToken()];chem_panel=create_custom_reaction'>Create Custom Reaction</A><br>
				"}

	show_browser(usr, dat, "Chem Panel", "chempanel", "size=210x300")
	return

/client/proc/chem_panel()
	set name = "Chem Panel"
	set category = "Admin.Panels"
	if(admin_holder)
		admin_holder.chempanel()
	return

/datum/admins/var/create_humans_html = null
/datum/admins/proc/create_humans(mob/user)
	if(!GLOB.gear_name_presets_list)
		return

	if(!create_humans_html)
		var/equipment_presets = jointext(GLOB.gear_name_presets_list, ";")
		create_humans_html = file2text('html/create_humans.html')
		create_humans_html = replacetext(create_humans_html, "null /* object types */", "\"[equipment_presets]\"")
		create_humans_html = replacetext(create_humans_html, "/* href token */", RawHrefToken(forceGlobal = TRUE))

	show_browser(user, replacetext(create_humans_html, "/* ref src */", "\ref[src]"), "Create Humans", "create_humans", "size=450x720")

/client/proc/create_humans()
	set name = "Create Humans"
	set category = "Admin.Events"
	if(admin_holder)
		admin_holder.create_humans(usr)

/datum/admins/var/create_xenos_html = null
/datum/admins/proc/create_xenos(mob/user)
	if(!create_xenos_html)
		var/hive_types = jointext(ALL_XENO_HIVES, ";")
		var/xeno_types = jointext(ALL_XENO_CASTES, ";")
		create_xenos_html = file2text('html/create_xenos.html')
		create_xenos_html = replacetext(create_xenos_html, "null /* hive paths */", "\"[hive_types]\"")
		create_xenos_html = replacetext(create_xenos_html, "null /* xeno paths */", "\"[xeno_types]\"")
		create_xenos_html = replacetext(create_xenos_html, "/* href token */", RawHrefToken(forceGlobal = TRUE))

	show_browser(user, replacetext(create_xenos_html, "/* ref src */", "\ref[src]"), "Create Xenos", "create_xenos", "size=450x630")

/client/proc/create_xenos()
	set name = "Create Xenos"
	set category = "Admin.Events"
	if(admin_holder)
		admin_holder.create_xenos(usr)

/client/proc/clear_mutineers()
	set name = "Clear All Mutineers"
	set category = "Admin.Events"
	if(admin_holder)
		admin_holder.clear_mutineers()
	return

/datum/admins/proc/clear_mutineers()
	if(!check_rights(R_MOD))
		return

	if(alert(usr, "Are you sure you want to change all mutineers back to normal?", "Confirmation", "Yes", "No") != "Yes")
		return

	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(H.mob_flags & MUTINEER)
			H.mob_flags &= ~MUTINEER
			H.hud_set_squad()

			for(var/datum/action/human_action/activable/mutineer/A in H.actions)
				A.remove_from(H)

/client/proc/cmd_fun_fire_ob()
	set category = "Admin.Fun"
	set desc = "Fire an OB warhead at your current location."
	set name = "Fire OB"

	if(!check_rights(R_ADMIN))
		return

	var/list/firemodes = list("Standard Warhead", "Custom HE", "Custom Cluster", "Custom Incendiary")
	var/mode = tgui_input_list(usr, "Select fire mode:", "Fire mode", firemodes)
	// Select the warhead.
	var/obj/structure/ob_ammo/warhead/warhead
	var/statsmessage
	var/custom = TRUE
	switch(mode)
		if("Standard Warhead")
			custom = FALSE
			var/list/warheads = subtypesof(/obj/structure/ob_ammo/warhead/)
			var/choice = tgui_input_list(usr, "Select the warhead:", "Warhead to use", warheads)
			warhead = new choice
		if("Custom HE")
			var/obj/structure/ob_ammo/warhead/explosive/OBShell = new
			OBShell.name = input("What name should the warhead have?", "Set name", "HE orbital warhead")
			if(!OBShell.name) return//null check to cancel
			OBShell.clear_power = tgui_input_number(src, "How much explosive power should the wall clear blast have?", "Set clear power", 1200, 3000)
			if(isnull(OBShell.clear_power)) return
			OBShell.clear_falloff = tgui_input_number(src, "How much falloff should the wall clear blast have?", "Set clear falloff", 400)
			if(isnull(OBShell.clear_falloff)) return
			OBShell.standard_power = tgui_input_number(src, "How much explosive power should the main blasts have?", "Set blast power", 600, 3000)
			if(isnull(OBShell.standard_power)) return
			OBShell.standard_falloff = tgui_input_number(src, "How much falloff should the main blasts have?", "Set blast falloff", 30)
			if(isnull(OBShell.standard_falloff)) return
			OBShell.clear_delay = tgui_input_number(src, "How much delay should the clear blast have?", "Set clear delay", 3)
			if(isnull(OBShell.clear_delay)) return
			OBShell.double_explosion_delay = tgui_input_number(src, "How much delay should the clear blast have?", "Set clear delay", 6)
			if(isnull(OBShell.double_explosion_delay)) return
			statsmessage = "Custom HE OB ([OBShell.name]) Stats from [key_name(usr)]: Clear Power: [OBShell.clear_power], Clear Falloff: [OBShell.clear_falloff], Clear Delay: [OBShell.clear_delay], Blast Power: [OBShell.standard_power], Blast Falloff: [OBShell.standard_falloff], Blast Delay: [OBShell.double_explosion_delay]."
			warhead = OBShell
		if("Custom Cluster")
			var/obj/structure/ob_ammo/warhead/cluster/OBShell = new
			OBShell.name = input("What name should the warhead have?", "Set name", "Cluster orbital warhead")
			if(!OBShell.name) return//null check to cancel
			OBShell.total_amount = tgui_input_number(src, "How many salvos should be fired?", "Set cluster number", 60)
			if(isnull(OBShell.total_amount)) return
			OBShell.instant_amount = tgui_input_number(src, "How many shots per salvo? (Max 10)", "Set shot count", 3)
			if(isnull(OBShell.instant_amount)) return
			if(OBShell.instant_amount > 10)
				OBShell.instant_amount = 10
			OBShell.explosion_power = tgui_input_number(src, "How much explosive power should the blasts have?", "Set blast power", 300, 1500)
			if(isnull(OBShell.explosion_power)) return
			OBShell.explosion_falloff = tgui_input_number(src, "How much falloff should the blasts have?", "Set blast falloff", 150)
			if(isnull(OBShell.explosion_falloff)) return
			statsmessage = "Custom Cluster OB ([OBShell.name]) Stats from [key_name(usr)]: Salvos: [OBShell.total_amount], Shot per Salvo: [OBShell.instant_amount], Explosion Power: [OBShell.explosion_power], Explosion Falloff: [OBShell.explosion_falloff]."
			warhead = OBShell
		if("Custom Incendiary")
			var/obj/structure/ob_ammo/warhead/incendiary/OBShell = new
			OBShell.name = input("What name should the warhead have?", "Set name", "Incendiary orbital warhead")
			if(!OBShell.name) return//null check to cancel
			OBShell.clear_power = tgui_input_number(src, "How much explosive power should the wall clear blast have?", "Set clear power", 1200, 3000)
			if(isnull(OBShell.clear_power)) return
			OBShell.clear_falloff = tgui_input_number(src, "How much falloff should the wall clear blast have?", "Set clear falloff", 400)
			if(isnull(OBShell.clear_falloff)) return
			OBShell.clear_delay = tgui_input_number(src, "How much delay should the clear blast have?", "Set clear delay", 3)
			if(isnull(OBShell.clear_delay)) return
			OBShell.distance = tgui_input_number(src, "How many tiles radius should the fire be? (Max 30)", "Set fire radius", 18, 30)
			if(isnull(OBShell.distance)) return
			if(OBShell.distance > 30)
				OBShell.distance = 30
			OBShell.fire_level = tgui_input_number(src, "How long should the fire last?", "Set fire duration", 70)
			if(isnull(OBShell.fire_level)) return
			OBShell.burn_level = tgui_input_number(src, "How damaging should the fire be?", "Set fire strength", 80)
			if(isnull(OBShell.burn_level)) return
			var/list/firetypes = list("white","blue","red","green","custom")
			OBShell.fire_type = tgui_input_list(usr, "Select the fire color:", "Fire color", firetypes)
			if(isnull(OBShell.fire_type)) return
			OBShell.fire_color = null
			if(OBShell.fire_type == "custom")
				OBShell.fire_type = "dynamic"
				OBShell.fire_color = input(src, "Please select Fire color.", "Fire color") as color|null
				if(isnull(OBShell.fire_color)) return
			statsmessage = "Custom Incendiary OB ([OBShell.name]) Stats from [key_name(usr)]: Clear Power: [OBShell.clear_power], Clear Falloff: [OBShell.clear_falloff], Clear Delay: [OBShell.clear_delay], Fire Distance: [OBShell.distance], Fire Duration: [OBShell.fire_level], Fire Strength: [OBShell.burn_level]."
			warhead = OBShell

	if(custom)
		if(alert(usr, statsmessage, "Confirm Stats", "Yes", "No") != "Yes")
			qdel(warhead)
			return
		message_admins(statsmessage)

	var/turf/target = get_turf(usr.loc)

	if(alert(usr, "Fire or Spawn Warhead?", "Mode", "Fire", "Spawn") == "Fire")
		if(alert("Are you SURE you want to do this? It will create an OB explosion!",, "Yes", "No") != "Yes")
			qdel(warhead)
			return

		message_admins("[key_name(usr)] has fired \an [warhead.name] at ([target.x],[target.y],[target.z]).")
		warhead.warhead_impact(target)

	else
		warhead.forceMove(target)

/client/proc/change_taskbar_icon()
	set name = "Set Taskbar Icon"
	set desc = "Change the taskbar icon to a preset list of selectable icons."
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN))
		return

	var/taskbar_icon = tgui_input_list(usr, "Select an icon you want to appear on the player's taskbar.", "Taskbar Icon", GLOB.available_taskbar_icons)
	if(!taskbar_icon)
		return

	SSticker.mode.taskbar_icon = taskbar_icon
	SSticker.set_clients_taskbar_icon(taskbar_icon)
	message_admins("[key_name_admin(usr)] has changed the taskbar icon to [taskbar_icon].")

/client/proc/change_weather()
	set name = "Change Weather"
	set category = "Admin.Events"

	if(!check_rights(R_EVENT))
		return

	if(!SSweather.map_holder)
		to_chat(src, SPAN_WARNING("This map has no weather data."))
		return

	if(SSweather.is_weather_event_starting)
		to_chat(src, SPAN_WARNING("A weather event is already starting. Please wait."))
		return

	if(SSweather.is_weather_event)
		if(tgui_alert(src, "A weather event is already in progress! End it?", "Confirm", list("End", "Continue"), 10 SECONDS) == "Continue")
			return
		if(SSweather.is_weather_event)
			SSweather.end_weather_event()

	var/list/mappings = list()
	for(var/datum/weather_event/typepath as anything in subtypesof(/datum/weather_event))
		mappings[initial(typepath.name)] = typepath
	var/chosen_name = tgui_input_list(src, "Select a weather event to start", "Weather Selector", mappings)
	var/chosen_typepath = mappings[chosen_name]
	if(!chosen_typepath)
		return

	var/retval = SSweather.setup_weather_event(chosen_typepath)
	if(!retval)
		to_chat(src, SPAN_WARNING("Could not start the weather event at present!"))
		return
	to_chat(src, SPAN_BOLDNOTICE("Success! The weather event should start shortly."))


/client/proc/cmd_admin_create_bioscan()
	set name = "Report: Bioscan"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	var/choice = tgui_alert(usr, "Are you sure you want to trigger a bioscan?", "Bioscan?", list("Yes", "No"))
	if(choice != "Yes")
		return
	else
		var/faction = tgui_input_list(usr, "What faction do you wish to provide a bioscan for?", "Bioscan Faction", list("Xeno","Marine","Yautja"), 20 SECONDS)
		var/variance = tgui_input_number(usr, "How variable do you want the scan to be? (+ or - an amount from truth)", "Variance", 2, 10, 0, 20 SECONDS)
		message_admins("BIOSCAN: [key_name(usr)] admin-triggered a bioscan for [faction].")
		GLOB.bioscan_data.get_scan_data()
		switch(faction)
			if("Xeno")
				GLOB.bioscan_data.qm_bioscan(variance)
			if("Marine")
				var/force_status = FALSE
				if(!ares_can_interface()) //proc checks if ARES is dead or if ARES cannot do announcements
					var/force_check = tgui_alert(usr, "ARES is currently unable to properly display and/or perform the Bioscan, do you wish to force ARES to display the bioscan?", "Display force", list("Yes", "No"), 20 SECONDS)
					if(force_check == "Yes")
						force_status = TRUE
				GLOB.bioscan_data.ares_bioscan(force_status, variance)
			if("Yautja")
				GLOB.bioscan_data.yautja_bioscan()

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

	var/song_title = tgui_input_text(usr, message = "Song Title - Displayed BOLDED on top.", title = "Song Title", timeout = null)
	if (song_title == null) return
	var/song_artist = tgui_input_text(usr, message = "Song Artist - Second line, left.", title = "Song Artist", timeout = null)
	if (song_artist == null) return
	var/song_name = tgui_input_text(usr, message = "Song Name - Second line, after dash on right. LAST CHANCE TO CANCEL.", title = "Song Name", timeout = null)
	if (song_name == null) return
	var/song_album = tgui_input_text(usr, message = "Song Album. Optional, Third line.", title = "Song Album", timeout = null)
	show_blurb_song(name = "[song_title]", artist = "[song_artist]", title = "[song_title]", album = "[song_album]")
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

	var/puzzlebox_admin_option = tgui_input_list(usr, "Select a Sequence", "Start Sequence", list("None - Leave", "Dock 31 Landing", "Dock 31 Elevator Up", "Dorms - Going Down","Pythia Statistic Icons","Resolution"), 0)
	if (!puzzlebox_admin_option) return
	switch(puzzlebox_admin_option)
		if("None - Leave")
			return
		if("Dock 31 Landing")
			to_chat(world, narrate_body("The shuttle's Twilight Paradox drives sigh quietly as the shuttle makes a leapfrog style jump towards the PST. As it approaches, the stations on board systems take control of the shuttle and start to guide it towards its destination."))
			sleep(150)
			to_chat(world, narrate_body("The station is huge, likely the biggest artificial object in the Neroid Sector, if not all the Veils. The shuttle comes close near its top, from where the station widens considerably. It's hard to not notice how well maintained the outer hull of the station is, indicating that it is either freshly built, or unusually well maintained for an object its size."))
			sleep(150)
			to_chat(world, narrate_body("The shuttle slows down and starts to fly along the side of the station, near one of its closed wings. It turns sharply and ducks right under the wing and gives you a clear view of what seems to be a fleet of thousands of small drones, all parked in charging stations strewn what look like zero gravity manufacturing and 3d printing plants. All of this seems to be automated but is currently inert."))
			sleep(150)
			to_chat(world, narrate_body("The shuttle gets out from under the wing and heads for what is essentially the bottom of the station where it becomes paper thin again. Here, various sized ports and berths are located. You take notice of what looks to be several medium-sized corporate ships docked in one segment of the station's docking facilities."))
			sleep(150)
			to_chat(world, narrate_body("The shuttle arrives at its destination and the drives power off. The airlock takes a moment to pressurize, then beeps."))
			return
		if("Dock 31 Elevator Up")
			to_chat(world, narrate_body("The elevator groans then rather violently jerks and begins its rapid ascent topside. Hanako was not kidding. The ascent is intense and pushes you into your chair somewhat. The sensation is not enough to be painful and with the jolt of adrenaline that follows it, certainly wakes you up somewhat."))
			sleep(150)
			to_chat(world, narrate_body("You notice bright blue patterns on the shaft of the elevator, seemingly wrapping around the shaft from all directions. The ascent is too rapid to make out what exactly is the source of these patterns, but these seem unique to the PST."))
			sleep(150)
			to_chat(world, narrate_body("The elevator stops as suddenly as it starts, giving you one final jerk and shot of adrenaline as a pair of doors begins to unseal. You have arrived at your destination."))
			return
		if("Dorms - Going Down")
			to_chat(world, narrate_body("The elevator hums and beings its descent back into the depths of the PST. Compared to the previous ride, this descent is gentle. Pleasant. Really, all its missing is elevator music."))
			sleep(100)
			to_chat(world, narrate_body("Like the other shaft, this one is also filled with intricate, blue glowing patterns. You can make out their source this time - these all appear to be Liquid Data streams, housed in special cables that seem nearly translucent. You have never seen a solution like this before, normally Liquid Data devices are highly secure and kept in contained areas of ships."))
			sleep(150)
			to_chat(world, narrate_body("The elevator slows and stops as it arrives at its destination. As its doors start to unseal, you feel a breeze on your cheeks."))
			return
		if("Pythia Statistic Icons")
			for(var/obj/structure/eventterminal/puzzle05/testament_of_sacrifice/pythia in world)
				for(var/obj/structure/machinery/light/marker/admin/mel in world)
					if(mel.light_id == "melinoe")
						pythia.pythia_terminal_icons("data")
						mel.emoteas("The terminal monitors fizzle for a moment, then each begin to display its own, unsynchronized stream of data. For a while, the data seems random.")
						mel.emoteas("You then start to see patterns. The terminal seems to be displaying security records, conversation records, mission reports and other official data about each and every one of you present in the room, switching between person to person at random intervals.")
						mel.emoteas("It takes you a moment to realize that not all the data is correct. Some of it seems to mention events that have not taken place but all, somewhat disturbingly, seem to end with your demise in some accident or combat deployment, some time in the last year.")
		if("Resolution")
			to_chat(world, narrate_head("A warning klaxon rings out across the station as airlocks start to seal and clamp shut. The familiar robotic voice speaks:"))
			to_chat(world, narrate_body("Attention. Security Lockout. Unauthorized attempt to overwrite proprietary UACM technology. All personnel are to remain locked down in their assigned dorms until an All-Clear signal is sent. Expected time until resolution: 70 hours."))
			sleep(150)
			to_chat(world, narrate_head("The speakers fizzle and buzz, then pop. The warning klaxon stops. A female voice you've all heard before rings out from the loudspeaker:"))
			to_chat(world, narrate_body("Attention Test Crews of the PST. This is CA-RW. It appears you have triggered a security lockout after you have, somehow, tried to overwrite the station's Artificial Intelligence with an unscheduled software package which we think triggered every security warning known to mankind."))
			sleep(150)
			to_chat(world, narrate_body("I would be mad if we weren't both slightly impressed. I'm going to wager a guess that you were helped by a certain overactive station engineer that knows way more about the PST for their own good and that you found an MUP hidden inside a Task Force 14 safe house."))
			sleep(150)
			to_chat(world, narrate_body("I'm sorry to do this to you, but we have no way of overriding the lockout remotely. This will require the physical presence of one of us and our very gentle little fingers. The Persephone is on its way. Expect one or both of us in less than twelve hours, likely with another bunch of recruits. Until then, enjoy what constitutes your new home. I left some snacks."))
			sleep(150)
			to_chat(world, narrate_body("Keep in mind that UACM brass has also taken notice of this alert and they are likely on the way too but knowing them it will take them a good sixty hours to even send a ship here. The next twenty-four hours on the PST are likely going to be heavily investigated by the authorities and if you want to insulate yourself from that sort of attention, we both respect that choice and will give you the means to do so, no questions asked."))
			sleep(150)
			to_chat(world, narrate_head("The speakers pop again, and this time die down for good. The PST is silent again, though the lockdown persists."))
			return
