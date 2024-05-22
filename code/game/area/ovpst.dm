/area/ovpst
	name = "The Outer Veil Primary Supply Terminal - Interiors"
	icon = 'icons/turf/area_almayer.dmi'
	// ambience = list('sound/ambience/shipambience.ogg')
	icon_state = "almayer"
	ceiling = CEILING_METAL
	powernet_name = "ovpst"
	sound_environment = SOUND_ENVIRONMENT_ROOM
	soundscape_interval = 30
	// soundscape_playlist = list('sound/effects/xylophone1.ogg', 'sound/effects/xylophone2.ogg', 'sound/effects/xylophone3.ogg')
	ambience_exterior = AMBIENCE_ALMAYER
	ceiling_muffle = FALSE
	requires_power = FALSE
	unlimited_power = TRUE

/area/ovpst/airlock
	icon_state = "portatmos"

/area/ovpst/airlock/d31

/area/ovpst/airlock/ele_e_d31

/area/ovpst/airlock/ele_e_pin

/area/ovpst/airlock/ele_d_drm

/area/ovpst/airlock/ele_d_pin

// Persistant sotrage areas

/area/ovpst/Write()
	var/savefile/S = new("data/persistance/turf_ovpst.sav")
	var/tile_xyz
	for(var/turf/open/floor/plating/modular/T in GLOB.turfs_saved)
		tile_xyz = "[T.x]-[T.y]-[T.z]"
		if(S.dir.Find("[tile_xyz]") == FALSE) S.dir.Add("[tile_xyz]")
		S.cd = "[tile_xyz]"
		S["tile_top_left"] << T.tile_top_left
		S["tile_top_riht"] << T.tile_top_rght
		S["tile_bot_left"] << T.tile_bot_left
		S["tile_bot_riht"] << T.tile_bot_rght
		S["tile_seal"] << T.tile_seal

/area/ovpst/Read()
	var/savefile/S = new("data/persistance/turf_ovpst.sav")
	var/tile_xyz
	for(var/turf/open/floor/plating/modular/T in GLOB.turfs_saved)
		tile_xyz = "[T.x]-[T.y]-[T.z]"
		if(S.dir.Find("[tile_xyz]") == FALSE) return
		S.cd = "[tile_xyz]"
		S["tile_top_left"] >> T.tile_top_left
		S["tile_top_riht"] >> T.tile_top_rght
		S["tile_bot_left"] >> T.tile_bot_left
		S["tile_bot_riht"] >> T.tile_bot_rght
		S["tile_seal"] >> T.tile_seal


/area/ovpst/persist
	name = "Persistant save area master define"
	desc = "This should not be used in game - use or create specific paths for each savable room/area"
	desc_lore = "Its also acceptable to use this for testing, but do not leave it in game"
