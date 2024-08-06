/obj/structure/ship_elements/primary_cannon
	name = "\improper PST Type-A Prototype Cannon"
	desc = "A complex piece of heavy machinery without any clear indications how to use it, only warning labels. Complete with a tray that extends from the cannon itself."
	icon = 'icons/sectorpatrol/ship/cannons96.dmi'
	desc_lore = "In PST technical jargon, Weapon System Type A essentially stands for "Primary" or "Missile" based weapon system. This system encodes regular information passed to it from user terminals and converts it to a format understandable by the PSTs Mission Control system. The system's primary unique feature is when the missile has the right navigational data, it will always strike its target even if it moves or changes its vector."
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
	var/list/loaded_projectile = list("missle" = "none",
		"warhead" = "none",
		"speed" = 0,
		"payload" = 0
		)
