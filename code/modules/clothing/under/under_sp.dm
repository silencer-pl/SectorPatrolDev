/obj/item/clothing/under/sp_personal/
	name = "civilian clothing master item"
	desc = "If you see this, something is wrong."
	desc_lore = "This is an item that should not be acessible for mere mortals. Fear it."
	icon = 'icons/obj/sp_clothes/under/icon/under.dmi'
	icon_state = ""
	item_icons = list(
		WEAR_BODY = 'icons/obj/sp_clothes/under/onmob/under.dmi'
	)

// Objects with rollable sleeves

/obj/item/clothing/under/sp_personal/rollsleeves
	name = "rollable sleeves master item"
	desc = "Until such a day comes where all icon sets have rollable sleeves, this entry must exist. Alas."
	var/rolled = 0
	var/skirt = 0

/obj/item/clothing/under/sp_personal/rollsleeves/verb/rollsleeves()
	set category = "Object"
	set name = "Roll up sleeves"
	set src in usr
	if(!usr.is_mob_incapacitated())
		src.rolled = !src.rolled
		if(src.rolled)
			LAZYSET(item_state_slots, WEAR_BODY, "[initial(src.icon_state)]_d")
			if (skirt == 0)
				to_chat(usr, SPAN_INFO("You roll up your sleeves. You certainly mean business now, also your clothes are less likely to get dirty."))
			if (skirt == 1)
				to_chat(usr, SPAN_INFO("You roll up your sleeves and skirt. You certainly mean business now, also your clothes are less likely to get dirty."))
		else
			LAZYSET(item_state_slots, WEAR_BODY, "[initial(src.icon_state)]")
			if (skirt == 0)
				to_chat(usr, SPAN_INFO("You roll the sleeves down and smmooth out some of the wrinkles on the clothes a bit."))
			if (skirt == 1)
				to_chat(usr, SPAN_INFO("You roll the sleeves and skirt down and smmooth out some of the wrinkles on the clothes a bit."))
		update_clothing_icon() //so our mob-overlays update

