//Sector Patrol Ship to Ship combat master defs. I'm using master defs because GLOBs/Datums sure are fun, but when it comes to actually live editing values in game, being able to VV a controller wihtout any other admin commands is the best chocie I find, and that sollution needs these.area
//Because this thin guses /global/ for the grid, IN THEORY the whole system should work as long as at least one IC console is in game. For obvious reasons assuming that this will always be the case in game is not wise, so this thing will likely exist in game too.
/obj/structure/shiptoship_master
	name = "Ship to Ship Master Control"
	desc = "This shoudnt be in the main IC space, but if you're ghosted and peering behind the secenes, one of these is somewhere in the admin area. Congrats on findng it :p"
	icon = 'icons/sp_default.dmi'
	icon_state = "default"
	var/global/list/sector_map = list()
	var/global/list/round_history = list()
	var/global/list/round_history_current = list()
	var/list/variable_storage = list(
		"stored_x" = 0,
		"stored_y" = 0,
		"stored_tag" = 0,
		)

/obj/structure/shiptoship_master/proc/ReturnBearing(x = null, y = null)
	var/x_to_check = x
	var/y_to_check = y
	if(x_to_check == null || y_to_check == null) return
	if(x_to_check == 0 && y_to_check == 0) return
	if(x_to_check < 0)
		if(y_to_check > 0)
			return "NW"
		if(y_to_check < 0)
			return "SW"
	if(x_to_check > 0)
		if(y_to_check > 0)
			return "NE"
		if(y_to_check < 0)
			return "SE"
	if(x_to_check == 0)
		if(y_to_check > 0)
			return "N"
		if(y_to_check < 0)
			return "S"
	if(y_to_check == 0)
		if(x_to_check > 0)
			return "E"
		if(x_to_check < 0)
			return "W"


/obj/structure/shiptoship_master/proc/log_round_history(event = null, log_source = null, log_target = null, log_dest_x = null, log_dest_y = null)
	var/event_to_add = event
	var/log_source_to_add = log_source
	var/log_target_to_add = log_target
	if(event_to_add == null) return
	if(log_source_to_add == null) log_source_to_add = "Unidentified"
	if(log_target_to_add == null) log_target_to_add = "Unidentified"
	switch(event_to_add)
		if("collision")
			round_history.Add("The [log_source_to_add] barely avoided a collision with the [log_target_to_add].")
			return
		if("collision_move")
			var/x_to_move = log_dest_x
			if(x_to_move == null) x_to_move = 50
			var/y_to_move = log_dest_y
			if(y_to_move == null) y_to_move = 50
			round_history.Add("The [log_source_to_add] arrives at coordinates [x_to_move],[y_to_move] after emergency maeouvers.")
			return

/obj/structure/shiptoship_master/proc/CheckCollision(type = null, x = null, y = null)
	var/x_to_check = x
	var/y_to_check = y
	var/type_to_check = type
	if(x_to_check == null || y_to_check == null || type_to_check == null) return
	if(sector_map[x_to_check][y_to_check][type_to_check]["id_tag"] != null)
		return 1
	if(sector_map[x_to_check][y_to_check][type_to_check]["id_tag"] == null)
		return 0

