/obj/structure/botany/tray
	name = "Botany Tray Master Item"
	desc = "This is a general item that hides all the botany mechanics in-code. It should not be in the game."
	desc_lore = "This will be redundant soon and I shoudnt really be doing this anymore. The lore_desc, not the master item."
	icon = 'icons/sp_default.dmi'
	icon_state = "default"
	var/list/botany_tray = list(
		"plant_type" = "empty",
		"fertilizer" = "empty",
		"additional" = "empty",
		"cycle" = 0,
		"cycle_time" = 150,
		)

/obj/structure/botany/tray/proc/botany_advance_cycle()
	while(botany_tray["cycle"] <= 4)
		sleep(botany_tray["cycle_time"])
		botany_tray["cycle"] += 1

/obj/structure/botany/tray/standard

	name = "prototype rapid hydroponics tray"
	desc = "A tray with what looks like a mixture of black, muddy dirt and blue tinted water. A logo depicting multiple wheat stalks and the words 'FEED OUR FAMILIES' can be seen on the side."
	desc_lore = "These trays follow a heavily modified corporate design and have been co-developed with PST Engineers with the help of the Harvest Star Conglomerate, a small group of farming and farming equipment-oriented corporations based in the Neroid Sector. The mixture used in the trays is grown somewhere on the PST and is a special kind of bioorganic compound accelerating plant growth. The water has programmed crystalline structures which can further be additionally programmed by adding fertilizer and other compounds and assists in repairing the plants during their rapid growth."
	icon = 'icons/sectorpatrol/botany/structures/tray.dmi'
	icon_state = "tray"

/obj/structure/botany/tray/standard/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/botany/fertilizer))
		var/obj/item/botany/fertilizer/C
		if(C.botany_fertilizer_type == null || C.botany_fertilizer_uses < 1)
			to_chat(usr, SPAN_WARNING("The tray buzzes. The container seems to be empty."))
			playsound(src, 'sound/machines/terminal_error.ogg', 25)
			return
		to_chat(src, "You connect the tank to the tray and let it inject a dose of fertilizer.")
		playsound(src, 'sound/effects/spray.ogg', 25)
		botany_tray["fertilizer"] = C.botany_fertilizer_type
		return
