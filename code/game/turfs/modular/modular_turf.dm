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
	overlays += image('icons/turf/modular_nrps.dmi', src, "[initial(icon_state)]")
	if (tile_top_left != null)
		overlays += image('icons/turf/modular_nrps.dmi', src, "[tile_top_left]_top_left")
	if (tile_bot_left != null)
		overlays += image('icons/turf/modular_nrps.dmi', src, "[tile_bot_left]_bot_left")
	if (tile_top_rght != null)
		overlays += image('icons/turf/modular_nrps.dmi', src, "[tile_top_rght]_top_rght")
	if (tile_bot_rght != null)
		overlays += image('icons/turf/modular_nrps.dmi', src, "[tile_bot_rght]_bot_rght")
	if (tile_seal != null)
		overlays += image('icons/turf/modular_nrps.dmi', src, "[tile_seal]_seal")

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
