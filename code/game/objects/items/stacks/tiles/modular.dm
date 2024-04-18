/obj/item/stack/modulartiles
	name = "NRPS modular floor tiles"
	icon = 'icons/obj/items/floortiles.dmi'
	icon_state = "tiles_default"
	singular_name = "NRPS modular floor tile"
	desc = "These floor tiles are lighter than you'd expect and have a distinct port on their back. It looks like they're meant to be slotted somewhere."
	desc_lore = "These floor tiles are produced in compliance with the Northern Republic Production Standard and fit into preprepared floor struts. The tiles themselves can be printed with minimal resource requirements and are both modular and easy to replace. "
	w_class = SIZE_MEDIUM
	force = 1
	throwforce = 1
	flags_item = NOBLUDGEON
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	max_amount = 40
	stack_id = "default modular tile"
	var/tiles_color = "default"
	amount_sprites = TRUE

/obj/item/stack/modulartiles/Initialize()
	. = ..()
	if (tiles_color != "default" && tiles_color != null)
		name = "[tiles_color] NRPS modular floor tiles"
		icon_state = "tiles_[tiles_color]"
		stack_id = "[tiles_color] modular tile"
		update_icon()

