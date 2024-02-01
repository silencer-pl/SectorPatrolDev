/datum/job/uacm/basepc
	title = JOB_UACM_BASEPC
	total_positions = 10
	spawn_positions = 10
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uacm/basepc
	entry_message_intro = "You are an UACM Comissioned Officer, currently assigned to the 2nd Logistics Division, under RDML Thomas Boulette."
	entry_message_body = "You have spent the last two weeks travelling on various UACM spaceships or waiting on UACM transfer stations to get to the Outer Veil Primary Supply Terminal, where you will be stationed for the duration of your assignment."
	entry_message_end = "For the last leg of your journey, you are rather last minute loaded onto a transit shuttle headed for the PST that was picking up cargo intended for the station. The officer operating the shuttle seemed somewhat surprised by your presence but nonetheless seemed happy to help. After about 20 minutes of flight, the shuttle abruptly stops and your pilot looks in frustration at her pilot console."
/obj/effect/landmark/start/basepc
	name = JOB_UACM_BASEPC
	icon_state = "so_spawn"
	job = /datum/job/uacm/basepc
