/obj/structure/machinery/cm_vending/clothing/super_snowflake/sp_civclothes
	name = "OV-PST Civilian Clothing Production Line Dispenser"
	desc = "A generic looking vending machine, displaying various articles of clothing on its colored screen. Seems to react to anyone approaching it. This device seems to be connected to a thick Liquid Data conduit that ties to the rest of the station."
	desc_lore = "Recreated from generic blueprints of vending machines acquired from Earth, these devices have two key unique qualities. First, the screens and electronic parts were all manufactured on the PST, meaning that they all carry traces of the stations Liquid Data foundries and are also able to display colored images if they are not taken off station. Second, these devices aren't vending machines at all, but rather end points in a complex manufacturing system that, at least in theory, utilizes polymers, resins and unique metal alloys to manufacture everything its crew may need."
	icon = 'icons/obj/structures/machinery/vending_sp.dmi'
	icon_state = "clothes"
	item_types = list(/obj/item/clothing/head/sp_personal/, /obj/item/clothing/under/sp_personal/, /obj/item/clothing/suit/sp_personal, /obj/item/clothing/socks, /obj/item/clothing/shoes/sp_personal)
	vend_delay = 5 SECONDS

/obj/structure/machinery/cm_vending/clothing/super_snowflake/sp_tiles
	name = "OV-PST NRPS compliant tile press"
	desc = "A complex machine connected to a sizable Liquid Data port that colors, stamps, and 'bakes' NRPS compliant floor tiles on demand."
	desc_lore = "Machines like these are used in other manufacturing facilities that produce NRPS compliant tiles, this one however seems to have been heavily modified to both make the process work with the unique materials and energy threshold available on the PST and to be Liquid Data compatible. The result is hard to deny, a complete set of tiles can be 'baked' in around 10 seconds compared to a whole day in most solutions. Near infinite stores of energy, as it turns out, have their benefit."
	icon = 'icons/obj/structures/machinery/vending_sp.dmi'
	icon_state = "tiles"
	item_types = list(/obj/item/stack/modulartiles)
	vend_delay = 10 SECONDS
