//UACM
/obj/item/clothing/under/marine/uacm/uniform_standard
	name = "\improper UACM comissioned officer uniform"
	desc = "A standard issue formal uniform meant for everyday use. An instantly recognizable classic, bound to turn heads for better or worse."
	desc_lore = "While the UACM is stepping up efforts to encourage all ship crews to adapt the color-coded jumpsuit style uniforms, many UACM personnel prefer these more formal feeling wear that matches their previous uniforms closer. Some go as far as to claim that they both feel and perform better in these, but it's hard to imagine why. If anything, it's the jumpsuits that are designed to improve their users long term fatigue levels."
	icon_state = "formal_jumpsuit"
	worn_state = "formal_jumpsuit"
	flags_atom = NO_NAME_OVERRIDE|NO_SNOW_TYPE
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE


/obj/item/clothing/under/marine/uacm/jumpsuit_engie
	name = "\improper UACM comissioned officer jumpsuit style uniform - engineering variant"
	desc = "A snug and warm looking jumpsuit style uniform in dark blue. A sign of trouble in the old days and of grit and determination in the new. "
	desc_lore = "Color coded, jumpsuit style uniforms are the UACM preferred choice and in a pinch of irony that is unsettlingly present across the new formation, the only UA formation that used anything close to a compatible system were the defunct Marines. Blue jumpsuits were associated with some of the most undisciplined and troublesome personnel, but also with some of the smartest people in the stars. The UACM is still hoping on retaining mostly the latter in the recruitment efforts, and while like most colonies and ships prefers the yellow color for Engineering objects, UACM engineering staff has almost uniformly opted for the dark blue shade of the current design. "
	icon_state = "mt_jumpsuit"
	worn_state = "mt_jumpsuit"
	flags_atom = NO_NAME_OVERRIDE|NO_SNOW_TYPE
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/uacm/cmisrs_inspector
	name = "\improper CMISRS office uniform"
	desc = "The 'office' variant of the CMISRS uniform, used by officers who work out of CMISRS capital ships and installations. Smoother and shinier than its field counterpart."
	desc_lore = "These black uniforms were originally used by the upper echelons of the USCMC law enforcement circles, infamous for both their zeal and tendency for gross overreach. While on paper, the CMISRS has inherited those duties, a lot of talented officers were recruited into the UAAC-TIS instead and it is that agency that currently is known more for its zeal and unforgiveness. Whether this is enough to counter the reputation the black and crimson has among UACM personel remains to be seen."
	icon_state = "tis"
	worn_state = "tis"
	flags_atom = NO_NAME_OVERRIDE|NO_SNOW_TYPE
	suit_restricted = list(
		/obj/item/clothing/suit/storage/marine/MP,
		/obj/item/clothing/suit/armor/riot/marine,
		/obj/item/clothing/suit/storage/jacket/marine/provost,
	)
