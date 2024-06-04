/obj/item/salvaging/recycler_backpack
	name = "recycler backpack"
	desc = "Two hefty looking cylinders with some electronics attached to them, wrapped in several tubes connected to what looks like a Liquid Data enabled terminal on the back. Heavier than it looks, and it looks quite heavy."
	desc_lore = "Recycler backpacks store matter converted by nozzles that are paired with it in multiple separated compartment slots. Matter converted using Twilight Paradox reduction is atypically dense, which explains why these packs tend to get way heavier than one would think, especially as they fill up.</p><p>More than one nozzle can be paired with a single pack thanks to the Liquid Data transfer methods utilized, the nozzles just need to be in close range of the pack. The pack also does not have to be worn on the back to be effective, however due to its unusual weight, it is not advised to try and pull a pack that's close to being full."
	icon = 'icons/obj/sp_icons/salvaging/icon/recycler_items.dmi'
	icon_state = "recycler_back"
	flags_equip_slot = WEAR_BACK
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_lhand.dmi',
		WEAR_R_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_rhand.dmi',
		WEAR_BACK = 'icons/obj/sp_icons/salvaging/onmob/recycler_back.dmi'
		)
	var/list/recycler_backpack_stored_materials = list(
		metal = 0,
		resins = 0,
		alloys = 0
		)
	var/recycler_backpack_storage_max = 500
	var/recycler_backpack_storage = 0

/obj/item/salvaging/recycler_nozzle
	name = "recycler nozzle"
	desc = "A pointed, long nozzle with a trigger attached to it and a long cable dangling from the back. The cable seems like it can be plugged into something. Liquid Data shimmers with an unusual green shade in a container attached to the top of the device."
	desc_lore = "On their own, these nozzles seem to be modified paint guns with an LD container on top, but jury rigged to work in reverse and aided by a small air cylinder near the trigger. This necessitates 'reloads' of the device, facilitated via plugging them into stationary charging machines. Once synced to a recycler collector unit, this device uses Liquid Data to create a localized Twilight Paradox field, which it then uses to break down any item into its very basic matter components and store this matter in a compartment on the collector.</p><p> While matter collected this way can only be effectively utilized by the Outer Veil Primary Supply Terminal which comes with its own slew of complications and restrictions, on paper at least widespread use of this technology could potentially help improve the quality of life of spacers everywhere by mercifully retiring some ships, particularly ones that still have elements of hulls from almost a century ago."
	icon = 'icons/obj/sp_icons/salvaging/icon/recycler_items.dmi'
	icon_state = "recycler_nozzle"
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_lhand.dmi',
		WEAR_R_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_rhand.dmi'
		)
	var/obj/item/salvaging/recycler_backpack/recycler_nozzle_paired_pack = null
	var/recycler_nozzle_charges_max = 100
	var/recycler_nozzle_charges = 100
