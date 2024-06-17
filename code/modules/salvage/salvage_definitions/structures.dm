//Airlocks

/obj/structure/salvage/airlock
	name = "airlock"
	desc = "A heavy metal door that slides and locks into place when opened from a nearby terminal."
	desc_lore = "Airlocks, as the name suggests, are essentially what doors are to spacers. Typically opened remotely via a control panel next to them, but most with some sort of emergency release, these separate major 'rooms' in a ship from each other, forming protective, airtight seals if needed."
	desc_lore_affix = "A standard airlock is most likely going to have a fair share of metal and alloys, with some resins as well. It's generally advised to just salvage an airlock to gain entry to a closed off area if such a need arises."
	icon = 'icons/sectorpatrol/salvage/doors.dmi'
	icon_state = "door_1"
	salvage_decon_keyword = "AECBBADB"
	var/width = 1

/obj/structure/salvage/airlock/Initialize(mapload, ...)
	. = ..()
	if(dir in list(EAST, WEST))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size

/obj/structure/salvage/airlock/double
	icon = 'icons/sectorpatrol/salvage/doors64.dmi'
	icon_state = "door_1"
	width = 2

