/obj/item/clothing/suit/sp_personal
//	name = "civilian jacket master item"
	desc = "A thick article of clothing, made from some hardened artificial, rubber like substance that is textured to simulate leather, with hardened resin elements used for finer details."
	desc_lore = "Typically called 'jackets' or 'suits', this article of clothing is thicker than most and is meant to be worn on top of lighter, more breathable uniforms. This is why they are typically made of heavier leather and worn by personnel departing the ship for planets where the atmosphere is breathable. The PST made variants replace leather with a polymer and resin mixture, resulting in clothes that are just as warm, damage a bit easier, but can be easily recycled and made back from scratch with the push of a button."
	customizable = 1
	icon = 'icons/obj/sp_clothes/coats/icon/suit.dmi'
//	icon_state = ""
	name = "khaki lightjacket"
	icon_state = "lightjacket_khaki"
	item_icons = list(
		WEAR_JACKET = 'icons/obj/sp_clothes/coats/onmob/suit.dmi'
	)
	var/openable
	var/openable_open
	PersistantObject = TRUE


/obj/item/clothing/suit/sp_personal/verb/open_jacket()
	set category = "Object"
	set name = "Open or close jacket"
	set src in usr
	if(!usr.is_mob_incapacitated())
		switch (openable)
			if ("zipper")
				src.openable_open = !src.openable_open
				if(src.openable_open)
					icon_state = "[initial(icon_state)]_o"
					playsound(src, soundin = 'sound/items/zip.ogg', vol = 10, vary = 1)
					to_chat(usr, SPAN_INFO("You unzip your jacket decisively, giving yourself a more casual look."))
				else
					icon_state = "[initial(icon_state)]"
					playsound(src, soundin = 'sound/items/zip.ogg', vol = 10, vary = 1)
					to_chat(usr, "You zip up your jacket. You feel warmer already.")
				update_clothing_icon() //so our mob-overlays update
			if ("buttons")
				src.openable_open = !src.openable_open
				if(src.openable_open)
					icon_state = "[initial(icon_state)]_o"
					to_chat(usr, SPAN_INFO("You open up your jacket, giving yourself a more casual look."))
				else
					icon_state = "[initial(icon_state)]"
					to_chat(usr, "You button up your jacket. You feel warmer already.")
				update_clothing_icon() //so our mob-overlays update
			else
				to_chat(usr, SPAN_NOTICE("This jacket does not have any functional way of keeping it open and closed."))

///obj/item/clothing/suit/sp_personal/basejacket/lightjacket_khaki
//	name = "khaki lightjacket"
//	icon_state = "lightjacket_khaki"

/obj/item/clothing/suit/sp_personal/basejacket/lightjacket_red
	name = "red lightjacket"
	icon_state = "lightjacket_red"

/obj/item/clothing/suit/sp_personal/basejacket/lightjacket_grey
	name = "grey lightjacket"
	icon_state = "lightjacket_grey"

/obj/item/clothing/suit/sp_personal/basejacket/lightjacket_black
	name = "black lightjacket"
	icon_state = "lightjacket_black"

/obj/item/clothing/suit/sp_personal/basejacket/lightjacket_brown
	name = "brown lightjacket"
	icon_state = "lightjacket_brown"

/obj/item/clothing/suit/sp_personal/basejacket/lightjacket_blue
	name = "blue lightjacket"
	icon_state = "lightjacket_blue"

/obj/item/clothing/suit/sp_personal/basejacket/vest_brown
	name = "brown puffy vest"
	icon_state = "vest_brown"

/obj/item/clothing/suit/sp_personal/basejacket/vest_tan
	name = "tan puffy vest"
	icon_state = "vest_tan"

/obj/item/clothing/suit/sp_personal/basejacket/vest_grey
	name = "grey puffy vest"
	icon_state = "vest_grey"

//openable, zippers

/obj/item/clothing/suit/sp_personal/basejacket/greenpark
	name = "green parka"
	icon_state = "greenpark"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/navypark
	name = "navy parka"
	icon_state = "navypark"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/yellowpark
	name = "yellow parka"
	icon_state = "yellowpark"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/redpark
	name = "red parka"
	icon_state = "redpark"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/purplepark
	name = "purple parka"
	icon_state = "purplepark"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/pilot
	name = "light aviator jacket"
	icon_state = "pilot"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/jacket_tanker
	name = "tanker style jacket"
	icon_state = "jacket_tanker"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/bomber
	name = "bomber jacket"
	icon_state = "bomber"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/windbreaker_brown
	name = "brown windbreaker"
	icon_state = "windbreaker_brown"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/windbreaker_browngreen
	name = "brown and green windbreaker"
	icon_state = "windbreaker_browngreen"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/windbreaker_gray
	name = "gray windbreaker"
	icon_state = "windbreaker_gray"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/windbreaker_green
	name = "green windbreaker"
	icon_state = "windbreaker_green"
	openable = "zipper"

/obj/item/clothing/suit/sp_personal/basejacket/windbreaker_brownlight
	name = "light brown windbreaker"
	icon_state = "windbreaker_brownlight"
	openable = "zipper"

// openable, buttons


/obj/item/clothing/suit/sp_personal/basejacket/bomber2
	name = "bomber jacket"
	icon_state = "bomber2"
	openable = "buttons"

/obj/item/clothing/suit/sp_personal/basejacket/coat_tan
	name = "tan coat"
	icon_state = "coat_tan"
	openable = "buttons"

/obj/item/clothing/suit/sp_personal/basejacket/navycoat_tan
	name = "tan navy coat"
	icon_state = "navycoat_tan"
	openable = "buttons"

/obj/item/clothing/suit/sp_personal/basejacket/navycoat_whiteheavy
	name = "white heavy navy coat"
	icon_state = "navycoat_whiteheavy"
	openable = "buttons"

/obj/item/clothing/suit/sp_personal/basejacket/navycoat_greendark
	name = "dark olive navy coat"
	icon_state = "navycoat_greendark"
	openable = "buttons"

/obj/item/clothing/suit/sp_personal/basejacket/navycoat_greenlight
	name = "olive navy coat"
	icon_state = "navycoat_greenlight"
	openable = "buttons"

/obj/item/clothing/suit/sp_personal/basejacket/uppcoat
	name = "eastern navy coat"
	icon_state = "uppcoat"
	openable = "buttons"
