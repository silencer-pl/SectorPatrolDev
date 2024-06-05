//items - no disassembly, but can be intel

/obj/item/salvage
	name = "salvage item - master definition"
	desc = "This is a master item. It shoudl not be placed anywhere in the game world."
	desc_lore = "If you have the time, please consider reporting this as a bug."
	icon = 'icons/sectorpatrol/salvage/items.dmi'
	icon_state = "master"
	flags_item = NOBLUDGEON
	var/list/salvage_contents = list(
		"metal" = 0,
		"resin" = 0,
		"alloy" = 0,
		)
	var/salvage_intel_item = FALSE
	var/list/salvage_search = list(
		"can_be_searched" = 0,
		"was_searched" = 0,
		"search_time" = SEARCH_TIME_NORMAL,
		"search_return_initial" = "After a through search you don't discover anything of note. Oops.",
		"search_return_complete" = "There is nothing special about this item."
		)
	var/desc_affix
	var/desc_lore_affix

/obj/item/salvage/Initialize(mapload, ...)
	. = ..()
	GLOB.salvaging_total_ldpol += ((salvage_contents["metal"] + salvage_contents["resin"] + salvage_contents["alloy"]) / 5)
	GLOB.salvaging_total_metal += salvage_contents["metal"]
	GLOB.salvaging_total_resin += salvage_contents["resin"]
	GLOB.salvaging_total_alloy += salvage_contents["alloy"]
	if(desc_affix != null)
		desc = initial(desc) + "</p><p>" + desc_affix
	if(desc_lore_affix != null)
		desc_lore = initial(desc_lore) + "</p><p>" + desc_lore_affix

/obj/item/salvage/proc/salvage_recycle(obj/item/salvaging/recycler_nozzle/N)
	var/obj/item/salvaging/recycler_nozzle/nozzle = N
	nozzle.recycler_nozzle_paired_pack.recycler_add_salvage(metal = salvage_contents["metal"], resin = salvage_contents["resin"], alloy = salvage_contents["alloy"])
	playsound(src, 'sound/effects/EMPulse.ogg', 25)
//  icon_state = initial(icon_state) + "_0"
//  update_icon()
	sleep(10)
	qdel(src)
	return

/obj/item/salvage/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/salvaging/recycler_nozzle/))
		var/obj/item/salvaging/recycler_nozzle/nozzle = W
		if(nozzle.recycler_nozzle_paired_pack == null)
			nozzle.talkas("Error: No backpack paired. Please pair this nozzle to a backpack.")
			playsound(nozzle, 'sound/machines/terminal_error.ogg', 25)
			return
		if (nozzle.recycler_nozzle_paired_pack.recycler_backpack_storage >= nozzle.recycler_nozzle_paired_pack.recycler_backpack_storage_max)
			nozzle.recycler_nozzle_paired_pack.talkas("Error. Backpack full. Please depoist resources.")
			nozzle.recycler_nozzle_paired_pack.recycler_full_warning()
			return
		if (nozzle.recycler_nozzle_charges < 1)
			nozzle.talkas("Error: Air canister depleted. Please recharge at nearest charging station.")
			playsound(nozzle, 'sound/machines/terminal_error.ogg', 25)
			return
		salvage_recycle(nozzle)
		return

