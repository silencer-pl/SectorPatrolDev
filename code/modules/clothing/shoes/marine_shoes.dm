

/obj/item/clothing/shoes/marine
	name = "marine combat boots"
	desc = "Standard issue combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "marine"
	item_state = "marine"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	siemens_coefficient = 0.7
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/holdout,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/tool/screwdriver,
		/obj/item/tool/surgery/scalpel,
		/obj/item/weapon/straight_razor,
	)

	drop_sound = "armorequip"

/obj/item/clothing/shoes/marine/update_icon()
	if(stored_item)
		icon_state = "[initial(icon_state)]-1"
	else
		icon_state = initial(icon_state)

/obj/item/clothing/shoes/marine/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/jungle
	icon_state = "marine_jungle"
	item_state = "marine_jungle"
	desc = "Don't go walkin' slow, the devil's on the loose."

/obj/item/clothing/shoes/marine/jungle/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/brown
	icon_state = "marine_brown"
	item_state = "marine_brown"
	desc = "Standard issue combat boots for combat scenarios or combat situations. All combat, all the time. These are brown."

/obj/item/clothing/shoes/marine/brown/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/monkey
	name = "monkey combat boots"
	desc = "A sturdy pair of combat boots, the reflection of the polished leather reflects your true self."
	icon_state = "monkey_shoes"
	item_state = "monkey_shoes"
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/upp
	name = "military combat boots"
	icon_state = "marine_brown"
	item_state = "marine_brown"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH

/obj/item/clothing/shoes/marine/upp/knife
	spawn_item_type = /obj/item/attachable/bayonet/upp

/obj/item/clothing/shoes/marine/joe
	name = "biohazard boots"
	desc = "A pair of somewhat cheaply made biohazard boots. Tomorrow, Together."
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/dress
	name = "dress shoes"
	desc = "Pre-polished fancy dress shoes. You can see your reflection in them."
	icon_state = "laceups"
	flags_inventory = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/dress/commander
	name = "commanding officer dress shoes"
	desc = "Has special soles for better trampling those underneath."
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW

/obj/item/clothing/shoes/veteran/pmc
	name = "polished shoes"
	desc = "The height of fashion, but these look to be woven with protective fiber."
	icon_state = "jackboots"
	item_state = "jackboots"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/holdout,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/weapon/straight_razor,
	)

/obj/item/clothing/shoes/veteran/pmc/update_icon()
	if(stored_item)
		icon_state = "[initial(icon_state)]-1"
	else
		icon_state = initial(icon_state)

/obj/item/clothing/shoes/veteran/pmc/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/veteran/pmc/commando
	name = "\improper PMC commando boots"
	desc = "A pair of heavily armored, acid-resistant boots."
	permeability_coefficient = 0.01
	armor_bio = CLOTHING_ARMOR_HIGH
	siemens_coefficient = 0.2
	unacidable = TRUE

/obj/item/clothing/shoes/veteran/pmc/commando/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/veteran/pmc/van_bandolier
	name = "hiking boots"
	desc = "Over stone, over ice, through sun and sand, mud and snow, into raging water and hungry bog, these will never let you down."
	spawn_item_type = /obj/item/attachable/bayonet/van_bandolier

/obj/item/clothing/shoes/veteran/pmc/commando/cbrn
	name = "\improper M3 MOPP boots"
	desc = "M3 MOPP boots have been designed to protect the wearer from contact with any possible infection vectors or hazardous substances that may have contaminated the area of operations. This includes further enhancements in conjunction with the standard durability of M3 boots, reducing the probability of punctures or cuts as well as the effects of radiation."
	icon_state = "cbrn"
	item_state = "cbrn"
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_bio = CLOTHING_ARMOR_GIGAHIGHPLUS
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/corporate
	name = "rugged boots"
	desc = "These synth-leather boots seem high quality when first worn, but quickly detoriate, especially in the environments the corporate security members these are issued to operate in. Still, better than nothing."
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/ress
	name = "armored sandals"
	icon_state = "sandals"
	item_state = "sandals"
	allowed_items_typecache = null

