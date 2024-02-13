#define SEARCH_TIME_SHORT 50
#define SEARCH_TIME_NORMAL 150
#define SEARCH_TIME_LONG 250
/obj/structure/searchable
	name = "Base item for searchable interactions."
	desc = "Hello there! If you are in game then soemome f... Uh... You know."
	icon = 'icons/obj/structures/sp_searchable.dmi'
	icon_state = "default"
	var/searchable_step = 0

// This exists mostly so that serchable items have their own tree and base item reference and possibly generic messages down the line, but as other event centric stuff,specifc defines should be put in respective event dms.
