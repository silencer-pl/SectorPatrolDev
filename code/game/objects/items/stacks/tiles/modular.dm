/obj/item/stack/modulartiles
//	name = "NRPS modular floor tiles"
	name = "light gray NRPS modular floor tiles"
	icon = 'icons/obj/items/floortiles.dmi'
//	icon_state = "tiles_default"
	icon_state = "tiles_lightgray"
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
	amount = 40
//	stack_id = "default modular tile"
	stack_id = "lightgray"
//	var/tiles_color = "default"
	var/tiles_color = "tiles_lightgray"
	amount_sprites = TRUE

/obj/item/stack/modulartiles/Initialize()
	. = ..()
	update_icon()


/obj/item/stack/modulartiles/tiles_gray
	name = "gray NRPS modular floor tiles"
	icon_state = "tiles_gray"
	stack_id = "tiles_gray"
	tiles_color = "gray"

/obj/item/stack/modulartiles/tiles_blue
	name = "blue NRPS modular floor tiles"
	icon_state = "tiles_blue"
	stack_id = "tiles_blue"
	tiles_color = "blue"

/obj/item/stack/modulartiles/tiles_purple
	name = "purple NRPS modular floor tiles"
	icon_state = "tiles_purple"
	stack_id = "tiles_purple"
	tiles_color = "purple"

/obj/item/stack/modulartiles/tiles_orange
	name = "orange NRPS modular floor tiles"
	icon_state = "tiles_orange"
	stack_id = "tiles_orange"
	tiles_color = "orange"

/obj/item/stack/modulartiles/tiles_green
	name = "green NRPS modular floor tiles"
	icon_state = "tiles_green"
	stack_id = "tiles_green"
	tiles_color = "green"

/obj/item/stack/modulartiles/tiles_black
	name = "black NRPS modular floor tiles"
	icon_state = "tiles_black"
	stack_id = "tiles_black"
	tiles_color = "black"

/obj/item/stack/modulartiles/tiles_creamwhite
	name = "creamy white NRPS modular floor tiles"
	icon_state = "tiles_creamwhite"
	stack_id = "tiles_creamwhite"
	tiles_color = "creamwhite"

/obj/item/stack/modulartiles/tiles_limegreen
	name = "lime green NRPS modular floor tiles"
	icon_state = "tiles_limegreen"
	stack_id = "tiles_limegreen"
	tiles_color = "limegreen"

/obj/item/stack/modulartiles/tiles_plumpurple
	name = "purple plum NRPS modular floor tiles"
	icon_state = "tiles_plumpurple"
	stack_id = "tiles_plumpurple"
	tiles_color = "plumpurple"

/obj/item/stack/modulartiles/tiles_eclipsebrown
	name = "eclipse brown NRPS modular floor tiles"
	icon_state = "tiles_eclipsebrown"
	stack_id = "tiles_eclipsebrown"
	tiles_color = "eclipsebrown"

/obj/item/stack/modulartiles/tiles_rustred
	name = "rusty red NRPS modular floor tiles"
	icon_state = "tiles_rustred"
	stack_id = "tiles_rustred"
	tiles_color = "rustred"

/obj/item/stack/modulartiles/tiles_navyblue
	name = "navy blue NRPS modular floor tiles"
	icon_state = "tiles_navyblue"
	stack_id = "tiles_navyblue"
	tiles_color = "navyblue"

/obj/item/stack/modulartiles/tiles_darkpurple
	name = "dark purple NRPS modular floor tiles"
	icon_state = "tiles_darkpurple"
	stack_id = "tiles_darkpurple"
	tiles_color = "darkpurple"

/obj/item/stack/modulartiles/tiles_jadegreen
	name = "jade green NRPS modular floor tiles"
	icon_state = "tiles_jadegreen"
	stack_id = "tiles_jadegreen"
	tiles_color = "jadegreen"

/obj/item/stack/modulartiles/tiles_grassgreen
	name = "grass green NRPS modular floor tiles"
	icon_state = "tiles_grassgreen"
	stack_id = "tiles_grassgreen"
	tiles_color = "grassgreen"

/obj/item/stack/modulartiles/tiles_bronzebrown
	name = "bronze brown NRPS modular floor tiles"
	icon_state = "tiles_bronzebrown"
	stack_id = "tiles_bronzebrown"
	tiles_color = "bronzebrown"

/obj/item/stack/modulartiles/tiles_bloodred
	name = "blood red NRPS modular floor tiles"
	icon_state = "tiles_bloodred"
	stack_id = "tiles_bloodred"
	tiles_color = "bloodred"

/obj/item/stack/modulartiles/tiles_white
	name = "white NRPS modular floor tiles"
	icon_state = "tiles_white"
	stack_id = "tiles_white"
	tiles_color = "white"

/obj/item/stack/modulartiles/tiles_mistblue
	name = "misty blue NRPS modular floor tiles"
	icon_state = "tiles_mistblue"
	stack_id = "tiles_mistblue"
	tiles_color = "mistblue"

/obj/item/stack/modulartiles/tiles_cactusgreen
	name = "cactus green NRPS modular floor tiles"
	icon_state = "tiles_cactusgreen"
	stack_id = "tiles_cactusgreen"
	tiles_color = "cactusgreen"

/obj/item/stack/modulartiles/tiles_muddyyellow
	name = "muddy yellow NRPS modular floor tiles"
	icon_state = "tiles_muddyyellow"
	stack_id = "tiles_muddyyellow"
	tiles_color = "muddyyellow"

/obj/item/stack/modulartiles/tiles_sandyellow
	name = "sandy yellow NRPS modular floor tiles"
	icon_state = "tiles_sandyellow"
	stack_id = "tiles_sandyellow"
	tiles_color = "sandyellow"

/obj/item/stack/modulartiles/tiles_lavenderpurple
	name = "lavender purple NRPS modular floor tiles"
	icon_state = "tiles_lavenderpurple"
	stack_id = "tiles_lavenderpurple"
	tiles_color = "lavenderpurple"

/obj/item/stack/modulartiles/tiles_watermelonred
	name = "watermelon red NRPS modular floor tiles"
	icon_state = "tiles_watermelonred"
	stack_id = "tiles_watermelonred"
	tiles_color = "watermelonred"

/obj/item/stack/modulartiles/tiles_iguanagreen
	name = "iguana green NRPS modular floor tiles"
	icon_state = "tiles_iguanagreen"
	stack_id = "tiles_iguanagreen"
	tiles_color = "iguanagreen"

/obj/item/stack/modulartiles/tiles_dustyblue
	name = "dusty blue NRPS modular floor tiles"
	icon_state = "tiles_dustyblue"
	stack_id = "tiles_dustyblue"
	tiles_color = "dustyblue"

/obj/item/stack/modulartiles/tiles_crimsonred
	name = "crimson red NRPS modular floor tiles"
	icon_state = "tiles_crimsonred"
	stack_id = "tiles_crimsonred"
	tiles_color = "crimsonred"