/obj/item/clothing/shoes/hiking
	name = "hiking shoes"
	desc = "These rugged shoes are caked with mud and dirt. Designed for high-altitude hiking expeditions, they're sure to be helpful in any climate or environment."
	icon_state = "jackboots"
	item_state = "jackboots"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/holdout,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/weapon/straight_razor,
	)
	var/weed_slowdown_mult = 0.5

/obj/item/clothing/shoes/hiking/equipped(mob/user, slot, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user
	if(src != human_user.shoes)
		return
	RegisterSignal(user, COMSIG_MOB_WEED_SLOWDOWN, PROC_REF(handle_weed_slowdown))

/obj/item/clothing/shoes/hiking/unequipped(mob/user, slot, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_WEED_SLOWDOWN, PROC_REF(handle_weed_slowdown))

/obj/item/clothing/shoes/hiking/proc/handle_weed_slowdown(mob/user, list/slowdata)
	SIGNAL_HANDLER
	slowdata["movement_slowdown"] *= weed_slowdown_mult

//=ROYAL MARINES=\\

/obj/item/clothing/shoes/royal_marine
	name = "\improper L10 pattern combat boots"
	desc = "Standard issue combat boots for combat scenarios or combat situations. Used by the three world empires royal marines commando units."
	icon_state = "rmc_boots"
	item_state = "rmc_boots"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/holdout,
		/obj/item/weapon/gun/pistol/clfpistol,
	)
	flags_atom = NO_NAME_OVERRIDE

/obj/item/clothing/shoes/royal_marine/update_icon()
	if(stored_item)
		icon_state = "[initial(icon_state)]-1"
	else
		icon_state = initial(icon_state)

/obj/item/clothing/shoes/royal_marine/knife

	spawn_item_type = /obj/item/attachable/bayonet/rmc



/obj/item/clothing/shoes/socks
	name = "grey compression socks"
	desc = "A pair of grey compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. A spacer favorite."
	desc_lore = "Compression socks became a favorite for those who spend prolonged amount of time on spaceships or installations almost as soon as mankind reached for the stars. The reasoning is simple, the increased pressure on thighs and legs improves blood pressure and circulation, which is particularly useful in zero-g environments which spaceship crews often find themselves spending prolonged amounts of time in. Socks like these meant to be use in space are also typically insulated and quite warm, another very useful aspect in the relative cold of most space faring vessels."
	icon = 'icons/obj/items/clothing/socks.dmi'
	icon_state = "grey_thigh"
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
        WEAR_FEET = 'icons/mob/humans/onmob/socks.dmi'
    )

/obj/item/clothing/shoes/socks/black
	name = "black compression socks"
	desc = "A pair of black compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. A spacer favorite."
	icon_state = "black_thigh"
	layer = SUIT_GARB_LAYER

/obj/item/clothing/shoes/socks/white
	name = "white compression socks"
	desc = "A pair of white compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. A spacer favorite."
	icon_state = "white_thigh"

/obj/item/clothing/shoes/socks/striped
	name = "black and white striped compression socks"
	desc = "A pair of black and white striped compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. A spacer favorite."
	icon_state = "striped_thigh"

/obj/item/clothing/shoes/socks/striped_pink
	name = "pink and white striped compression socks"
	desc = "A pair of pink and white striped compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. A spacer favorite."
	icon_state = "striped_pink_thigh"

/obj/item/clothing/shoes/socks/striped_blue
	name = "blue and white striped compression socks"
	desc = "A pair of blue and white striped compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. A spacer favorite."
	icon_state = "striped_blue_thigh"

/obj/item/clothing/shoes/socks/striped_trans
	name = "multicolor striped compression socks"
	desc = "A pair of multicolor striped compression socks, guaranteed to keep your feet comfy and your legs warm while improving your blood circulation. The stripe colors used are commonly used pattern among transgender personnel and has been also used to express support. A spacer favorite."
	icon_state = "striped_trans_thigh"