/obj/structure/shiptoship_master/proc/CollisionMove(move_source_x = 0, move_source_y = 0, move_destination_x = 0, move_destination_y = 0)
	var/moving_source_x = move_source_x
	var/moving_source_y = move_source_y
	var/moving_destination_x = move_destination_x
	var/moving_destination_y = move_destination_y
	if(moving_source_x <= 0 || moving_source_y <= 0 ||moving_destination_x <= 0 ||moving_destination_y <= 0) return
	while(CheckCollision(type = "ship", x = moving_destination_x, y = moving_destination_y) == 1)
		switch(ReturnBearing(x = sector_map[move_source_x][move_source_y]["ship"]["vector"]["x"], y = sector_map[move_source_x][move_source_y]["ship"]["vector"]["x"]))
			if("NW")
				moving_destination_x += 1
				if(CheckCollision(type = "ship", x = moving_destination_x, y = moving_destination_y) == 0) break
				moving_destination_y -= 1
			if("SW")
				moving_destination_x += 1
				if(CheckCollision(type = "ship", x = moving_destination_x, y = moving_destination_y) == 0) break
				moving_destination_y += 1
			if("NE")
				moving_destination_x -= 1
				if(CheckCollision(type = "ship", x = moving_destination_x, y = moving_destination_y) == 0) break
				moving_destination_y -= 1
			if("SE")
				moving_destination_x -= 1
				if(CheckCollision(type = "ship", x = moving_destination_x, y = moving_destination_y) == 0) break
				moving_destination_y += 1
			if("N")
				moving_destination_y -= 1
			if("S")
				moving_destination_y += 1
			if("E")
				moving_destination_x -= 1
			if("W")
				moving_destination_x += 1
	log_round_history(event = "collision_move", log_source = sector_map[move_source_x][move_source_y]["ship"]["name"], log_target = sector_map[moving_destination_x][moving_destination_y]["ship"]["name"], log_dest_x = moving_destination_x, log_dest_y = moving_destination_y)



/obj/structure/shiptoship_master/proc/ProcessMovement(type = null)
	var/type_to_process = type
	if(type_to_process == null) return
	if(type_to_process == "ship")
		var/destination_x = 0
		var/destination_y = 0
		var/current_x = 1
		var/current_y = 1
		while (current_y <= GLOB.sector_map_y)
			while(current_x <= GLOB.sector_map_x)
				if(sector_map[current_x][current_y][type_to_process]["id_tag"] != null)
					if((sector_map[current_x][current_y][type_to_process]["vector"]["x"] != 0 && sector_map[current_x][current_y][type_to_process]["vector"]["y"] != 0) || sector_map[current_x][current_y][type_to_process]["system"]["processed_movement"] != 1)
						destination_x = current_x + sector_map[current_x][current_y][type_to_process]["vector"]["x"]
						destination_y = current_y + sector_map[current_x][current_y][type_to_process]["vector"]["y"]
						if(CheckCollision(type = type_to_process, x = destination_x, y = destination_y) == 1)
							log_round_history(event = "collision", log_source = sector_map[current_x][current_y][type_to_process]["name"], log_target = sector_map[destination_x][current_y][type_to_process]["name"])
							CollisionMove(move_source_x = current_x, move_source_y = current_y, move_destination_x = destination_x, move_destination_y = destination_y)
							return

/obj/structure/shiptoship_master/proc/populate_alpha()
	add_entity (entity_type = 0, x = 50, y = 50, name = "UAS Almayer", type = "Support and Logistics Transport", vector_x = 4, vector_y = -4, ship_status = "Operational", ship_faction = "UACM", ship_damage = 0, ship_shield = 5, ship_speed = 5)
	to_chat(world, SPAN_INFO("Testing data loaded."))

/obj/structure/shiptoship_master/proc/populate_map()
	var/current_x = 1
	var/current_y = 1
	while(current_y <= GLOB.sector_map_y)
		while(current_x <= GLOB.sector_map_x)
			sector_map[current_x][current_y] = list(
				"ship" = list(
					"id_tag" = "none",
					"faction" = "none",
					"status" = "none",
					"damage" = 0,
					"shield" = 0,
					"name" = "none",
					"type" = "none",
					"vector" = list("x" = 0, "y" = 0,"speed" = 0,),
					),
				"missle" = list(
					"id_tag" = "none",
					"target" = list("x" = 0, "y" = 0,),
					"speed" = 0,
					"warhead" = "none",
					),
				"other" = list(
					"special_id" = "none",
					"special_name" = "none",
					"special_type" = "none",
					"special_flavor" = "none",
					),
				"system" = list(
					"has_moved" = 0,
					"movement_left" = 0,
					"processed_movement" = 0,
					"has_repapired" = 0,
					"repairs_left" = 0,
					"has_fired" = 0,
					"salvos_left" = 0,
					)
				)
			current_x += 1
		current_x = 1
		current_y += 1

	to_chat(world, SPAN_INFO("Sector Map Populated and ready for initial setup."))
	return 1

