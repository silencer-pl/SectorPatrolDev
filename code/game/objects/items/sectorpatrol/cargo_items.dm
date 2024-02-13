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

/obj/item/cargo/efolder/folder
	name = "electronic folder"
	desc = "A black plastic device that resembles a paper folder but cannot be opened or used to store any paper. Has a slot on the label part."
	desc_lore = "Electronic folders are UAAC-TIS devices that are considered safe to carry by non-agency personnel and are used to store and transport operation related information between TIS mainframes and UACM ships. These devices saw initial adoption during USCMC times but were pushed as a standard when the UACM was established. Once recorded, a folder contains both a spoken debriefing and written information dumped from the ships AI to corroborate the report. These devices come paired with unique PID keys that need to be slotted into the device before it can be accessed by whatever method is used to read from it. Some TIS devices can read from these folders without making direct contact, but most require it to be directly plugged in and decoded."
	icon = 'icons/obj/items/sp_cargo.dmi'
	icon_state = "efolder"
	flags_item = NOBLUDGEON
	var/efolder_folder_id = "default"

/obj/item/cargo/efolder/folder/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/cargo/efolder/pid))
		var/obj/item/cargo/efolder/pid/pid = W
		if(pid.efolder_pid_id == efolder_folder_id)
			to_chat(usr, narrate_body("You slot the pid into the folder. The diodes flash once."))
			var/obj/item/cargo/efolder/folder_pid/folder = new(get_turf(usr))
			folder.efolder_folder_id = efolder_folder_id
			qdel(pid)
			usr.put_in_hands(folder)
			qdel(src)
			return
		if(pid.efolder_pid_id != efolder_folder_id)
			to_chat(usr, narrate_body("You slot the pid into the folder. The diodes flash three times and the pid is ejected."))
			return
	to_chat(user, narrate_body("There does not seem to be a way of combining those at the moment."))
	return


/obj/item/cargo/efolder/pid
	name = "pid device"
	desc = "A small, thin, black device resembling a pen, with a slot on one end and several inactive diodes along one side."
	desc_lore = "This device, technically called an electronic folder PID, carries an encoded unique encryption and decryption signature paired with its unique electronic folder. Upon recording, the device is detached from the folder and typically transported via separate means than the folder itself, to be decoded at whatever destination the folder and PID is intended for. When matched with its folder, the PID first matches its encryption signature with that of the folder, and if it matches, uses its encoded decryption key to pass the decoded contents to whatever means are used to access it."
	icon = 'icons/obj/items/sp_cargo.dmi'
	icon_state = "pid"
	flags_item = NOBLUDGEON
	var/efolder_pid_id = "default"

/obj/item/cargo/efolder/folder_pid
	name = "unlocked electronic folder"
	desc = "A black plastic device that resembles a paper folder but cannot be opened or used to store any paper. A small device is plugged into a slot on the laber label part."
	desc_lore = "Electronic folders are UAAC-TIS devices that are considered safe to carry by non-agency personnel and are used to store and transport operation related information between TIS mainframes and UACM ships. These devices saw initial adoption during USCMC times but were pushed as a standard when the UACM was established. Once recorded, a folder contains both a spoken debriefing and written information dumped from the ships AI to corroborate the report. These devices come paired with unique PID keys that need to be slotted into the device before it can be accessed by whatever method is used to read from it. Some TIS devices can read from these folders without making direct contact, but most require it to be directly plugged in and decoded."
	icon = 'icons/obj/items/sp_cargo.dmi'
	icon_state = "efolder_pid"
	flags_item = NOBLUDGEON
	var/efolder_folder_id = "default"

/obj/item/cargo/efolder/folder_pid/attack_self(mob/user)
	..()
	if(usr.a_intent == INTENT_GRAB)
		to_chat(usr, narrate_body("You slide the pid key out of the folder."))
		var/obj/item/cargo/efolder/folder/folder = new(get_turf(usr))
		var/obj/item/cargo/efolder/pid/pid = new(get_turf(usr))
		pid.efolder_pid_id = efolder_folder_id
		folder.efolder_folder_id = efolder_folder_id
		usr.drop_held_item(src)
		usr.put_in_hands(folder)
		usr.put_in_hands(pid)
		qdel(src)
		return

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

