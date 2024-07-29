/obj/structure/terminal/signals_console
	name = "signals console"
	item_serial = "-SIG-CNS"
	desc = "A terminal labeled 'Signals Control', looks almost like a regular computer terminal, however if you take a closer look a blue and pink shimmer seems to be visible inside the machine itself."
	desc_lore = "The current iteration of OV-PST made 'purpose' terminals, a term used to identify computer systems meant for specific purposes, comes with the same limitation as most other LD based system - once an OS is installed, it becomes very hard to modify it and major updates to its software typically mean replacing the whole terminal. </p><p> Since all the PST technology is effectively advanced prototypes, and taking the above into account, the terminals currently focus on modularity and ease of replacement not visual attractiveness or functionality and as such resemble the rather flimsy terminals used in current generation spaceships. Their potential, however, at least in theory, is supposed to be infinitely times greater."
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
	icon_state = "open_ok"
	terminal_reserved_lines = 1
	terminal_id = "_signals_control"
	var/obj/structure/shiptoship_master/ship_missioncontrol/linked_master_console
	var/probe_range = 3

/obj/structure/terminal/signals_console/proc/LinkToShipMaster(master_console as obj)

	linked_master_console = master_console
	terminal_id = "[linked_master_console.sector_map_data["name"]][initial(terminal_id)]"
	item_serial = "[uppertext(linked_master_console.sector_map_data["name"])][initial(item_serial)]"
	terminal_header += "<center><b>"+ html_encode("[linked_master_console.sector_map_data["name"]] - SIGNALS CONTROL") + "</b><br>" + html_encode("UACM 2ND LOGISTICS") + "</center><hr>"
	reset_buffer()

/obj/structure/terminal/signals_console/proc/terminal_advanced_parse(type = null, string = null)
	if(type == null || string == null) return
	switch(type)
		if("HELP")
			switch(string)
				if("PING")
					terminal_display_line("PING")
					terminal_display_line("Usage: PING <NUMBER>,<NUMBER> - Launches an EYE-7 pinging probe with the set vector.")
					terminal_display_line("EYE-7 Probes immediately provide a scan with exact coordinates of all entities within a 3x3 area of their target. Probes need to be reloaded in the LEFT Gunnery Room.")
				if("TRACK")
					terminal_display_line("TRACK")
					terminal_display_line("Usage: TRACK B <NUMBER> OR TRACK <NUMBER>,<NUMBER> - Handles the crafts LD tracking algorythms.")
					terminal_display_line("If given coordinates, targeted entity will be tracked using its LD presence. Tracking results are fed to the Command Overview. Bigger entities in the same grid will be targeted first.")
					terminal_display_line("If used with B and a number, breaks specified link. ID number is fed to Command Overview or reported during establishing link.")
				if("COMM")
					terminal_display_line("COMM")
					terminal_display_line("Usage: COMM <NUMBER>,<NUMBER> TEXT Attempts to establish two way link using LD comm protocols to an entity in the indicated grid.")
					terminal_display_line("While this link is unlikely to be exploited, the recepient is not compelled to answer or maintain comms.")
				else
					terminal_display_line("Error: HELP: [string] command not found. Use HELP with no arguments for a list of commands.")
		if("PING")
			var/commapos = findtext(string, ",")
			if(commapos != 0)
				commapos += 1
				var/x_to_scan = text2num(copytext(string, 1, commapos))
				var/y_to_scan = text2num(copytext(string, commapos))
				if(x_to_scan != null & y_to_scan != null)
					linked_master_console.ScannerPing(src, probe_target_x = x_to_scan, probe_target_y = y_to_scan, range = probe_range)
				if(x_to_scan == null) terminal_display_line("Error: Invalid x vector.")
				if(y_to_scan == null) terminal_display_line("Error: Invalid y vector.")
			if(commapos == 0) terminal_display_line("Error: Missing comma separator.")

/obj/structure/terminal/signals_console/terminal_parse(str)
	var/string_to_parse = uppertext(str)
	if(!string_to_parse) return "error - null string parsed"
	var/starting_buffer_length = terminal_buffer.len
	switch(string_to_parse)
		if("HELP")
			terminal_display_line("Available Commands:")
			terminal_display_line("PING - Launches an EYE-7 pinging probe with the set vector.")
			terminal_display_line("TRACK - Handles the crafts LD tracking algorythms.")
			terminal_display_line("COMM - Attempts to establish two way link using LD comm protocols.")
			terminal_display_line("Use HELP and a command type for more information.")
		if("PING")
			terminal_advanced_parse(type = "HELP", string = string_to_parse)
		if("COMM")
			terminal_advanced_parse(type = "HELP", string = string_to_parse)
		if("TRACK")
			terminal_display_line("Active Trackers: [linked_master_console.GetTrackingList(type = 1)]")
			terminal_advanced_parse(type = "HELP", string = string_to_parse)
	if(starting_buffer_length == terminal_buffer.len)
		var/tracked_position = 1
		while(tracked_position <= length(string_to_parse))
			var/type_to_parse = copytext(string_to_parse, 1, tracked_position + 1)
			var/argument_to_parse = trimtext(copytext(string_to_parse, tracked_position + 1))
			terminal_advanced_parse(type = type_to_parse, string = argument_to_parse)
			tracked_position += 1
	if(starting_buffer_length == terminal_buffer.len) terminal_display_line("Error: Unknown command. Please use HELP for a list of available commands.")
	terminal_input()
	return "Parsing Loop End"

/obj/structure/terminal/signals_console/attack_hand(mob/user)
	terminal_display_line("Welcome, [usr.name].")
	terminal_display()
	terminal_display_line("Active Trackers: [linked_master_console.GetTrackingList(type = 1)]")
	terminal_input()
	return "Primary input loop end"
