/obj/structure/shiptoship_master/ship_missioncontrol
	name = "Why yes, another master item"
	desc = "This definition contains critical code. Look for map specific instances down the line :p"
	var/list/sector_map_data = list(
		"name" = "none",
		"initialized" = 0,
		"x" = 0,
		"y" = 0,
		)
	var/list/linked_consoles = list("signals" = null,)
	var/list/tracking_list
	var/tracking_max = 3
	var/list/local_round_log = list()
	var/list/local_round_log_moves = list()
	var/list/ping_history = list()
	var/list/comms_messages = list()

/obj/structure/shiptoship_master/ship_missioncontrol/proc/SectorConversion(x = 0, y = 0) // Converts coords to map sector. If coordinates do not line up, even sectors should get the extra row.
	var/x_to_sectorconvert = x
	var/y_to_sectorconvert = y
	if(x_to_sectorconvert < 1 || x_to_sectorconvert > GLOB.sector_map_x || y_to_sectorconvert < 1 || y_to_sectorconvert > GLOB.sector_map_y) return "out_of_bounds"
	var/sector_to_return_x = floor(x_to_sectorconvert / (floor(GLOB.sector_map_x / GLOB.sector_map_sector_size)))
	var/sector_to_return_y = floor(y_to_sectorconvert / (floor(GLOB.sector_map_y / GLOB.sector_map_sector_size)))
	var/value_to_return = "[sector_to_return_x]-[sector_to_return_y]"
	return value_to_return

/obj/structure/shiptoship_master/ship_missioncontrol/proc/WriteToShipLog(shiplog_event = null, shiplog_dest_x = null, shiplog_dest_y = null)
	var/event_to_add_ship = shiplog_event
	var/shiplog_coordinate_x = shiplog_dest_x
	var/shiplog_coordinate_y = shiplog_dest_y
	switch(event_to_add_ship)
		if("collision_move")
			local_round_log.Add("Ship engine pattern changes suggest a <b>near-collision in Sector [SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>")
			return
		if("collision_boundary")
			local_round_log.Add("<b>Emergency maneuvers and rapid engine deceleration<b> detected on Twilight Boundary of Sector [SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)].")
			return
		if("regular_move")
			local_round_log.Add("Engine noise related to <b>ship movement detected in Sector [SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>.")
			if(local_round_log_moves.Find("<b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>") == 0) local_round_log_moves.Add("<b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>")
			return
		if("missle_collision")
			local_round_log.Add("Detonation detected after mulitple Projectile movement traces in Sector [SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]")
			return
		if("missle_move","warhead_miss","warhead_homing")
			local_round_log.Add("Projectile leapfrog trace in Sector <b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>.")
			if(local_round_log_moves.Find("<b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>") == 0) local_round_log_moves.Add("<b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>")
			return
		if("warhead_hit", "explosive_splash")
			local_round_log.Add("Warhead explosion detected in Sector <b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>")
			if(local_round_log_moves.Find("<b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>") == 0) local_round_log_moves.Add("<b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>")
			return
		if("hit_shield")
			local_round_log.Add("Deflector <b>shield impact</b> detected.")
			return
		if("shield_break")
			local_round_log.Add("Defletor <b>shield collapse</b> detected.")
			return
		if("destroy_complete")
			local_round_log.Add("Multiple explosions and ship fragmentation detected. High likelihood of a complete loss event.")
			return
		if("destroy_engine")
			local_round_log.Add("Twilight Paradox Engine Collapse detected. Escape pod launches detected.")
			return
		if("destroy_systems")
			local_round_log.Add("Rapid, repeated explosions followed by escape pod activation detected. On-board system failre likely.")
			return
		if("destroy_weapons")
			local_round_log.Add("Wepon bay detonation detected. High casuality event expected.")
			return
		if("destroy_hull")
			local_round_log.Add("Cascading hull breach detected. Partial ship fragmentation and high casualty event expected.")
			return
		if("nuclear_hit")
			local_round_log.Add("<b>WARNING:</b> Nuclear detonation detected in Sector <b>[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]</b>!")
			if(local_round_log_moves.Find("[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]") == 0) local_round_log_moves.Add("[SectorConversion(shiplog_coordinate_x,shiplog_coordinate_y)]")
			return

/obj/structure/shiptoship_master/ship_missioncontrol/Initialize(mapload, ...)
	. = ..()
	if(tracking_max > 0)
		tracking_list = new/list(tracking_max)
		var/current_row = 1
		while (current_row <= tracking_max)
			tracking_list[current_row] = list(
			"x" = 0,
			"y" = 0,
			"id_tag" = "none",
			"type" = "none",
			)
			current_row += 1