/obj/structure/shiptoship_master/Initialize(mapload, ...)
	. = ..()
	if (GLOB.sector_map_initialized == 0)
		sector_map = new/list(GLOB.sector_map_x, GLOB.sector_map_y)
		if(populate_map() == 1)
			populate_alpha()
			GLOB.sector_map_initialized = 1


/obj/structure/shiptoship_master/proc/scan_entites(category = 0, output_format = 0) // category = 0 for ships, 1 for missles, 2 for specials. format = 0 text for screen display/ref lists. 1 creates buttons with references.
	var/list/current_entites = list()
	var/current_x = 1
	var/current_y = 1
	while (current_y <= GLOB.sector_map_y)
		while(current_x <= GLOB.sector_map_x)
			if(category == 0)
				if(sector_map[current_x][current_y]["ship"]["id_tag"] != "none")
					if(output_format == 0)
						current_entites.Add("([current_x],[current_y])<b> - [sector_map[current_x][current_y]["ship"]["id_tag"]]</b><br><b>[sector_map[current_x][current_y]["ship"]["name"]]</b> - [sector_map[current_x][current_y]["ship"]["type"]] <br><b>VECTOR:</b> [sector_map[current_x][current_y]["ship"]["vector"]["x"]],[sector_map[current_x][current_y]["ship"]["vector"]["y"]] |<b> STATUS: </b>[sector_map[current_x][current_y]["ship"]["status"]] |<b> D:</b>[sector_map[current_x][current_y]["ship"]["damage"]] | <b>S:</b>[sector_map[current_x][current_y]["ship"]["shield"]]")
					if(output_format == 1)
						current_entites.Add(sector_map[current_x][current_y]["ship"]["id_tag"])
			if(category == 1)
				if(sector_map[current_x][current_y]["missle"]["id_tag"] != "none")
					if(output_format == 0)
						current_entites.Add("([current_x],[current_y])<b> - [sector_map[current_x][current_y]["missle"]["id_tag"]]</b> - [sector_map[current_x][current_y]["missle"]["warhead"]]<br>TARGET: <b>([sector_map[current_x][current_y]["missle"]["target"]["x"]],[sector_map[current_x][current_y]["missle"]["target"]["y"]])</b> | <b>SPEED:</b> [sector_map[current_x][current_y]["missle"]["speed"]]")
					if(output_format == 1)
						current_entites.Add(sector_map[current_x][current_y]["missle"]["id_tag"])
			current_x += 1
		current_x = 1
		current_y += 1
	if (current_entites.len == 0)
		if(category == 0)
			current_entites.Add("No active ships")
		if(category == 1)
			current_entites.Add("No active projectiles")
	return current_entites

