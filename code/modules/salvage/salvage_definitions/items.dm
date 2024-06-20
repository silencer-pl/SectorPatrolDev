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
	icon = 'icons/sectorpatrol/salvage/items/document.dmi'
	icon_state = "document"
	salvage_search = list(		//Main search list, has all the basic data, plus default return/reexamine texts. This is the var that is read for all text/functions of the searching system. Ideally this list should not be touched.
		"can_be_searched" = 0,
		"was_searched" = 0,
		"search_time" = SEARCH_TIME_NORMAL,
		"search_return_initial" = "There is nothing of note written in this document.",
		"search_return_complete" = "There is nothing of note written in this document."
		)
	salvage_search_alttext = list( //Alttexts for specific steps/results of searches. Copy the whole bock to customize.
		"search_return_initial" = "While scanning the document, you clearly find a note saying 'DO NOT RECYCLE' in red marker. This must be one of the Commander's 'intel' files. You mark the note and put the file to the side.",
		"search_return_complete" = "A 'DO NOT RECYCLE' note in red marker is circled in the document."
		)

/obj/item/salvage/document/random
	icon_state_max = 25
	salvage_random = 1
	pixel_randomize = 1
