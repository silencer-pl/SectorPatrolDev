

/client/proc/cmd_admin_select_mob_rank(var/mob/living/carbon/human/H in mob_list)
	set category = null
	set name = "Select Rank"
	if(!istype(H))
		alert("Invalid mob")
		return

	var/rank_list = list("Custom") + RoleAuthority.roles_by_name

	var/newrank = input("Select new rank for [H]", "Change the mob's rank and skills") as null|anything in rank_list
	if (!newrank)
		return
	if(!H || !H.mind)
		return
	var/obj/item/card/id/I = H.wear_id
	feedback_add_details("admin_verb","SMRK") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	if(newrank != "Custom")
		var/datum/job/J = RoleAuthority.roles_by_name[newrank]
		H.mind.role_comm_title = J.get_comm_title()
		H.mind.set_cm_skills(J.get_skills())
		if(istype(I))
			I.access = J.get_access()
			I.rank = J.title
			I.assignment = J.disp_title
			I.name = "[I.registered_name]'s ID Card ([I.assignment])"
			I.paygrade = J.get_paygrade()
	else
		var/newcommtitle = input("Write the custom title appearing on comms chat (e.g. Spc)", "Comms title") as null|text
		if(!newcommtitle)
			return
		if(!H || !H.mind)
			return

		H.mind.role_comm_title = newcommtitle

		if(!istype(I) || I != H.wear_id)
			to_chat(usr, "The mob has no id card, unable to modify ID and chat title.")
		else
			var/newchattitle = input("Write the custom title appearing in chat (e.g. SGT)", "Chat title") as null|text
			if(!newchattitle)
				return
			if(!H || I != H.wear_id)
				return

			I.paygrade = newchattitle

			var/IDtitle = input("Write the custom title on your ID (e.g. Squad Specialist)", "ID title") as null|text
			if(!IDtitle)
				return
			if(!H || I != H.wear_id)
				return

			I.rank = IDtitle
			I.assignment = IDtitle
			I.name = "[I.registered_name]'s ID Card ([I.assignment])"

		if(!H.mind)
			to_chat(usr, "The mob has no mind, unable to modify skills.")
		else
			var/newskillset = input("Select a skillset", "Skill Set") as null|anything in RoleAuthority.roles_by_name
			if(!newskillset)
				return

			if(!H || !H.mind)
				return

			var/datum/job/J = RoleAuthority.roles_by_name[newskillset]
			H.mind.set_cm_skills(J.get_skills())

/client/proc/cmd_admin_dress(var/mob/living/carbon/human/M in mob_list)
	set category = null
	set name = "Select Equipment"

	src.cmd_admin_dress_human(M)

/client/proc/cmd_admin_dress_human(var/mob/living/carbon/human/M in mob_list, var/datum/equipment_preset/dresscode, var/no_logs = 0)
	
	if (!no_logs)
		dresscode = input("Select dress for [M]", "Robust quick dress shop") as null|anything in gear_presets_list

	if(isnull(dresscode))
		return

	feedback_add_details("admin_verb","SEQ") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	for (var/obj/item/I in M)
		if (istype(I, /obj/item/implant))
			continue
		qdel(I)

	if(!ishuman(M))
		//If the mob is not human, we're transforming them into a human
		//To speed up the setup process
		M = M.change_mob_type( /mob/living/carbon/human , null, null, TRUE, "Human")
		if(!ishuman(M))
			to_chat(usr, "Something went wrong with mob transformation...")
			return

	arm_equipment(M, dresscode)
	M.regenerate_icons()
	if(!no_logs)
		log_admin("[key_name(usr)] changed the equipment of [key_name(M)] to [dresscode].")
		message_admins("<span class='notice'>[key_name_admin(usr)] changed the equipment of [key_name_admin(M)] to [dresscode].</span>", 1)
	return

/client/proc/cmd_admin_dress_all()
	set category = "Debug"
	set name = "Select Equipment - All Humans"
	set desc = "Applies an equipment preset to all humans in the world."

	var/datum/equipment_preset/dresscode = input("Select dress for ALL HUMANS", "Robust quick dress shop") as null|anything in gear_presets_list
	if (isnull(dresscode))
		return

	if(alert("Are you sure you want to change the equipment of ALL humans in the world to [dresscode]?",, "Yes", "No") == "No") return

	for(var/mob/living/carbon/human/M in mob_list)
		src.cmd_admin_dress_human(M, dresscode, 1)

	log_admin("[key_name(usr)] changed the equipment of ALL HUMANS to [dresscode].")
	message_admins("<span class='notice'>[key_name_admin(usr)] changed the equipment of ALL HUMANS to [dresscode].</span>", 1)

//note: when adding new dresscodes, on top of adding a proper skills_list, make sure the ID given has
//a rank that matches a job title unless you want the human to bypass the skill system.
/proc/arm_equipment(var/mob/living/carbon/human/M, var/dresscode, var/randomise = FALSE)
	if(!gear_presets_list)
		error("arm_equipment !gear_presets_list")
		return
	if(!gear_presets_list[dresscode])
		error("arm_equipment !gear_presets_list[dresscode]")
		return
	gear_presets_list[dresscode].load_preset(M, randomise)
	return
