/obj/item/clothing/suit/sp_personal
	name = "civilian jacket master item"
	desc = "If you see this, something is wrong."
	desc_lore = "This is an item that should not be acessible for mere mortals. Fear it."
	icon = 'icons/obj/sp_clothes/coats/icon/suit.dmi'
	icon_state = ""
	item_icons = list(
		WEAR_JACKET = 'icons/obj/sp_clothes/coats/onmob/suit.dmi'
	)

/obj/item/clothing/suit/sp_personal/openable
	name = "openable jacket master item"
	desc = "Maybe one day, all jackets can be openable."
	var/opened = 0

/obj/item/clothing/suit/sp_personal/openable/verb/open_jacket()
	set category = "Object"
	set name = "Button or unbutton jacket"
	set src in usr
	if(!usr.is_mob_incapacitated())
		src.opened = !src.opened
		if(src.opened)
			icon_state = "[initial(icon_state)]_o"
			to_chat(usr, SPAN_INFO("You open up your jacket, giving yourself a more casual look."))
		else
			icon_state = "[initial(icon_state)]"
			to_chat(usr, "You button up your jacket. You feel warmer already.")
		update_clothing_icon() //so our mob-overlays update
