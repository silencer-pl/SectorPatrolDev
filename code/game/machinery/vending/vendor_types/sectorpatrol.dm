/obj/structure/machinery/cm_vending/clothing/super_snowflake/sp_civclothes
	name = "OV-PST Civilian Clothing Production Line Dispenser"
	desc = "A generic looking vending machine, displaying various articles of clothing on its colored screen. Seems to react to anyone approaching it. This device seems to be connected to a thick Liquid Data conduit that ties to the rest of the station."
	desc_lore = "Recreated from generic blueprints of vending machines acquired from Earth, these devices have two key unique qualities. First, the screens and electronic parts were all manufactured on the PST, meaning that they all carry traces of the stations Liquid Data foundries and are also able to display colored images if they are not taken off station. Second, these devices aren't vending machines at all, but rather end points in a complex manufacturing system that, at least in theory, utilizes polymers, resins and unique metal alloys to manufacture everything its crew may need."
	icon = 'icons/obj/structures/machinery/vending_sp.dmi'
	icon_state = "clothes"
	item_types = list(/obj/item/clothing/head/sp_personal/basehat, /obj/item/clothing/under/sp_personal/baseunder/, /obj/item/clothing/suit/sp_personal/basejacket/, /obj/item/clothing/socks/compression/thigh/, /obj/item/clothing/shoes/sp_personal/baseshoe/)
	vend_delay = 2 SECONDS
	vendor_theme = VENDOR_THEME_USCM

/obj/structure/machinery/cm_vending/clothing/super_snowflake/sp_tiles
	name = "OV-PST NRPS compliant tile press"
	desc = "A complex machine connected to a sizable Liquid Data port that colors, stamps, and 'bakes' NRPS compliant floor tiles on demand."
	desc_lore = "Machines like these are used in other manufacturing facilities that produce NRPS compliant tiles, this one however seems to have been heavily modified to both make the process work with the unique materials and energy threshold available on the PST and to be Liquid Data compatible. The result is hard to deny, a complete set of tiles can be 'baked' in around 10 seconds compared to a whole day in most solutions. Near infinite stores of energy, as it turns out, have their benefit."
	icon = 'icons/obj/structures/machinery/vending_sp.dmi'
	icon_state = "tiles"
	item_types = list(/obj/item/stack/modulartiles, /obj/item/modular/sealant)
	vend_delay = 10 SECONDS
	vendor_theme = VENDOR_THEME_USCM

/obj/structure/machinery/cm_vending/clothing/super_snowflake/sp_tiles

/obj/item/reagent_container/food/snacks/mre_pack/uacm
	name = "OV-PST All-In-One Hypernutrient meal"
	desc = "A disposable, recyclable food tray with surprisingly juicy white lumps that feel almost like meat if you close your eyes. Amd pinch your nose. While the presentation leaves much to be desired, the aroma isn't bad and at least the food looks fresh."
	desc_lore = "The energy required to properly create, cultivate, harvest, and turn biomatter into something edible on-board ships or space stations means that any technology of this type remained a fever dream and to anyone's knowledge never was explored to any extent. It is curious then that the PST not only seems to have a pipeline fully capable of just that, but this does also not seem to be the initial iteration of this technology considering how refined it seems to be. This would likely mean this technology was pioneered back when the PST belonged to the cult of the Godseekers and Deep Void. Bon Appetit!"
	icon = 'icons/obj/items/sp_cargo.dmi'
	icon_state = "pstmeal"

/obj/item/reagent_container/food/snacks/mre_pack/uacm/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)
	bitesize = 3
/obj/structure/machinery/cm_vending/sorted/sectorpatrol/food
	name = "OV-PST Meal Assembly Station"
	desc = "USCM Food Vendor, containing standard military Prepared Meals."
	desc_lore = "This machine seems to not only dispense the food but also serves as the last stage in the PSTs bio generation process. Depending on the desired texture of the food, this machine can flash heat or freeze the product right before handing it out. The end product certainly does not look like what it claims to be, but it very much tastes like it almost to the letter."
	icon = 'icons/obj/structures/machinery/vending_sp.dmi'
	icon_state = "food"
	hackable = FALSE
	unacidable = TRUE
	unslashable = TRUE
	wrenchable = FALSE
	vend_delay = 28
	deny_delay = 20


/obj/structure/machinery/cm_vending/sorted/sectorpatrol/food/populate_product_list(scale)
	listed_products = list(
		list("UACM OV-PST BIOMASS PROCESSOR", -1, null, null),
		list("I promise this tastes and works better than it looks. Unlockng the full potential of this technology will require a Corporate contract most likely. I'll fill you in when it's time. For now, the only consolation I have is that this is what everyone is eating. -C.", -1, null, null),
		list("OV-PST Hyperprotein All-In-One Meal", 50, /obj/item/reagent_container/food/snacks/mre_pack/uacm, VENDOR_ITEM_REGULAR),
	)
