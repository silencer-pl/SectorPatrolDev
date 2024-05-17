//This is also the master object for all modular turfs.

/turf/open/floor/plating/modular

	name = "NRPS compliant modular floor plating"
	desc = "Metal plates attached to the hull, with small, predrilled holes doting their surface."
	desc_lore = "This special plating is typically permanently installed on ship hull floors meant for private or recreational locations. They come with small holes predrilled in preset, standardized distances that allow for the installation of modular tile struts, which in turn are used with the UACM standardized tiling system to add some color to private quarters of UACM personnel. The tiles themselves are printed in the PST's fabrication wings at minimal material cost. The drawback here is the amount of manual labor required to put these together and the fact that, some Marines argue at least, the UACM lacks any sense of style. Most agree that the jury is still out on that last one."
	icon = 'icons/turf/modular_nrps.dmi'
	icon_state = "plating"
	intact_tile = FALSE
	tool_flags = NO_FLAGS
	mouse_opacity = TRUE
	var/tile_top_left // Determine clors of individual tiles and the sealant. For these use only color names, rest of the icon name is appended. See either finished tile definitons or the DMI for avaialble options.
	var/tile_bot_left
	var/tile_top_rght
	var/tile_bot_rght
	var/tile_seal

/turf/open/floor/plating/modular/proc/check_tile(str)
	var/tiletocheck = str
	switch(tiletocheck)
		if(INTENT_HELP)
			if(tile_top_left == null)
				return TRUE
			else
				return FALSE
		if(INTENT_DISARM)
			if(tile_top_rght == null)
				return TRUE
			else
				return FALSE
		if(INTENT_HARM)
			if(tile_bot_left == null)
				return TRUE
			else
				return FALSE
		if(INTENT_GRAB)
			if(tile_bot_rght == null)
				return TRUE
			else
				return FALSE


