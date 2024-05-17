/obj/item/modular/sealant
	name = "white NRPS sealant applicator tube"
	desc = "A metallic gray blue tube with a distinct applicator."
	desc_lore = "NRPS Compliant sealant is effectively a colored fast trying glue that exits the tube as a liquid rapidly filling the grooves between installed modular tiles and then immediately hardens, holding the tiles together. Thanks to a unique, proprietary blend developed in the Northern Republic, piercing the hardened sealant, and allowing more oxygenation makes the glue retract and detach from the tiles, at which point it can just be removed from the grooves and discarded."
	icon = 'icons/obj/items/sp_cargo.dmi'
	icon_state = "sealanttube_white"
	var/sealant_color = "white"
	flags_item = NOBLUDGEON

/obj/item/modular/sealant/black
	name = "black NRPS sealant applicator tube"
	icon_state = "sealanttube_black"
	sealant_color = "black"