/obj/structure/shiptoship_master/ship_missioncontrol/proc/FindShipOnMap() // Should only be called after setting up the sector map and putting a ship with a corssesponding ["name"] segment set to match
	var/current_x = 1
	var/current_y = 1
	to_chat(world, SPAN_INFO("Initializing ship [sector_map_data["name"]]!"))
	if(linked_consoles["signals"] == null)
		for(var/obj/structure/terminal/signals_console/console in get_area(src))
			linked_consoles["signals"] = console
			console.LinkToShipMaster(master_console = src)
			var/turf/turf_return = get_turf(console)
			to_chat(world, SPAN_INFO("Singals Console Linked at [turf_return.x],[turf_return.y]"))
	while(current_x <= GLOB.sector_map_x)
		while(current_y <= GLOB.sector_map_y)
			if(sector_map[current_x][current_y]["ship"]["name"] == sector_map_data["name"])
				sector_map_data["x"] = current_x
				sector_map_data["y"] = current_y
				to_chat(world, SPAN_INFO("Ship [sector_map_data["name"]] Initalized on the Sector Map."))
			if(sector_map_data["x"] != 0 && sector_map_data["y"] != 0) break
			current_y += 1
		if(sector_map_data["x"] != 0 && sector_map_data["y"] != 0) break
		current_y = 1
		current_x += 1
	if(sector_map_data["x"] != 0 && sector_map_data["y" != 0]) return 1

/obj/structure/shiptoship_master/ship_missioncontrol/proc/GetTrackingList(type = 0)
	var/list/tracking_list_to_return = list()
	var/current_tracking_position = 1
	while (current_tracking_position <= tracking_max)
		if(tracking_list[current_tracking_position]["id_tag"] == "none") break
		tracking_list_to_return.Add("<b>[sector_map[tracking_list[current_tracking_position]["x"]][tracking_list[current_tracking_position]["y"]][tracking_list[current_tracking_position]["type"]]["type"]]</b> - <b>([tracking_list[current_tracking_position]["x"]],[tracking_list[current_tracking_position]["y"]])")
		current_tracking_position += 1
	if(type == 1) return (current_tracking_position - 1)
	if(tracking_list_to_return.len == 0) tracking_list_to_return.Add("No tracking active.")
	return tracking_list_to_return

/obj/structure/shiptoship_master/ship_missioncontrol/proc/GetStatusReadout()
	var/list/status_list_to_return = list()
	status_list_to_return.Add("<b>HULL INTEGRITY: [(sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["HP"]) - (sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["engine"] + sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["systems"] + sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["weapons"] + sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["hull"])]</b> <b>SHIELDS: [sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["shield"]]</b>")
	status_list_to_return.Add("<b> Damage Readout:</b>","Engines: [sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["engine"]]","Systems: [sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["systems"]]","Weapons: [sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["weapons"]]","Hull: [sector_map[sector_map_data["x"]][sector_map_data["y"]]["ship"]["damage"]["hull"]]")
	return status_list_to_return

/obj/structure/shiptoship_master/ship_missioncontrol/proc/OpenMissionControl(screen_type = "general")
	var/display_html
	var/sensor_to_display
	var/detailed_sonar_to_display
	var/tracking_to_display = jointext(GetTrackingList(), "</p><p>")
	var/pings_to_display
	var/messages_to_display
	var/status_to_display = jointext(GetStatusReadout(), "</p><p>")
	if(ping_history.len == 0) pings_to_display = "No ping history."
	if(ping_history.len <= 5 && ping_history.len != 0) pings_to_display = jointext(ping_history, "<br>")
	if(ping_history.len > 5) pings_to_display = jointext(ping_history.Copy((ping_history.len - 5)), "<br>")
	if(local_round_log_moves.len != 0) sensor_to_display = jointext(local_round_log_moves, " | ")
	if(!sensor_to_display) sensor_to_display = "No updates."
	if(local_round_log.len != 0) detailed_sonar_to_display = jointext(local_round_log, "</p></p>- ")

	if(comms_messages.len == 0) messages_to_display = "No messages to dispplay."
	if(comms_messages.len <= 5 && comms_messages.len != 0) messages_to_display = jointext(comms_messages, "<br>")
	if(comms_messages.len > 5) messages_to_display = jointext(comms_messages.Copy((comms_messages.len - 5)), "<br>")
	switch(screen_type)
		if("general")
			display_html = {"<!DOCTYPE html>
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
			<b>UACM 2ND LOGISTICS<br>[sector_map_data["name"]]<hr></b>
			</p>
			<p>
			<b>COMMAND OVERVIEW:<br><br>Detailed logs are accessible through Mission Control terminal.<hr></b>
			</p>
			<p><b>Ship position:</b> Sector [SectorConversion(x = sector_map_data["x"], y = sector_map_data["y"])]</p>
			<p><b>Communications Log:</b></p>
			<p>[messages_to_display]</p>
			<p><b>Sonar Activity in following Sectors:</b></p>
			<p>[sensor_to_display]</p>
			<p><b>Tracking Updates:</b></p>
			<p>[tracking_to_display]</p>
			<p><b>Active Probe Pings:</b></p>
			<p>[pings_to_display]</p>
			<p><b>SHIP STATUS:</b></p>
			<p>[status_to_display]</b></p>
			</div>
			</body>
			"}
		if("sonar")
			display_html = {"<!DOCTYPE html>
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
			<b>UACM 2ND LOGISTICS<br>[sector_map_data["name"]]<hr></b>
			</p>
			<p>
			<b>DETAILED SONAR LOG:</b>
			</p>
			<p>
			- [detailed_sonar_to_display]
			</p>
			"}
	usr << browse(display_html,"window=ship_[screen_type]_[sector_map_data["name"]];display=1;size=800x800;border=5px;can_close=1;can_resize=1;can_minimize=1;titlebar=1")
	onclose(usr, "ship_[screen_type]_[sector_map_data["name"]]")
