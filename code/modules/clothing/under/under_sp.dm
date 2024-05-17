/obj/item/clothing/under/sp_personal/
//	name = "civilian clothing master item"
	desc = "A body conforming layer of light, breathable fabric that is surprisingly warm when worn. Upon closer inspection, the material seems to be softer and retains shapes more than you'd expect. Most accents seem to be made using a colored, hardened resin."
	desc_lore = "Suits, uniforms, jumpsuits, whatever you call them, your basic layer of clothing - be it a skirt and/or shorts complimented by socks, a jumpsuit or pants and a shirt - is something you will likely be wearing a lot during your time in space. As such, they are often made from light and durable fabrics. The PST polymer and resin equivalent feels a bit more spongy than typical clothes of this type, but in turn tend to be both more comfortable and easier to wash. Even if it should tear, recycling and remaking the exact same garment is a matter of pushing a single button and waiting a few minutes."
	customizable = 1
	name = "colonist jumpsuit"
	icon_state = "colonist"
	icon = 'icons/obj/sp_clothes/under/icon/under.dmi'
//	icon_state = ""
	item_icons = list(
		WEAR_BODY = 'icons/obj/sp_clothes/under/onmob/under.dmi'
	)
	var/openable
	var/openable_open

// Objects with rollable sleeves

/obj/item/clothing/under/sp_personal/verb/open_jacket()
	set category = "Object"
	set name = "Roll up extremities"
	set src in usr
	if(!usr.is_mob_incapacitated())
		switch (openable)
			if ("sleeves")
				src.openable_open = !src.openable_open
				if(src.openable_open)
					icon_state = "[initial(icon_state)]_d"
					to_chat(usr, SPAN_INFO("You roll up your sleeves. You certainly mean business now, also your clothes are less likely to get dirty."))
				else
					icon_state = "[initial(icon_state)]"
					to_chat(usr, "You roll down the sleeves, then smmooth out some of the wrinkles on the clothes a bit.")
				update_clothing_icon() //so our mob-overlays update
			if ("sleevesskirt")
				src.openable_open = !src.openable_open
				if(src.openable_open)
					icon_state = "[initial(icon_state)]_d"
					to_chat(usr, SPAN_INFO("You roll up your sleeves and skirt. You certainly mean business now, also your clothes are less likely to get dirty."))
				else
					icon_state = "[initial(icon_state)]"
					to_chat(usr, "You roll down the sleeves and skirt, then smmooth out some of the wrinkles on the clothes a bit.")
				update_clothing_icon() //so our mob-overlays update
			else
				to_chat(usr, SPAN_NOTICE("The extremities on these clothes can't be rolled up wihtout tearing them."))

// The Greyshirt.

//obj/item/clothing/under/sp_personal/baseunder/colonist
//	name = "colonist jumpsuit"
//	icon_state = "colonist"

// No rollable icons

/obj/item/clothing/under/sp_personal/baseunder/liaison_regular
	name = "corporate light brown suit jacket"
	icon_state = "liaison_regular"

/obj/item/clothing/under/sp_personal/baseunder/liaison_suspenders
	name = "corporate shirt with suspenders"
	icon_state = "liaison_suspenders"

/obj/item/clothing/under/sp_personal/baseunder/liaison_outing
	name = "corporate light brown outing jacket"
	icon_state = "liaison_outing"

/obj/item/clothing/under/sp_personal/baseunder/liaison_formal
	name = "corporate tan suit jacket"
	icon_state = "liaison_formal"

/obj/item/clothing/under/sp_personal/baseunder/liaison_outing_red
	name = "corporate outing jacket with red shirt"
	icon_state = "liaison_outing_red"

/obj/item/clothing/under/sp_personal/baseunder/liaison_charcoal
	name = "corporate charcoal suit jacket"
	icon_state = "liaison_charcoal"

/obj/item/clothing/under/sp_personal/baseunder/synth_cargo_light
	name = "shirt and cargo pants"
	icon_state = "synth_cargo_light"

/obj/item/clothing/under/sp_personal/baseunder/trainee_uniform
	name = "light brown suit vest"
	icon_state = "trainee_uniform"

/obj/item/clothing/under/sp_personal/baseunder/manager_uniform
	name = "blue suit vest"
	icon_state = "manager_uniform"

