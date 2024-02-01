/obj/item/cargo/duffelbag
	name = "sealed duffel bag"
	desc = "A duffel bag, securely closed and sealed at a point of entry. Typically carrying personal effects or other assorted cargo."
	desc_lore = "Contents of such bags are rarely screened in detail but given a thorough scanning when they are introduced into the cargo system. Removal or loss of a seal before reaching your destination typically means loss of the entire bag, hence typically nothing to personal or sensitive is put into these."
	icon = 'icons/obj/items/sp_cargo.dmi'
	icon_state = "duffel"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/sp_cargo_lhand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/sp_cargo_rhand.dmi'
		)

/obj/structure/cargo/crate/
	name = "generic cargo crate"
	var/cargo_manifest

/obj/structure/cargo/crate/examine(mob/user)
	..()

	if (cargo_manifest != null)
		if(!isxeno(user) && (get_dist(user, src) < 4 || isobserver(user)))
			to_chat(user, narrate_body("You can see the cargo manifest stapled on the crate. It reads:"))
			to_chat(user, narrate_manifest_block(narrate_manifest("[cargo_manifest]")))
/obj/structure/cargo/crate/general/sealed
	name = "sealed generic UACM standard cargo crate"
	desc = "A crate with the UACM insignia printed on the side. This crate is marked with green stripes and is sealed with tamper-proofing yellow tape."
	desc_lore = "Green stripes on UACM crates means that they contain personal effects, physical mail, and other items that are not easily classified by the Unified Cargo Code System but that have been given special leave to travel through the UACM logistics system. Once accepted into the system, all cargo is wrapped in yellow tape which should only be removed at its destination."
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "general_closed_sealed"
	climbable = 1
	anchored = FALSE
	throwpass = 1

/obj/structure/cargo/crate/b/sealed
	name = "sealed type B UACM standard cargo crate"
	desc = "A crate with the UACM insignia printed on the side. This crate is marked with a single yellow stripe and the letter 'B'. It is also sealed with tamper-proofing yellow tape."
	desc_lore = "A yellow stripe and the letter 'B' indicate this is a type B crate, containing tools and/or replacement electronic and electric parts, sometimes also containing materials specific to engineering tasks. Once accepted into the system, all cargo is wrapped in yellow tape which should only be removed at its destination."
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "type_b_closed_sealed"
	climbable = 1
	anchored = FALSE
	throwpass = 1

/obj/structure/cargo/crate/

/obj/structure/cargo/crate/examine(mob/user)
	..()

	if (item_serial != null)
		if(!isxeno(user) && (get_dist(user, src) < item_serial_distance || isobserver(user)))
			to_chat(user, narrate_body("The serial number is:"))
			to_chat(user, narrate_serial_block(narrate_serial("[item_serial]")))
