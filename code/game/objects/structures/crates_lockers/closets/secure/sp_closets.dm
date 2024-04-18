//UACM Standarized Security Layers
//General Red Locker
/obj/structure/closet/secure_closet/sp/red/
	name = "red locker"
	desc = "A red locker with a simple electronic locking mechanism. It does not seem to have any labels or other identifying information on it."
	desc_lore = "Lockers with no specific access rights are convenient ways of temporarily storing things, but not something one would mind losing. Most space faring humans assume that if something is stored in a generally accessible locker like this, it is for anyone to use as needed."
	icon_state = "red_nolabel_unlocked"
	icon_closed = "red_nolabel_unlocked"
	icon_locked = "red_nolabel_locked"
	icon_opened = "red_nolabel_open"
	icon_broken = "red_nolabel_broken"
	icon_off = "red_nolabel_closed"

//Class D Red Locker

/obj/structure/closet/secure_closet/sp/red/d01
	name = "red locker - D class"
	desc = "A red locker with a simple electronic locking mechanism."
	desc_lore = "Lockers with specific access classes typically contain spare, extra or non-standard gear related to duties that involve having the appropriate clearance level. The letter D indicates security Class D, indicating its function is related to law enforcement or security on board UACM ships and installations."
	req_access = list(ACCESS_SP_OVPST_SECURITY_DEFAULT)
	icon_state = "red_class_d_unlocked"
	icon_closed = "red_class_d_unlocked"
	icon_locked = "red_class_d_locked"
	icon_opened = "red_class_d_open"
	icon_broken = "red_class_d_broken"
	icon_off = "red_class_d_closed"

/obj/structure/closet/secure_closet/sp/red/d01/wall
	name = "red wall or floor mounted container - D class"
	desc = "A small container mounted in a special slot inside a wall or floor. Not easilly moved or accessed without the proper authorization."
	desc_lore = "Containers like this, sometimes called 'safes' although they dont always come with added security measures, are typically used for storage of mundane gear, documents and small personal items near workstations and stationary posts. A 'D' security class indicates that this locker contains something related to law enforcement or security on board UACM ships and installations."
	icon_state = "safe_red_class_d_unlocked"
	icon_closed = "safe_red_class_d_unlocked"
	icon_locked = "safe_red_class_d_locked"
	icon_opened = "safe_red_class_d_open"
	icon_broken = "safe_red_class_d_broken"
	icon_off = "safe_red_class_d_closed"
	density = FALSE
	store_mobs = FALSE
	wall_mounted = TRUE
	plane = FLOOR_PLANE

/obj/structure/closet/secure_closet/sp/red/d01/wall/d31chips

	desc = "A small container mounted in a special slot inside a wall or floor. Not easilly moved or accessed without the proper authorization."
	icon_state = "safe_red_class_d_locked"
	locked = 1
	plane = GAME_PLANE

/obj/structure/closet/secure_closet/sp/red/d01/wall/d31chips/Initialize()
	. = ..()
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)
	new /obj/item/device/uacmrfid/(src)

//Yellow lockers

/obj/structure/closet/secure_closet/sp/yellow/
	name = "yellow locker"
	desc = "A yellow locker with a simple electronic locking mechanism. It does not seem to have any labels or other identifying information on it."
	desc_lore = "Lockers with no specific access rights are convenient ways of temporarily storing things, but not something one would mind losing. Most space faring humans assume that if something is stored in a generally accessible locker like this, it is for anyone to use as needed."
	icon_state = "yellow_nolabel_unlocked"
	icon_closed = "yellow_nolabel_unlocked"
	icon_locked = "yellow_nolabel_locked"
	icon_opened = "yellow_nolabel_open"
	icon_broken = "yellow_nolabel_broken"
	icon_off = "yellow_nolabel_closed"

//G Class
/obj/structure/closet/secure_closet/sp/yellow/g01

	name = "yellow locker - Class G"
	desc = "A yellow locker with a simple electronic locking mechanism."
	desc_lore = "Lockers with specific access classes typically contain spare, extra or non-standard gear related to duties that involve having the appropriate clearance level. The letter G indicates that this is a general access locker, most likely containing gear required to perform service or engineering task on nearby equipment that does not require any extra certifications or qualifications."
	req_access = list(ACCESS_SP_OVPST_GENERAL_DEFAULT)
	icon_state = "yellow_class_g_unlocked"
	icon_closed = "yellow_class_g_unlocked"
	icon_locked = "yellow_class_g_locked"
	icon_opened = "yellow_class_g_open"
	icon_broken = "yellow_class_g_broken"
	icon_off = "yellow_class_g_closed"

/obj/structure/closet/secure_closet/sp/yellow/g01/engiebasics

/obj/structure/closet/secure_closet/sp/yellow/g01/engiebasics/Initialize()
	. = ..()
	new /obj/item/storage/toolbox/uacm/genericengie(src)
	new /obj/item/storage/toolbox/uacm/genericengie(src)
	new /obj/item/storage/toolbox/uacm/genericengie(src)
	new /obj/item/device/flashlight/uacm
	new /obj/item/device/flashlight/uacm
	new /obj/item/device/flashlight/uacm
	new /obj/item/device/flashlight/uacm
	new /obj/item/device/flashlight/uacm