/obj/structure/shiptoship_master/proc/open_movement_console(x = null, y = null)
	var/ship_to_move_x = x
	var/ship_to_move_y = y
	if(ship_to_move_x == null || ship_to_move_y == null) return
	if(sector_map[ship_to_move_x][ship_to_move_y]["system"]["has_moved"] == 0 && sector_map[ship_to_move_x][ship_to_move_y]["system"]["movement_left"] == 0)
		sector_map[ship_to_move_x][ship_to_move_y]["system"]["movement_left"] = sector_map[ship_to_move_x][ship_to_move_y]["ship"]["vector"]["speed"]
	variable_storage["stored_x"] = ship_to_move_x
	variable_storage["stored_y"] = ship_to_move_y
	var/terminal_html ={"<!DOCTYPE html>
	<html>
	<head>
	<style>
	body {
	background-color:black;
	}
	#main_window {
	font-family: 'Lucida Grande', monospace;
	font-size: 20px;
	color: #ffffff;
	text-align: center;
	padding: 0em 1em;
	}
	</style>
	</head>
	<body>
	<div id="main_window">
	<p>
	[sector_map[ship_to_move_x][ship_to_move_y]["ship"]["name"]]<br>Vector: ([sector_map[ship_to_move_x][ship_to_move_y]["ship"]["vector"]["x"]],[sector_map[ship_to_move_x][ship_to_move_y]["ship"]["vector"]["y"]])
	</p>
	<p>
	<a href='?src=\ref[src];ship_control=y_plus'>+Y</a><br><a href='?src=\ref[src];ship_control=x_minus'>-X</a> | [sector_map[ship_to_move_x][ship_to_move_y]["system"]["movement_left"]] | <a href='?src=\ref[src];ship_control=x_plus'>+X</a><br><a href='?src=\ref[src];ship_control=y_minus'>-Y</a>
	</p>
	<p>
	<a href='?src=\ref[src];ship_control=close'>EXIT</a>
	</p>
	</div>
	</body>
	"}
	usr << browse(terminal_html,"window=[sector_map[ship_to_move_x][ship_to_move_y]["ship"]["id_tag"]]-control;display=1;size=300x300;border=5px;can_close=0;can_resize=0;can_minimize=0;titlebar=0")
	onclose(usr, "[sector_map[ship_to_move_x][ship_to_move_y]["ship"]["id_tag"]]-control")

/obj/structure/shiptoship_master/proc/mod_entity(entity_type = "none", entity_tag = "none", entity_property = "none")
	var/mod_entity_type = entity_type
	var/mod_entity_tag = entity_tag
	var/mod_entity_prop = entity_property
	if(mod_entity_tag == null || mod_entity_prop == null || mod_entity_type == null) return
	var/current_x = 1
	var/current_y = 1
	var/mod_tag_x
	var/mod_tag_y
	var/mod_original_value
	while (current_y <= GLOB.sector_map_y)
		while(current_x < GLOB.sector_map_x)
			if(sector_map[current_x][current_y]["ship"]["id_tag"] == mod_entity_tag)
				mod_tag_x = current_x
				mod_tag_y = current_y
				break
			current_x += 1
		if(mod_tag_x && mod_tag_y)
			current_x = 1
			current_y = 1
			break
		current_x = 1
		current_y += 1
	if(mod_entity_type == "ship")
		switch(mod_entity_prop)
			if("name")
				mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]
				sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = tgui_input_text(usr, "Enter ship name or otherwise identifiable nickname", "NAME Entry", timeout = 0)
				if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = mod_original_value
				MasterControl()
				return
			if("faction")
				mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]
				sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = tgui_input_text(usr, "Enter ship faction", "FACTION Entry", timeout = 0)
				if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = mod_original_value
				MasterControl()
				return
			if("id_tag")
				mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]
				sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = tgui_input_text(usr, "Enter ship ID Tag","id_tag entry", timeout = 0)
				if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = mod_original_value
				MasterControl()
				return
			if("type")
				mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]
				sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = tgui_input_text(usr, "Enter ship type", "TYPE Entry", timeout = 0)
				if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = mod_original_value
				MasterControl()
				return
			if("status")
				mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]
				sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = tgui_input_text(usr, "Enter ship status", "STATUS Entry", timeout = 0)
				if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = mod_original_value
				MasterControl()
				return
			if("damage")
				mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]
				sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = tgui_input_number(usr, "Pick Damage value","DAM Entry", default = 0,  min_value = 0, timeout = 0)
				if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = mod_original_value
				MasterControl()
				return
			if("shield")
				mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]
				sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = tgui_input_number(usr, "Pick Shield value","SHLD Entry", default = 0,  min_value = 0, timeout = 0)
				if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop] = mod_original_value
				MasterControl()
				return
			if("vector")
				if(tgui_input_list(usr, "Open Movement Console or Hard Edit Values?", "Vector Mod Type", list("Movement Console","Hard Edit")) == "Hard Edit")
					mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["x"]
					sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["x"] = tgui_input_number(usr, "Pick Vector X value","Vector X Entry", default = 0, max_value = 1000, min_value = 1000, timeout = 0)
					if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["x"] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["x"] = mod_original_value
					mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["y"]
					sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["y"] = tgui_input_number(usr, "Pick Vector Y value","Vector Y Entry", default = 0, max_value = 1000, min_value = 1000, timeout = 0)
					if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["y"] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["y"] = mod_original_value
					mod_original_value = sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["speed"]
					sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["speed"] = tgui_input_number(usr, "Pick Vector Speed value","Vector SPD Entry", default = 0, min_value = 0, timeout = 0)
					if (sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["speed"] == null) sector_map[mod_tag_x][mod_tag_y][mod_entity_type][mod_entity_prop]["speed"] = mod_original_value
					MasterControl()
					return
				else
					open_movement_console(x = mod_tag_x, y = mod_tag_y)
					return