/obj/item/salvage/attack_self(mob/user)
	. = ..()
	if(usr.a_intent == INTENT_GRAB)
		if(salvage_search["can_be_searched"] == 0)
			to_chat(usr, SPAN_INFO("There is nothing to search. This item can be safely recycled."))
			return
		if(salvage_search["was_searched"] == 1)
			to_chat(usr, SPAN_INFO("This item was already searched, but you can still gather the following:"))
			to_chat(usr, narrate_body(salvage_search["search_return_complete"]))
			if(salvage_intel_item == FALSE)
				to_chat(usr, SPAN_INFO("This item can be safely salvaged."))
			if(salvage_intel_item == TRUE)
				to_chat(usr, SPAN_INFO("This item should be returned for intelligence processing and should not be recycled."))
			return
		if(salvage_search["was_searched"] == 0)
			to_chat(usr, SPAN_INFO("Something seems to be off, you take a closer look at the item..."))
			if(do_after(usr, salvage_search["search_time"], INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				to_chat(usr, narrate_body(salvage_search["search_return_initial"]))
				if(salvage_intel_item == FALSE)
					to_chat(usr, SPAN_INFO("This item can be safely salvaged."))
				if(salvage_intel_item == TRUE)
					to_chat(usr, SPAN_INFO("This item should be returned for intelligence processing and should not be recycled."))
				salvage_search["was_searched"] = 1
				return

//Structures - Disassembly needed. Dissasembly code to be included down the line for organization purposes, bear with me.

/obj/structure/salvage
	name = "salvage structure - master definition"
	desc = "This is a master structure. It shoudl not be placed anywhere in the game world."
	desc_lore = "If you have the time, please consider reporting this as a bug."
	icon = 'icons/sectorpatrol/salvage/structures.dmi'
	icon_state = "master"
	anchored = 1
	density = 1
	opacity = 0
	var/list/salvage_contents = list(
		"metal" = 0,
		"resin" = 0,
		"alloy" = 0,
		)
	var/salvage_strucutre_ready = FALSE
	var/desc_affix
	var/desc_lore_affix

/obj/structure/salvage/Initialize(mapload, ...)
	. = ..()
	GLOB.salvaging_total_ldpol += (salvage_contents["metal"] + salvage_contents["resin"] + salvage_contents["alloy"])
	GLOB.salvaging_total_metal += salvage_contents["metal"]
	GLOB.salvaging_total_resin += salvage_contents["resin"]
	GLOB.salvaging_total_alloy += salvage_contents["alloy"]
	if(desc_affix != null)
		desc = initial(desc) + "</p><p>" + desc_affix
	if(desc_lore_affix != null)
		desc_lore = initial(desc_lore) + "</p><p>" + desc_lore_affix

/obj/structure/salvage/proc/salvage_recycle(obj/item/salvaging/recycler_nozzle/N)
	var/obj/item/salvaging/recycler_nozzle/nozzle = N
	nozzle.recycler_nozzle_paired_pack.recycler_add_salvage(metal = salvage_contents["metal"], resin = salvage_contents["resin"], alloy = salvage_contents["alloy"])
	playsound(src, 'sound/effects/EMPulse.ogg', 25)
//  icon_state = initial(icon_state) + "_0"
//  update_icon()
	sleep(10)
	qdel(src)
	return

/obj/structure/salvage/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/salvaging/recycler_nozzle/))
		var/obj/item/salvaging/recycler_nozzle/nozzle = W
		if(nozzle.recycler_nozzle_paired_pack == null)
			nozzle.talkas("Error: No backpack paired. Please pair this nozzle to a backpack.")
			playsound(nozzle, 'sound/machines/terminal_error.ogg', 25)
			return
		if (nozzle.recycler_nozzle_paired_pack.recycler_backpack_storage >= nozzle.recycler_nozzle_paired_pack.recycler_backpack_storage_max)
			nozzle.recycler_nozzle_paired_pack.talkas("Error. Backpack full. Please depoist resources.")
			nozzle.recycler_nozzle_paired_pack.recycler_full_warning()
			return
		if (nozzle.recycler_nozzle_charges < 1)
			nozzle.talkas("Error: Air canister depleted. Please recharge at nearest charging station.")
			playsound(nozzle, 'sound/machines/terminal_error.ogg', 25)
			return
		if(salvage_strucutre_ready == FALSE)
			nozzle.talkas("Error: Unloosened fastening detected. Salvage will be suboptimal.")
			nozzle.talkas("Error: Safety mode engaged. Action disallowed.")
			playsound(nozzle, 'sound/machines/terminal_error.ogg', 25)
			return
		salvage_recycle(nozzle)
		return