/obj/item/clothing/under/sp_personal/baseunder/twe_suit
	name = "light blue suit vest"
	icon_state = "twe_suit"

/obj/item/clothing/under/sp_personal/baseunder/red_suit
	name = "red suit vest"
	icon_state = "red_suit"

/obj/item/clothing/under/sp_personal/baseunder/detective2
	name = "black suit vest"
	icon_state = "detective2"

/obj/item/clothing/under/sp_personal/baseunder/base
	name = "steel blue jumpsuit"
	icon_state = "base"

/obj/item/clothing/under/sp_personal/baseunder/lightred
	name = "light red jumpsuit"
	icon_state = "lightred"

/obj/item/clothing/under/sp_personal/baseunder/darkred
	name = "dark red jumpsuit"
	icon_state = "darkred"

/obj/item/clothing/under/sp_personal/baseunder/yellow
	name = "yellow jumpsuit"
	icon_state = "yellow"

/obj/item/clothing/under/sp_personal/baseunder/black
	name = "black jumpsuit"
	icon_state = "black"

/obj/item/clothing/under/sp_personal/baseunder/white
	name = "white jumpsuit"
	icon_state = "white"

/obj/item/clothing/under/sp_personal/baseunder/pink
	name = "pink jumpsuit"
	icon_state = "pink"

/obj/item/clothing/under/sp_personal/baseunder/green
	name = "green jumpsuit"
	icon_state = "green"

/obj/item/clothing/under/sp_personal/baseunder/blue
	name = "blue jumpsuit"
	icon_state = "blue"

/obj/item/clothing/under/sp_personal/baseunder/lightbrown
	name = "light brown jumpsuit"
	icon_state = "lightbrown"

/obj/item/clothing/under/sp_personal/baseunder/brown
	name = "brown jumpsuit"
	icon_state = "brown"

/obj/item/clothing/under/sp_personal/baseunder/grey
	name = "grey jumpsuit"
	icon_state = "grey"

/obj/item/clothing/under/sp_personal/baseunder/tshirt_w_br
	name = "white t-shirt with brown pants"
	icon_state = "tshirt_w_br"

/obj/item/clothing/under/sp_personal/baseunder/tshirt_gray_blu
	name = "gray t-shirt with blue pants"
	icon_state = "tshirt_gray_blu"

/obj/item/clothing/under/sp_personal/baseunder/tshirt_r_bla
	name = "red t-shirt with black pants"
	icon_state = "tshirt_r_bla"

/obj/item/clothing/under/sp_personal/baseunder/psychturtle
	name = "cyan turtleneck"
	icon_state = "psychturtle"

/obj/item/clothing/under/sp_personal/baseunder/syndicate
	name = "black 'tactical' turtleneck"
	icon_state = "syndicate"

/obj/item/clothing/under/sp_personal/baseunder/charcoal_suit
	name = "charcoal suit"
	icon_state = "charcoal_suit"

/obj/item/clothing/under/sp_personal/baseunder/navy_suit
	name = "navy suit"
	icon_state = "navy_suit"

/obj/item/clothing/under/sp_personal/baseunder/burgundy_suit
	name = "burgundy suit"
	icon_state = "burgundy_suit"

/obj/item/clothing/under/sp_personal/baseunder/checkered_suit
	name = "checkered suit"
	icon_state = "checkered_suit"

/obj/item/clothing/under/sp_personal/baseunder/tan_suit
	name = "tan suit"
	icon_state = "tan_suit"

/obj/item/clothing/under/sp_personal/baseunder/black_suit_fem
	name = "loosened black suit"
	icon_state = "black_suit_fem"

/obj/item/clothing/under/sp_personal/baseunder/blueskirt
	name = "blue shirt with black skirt"
	icon_state = "blueskirt"

/obj/item/clothing/under/sp_personal/baseunder/redskirt
	name = "red shirt with black skirt"
	icon_state = "redskirt"

/obj/item/clothing/under/sp_personal/baseunder/purpleskirt
	name = "purple shirt with black skirt"
	icon_state = "purpleskirt"

/obj/item/clothing/under/sp_personal/baseunder/blackskirt
	name = "black suit blazer with red skirt"
	icon_state = "blackskirt"

/obj/item/clothing/under/sp_personal/baseunder/teal_gown
	name = "teal cocktail dress"
	icon_state = "teal_gown"

