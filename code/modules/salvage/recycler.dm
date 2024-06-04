/obj/item/salvaging/recycler_backpack
	name = "recycler backpack"
	desc = "Two hefty looking cylinders with some electronics attached to them, wrapped in several tubes connected to what looks like a Liquid Data enabled terminal on the back. Heavier than it looks, and it looks quite heavy."
	desc_lore = "Recycler backpacks store matter converted by nozzles that are paired with it in multiple separated compartment slots. Matter converted using Twilight Paradox reduction is atypically dense, which explains why these packs tend to get way heavier than one would think, especially as they fill up.</p><p>More than one nozzle can be paired with a single pack thanks to the Liquid Data transfer methods utilized, the nozzles just need to be in close range of the pack. The pack also does not have to be worn on the back to be effective, however due to its unusual weight, it is not advised to try and pull a pack that's close to being full."
	icon = 'icons/obj/sp_icons/salvaging/icon/recycler_items.dmi'
	icon_state = "recycler_back"
	flags_equip_slot = WEAR_BACK
	w_class = SIZE_HUGE
	slowdown = 0.2
	drag_delay = 2
	flags_item = NOBLUDGEON
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_lhand.dmi',
		WEAR_R_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_rhand.dmi',
		WEAR_BACK = 'icons/obj/sp_icons/salvaging/onmob/recycler_back.dmi'
		)
	var/list/recycler_backpack_stored_materials = list(
		"metals" = 0,
		"resins" = 0,
		"alloys" = 0
		)
	var/recycler_backpack_storage_max = 500
	var/recycler_backpack_storage = 0

/obj/item/salvaging/recycler_backpack/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/salvaging/recycler_nozzle))
		var/obj/item/salvaging/recycler_nozzle/nozzle = W
		if(nozzle.recycler_nozzle_paired_pack == null)
			nozzle.recycler_nozzle_paired_pack = src
			playsound(nozzle, 'sound/machines/ping.ogg', 25)
			talkas("Nozzle paired.")
			return
		if(nozzle.recycler_nozzle_paired_pack != null)
			talkas("Error. Nozzle already paired. Please reset pairing on the nozzle.")
			to_chat(usr, SPAN_INFO("The nozzle needs to be used in GRAB intent to reset its pairing before you can do that."))
			return

/obj/item/salvaging/recycler_backpack/update_icon()
	recycler_backpack_storage = recycler_backpack_stored_materials["metals"] + recycler_backpack_stored_materials["resins"] + recycler_backpack_stored_materials["alloys"]
	if(recycler_backpack_storage == 0)
		slowdown = initial(slowdown)
		drag_delay = initial(drag_delay)
		icon_state = initial(icon_state)
	if(recycler_backpack_storage > 0 && recycler_backpack_storage < (recycler_backpack_storage_max * 0.35))
		slowdown = 0.4
		drag_delay = 3
		icon_state = initial(icon_state) + "_1"
	if(recycler_backpack_storage >= (recycler_backpack_storage_max * 0.35) && recycler_backpack_storage < (recycler_backpack_storage_max * 0.65))
		slowdown = 0.6
		drag_delay = 4
		icon_state = initial(icon_state) + "_2"
	if(recycler_backpack_storage >= (recycler_backpack_storage_max * 0.65) && recycler_backpack_storage < (recycler_backpack_storage_max))
		slowdown = 0.8
		drag_delay = 5
		icon_state = initial(icon_state) + "_3"
	if(recycler_backpack_storage >= (recycler_backpack_storage_max))
		slowdown = 1
		drag_delay = 6
		icon_state = initial(icon_state) + "_4"
		recycler_full_warning()
	. = ..()

/obj/item/salvaging/recycler_backpack/proc/recycler_add_salvage(metal = 0,resin = 0,alloy = 0) // Called by nozzles depending on objects used on, adds resources to backpacks storage
	if (recycler_backpack_storage >= recycler_backpack_storage_max)
		talkas("Error. Backpack full. Please depoist resources.")
		recycler_full_warning()
		return "full"
	if (metal == 0 && resin == 0 && alloy == 0)
		to_chat(usr, SPAN_WARNING("Error. No resources of note detected."))
		return "zero"
	recycler_backpack_stored_materials["metals"] += metal
	recycler_backpack_stored_materials["resins"] += resin
	recycler_backpack_stored_materials["alloys"] += alloy
	update_icon()

/obj/item/salvaging/recycler_backpack/proc/recycler_full_warning()
	playsound(src, 'sound/machines/twobeep.ogg', 25)
	emoteas("Beeps twice")
	talkas("Internal pressure safety threshold reached. This backpack is full. Please head to your nearest deposit station.")

/obj/item/salvaging/recycler_backpack/proc/recycler_empty()
	recycler_backpack_stored_materials["metals"] = 0
	recycler_backpack_stored_materials["resins"] = 0
	recycler_backpack_stored_materials["alloys"] = 0
	recycler_backpack_storage = 0
	playsound(src, 'sound/effects/tankhiss1.ogg', 25)
	sleep(30)
	update_icon()

