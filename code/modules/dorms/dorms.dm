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
	var/dorm_id_tag = "default" // This needs to have unique values for each roomor it will not save between rounds right

/obj/structure/dorm_button/verb/claim()
	set category = "Object"
	set name = "Claim or unclaim dorm room"
	set src in view(1)
	if(usr.is_mob_incapacitated())
		return

	if(ishuman(usr))
		if(dorm_owner_name == null)
			if(GLOB.dorms_name_list.Find(usr.name) == 0)
				GLOB.dorms_name_list += usr.name
				dorm_owner_name = usr.name
				to_chat(usr, SPAN_INFO("Dorm Claimed."))
				return
			else
				to_chat(usr, SPAN_WARNING("Error: You appear to have already claimed a dorm. Please unclaim your current dorm room before trying to claim another one."))
		if(dorm_owner_name)
			if(dorm_owner_name == usr.name)
				GLOB.dorms_name_list -= usr.name
				dorm_owner_name = null
				to_chat(usr, SPAN_INFO("Dorm Unclaimed."))
				return
			else
				to_chat(usr, SPAN_INFO("This dorm is claimed by someone else."))
				return

/obj/structure/dorm_button/Initialize(mapload, ...)
	. = ..()
	GLOB.dorms_button_list += src
