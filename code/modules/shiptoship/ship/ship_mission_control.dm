/obj/structure/shiptoship_master/ship_missioncontrol
	name = "Why yes, another master item"
	desc = "This definition contains critical code. Look for map specific instances down the line :p"
	var/list/sector_map_data = list(
		"name" = "none",
		"initialized" = 0,
		"x" = 0,
		"y" = 0,
		)
	var/list/tracking_list
	var/tracking_max = 3
	var/list/local_round_log = list()
	var/list/ping_history = list()
	var/list/comms_messages = list()

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

/obj/structure/shiptoship_master/ship_missioncontrol/proc/GetTrackingList()
	var/list/tracking_list_to_return = list()
	var/current_tracking_position = 1
	while (current_tracking_position <= tracking_max)
		if(tracking_list[current_tracking_position]["id_tag"] == "none") break
		tracking_list_to_return.Add("<b>[sector_map[tracking_list[current_tracking_position]["x"]][tracking_list[current_tracking_position]["y"]][tracking_list[current_tracking_position]["type"]]["type"]]</b> - <b>([tracking_list[current_tracking_position]["x"]],[tracking_list[current_tracking_position]["y"]])")
		current_tracking_position += 1
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
	var/tracking_to_display = jointext(GetTrackingList(), "</p><p>")
	var/pings_to_display
	var/messages_to_display
	var/status_to_display = jointext(GetStatusReadout(), "</p><p>")
	if(ping_history.len == 0) pings_to_display = "No ping history."
	if(ping_history.len <= 5 && ping_history.len != 0) pings_to_display = jointext(ping_history, "<br>")
	if(ping_history.len > 5) pings_to_display = jointext(ping_history.Copy((ping_history.len - 5)), "<br>")
	if(local_round_log.len != 0) sensor_to_display = jointext(local_round_log, "<br>")
	if(!sensor_to_display) sensor_to_display = "No updates."
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
			<b>COMMAND OVERVIEW:<hr></b>
			</p>
			<p><b>Communications Log:</b></p>
			<p>[messages_to_display]<hr></p>
			<p><b>Sensor Reports:</b></p>
			<p>[sensor_to_display]<hr></p>
			<p><b>Tracking Updates:</b></p>
			<p>[tracking_to_display]<hr></p>
			<p><b>Recent Scanner Pings:</b></p>
			<p>[pings_to_display]<hr></p>
			<p><b>SHIP STATUS:</b></p>
			<p>[status_to_display]</b></p>
			</div>
			</body>
			"}
	usr << browse(display_html,"window=ship_display_[sector_map_data["name"]];display=1;size=800x800;border=5px;can_close=1;can_resize=1;can_minimize=1;titlebar=1")
	onclose(usr, "sts_master")
