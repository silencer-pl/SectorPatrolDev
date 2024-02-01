/area/hanako
	icon = 'icons/turf/areas_event.dmi'
	name = "Hanako's Hideaway"
	//ambience = list('sound/ambience/shipambience.ogg')
	icon_state = "event_nopower"
	ceiling = CEILING_METAL
	powernet_name = "hanako"
	requires_power = TRUE
	unlimited_power = FALSE
	sound_environment = SOUND_ENVIRONMENT_ROOM
	soundscape_interval = 30
	//soundscape_playlist = list('sound/effects/xylophone1.ogg', 'sound/effects/xylophone2.ogg', 'sound/effects/xylophone3.ogg')
	ambience_exterior = AMBIENCE_ALMAYER
	ceiling_muffle = FALSE

area/hanako/ooc
	name = "Hideaway - OOC and login area"
	icon_state = "undercas_nopower"
	//always powered
	requires_power = FALSE
	unlimited_power = TRUE
	base_lighting_alpha = 255

area/hanako/main
	name = "Hideaway - Main Area"
	icon_state = "metal_nopower"

area/hanako/bubble
	name = "Hideaway - bubble level"
	icon_state = "deep_nopower"
