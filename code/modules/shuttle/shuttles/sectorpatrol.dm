/obj/docking_port/stationary/emergency_response/pst_start
	name = "Deep Space, Outer Veil PST approach."
	dir = NORTH
	id = "ovpst_starter"
	roundstart_template = /datum/map_template/shuttle/l533
	width = 27
	height = 9

/obj/docking_port/stationary/emergency_response/external/pst_dock31
	name = "Outer Veil PST, Dock 31"
	dir = NORTH
	id = "ovpst_d31"
	width = 27
	height = 9

/obj/docking_port/mobile/emergency_response/l533
	name = "Shuttle L-533"
	id = "uacm_ovpst_transit_L-533"
	preferred_direction = EAST
	port_direction = EAST
	width = 27
	height = 9
	var/port_door
	var/starboard_door

/obj/docking_port/mobile/emergency_response/l533/Initialize(mapload)
	. = ..()
	external_doors = list()
	for(var/place in shuttle_areas)
		for(var/obj/structure/machinery/door/air in place)
			if(air.id == "starboard_door")
				starboard_door = air
				external_doors += list(air)
				air.breakable = FALSE
				air.indestructible = TRUE
				air.unacidable = TRUE
			else if(air.id == "port_door")
				port_door = air
				external_doors += list(air)
				air.breakable = FALSE
				air.indestructible = TRUE
				air.unacidable = TRUE
	if(!port_door)
		WARNING("No port door found for [src]")
	if(!starboard_door)
		WARNING("No starboard door found for [src]")

/datum/map_template/shuttle/l533
	name = "Shuttle L-533"
	shuttle_id = "uacm_ovpst_transit_L-533"

/area/shuttle/l533
	name = "Shuttle L-533"