/obj/structure/shiptoship_master/proc/add_entity (entity_type = 0, x = 1, y = 1, name = "none", type = "none", vector_x = 0, vector_y = 0, ship_status = "none", ship_faction = "none", ship_damage = 0, ship_shield = 0, ship_speed = 0) // 0 ships, 1 missles
	var/coord_x = x
	var/coord_y = y
	var/name_to_apply = name
	var/type_to_apply = type
	var/vector_x_to_apply = vector_x
	var/vector_y_to_apply = vector_y
	var/faction_to_apply = ship_faction
	var/status_to_apply = ship_status
	var/shield_to_apply = ship_shield
	var/damage_to_apply = ship_damage
	var/speed_to_apply = ship_speed
	if(entity_type == 0)
		sector_map[coord_x][coord_y]["ship"]["name"] = name_to_apply
		sector_map[coord_x][coord_y]["ship"]["faction"] = faction_to_apply
		sector_map[coord_x][coord_y]["ship"]["id_tag"] = "[sector_map[coord_x][coord_y]["ship"]["faction"]]-SHIP-[GLOB.sector_map_id_tag]"
		GLOB.sector_map_id_tag += 1
		sector_map[coord_x][coord_y]["ship"]["type"] = type_to_apply
		sector_map[coord_x][coord_y]["ship"]["vector"]["x"] = vector_x_to_apply
		sector_map[coord_x][coord_y]["ship"]["vector"]["y"] = vector_y_to_apply
		sector_map[coord_x][coord_y]["ship"]["vector"]["speed"] = speed_to_apply
		sector_map[coord_x][coord_y]["ship"]["status"] = status_to_apply
		sector_map[coord_x][coord_y]["ship"]["damage"] = damage_to_apply
		sector_map[coord_x][coord_y]["ship"]["shield"] = shield_to_apply
		return
	if(entity_type == 1)
		sector_map[coord_x][coord_y]["missle"]["speed"] = name_to_apply
		sector_map[coord_x][coord_y]["missle"]["id_tag"] = "MSL-[GLOB.sector_map_id_tag]"
		GLOB.sector_map_id_tag += 1
		sector_map[coord_x][coord_y]["missle"]["warhead"] = type_to_apply
		sector_map[coord_x][coord_y]["missle"]["target"]["x"] = vector_x_to_apply
		sector_map[coord_x][coord_y]["missle"]["target"]["y"] = vector_y_to_apply
		return

