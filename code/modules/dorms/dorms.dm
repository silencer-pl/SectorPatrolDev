// Sector Patrol Pesistance Dorm Mechanics
// Master def file

// Dorm button and button claiming.

/obj/structure/dorm_button
	name = "wall mounted button"
	desc = "A button. It can be pushed. Most likely will trigger things."
	desc_lore = "While this button does not appear to be in any way unusual, it is linked to a central dorm database and can be used, along with a properly working and chipped UACM PST id card, to 'claim' or 'unclaim' a dorm room. These functions should be available via right click menu of the item."
	icon = 'icons/sectorpatrol/buttons/dorm_control.dmi'
	icon_state = "dorm_button"
	var/dorm_owner_name
	var/dorm_id_tag