/turf/open/floor/plating/modular/proc/set_tile(str)
	var/clr = str
	to_chat(usr, SPAN_NOTICE("You start attaching a tile to the floor."))
	if(do_after(usr, 20, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		playsound(src, 'sound/effects/thud.ogg', 30)
		usr.visible_message(SPAN_NOTICE("[usr] sets a floor tile with a satisfying click."), SPAN_NOTICE("You set a floor tile with a satisfying click."), SPAN_WARNING("You hear a quiet click."))
		switch(usr.a_intent)
			if(INTENT_HELP)
				tile_top_left = clr
			if(INTENT_DISARM)
				tile_top_rght = clr
			if(INTENT_HARM)
				tile_bot_left = clr
			if(INTENT_GRAB)
				tile_bot_rght = clr
		update_icon()

/turf/open/floor/plating/modular/proc/rem_tile()
	to_chat(usr, SPAN_NOTICE("You start detaching a tile from the floor."))
	if(do_after(usr, 20, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		playsound(src, 'sound/effects/thud.ogg', 30)
		usr.visible_message(SPAN_NOTICE("[usr] detaches a tile from the floor."), SPAN_NOTICE("You detach a tile form the floor."), SPAN_WARNING("You hear a quiet click."))
		var/obj/item/stack/modulartiles/tiles = new(get_turf(usr))
		tiles.amount = 1
		switch (usr.a_intent)
			if(INTENT_HELP)
				tiles.tiles_color = tile_top_left
				tile_top_left = null
			if(INTENT_DISARM)
				tiles.tiles_color = tile_top_rght
				tile_top_rght = null
			if(INTENT_HARM)
				tiles.tiles_color = tile_bot_left
				tile_bot_left = null
			if(INTENT_GRAB)
				tiles.tiles_color = tile_bot_rght
				tile_bot_rght = null
		tiles.update_icon()
		update_icon()
		usr.put_in_inactive_hand(tiles)

/turf/open/floor/plating/modular/attack_hand(mob/user)
	if (tile_seal != null) return
	if(check_tile(usr.a_intent) == TRUE)
		to_chat(usr,SPAN_NOTICE("There is no tile to pick up in this slot. Please make sure you are using the right intent."))
		return
	else
		rem_tile()

/turf/open/floor/plating/modular/attackby(obj/item/C, mob/user)
	if (!(istype (C, /obj/item/stack/modulartiles) || istype(C, /obj/item/modular/sealant) ||HAS_TRAIT(C, TRAIT_TOOL_SCREWDRIVER)))
		to_chat(usr, SPAN_NOTICE("These two things don't seem to go together."))
		return
	if(istype(C, /obj/item/modular/sealant))
		var/obj/item/modular/sealant/sealant = C
		if(tile_bot_left == null || tile_bot_rght == null || tile_top_left == null || tile_top_rght == null)
			to_chat(usr, SPAN_NOTICE("The sealant will not work properly unless all four tiles are installed."))
			return
		if(tile_bot_left != null || tile_bot_rght != null || tile_top_left != null || tile_top_rght != null) //Excessive, but making sure all 4 are present
			usr.visible_message(SPAN_NOTICE("[usr] starts applying sealant to the [src]"), SPAN_NOTICE("You start applying sealant to the [src]"))
			playsound(src, 'sound/effects/squelch1.ogg', 30)
			if(do_after(usr, 20, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				tile_seal = sealant.sealant_color
				update_icon()
				return
			to_chat(usr, SPAN_WARNING("You moved away."))
	if(istype(C, /obj/item/stack/modulartiles))
		if(tile_seal != null)
			to_chat(usr, SPAN_NOTICE("The tiles have been locked in place by a hardened sealant. You will need to scrape it away with a screwdriver, used in GRAB mode, before you can alter the tiling in any way."))
			return
		if (check_tile(usr.a_intent) == FALSE)
			to_chat(usr, SPAN_NOTICE("A tile is already in that spot. You can remove it by clicking on it with an active empty hand."))
			return
		var/obj/item/stack/modulartiles/tile = C
		if (tile.amount < 1)
			to_chat(usr, SPAN_WARNING("Somehow, you are holding less than one tile. This really shount't be happening."))
			return
		if (tile.amount >= 1)
			set_tile(tile.tiles_color)
			tile.use(1)
			return
	if(HAS_TRAIT(C, TRAIT_TOOL_SCREWDRIVER))
		if(tile_seal == null)
			to_chat(usr, SPAN_NOTICE("There is no sealant applied to the tiles, so there is no need for that."))
			return
		if(usr.a_intent == INTENT_GRAB)
			if(tile_seal != null)
				usr.visible_message(SPAN_NOTICE("[user] starts to scrape tile sealant from the [src]"), SPAN_NOTICE("You start to scrape tile sealant from the [src]"), SPAN_WARNING("You hear metalic scraping."))
				playsound(src, 'sound/items/Screwdriver.ogg', 30)
				if(do_after(usr, 40, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					tile_seal = null
					update_icon()
					return
				else
					to_chat(usr, SPAN_WARNING("You moved away from the plating."))
					return
		else
			to_chat(usr, SPAN_WARNING("That does not seem to work. If you are trying to scrape off the tile sealent, please remember to use GRAB intent."))
			return

/turf/open/floor/plating/modular/break_tile_to_plating()
	if (!broken)
		tile_top_left = null
		tile_bot_left = null
		tile_top_rght = null
		tile_bot_rght = null
		tile_seal = null
		icon_state = "platingdmg[pick(1, 3)]"
		name = "heavilly damaged [initial(name)]"
		desc = "[initial(desc)] ]It's heavily damaged and in need of repairs. The attached struts are mangled beyond repair."
		desc_lore = "[initial(desc_lore)] Physical damage on plating like this is best removed using a welder. Modular struts that attach tiles to the ground are not particularly explosion resistant, so they get damaged easily, requiring complete replacements. This fact is not seen as a flow by the Northern Republic that maintains the standard, as they argue explosions should not be an occurrence in areas where these tiles are used unless something is very wrong."
		broken = 1
	return

/turf/open/floor/plating/modular/break_tile()
	if (!broken && !burnt)
		tile_top_left = null
		tile_bot_left = null
		tile_top_rght = null
		tile_bot_rght = null
		tile_seal = null
		icon_state = "[initial(icon_state)]"
		name = "damaged [initial(name)]"
		desc = "[initial(desc)] The plating and struts are badly damaged and will need repairs, but can be used again."
		desc_lore = "[initial(desc_lore)] The struts, screws and other elements that can be attached to the plating are all in compliance with the Northern Republic Production Standard, guaranteeing compatibility with almost any human ship in existence. Physical damage on plating like this is best removed using a welder. Somehow the struts on this panel survived whatever blew off the tiles, but typically they are not particularly explosion resistant, so they get damaged easily, requiring complete replacements. This fact is not seen as a flow by the Northern Republic that maintains the standard, as they argue explosions should not be an occurrence in areas where these tiles are used unless something is very wrong."
		broken = 1
	return

/turf/open/floor/plating/modular/burn_tile()
	if (!broken && !burnt)
		tile_top_left = null
		tile_bot_left = null
		tile_top_rght = null
		tile_bot_rght = null
		tile_seal = null
		icon_state = "platingscorched"
		name = "burnt [initial(name)]"
		desc = "[initial(desc)] At least one metal strut has been placed and matched to the openings on the plating, ready to be attached to the platform. It looks badly burnt and will need to be cleaned before use."
		desc_lore = "[initial(desc_lore)] The struts, screws and other elements that can be attached to the plating are all in compliance with the Northern Republic Production Standard, guaranteeing compatibility with almost any human ship in existence. The tiles following the Northern Republic standard will by design burn off as fast as possible while generating as little heat and smoke as possible. This typically is enough to save the struts that hold them in place, all they need is a little cleaning that will require you to loosen their bolts with a screwdriver first."
		burnt = 1
	return

/turf/open/floor/plating/modular/update_icon()
	overlays = null
	overlays += image(icon, src, "[icon_state]")
	if (tile_top_left != null)
		overlays += image(icon, src, "[tile_top_left]_top_left")
	if (tile_bot_left != null)
		overlays += image(icon, src, "[tile_bot_left]_bot_left")
	if (tile_top_rght != null)
		overlays += image(icon, src, "[tile_top_rght]_top_rght")
	if (tile_bot_rght != null)
		overlays += image(icon, src, "[tile_bot_rght]_bot_rght")
	if (tile_seal != null)
		overlays += image(icon, src, "[tile_seal]_seal")

/turf/open/floor/plating/modular/Initialize(mapload, ...)
	. = ..()
	if(tile_top_left != null || tile_bot_left != null || tile_top_rght != null || tile_bot_rght != null || tile_seal != null)
		update_icon()

//Completed floors start here.
/turf/open/floor/plating/modular/gray
	tile_top_left = "gray"
	tile_top_rght = "gray"
	tile_bot_left = "gray"
	tile_bot_rght = "gray"
	tile_seal = "black"
