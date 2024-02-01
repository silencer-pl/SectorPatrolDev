/obj/item/device/uacmrfid/

	name = "blank UACM RFID chip"
	desc = "A small chip with what looks like a capsule with an inert, translucent, slightly blue colored liquid in the middle."
	desc_lore = "The UACM using RFID chips as ways of tagging their crews for on-board AIs is fairly common practice. This chip utilizes a small amount of Liquid Data, which is a prototype solution implemented currently only on the PST."
	icon = 'icons/obj/items/rfid.dmi'
	icon_state = "rfid"
	req_access = list(ACCESS_SP_ADMIN)
	w_class = SIZE_TINY
	var/set_name
	var/set_rank

/obj/item/device/uacmrfid/attack_self()
	..()
	if(set_name && set_rank && icon_state == "rfid")
		name = "set UACM RFID chip"
		icon_state = "rfid_set"
		desc = "A small chip with what looks like a capsule with a translucent, slightly blue colored liquid in the middle. The liquid appears to be swirling lazily and gives of the slightest of glows, only visible in almost absolute darkness."
		desc_lore = "The UACM using RFID chips as ways of tagging their crews for on-board AIs is fairly common practice. This chip utilizes a small amount of Liquid Data, which is a prototype solution implemented currently only on the PST. This one seems to have been set to someone's biometrics and is very likely to engage an alarm if pried apart from its designated dog tags for too long."
	if(!set_name)
		set_name = tgui_input_text (src, "Name not found. Setting:", "Name:", max_length = MAX_MESSAGE_LEN, timeout = 0)
		if(!set_name) return
	if(!set_rank)
		set_rank = tgui_input_text (src, "Rank not found. Setting:", "Rank:", max_length = MAX_MESSAGE_LEN, timeout = 0)
		if(!set_rank) return
	return
