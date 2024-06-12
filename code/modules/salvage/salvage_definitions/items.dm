//documents, randmizes chance to be intel using general formula (5% to be intel + 15% to be dud)

/obj/item/salvage/document
	name = "document"
	desc = "Information in written form on a piece of paper. Still the most common way of indirect communication in the galaxy. "
	desc_lore = "While the method of producing paper has evolved and currently papers are way more likely to be made from specially prepared resins that notably do not rely on organic matter in any form, the actual use remains the same - you put a writing medium to the surface to create words or pictures. Simple, yet effective. "
	salvage_contents = list(
	"metal" = 0,
	"resin" = 5,
	"alloy" = 0,
	)
	icon_state = "document"
	icon_state_max = 25
	salvage_random = 1
