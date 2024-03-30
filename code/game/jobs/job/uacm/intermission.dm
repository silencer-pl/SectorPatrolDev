/datum/job/uacm/basepc
	title = JOB_UACM_BASEPC
	total_positions = 10
	spawn_positions = 10
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uacm/basepc
	entry_message_intro = "You are an UACM Comissioned Officer, currently assigned to the 2nd Logistics Division, under RDML Thomas Boulette."
	entry_message_body = "You have spent the last two weeks travelling on various UACM spaceships or waiting on UACM transfer stations to get to the Outer Veil Primary Supply Terminal, where you will be stationed for the duration of your assignment."
	entry_message_end = "As you are rather urgently loaded onto a transit shuttle for the last leg of your journey, the ship you are on is intercepted by the UAS Persephone. After some commotion, some extra cargo is loaded onto your shuttle and the crafts pilot is replaced with what looks like an UAAC-TIS Commander that some of you may recognize. The shuttle seems to have been adrift in space for a good ten minutes now as the Commander just glares at her pilot's console."
/obj/effect/landmark/start/basepc
	name = JOB_UACM_BASEPC
	icon_state = "so_spawn"
	job = /datum/job/uacm/basepc
