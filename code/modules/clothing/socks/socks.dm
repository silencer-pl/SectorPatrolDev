/obj/item/clothing/socks
	name = "socks"
	desc = "Socks master item. Beware sightings in the wild."
	desc_lore = "Please report any instances of this item to staff."
	icon = 'icons/obj/sp_clothes/socks/icon/socks.dmi'
	icon_state = ""
	flags_equip_slot = SLOT_SOCKS
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	siemens_coefficient = 0.7
	item_icons = list(
        WEAR_SOCKS = 'icons/obj/sp_clothes/socks/onmob/socks.dmi'
    )
	layer = SOCKS_LAYER

/obj/item/clothing/socks/update_clothing_icon()
	if(ismob(loc))
		var/mob/user = loc
		user.update_inv_socks()

/obj/item/clothing/socks/compression/

	name = "compression socks"
	desc = "A pair of compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. A spacer favorite."
	desc_lore = "Compression socks became a favorite for those who spend prolonged amount of time on spaceships or installations almost as soon as mankind reached for the stars. The reasoning is simple, the increased pressure on thighs and legs improves blood pressure and circulation, which is particularly useful in zero-g environments which spaceship crews often find themselves spending prolonged amounts of time in. Socks like these meant to be use in space are also typically insulated and quite warm, another very useful aspect in the relative cold of most space faring vessels."

//Thigh high, effectively covering whole legs
/obj/item/clothing/socks/compression/thigh/gray
	name = "gray compression socks"
	icon_state = "grey_thigh"

/obj/item/clothing/socks/compression/thigh/black
	name = "black compression socks"
	icon_state = "black_thigh"


/obj/item/clothing/socks/compression/thigh/white
	name = "white compression socks"
	icon_state = "white_thigh"

/obj/item/clothing/socks/compression/thigh/striped
	name = "black and white striped compression socks"
	icon_state = "striped_thigh"

/obj/item/clothing/socks/compression/thigh/striped_pink
	name = "pink and white striped compression socks"
	icon_state = "striped_pink_thigh"

/obj/item/clothing/socks/compression/thigh/striped_blue
	name = "blue and white striped compression socks"
	icon_state = "striped_blue_thigh"

/obj/item/clothing/socks/compression/thigh/striped_trans
	name = "multicolor striped compression socks"
	desc = "A pair of multicolor striped compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. The stripe colors used are commonly used pattern among transgender personnel and has been also used to express support. A spacer favorite."
	icon_state = "striped_trans_thigh"