/obj/structure/shiptoship_master/proc/rem_entity(id = null)
	var/tag_to_remove = id
	if(tag_to_remove == null) return
	var/current_x = 1
	var/current_y = 1
	while (current_y <= GLOB.sector_map_y)
		while(current_x < GLOB.sector_map_x)
			if(sector_map[current_x][current_y]["ship"]["id_tag"] == tag_to_remove)
				sector_map[current_x][current_y]["ship"]["name"] = "none"
				sector_map[current_x][current_y]["ship"]["id_tag"] = "none"
				sector_map[current_x][current_y]["ship"]["type"] = "none"
				sector_map[current_x][current_y]["ship"]["faction"] = "none"
				sector_map[current_x][current_y]["ship"]["status"] = "none"
				sector_map[current_x][current_y]["ship"]["damage"] = 0
				sector_map[current_x][current_y]["ship"]["shield"] = 0
				sector_map[current_x][current_y]["ship"]["vector"]["x"] = 0
				sector_map[current_x][current_y]["ship"]["vector"]["y"] = 0
				sector_map[current_x][current_y]["ship"]["vector"]["speed"] = 0
			if(sector_map[current_x][current_y]["missle"]["id_tag"] )
				sector_map[current_x][current_y]["missle"]["warhead"] = "none"
				sector_map[current_x][current_y]["missle"]["id_tag"] = "none"
				sector_map[current_x][current_y]["missle"]["speed"] = 0
				sector_map[current_x][current_y]["missle"]["target"]["x"] = 0
				sector_map[current_x][current_y]["missle"]["target"]["y"] = 0
			current_x += 1
		current_x = 1
		current_y += 1


/obj/structure/shiptoship_master/proc/MasterControl()
	if(variable_storage["stored_x"] != 0) variable_storage["stored_x"] = 0
	if(variable_storage["stored_y"] != 0) variable_storage["stored_y"] = 0
	var/contacts_list = (jointext((scan_entites(category = 0, output_format = 0)), "</p><p>")+"</p><p>"+jointext((scan_entites(category = 1, output_format = 0)), "</p><p>"))
	var/terminal_html ={"<!DOCTYPE html>
	<html>
	<head>
	<style>
	body {
	background-color:black;
	}
	#main_window {
	font-family: 'Lucida Grande', monospace;
	font-size: 18px;
	color: #ffffff;
	text-align: center;
	padding: 0em 1em;
	}
	</style>
	</head>
	<body>
	<div id="main_window">
	<p style="font-size: 120%;">
	<b>SECTOR PATROL ALPHA</b><br>GM SPACE SYSTEM CONTROL PANEL<hr>
	</p>
	<p>
	Current System:<br>[GLOB.ingame_current_system]
	</p>
	<p style="font-size: 120%;"><b>ACTIVE ENTITIES:</b></p>
	<p>[contacts_list]</p>
	<hr>
	<p style="font-size: 120%;">COMMANDS</p>
	<p>
	<b><a href='?src=\ref[src];modify_entity=1'>Entity Controls</a></b>
	</p>
	<p>
	<b><a href='?src=\ref[src];add_entity=1'>Add Entity</a><nbsp>-<nbsp><a href='?src=\ref[src];rem_entity=1'>Remove Entity</a><br></b>
	</p>
	</div>
	</body>
	"}
	usr << browse(terminal_html,"window=sts_master;display=1;size=800x800;border=5px;can_close=1;can_resize=1;can_minimize=1;titlebar=1")
	onclose(usr, "sts_master")

