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

// Structures and decon generation

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
	var/desc_affix
	var/desc_lore_affix
	var/salvage_decon_keyword // Keyword formula: [TOOL(A to F) PAIR 1][TOOL PAIR 2](...)[INTENT(A to D) PAIR 1][INTENT PAIR2](...) ammount of steps is derived from lengh of string. Example: AFFAADBA, case insensitive
	var/list/salvage_decon_array //Alternatively just present a full array, with TRAIT_TOOL / INTENT_ pairs in each row. Presence of a decon array will make mapinit ignore the keyword, even if its set.
	var/salvage_steps
	var/salvage_current_step = 1

/obj/structure/salvage/proc/salvage_generate_decon()

	salvage_steps = (length(salvage_decon_keyword) / 2)
	salvage_decon_array = new/list(2,salvage_steps)
	var/salvage_gen_current_step = 0
	while (salvage_gen_current_step < salvage_steps)
		salvage_gen_current_step += 1
		var/salvage_decon_letter = uppertext(copytext(salvage_decon_keyword, salvage_gen_current_step, (salvage_gen_current_step + 1)))
		switch(salvage_decon_letter)
			if("A")
				salvage_decon_array[1][salvage_gen_current_step] = TRAIT_TOOL_SCREWDRIVER
			if("B")
				salvage_decon_array[1][salvage_gen_current_step] = TRAIT_TOOL_CROWBAR
			if("C")
				salvage_decon_array[1][salvage_gen_current_step] = TRAIT_TOOL_WIRECUTTERS
			if("D")
				salvage_decon_array[1][salvage_gen_current_step] = TRAIT_TOOL_WRENCH
			if("E")
				salvage_decon_array[1][salvage_gen_current_step] = TRAIT_TOOL_MULTITOOL
			if("F")
				salvage_decon_array[1][salvage_gen_current_step] = TRAIT_TOOL_DRILL
	salvage_gen_current_step = 0
	while (salvage_gen_current_step < salvage_steps)
		salvage_gen_current_step += 1
		var/salvage_decon_letter = uppertext(copytext(salvage_decon_keyword, (salvage_gen_current_step + salvage_steps), ((salvage_gen_current_step + salvage_steps + 1))))
		switch(salvage_decon_letter)
			if("A")
				salvage_decon_array[2][salvage_gen_current_step] = INTENT_HELP
			if("B")
				salvage_decon_array[2][salvage_gen_current_step] = INTENT_GRAB
			if("C")
				salvage_decon_array[2][salvage_gen_current_step] = INTENT_DISARM
			if("D")
				salvage_decon_array[2][salvage_gen_current_step] = INTENT_HARM


/obj/structure/salvage/Initialize(mapload, ...)
	. = ..()
	if(salvage_decon_keyword && !salvage_decon_array) salvage_generate_decon()
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


/obj/structure/salvage/proc/salvage_process_decon_generate_text(text = null, state = null)
	if (text == null || state == null) return
	var/text_to_return = text
	var/state_to_return = state
	switch(text_to_return)
		if(TRAIT_TOOL_SCREWDRIVER)
			switch(state_to_return)
				if("starting") return "You start to unfasten the screws on the [src]."
				if("finished") return "You remove the screws from the [src] and put them aside."
		if(TRAIT_TOOL_CROWBAR)
			switch(state_to_return)
				if("starting") return "You start to pry the external cover off the [src] with a crowbar."
				if("finished") return "You remove the external cover from the [src]."
		if(TRAIT_TOOL_WIRECUTTERS)
			switch(state_to_return)
				if("starting") return "You start to cut the internal circutry of [src] with the wirecutters."
				if("finished") return "You finish cutting the internal circutry of [src] and make sure the internal elements are loose."
		if(TRAIT_TOOL_WRENCH)
			switch(state_to_return)
				if("starting") return "You start to remove heavy bolts from the [src] with a wrench."
				if("finished") return "You remove the bolts from the [src]."
		if(TRAIT_TOOL_MULTITOOL)
			switch(state_to_return)
				if("starting") return "You plug in a multitool to [src] and start a diagnostic routine."
				if("finished") return "The multitool finishes its routine on [src] and opens its maintenance hatch."
		if(TRAIT_TOOL_DRILL)
			switch(state_to_return)
				if("starting") return "You start to drill through the [src]."
				if("finished") return "You finish drilling through the [src]."

/obj/structure/salvage/proc/salvage_process_decon(tool = null)
	if (tool == null) return 0
	var/salvage_active_tool_trait = tool
	to_chat(usr, SPAN_INFO(salvage_process_decon_generate_text(text = salvage_active_tool_trait, state = "starting")))
	if(do_after(usr, (CRAFTING_DELAY_NORMAL * usr.get_skill_duration_multiplier(SKILL_CONSTRUCTION)), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		to_chat(usr, SPAN_INFO(salvage_process_decon_generate_text(text = salvage_active_tool_trait, state = "finished")))
		salvage_current_step += 1
		return 1
	return 0

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
		if(salvage_current_step < salvage_steps)
			nozzle.talkas("Error: Unloosened fastening detected. Salvage will be suboptimal.")
			nozzle.talkas("Error: Safety mode engaged. Action disallowed.")
			playsound(nozzle, 'sound/machines/terminal_error.ogg', 25)
			return
		salvage_recycle(nozzle)
		return
	if(salvage_current_step > salvage_steps)
		to_chat(usr, SPAN_INFO("This object is ready for salvaging and does not need any further tinkering."))
		return
	if(salvage_decon_array && salvage_current_step <= salvage_steps)
		if(istype(W, salvage_decon_array[1][salvage_current_step]))
			if(usr.a_intent == salvage_decon_array[2][salvage_current_step])
				if(salvage_process_decon(tool = W) == 1)
					update_icon()
					return
				return "exception - salvage_process_decon failed"
			to_chat(usr, SPAN_INFO("You do not seem to be using the correct intent for this action. Look at the object for more information."))
			return
		to_chat(usr, SPAN_INFO("You do not seem to be using the correct tool for this action. Look at the object for more information."))
		return
	to_chat(usr, SPAN_INFO("This object does not seem to need any tinkering."))
