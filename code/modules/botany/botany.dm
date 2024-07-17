/obj/item/botany/fertilizer
	name = "OV-PST bioturf storage device"
	desc = "A metal cylinder, smooth to the touch. Has a visible port at its bottom."
	desc_lore = "Like the trays they fit into, these containers follow a heavily modified corporate design and have been co-developed with PST Engineers with the help of the Harvest Star Conglomerate, a small group of farming and farming equipment-oriented corporations based in the Neroid Sector. The mixture transported in the container is grown somewhere on the PST and is a special kind of bioorganic compound accelerating plant growth. Water is also present, with programmed crystalline structures which can further be additionally programmed by adding fertilizer and other compounds and assists in repairing the plants during their rapid growth."
	icon = 'icons/sectorpatrol/botany/items/prep_items.dmi'
	icon_state = "fertilizer_tank_empty"
	var/botany_fertilizer_type
	var/botany_fertilizer_uses = 0

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