/obj/item/clothing/under/sp_personal/baseunder/wine_gown
	name = "wine cocktail dress"
	icon_state = "wine_gown"

/obj/item/clothing/under/sp_personal/baseunder/midnight_gown
	name = "midnight cocktail dress"
	icon_state = "midnight_gown"

// Rollable sleeves

/obj/item/clothing/under/sp_personal/baseunder/marshal
	name = "blue formal shirt and tie"
	icon_state = "marshal"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/polsuit
	name = "white formal shirt and tie"
	icon_state = "polsuit"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/synth_yellow_utility
	name = "yellow utility jumpsuit"
	icon_state = "synth_yellow_utility"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/synth_blue_utility
	name = "blue utility jumpsuit"
	icon_state = "synth_blue_utility"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/synth_red_utility
	name = "red utility jumpsuit"
	icon_state = "synth_red_utility"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/synth_green_utility
	name = "green utility jumpsuit"
	icon_state = "synth_green_utility"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/ua_civvies
	name = "blue shirt and pants"
	icon_state = "ua_civvies"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/wy_davisone
	name = "brown shirt and pants"
	icon_state = "wy_davisone"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/wy_joliet_shopsteward
	name = "light brown shirt and pants"
	icon_state = "wy_joliet_shopsteward"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/corporate_field
	name = "dark blue shirt and pants"
	icon_state = "corporate_field"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/corporate_ivy
	name = "light blue shirt and pants"
	icon_state = "corporate_ivy"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/corporate_formal
	name = "shirt and light gray pants"
	icon_state = "corporate_formal"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/corporate_black
	name = "shirt and black pants"
	icon_state = "corporate_black"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/corporate_brown
	name = "shirt and brown pants"
	icon_state = "corporate_brown"
	openable = "sleeves"

/obj/item/clothing/under/sp_personal/baseunder/corporate_blue
	name = "shirt and light blue pants"
	icon_state = "corporate_formal"
	openable = "sleeves"

//rollable sleeves and skirts

/obj/item/clothing/under/sp_personal/baseunder/plaid_red
	name = "white jacket with plaid red skirt"
	icon_state = "plaid_red"
	openable = "sleevesskirt"

/obj/item/clothing/under/sp_personal/baseunder/plaid_blue
	name = "white jacket with plaid blue skirt"
	icon_state = "plaid_blue"
	openable = "sleevesskirt"

/obj/item/clothing/under/sp_personal/baseunder/plaid_purple
	name = "white jacket with purple red skirt"
	icon_state = "plaid_purple"
	openable = "sleevesskirt"

/obj/item/clothing/under/sp_personal/baseunder/plaid_green
	name = "white jacket with plaid green skirt"
	icon_state = "plaid_green"
	openable = "sleevesskirt"

// admeme

/obj/item/clothing/under/sp_admin/
	name = "crimson-black dress"
	desc = "A high-quality, deep red dress that seems to naturally shimmer in the dark."
	desc_lore = "We didn't realize what exactly the Commanders being partially native to Liquid Data streams meant until Alysia designed a dress for Cassandra with by just musing about it in her spare time. This dress was designed from the ground up to fit Cassandra's body and even changes between recycling to adapt to any changes. This is direct editing of Liquid Data streams at an unprecedented rate and that wasn't even all of it."
	icon = 'icons/obj/sp_clothes/admin/icon/sp_clothes.dmi'
	icon_state = "cass_dress"
	item_icons = list(
		WEAR_BODY = 'icons/obj/sp_clothes/admin/onmob/sp_clothes.dmi'
	)

/obj/item/clothing/under/sp_admin/aly
	name = "purple-pulse dress"
	desc = "A high-quality purple dress that seems to naturally shift between different shades independently of other conditions."
	desc_lore = "We knew that they could just program LD data streams, but the realization that Crystalline emitted from their 'implants' came as a shock to everyone. Cassandra would just flick a tear onto a Textile Printer and that was enough to copy that purple design wedding anniversary gift of hers regardless of the device in question being LD enabled or not. This was not regular Crystalline behavior; the question then is what changed. Was the Commander controlling the streams consciously and not telling us, or was there perhaps something else about Liquid Data we didn't understand? "
	icon_state = "aly_dress"
