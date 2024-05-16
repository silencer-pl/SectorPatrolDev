/datum/job/uacm/basepc
	title = JOB_UACM_BASEPC
	total_positions = -1
	spawn_positions = -1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uacm/basepc
	entry_message_intro = "You are an UACM Comissioned Officer, currently assigned to the 2nd Logistics Division, under RDML Thomas Boulette."
	entry_message_body = "Sometime in the last few days you have arrived at the headquarters of your new assignment - the Outer Veil Primary Supply Terminal, a massive, sprawling logistics station. "
	entry_message_end = "Whether you arrived days or minutes ago, the official version is that due to an unspecified security issue, the station is under strict lockdown. Regardless of your involvement with the issues on the station, like the other members of the Test Crews that have arrived on station, you are currently under lockdown in what is supposed to be your future dorm."
/obj/effect/landmark/start/basepc
	name = JOB_UACM_BASEPC
	icon_state = "so_spawn"
	job = /datum/job/uacm/basepc
