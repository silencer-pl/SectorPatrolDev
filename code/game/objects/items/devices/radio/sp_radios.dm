/obj/item/device/encryptionkey/pst_standard
	name = "\improper UACM OV-PST encryption keys"
	icon_state = "binary_key"
	channels = list(RADIO_CHANNEL_ALMAYER = TRUE, RADIO_CHANNEL_COMMAND = TRUE)

/obj/item/device/encryptionkey/pst_extended
	name = "\improper UACM OV-PST command encryption keys"
	icon_state = "binary_key"
	channels = list(RADIO_CHANNEL_ALMAYER = TRUE, RADIO_CHANNEL_COMMAND = TRUE, RADIO_CHANNEL_HIGHCOM = TRUE)

/obj/item/device/radio/headset/uacm/pst_standard
	name = "radio headset"
	desc = "A simple speker and microphone, tuned into local radio channels."
	icon_state = "mcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/pst_standard)
	volume = RADIO_VOLUME_QUIET

/obj/item/device/radio/headset/uacm/pst_extended
	name = "radio headset"
	desc = "A simple speker and microphone, tuned into local radio channels."
	icon_state = "mcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/pst_extended)
	volume = RADIO_VOLUME_IMPORTANT