/obj/structure/shiptoship_master/Topic(href, list/href_list)
	. = ..()
	if(.)
		return
	if(href_list["add_entity"])
		switch(tgui_input_list(usr, "What type of entity to add?", "Add Entity", list("ship","missle"), timeout = 0))
			if("ship")
				var/coordinate_x = tgui_input_number(usr, "Pick the X coordinate, max: [GLOB.sector_map_x]", "Add Entity - X Coordinate", min_value = 0, timeout = 0)
				if(coordinate_x == null) return
				if(coordinate_x > GLOB.sector_map_x) coordinate_x = GLOB.sector_map_x
				var/coordinate_y = tgui_input_number(usr, "Pick the Y coordinate, max: [GLOB.sector_map_y]", "Add Entity - Y Coordinate", min_value = 0, timeout = 0)
				if(coordinate_y == null) return
				if(coordinate_y > GLOB.sector_map_y) coordinate_y = GLOB.sector_map_y
				if(sector_map[coordinate_x][coordinate_y]["ship"]["id_tag"] != "none")
					to_chat(usr, SPAN_WARNING("An Entity exists on this coordinate already."))
					return
				var/name_to_enter = tgui_input_text(usr, "Enter ship name or otherwise identifiable nickname", "NAME Entry", timeout = 0)
				if(name_to_enter == null) name_to_enter = "Unknown"
				var/type_to_enter = tgui_input_text(usr, "Enter ship type or identifiable cahracteristics if unknown ", "TYPE Entry", timeout = 0)
				if(type_to_enter == null) type_to_enter = "Unknown"
				var/faction_to_enter = tgui_input_text(usr, "Enter ship faction", "FACTION Entry", timeout = 0)
				if(faction_to_enter == null) faction_to_enter = "UNKW"
				var/status_to_enter = tgui_input_text(usr, "Enter ship status", "STATUS Entry", timeout = 0)
				if(status_to_enter == null) status_to_enter = "Unknown"
				var/damage_to_enter = tgui_input_number(usr, "Pick Damage value","DAM Entry", default = 0,  min_value = 0, timeout = 0)
				if(damage_to_enter == null) damage_to_enter = 0
				var/shield_to_enter = tgui_input_number(usr, "Pick value of shield", "SHLD Entry", default = 0,  min_value = 0, timeout = 0)
				if(shield_to_enter == null) shield_to_enter = 0
				var/vector_x_to_enter = tgui_input_number(usr, "Pick X value of the vector", "Vector - X", default = 0,max_value = 1000 ,min_value = -1000, timeout = 0)
				if(vector_x_to_enter == null) vector_x_to_enter = 0
				var/vector_y_to_enter = tgui_input_number(usr, "Pick Y value of the vector", "Vector - X", default = 0,max_value = 1000 ,min_value = -1000, timeout = 0)
				if(vector_y_to_enter == null) vector_y_to_enter = 0
				var/speed_to_enter = tgui_input_number(usr, "Pick speed", "Speed", default = 0 ,min_value = 0, timeout = 0)
				if(speed_to_enter == null)speed_to_enter = 0
				add_entity(entity_type = 0, x = coordinate_x, y = coordinate_y, name = name_to_enter, type = type_to_enter, vector_x = vector_x_to_enter, vector_y = vector_y_to_enter, ship_status = status_to_enter, ship_faction = faction_to_enter, ship_damage = damage_to_enter, ship_shield = shield_to_enter, ship_speed = speed_to_enter)
				to_chat(usr, SPAN_INFO("Entity Added."))
				MasterControl()
				return
			if("missle")
				var/coordinate_x = tgui_input_number(usr, "Pick the X coordinate, max: [GLOB.sector_map_x]", "Add Entity - X Coordinate", min_value = 0, timeout = 0)
				if(coordinate_x == null) return
				if(coordinate_x > GLOB.sector_map_x) coordinate_x = GLOB.sector_map_x
				var/coordinate_y = tgui_input_number(usr, "Pick the Y coordinate, max: [GLOB.sector_map_y]", "Add Entity - Y Coordinate", min_value = 0, timeout = 0)
				if(coordinate_y == null) return
				if(coordinate_y > GLOB.sector_map_y) coordinate_y = GLOB.sector_map_y
				if(sector_map[coordinate_x][coordinate_y]["missle"]["id_tag"] != "none")
					to_chat(usr, SPAN_WARNING("A missle exists on this coordinate already."))
					return
				var/name_to_enter = tgui_input_number(usr, "Enter Missle Speed", "SPEED Entry", timeout = 0)
				if(name_to_enter == null) name_to_enter = "Unknown"
				var/type_to_enter = tgui_input_text(usr, "Enter warhead type", "WARHEAD Entry", timeout = 0)
				if(type_to_enter == null) type_to_enter = "Unknown"
				var/vector_x_to_enter = tgui_input_number(usr, "Pick X coord of target", "Target - X", default = 0,max_value = 1000 ,min_value = -1000, timeout = 0)
				if(vector_x_to_enter == null) vector_x_to_enter = 0
				var/vector_y_to_enter = tgui_input_number(usr, "Pick Y coord of target", "Target - Y", default = 0,max_value = 1000 ,min_value = -1000, timeout = 0)
				if(vector_y_to_enter == null) vector_y_to_enter = 0
				add_entity(entity_type = 1, x = coordinate_x, y = coordinate_y, name = name_to_enter, type = type_to_enter, vector_x = vector_x_to_enter, vector_y = vector_y_to_enter)
				to_chat(usr, SPAN_INFO("Entity Added."))
				MasterControl()
				return
	if(href_list["rem_entity"])
		switch(tgui_input_list(usr, "What type of entity to remove?", "Rem Entity", list("ship","missle"), timeout = 0))
			if("ship")
				var/id_to_remove = tgui_input_list(usr, "Which ship Entity to remove?", "Rem Ship", scan_entites(category = 0, output_format = 1), timeout = 0)
				if(id_to_remove == null) return
				rem_entity(id = id_to_remove)
				MasterControl()
				return
			if("missle")
				var/id_to_remove = tgui_input_list(usr, "Which ship Entity to remove?", "Rem Ship", scan_entites(category = 1, output_format = 1), timeout = 0)
				if(id_to_remove == null) return
				rem_entity(id = id_to_remove)
				MasterControl()
				return
	if(href_list["modify_entity"])
		switch(tgui_input_list(usr, "What type of entity to modify?", "Mod Entity", list("ship","missle"), timeout = 0))
			if("ship")
				var/modify_id = tgui_input_list(usr, "Select a Ship Entity to Edit", "Mod Entity", scan_entites(category = 0, output_format = 1), timeout = 0)
				var/modify_value = tgui_input_list(usr, "Select a Ship Entity Property to Edit", "Mod Entity", list("name","faction","id_tag","type","status","damage","shield","vector"), timeout = 0)
				mod_entity(entity_type = "ship", entity_tag = modify_id, entity_property = modify_value)
				return
	switch(href_list["ship_control"])
		if("y_plus")
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["y"] >= sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["speed"])
				to_chat(usr,SPAN_WARNING("Error: Maxium velocity reached. Safeguards in place. Acceleration denied."))
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] == 0) sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] = 1
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] > 0)
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["y"] += 1
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] -= 1
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
		if("y_minus")
			var/reversed_max = 0 - sector_map["stored_x"]["stored_y"]["ship"]["vector"]["speed"]
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["y"] <= reversed_max)
				to_chat(usr,SPAN_WARNING("Error: Maxium velocity reached. Safeguards in place. Acceleration denied."))
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] == 0) sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] = 1
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] > 0)
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["y"] -= 1
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] -= 1
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
		if("x_plus")
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["x"] == sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["speed"])
				to_chat(usr,SPAN_WARNING("Error: Maxium velocity reached. Safeguards in place. Acceleration denied."))
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] == 0) sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] = 1
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] > 0)
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["x"] += 1
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] -= 1
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
		if("x_minus")
			var/reversed_max = 0 - sector_map["stored_x"]["stored_y"]["ship"]["vector"]["speed"]
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["x"] <= reversed_max)
				to_chat(usr,SPAN_WARNING("Error: Maxium velocity reached. Safeguards in place. Acceleration denied."))
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] == 0) sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["has_moved"] = 1
			if(sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] > 0)
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["vector"]["x"] -= 1
				sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["system"]["movement_left"] -= 1
				open_movement_console(x = variable_storage["stored_x"], y = variable_storage["stored_y"])
				return
		if("close")
			usr << browse(null,"window=[sector_map[variable_storage["stored_x"]][variable_storage["stored_y"]]["ship"]["id_tag"]]-control;display=1;size=300x300;border=5px;can_close=0;can_resize=0;can_minimize=0;titlebar=0")
			MasterControl()
			return