/obj/item/salvaging/recycler_nozzle
	name = "recycler nozzle"
	desc = "A pointed, long nozzle with a trigger attached to it and a long cable dangling from the back. The cable seems like it can be plugged into something. Liquid Data shimmers with an unusual green shade in a container attached to the top of the device."
	desc_lore = "On their own, these nozzles seem to be modified paint guns with an LD container on top, but jury rigged to work in reverse and aided by a small air cylinder near the trigger. This necessitates 'reloads' of the device, facilitated via plugging them into stationary charging machines. Once synced to a recycler collector unit, this device uses Liquid Data to create a localized Twilight Paradox field, which it then uses to break down any item into its very basic matter components and store this matter in a compartment on the collector.</p><p> While matter collected this way can only be effectively utilized by the Outer Veil Primary Supply Terminal which comes with its own slew of complications and restrictions, on paper at least widespread use of this technology could potentially help improve the quality of life of spacers everywhere by mercifully retiring some ships, particularly ones that still have elements of hulls from almost a century ago."
	icon = 'icons/obj/sp_icons/salvaging/icon/recycler_items.dmi'
	icon_state = "recycler_nozzle"
	w_class = SIZE_MEDIUM
	flags_item = NOBLUDGEON
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_lhand.dmi',
		WEAR_R_HAND = 'icons/obj/sp_icons/salvaging/onmob/recycler_rhand.dmi'
		)
	var/obj/item/salvaging/recycler_backpack/recycler_nozzle_paired_pack = null
	var/recycler_nozzle_charges_max = 100
	var/recycler_nozzle_charges = 100

/obj/item/salvaging/recycler_nozzle/attack_self(mob/user)
	. = ..()
	if(usr.a_intent = INTENT_GRAB)
		if(recycler_nozzle_paired_pack = null)
			to_chat(usr, SPAN_INFO("This nozzle is not paired to any packs."))
			return
		recycler_nozzle_paired_pack = null
		emoteas("Beps twice.")
		playsound(src, 'sound/machines/twobeep.ogg', 25)

/obj/structure/salvaging/recycler_base
	name = "recycler depositor"
	icon = 'icons/obj/sp_icons/salvaging/structures/deposit.dmi'
	icon_state = "salvage_deposit"
	desc = "A top chamber laid over a high-powered hydraulic press."
	desc_lore = "Matter processed by the recyclers backpacks is further compressed in these devices, the end output being highly compressed rods that can be used on the Primary Supply Terminal. Further processed resources like this can also be used on board ships that have compliant manufacturing printers or lathes, but these too are constructed on the PST and as such are currently mostly restricted to ships operated by the Test Crews."
	var/recycler_busy = FALSE

/obj/structure/salvaging/recycler_base/attackby(obj/item/W, mob/user)
	if(recycler_busy = TRUE)
		to_chat(usr, SPAN_WARNING("This device is working. Please wait until it finishes processing its current task."))
		return
	if(istype(W, /obj/item/salvaging/recycler_backpack))
		var/obj/item/salvaging/recycler_backpack/backpack = W
		if(backpack.recycler_backpack_storage == 0)
			playsound(src, 'sound/machines/terminal_error.ogg', 25)
			talkas("Error: Backpack empty.")
			return
		recycler_busy = TRUE
		if(do_after(user, 20, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			talkas("Depositing...")
			if(backpack.recycler_backpack_stored_materials["metals"] != 0)
				GLOB.resources_metal += backpack.recycler_backpack_stored_materials["metals"]
				icon_state = "salvage_deposit_on"
				update_icon()
				sleep(25)
				talkas("Metals deposited. Units processed: [backpack.recycler_backpack_stored_materials["metals"]]")
				icon_state = initial(icon_state)
			if(backpack.recycler_backpack_stored_materials["resins"] != 0)
				GLOB.resources_ldpol += backpack.recycler_backpack_stored_materials["resins"]
				icon_state = "salvage_deposit_on"
				update_icon()
				sleep(25)
				talkas("Resins deposited. Units processed: [backpack.recycler_backpack_stored_materials["resins"]]")
				icon_state = initial(icon_state)
			if(backpack.recycler_backpack_stored_materials["metals"] != 0)
				GLOB.resources_ldpol += backpack.recycler_backpack_stored_materials["alloys"]
				icon_state = "salvage_deposit_on"
				update_icon()
				sleep(25)
				talkas("Metals deposited. Units processed: [backpack.recycler_backpack_stored_materials["metals"]]")
				icon_state = initial(icon_state)
			GLOB.resources_ldpol += backpack.recycler_backpack_storage
			icon_state = "salvage_deposit_on"
			update_icon()
			sleep(25)
			talkas("LD-Polymer extraction complete. Units processed: [backpack.recycler_backpack_storage]")
			icon_state = initial(icon_state)
			INVOKE_ASYNC(backpack, TYPE_PROC_REF(/obj/item/salvaging/recycler_backpack, recycler_empty))
			recycler_busy = FALSE
			talkas("Deposit complete! Thank you for your contirbution!")
