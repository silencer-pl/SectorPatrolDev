/obj/effect/step_trigger/message/seeonce
	var/trigger_id = ""
	once = null

/obj/effect/step_trigger/message/seeonce/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			to_chat(M, narrate_body("[message]"))
			M.saw_narrations.Add("[trigger_id]")
			if(once)
				qdel(src)

//Location Blurbs

/obj/effect/step_trigger/message/seeonce_blurb/
	var/trigger_id = "default"
	var/trigger_text = "default trigger text" // Use \n for new lines, single character html tags will work as well, see show_blurb() comments for full info

/obj/effect/step_trigger/message/seeonce_blurb/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			M.saw_narrations.Add("[trigger_id]")
			var/mobs = list(M)
			show_blurb(mobs, duration = 10 SECONDS, message = "[trigger_text]", screen_position = "CENTER,BOTTOM+1.5:16", text_alignment = "center", text_color = "#ffaef2", blurb_key = "[trigger_id]", ignore_key = FALSE, speed = 1)

//Sector Patrol Area Entry Blurbs

/obj/effect/step_trigger/message/seeonce_blurb/Dock31
	trigger_id = "Dock31"
	trigger_text = "<b>The Outer Veil Primary Supply Terminal\nDock 31</b>\nA quiet and clean entryway into the PST.\nReserved for Test Crew members."

/obj/effect/step_trigger/message/seeonce_blurb/Pinnacle
	trigger_id = "Pinnacle"
	trigger_text = "<b>The Outer Veil Primary Supply Terminal\nThe Pinnacle</b>\nThe topmost level of the PST.\nA place to find your way."

/obj/effect/step_trigger/message/seeonce_blurb/Dorms
	trigger_id = "Dorms"
	trigger_text = "<b>The Outer Veil Primary Supply Terminal\nDorms, Deck 37</b>\nFresh, cool air and artificial sunlight.\nHome."

/obj/effect/step_trigger/message/seeonce_blurb/Hideaway
	trigger_id = "Hideaway"
	trigger_text = "<b>The Outer Veil Primary Supply Terminal\nThe Hideaway, Deck 38</b>\nAn old Task Force 14 hideout.\nA place to relax and look back."

/obj/effect/step_trigger/message/seeonce_blurb/Testament
	trigger_id = "Testament"
	trigger_text = "<b>The Outer Veil Primary Supply Terminal\nMUP #03-Upsilon, Deck 38<b>\nGateway to the heart of the station.\nA testament of sacrifice."

//Sector Patrol event specifc

/obj/effect/step_trigger/message/seeonce/D31Scn2

	trigger_id = "D31Entrance"

/obj/effect/step_trigger/message/seeonce/D31Scn2/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			M.saw_narrations.Add("[trigger_id]")
			to_chat(M, narrate_body("The scanner hums around you. For a moment you feel slightly disoriented."))
			sleep(30)
			if (M.client.prefs.chargen_birthright == "[CHARGEN_BIRTHRIGHT_EARTH]")
				to_chat(M, narrate_body("For a split second, you see the slowly reclaimed, barren landscapes of Earth and its overcrowded megacities. The crowds of Earth and their constant chattering feels warm and comforting somehow. The sensation passes as quickly as it comes."))
			if (M.client.prefs.chargen_birthright == "[CHARGEN_BIRTHRIGHT_LUNA]")
				to_chat(M, narrate_body("For a split second, you see the halls of the learning institutions on Luna. You feel elated by the amount of raw knowledge and thought produced here. The sensation passes as quickly as it comes."))
			if (M.client.prefs.chargen_birthright == "[CHARGEN_BIRTHRIGHT_MARS]")
				to_chat(M, narrate_body("For a split second, you find yourself in one of the largest of Mars' Arcologies, surrounded by the bustle of corporate work. The order and direction of the Corporate Standard feels familiar and comforting. The sensation passes as quickly as it comes."))
			if (M.client.prefs.chargen_birthright == "[CHARGEN_BIRTHRIGHT_JUPITER]")
				to_chat(M, narrate_body("For a split second, you see the forges of Jupiter. In the distance, new forges are being built, something unseen in the last few decades. The chaos of the activity here feels refreshing. The sensation passes as quickly as it comes."))
			if (M.client.prefs.chargen_birthright == "[CHARGEN_BIRTHRIGHT_INNERRIM]")
				to_chat(M, narrate_body("For a split second, you find yourself among the bruised and traumatized colonists of the Inner Rim. The Colony Wars still linger here. The silence seems soothing, despite everything that has happened here. The sensation passes as quickly as it comes."))
			if (M.client.prefs.chargen_birthright == "[CHARGEN_BIRTHRIGHT_VEIL]")
				to_chat(M, narrate_body("For a split second, you see a diagram of the Neroid Sector, with multiple vectors converging onto it from all sides. It feels like everyone's eyes are on the Sector right now, which is both exciting and concerning. The sensation passes as quickly as it comes."))
			if (M.client.prefs.chargen_birthright == "[CHARGEN_BIRTHRIGHT_OUTERRIM]")
				to_chat(M, narrate_body("For a split second, you peer into the blackness of deep space. Something moves into the abyss, it feels wrong. It feels like both a familiar, friendly presence and something else lingers somewhere out there, beyond light. The sensation passes as quickly as it comes."))
			M.saw_narrations.Add("[trigger_id]")
