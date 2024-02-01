/obj/structure/searchable
	name = "Base item for searchable interactions."
	desc = "Hello there! If you are in game then soemome f... Uh... You know."
	icon = 'icons/obj/structures/sp_searchable.dmi'
	icon_state = "default"
	var/searchable_searched = FALSE
	var/searchable_search_time = 150
	var/searchable_step = 0
	var/searchable_max_steps = 6


/obj/structure/searchable/attack_hand(mob/user as mob)
	if(searchable_step == searchable_max_steps)
		to_chat(user, SPAN_NOTICE("Looks like someone already thoroughly searched here. There does not seem to be anything of note left."))
		return
	if(searchable_searched == TRUE)
		to_chat(user, SPAN_WARNING("Someone is already searching this!"))
		return
	to_chat(user, SPAN_NOTICE("You begin your search through the [src]. You should be able to do this [searchable_max_steps - searchable_step] more times."))
	searchable_searched = TRUE
	update_icon()
	if(do_after(user, searchable_search_time, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_GENERIC))
		searchable_searched = FALSE
		update_icon()
		to_chat(user, narrate_body("You complete a search step. This is a placeholder text."))
		searchable_step += 1
		return
	searchable_searched = FALSE
	update_icon()
	return

/obj/structure/searchable/update_icon()
	if(searchable_searched == TRUE || searchable_step == searchable_max_steps) icon_state = "[initial(icon_state)]_o"
	if(searchable_searched == FALSE) icon_state = "[initial(icon_state)]"
	..()
