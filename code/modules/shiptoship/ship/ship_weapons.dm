/obj/structure/ship_elements/primary_cannon
	name = "\improper PST Type-A Prototype Cannon"
	desc = "A complex piece of heavy machinery without any clear indications how to use it, only warning labels. Complete with a tray that extends from the cannon itself."
	icon = 'icons/sectorpatrol/ship/cannons96.dmi'
	desc_lore = "In PST technical jargon, Weapon System Type A essentially stands for\"Primary\" or \"Missile\" based weapon system. This system encodes regular information passed to it from user terminals and converts it to a format understandable by the PSTs Mission Control system. The system's primary unique feature is when the missile has the right navigational data, it will always strike its target even if it moves or changes its vector."
	icon_state = "primary_unloaded"
	density = TRUE
	anchored = TRUE
	layer = LADDER_LAYER
	bound_width = 128
	bound_height = 64
	bound_y = 64
	unslashable = TRUE
	unacidable = TRUE
	var/weapon_fired = 0
	var/list/loaded_projectile = list("missile" = "none",
		"warhead" = "none",
		"speed" = 0,
		"payload" = 0,
		"loaded" = 0,
		)

/obj/structure/ship_elements/missile_ammo
	name = "missile ammo master item"
	desc = "Haha nope. Should not be in game either :P"
	icon = 'icons/sectorpatrol/ship/weapon_ammo.dmi'
	icon_state = "default"
	var/missile_type
	var/warhead_type

/obj/structure/ship_elements/missile_ammo/update_icon()
	if(missile_type) icon_state = missile_type
	if(warhead_type) icon_state = warhead_type
	if(warhead_type && missile_type) icon_state = initial(icon_state)
	. = ..()



/obj/structure/ship_elements/primary_cannon/update_icon(loading = 0)
	overlays.Cut()
	if(loading == 0)
		if(loaded_projectile["loaded"] == 0)
			overlays += image("primary_unloaded")
			if(loaded_projectile["missile"] != "none")
				overlays += image("tray_missile_[loaded_projectile["missile"]]")
			if(loaded_projectile["warhead"] != "none")
				overlays += image("tray_warhead_[loaded_projectile["warhead"]]")
			return
		if(loaded_projectile["loaded"] == 1)
			overlays += image("primary_loaded")
			return
	if(loading == 1)
		if(icon_state == "primary_unloaded")
			overlays += image("primary_load")
			icon_state = "primary_load"
			return
		if(icon_state == "primary_load")
			overlays += image("primary_loaded")
			icon_state = "primary_loaded"
			return
		if(icon_state == "primary_loaded")
			overlays += image("primary_fire")
			icon_state = "primary_fire"
			return
		if(icon_state == "primary_fire")
			overlays += image("primary_unloaded")
			icon_state = "primary_unloaded"
			return


/obj/structure/ship_elements/primary_cannon/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/powerloader_clamp))
		var/obj/item/powerloader_clamp/PC = I
		if(!PC.linked_powerloader)
			qdel(PC)
			return
		if(PC.loaded)
			if(!istype(PC.loaded, /obj/structure/ship_elements/missile_ammo))
				to_chat(user, SPAN_WARNING("There is no way you can put \the [PC.loaded] into \the [src]!"))
				return

			var/obj/structure/ship_elements/missile_ammo/AmmoToInsert = PC.loaded
			if(AmmoToInsert.missile_type != null)
				if(loaded_projectile["missile"] != "none")
					to_chat(user, SPAN_WARNING("\The [src] already has a missile loaded."))
					return
				if(loaded_projectile["missile"] == "none")
					to_chat(user, SPAN_NOTICE("You load \the [AmmoToInsert] into \the [src]."))
					loaded_projectile["missile"] = AmmoToInsert.missile_type
					qdel(AmmoToInsert)
			else
				if(AmmoToInsert.warhead_type != null)
					if(loaded_projectile["warhead"] != "none")
						to_chat(user, SPAN_WARNING("\The [src] already has a warhead loaded."))
						return
					if(loaded_projectile["warhead"] == "none")
						to_chat(user, SPAN_NOTICE("You load \the [AmmoToInsert] into \the [src]."))
						loaded_projectile["warhead"] = AmmoToInsert.missile_type
						qdel(AmmoToInsert)
			playsound(src, 'sound/machines/hydraulics_1.ogg', 40, 1)
			PC.loaded = null
			update_icon()
			PC.update_icon()
		else
			if(loaded_projectile["missile"] != "none")
				var/obj/structure/ship_elements/missile_ammo/AmmoToGrab = new (src)
				AmmoToGrab.missile_type = loaded_projectile["missile"]
				AmmoToGrab.update_icon()
				loaded_projectile["missile"] = "none"
				PC.grab_object(user, AmmoToGrab, "big_crate", 'sound/machines/hydraulics_2.ogg')
			else if(loaded_projectile["warhead"] != "none")
				var/obj/structure/ship_elements/missile_ammo/AmmoToGrab = new (src)
				AmmoToGrab.warhead_type = loaded_projectile["warhead"]
				AmmoToGrab.update_icon()
				loaded_projectile["warhead"] = "none"
				PC.grab_object(user, AmmoToGrab, "big_crate", 'sound/machines/hydraulics_2.ogg')
			update_icon()
			return
	else
		. = ..()
