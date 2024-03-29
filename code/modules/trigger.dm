/obj/effect/step_trigger/message
	var/message //the message to give to the mob
	var/once = 1

/obj/effect/step_trigger/message/memorial
	message = "Please stand silently for a moment of reflection and respect. "
	once = 0

/obj/effect/step_trigger/message/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		to_chat(M, SPAN_INFO("[message]"))
		if(once)
			qdel(src)

/obj/effect/step_trigger/teleport_fancy
	var/locationx
	var/locationy
	var/uses = 1 //0 for infinite uses
	var/entersparks = 0
	var/exitsparks = 0
	var/entersmoke = 0
	var/exitsmoke = 0

/obj/effect/step_trigger/teleport_fancy/Trigger(mob/M)
	var/dest = locate(locationx, locationy, z)
	if(!M || !istype(M))
		return

	M.Move(dest)

	if(entersparks)
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(4, 1, src)
		s.start()
	if(exitsparks)
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(4, 1, dest)
		s.start()

	if(entersmoke)
		var/datum/effect_system/smoke_spread/s = new /datum/effect_system/smoke_spread
		s.set_up(2, 1, src, 0)
		s.start()
	if(exitsmoke)
		var/datum/effect_system/smoke_spread/s = new /datum/effect_system/smoke_spread
		s.set_up(2, 1, dest, 0)
		s.start()

	uses--
	if(uses == 0)
		qdel(src)

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

/obj/effect/step_trigger/message/seeonce/D31Ent

	trigger_id = "D31Ent"

/obj/effect/step_trigger/message/seeonce/D31Ent/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			M.saw_narrations.Add("[trigger_id]")
			to_chat(M, narrate_head("The Outer Veil Primary Supply Terminal - Dock 31"))
			to_chat(M, narrate_body("Dock 31 is quieter and cleaner than most space station docks you've seen. The first part, the relative quiet, stands out as space stations rarely do not squeak, creak and groan as part of their natural operation."))
			sleep(50)
			to_chat(M, narrate_body("You can't help but notice that a lot of the signs, insignia and other visual elements seem to have been applied recently. It would seem the whole area got a serious visual upgrade recently."))


/obj/effect/step_trigger/message/seeonce/Pinnacle

	trigger_id = "Pinnacle"

/obj/effect/step_trigger/message/seeonce/Pinnacle/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			M.saw_narrations.Add("[trigger_id]")
			to_chat(M, narrate_head("The Outer Veil Primary Supply Terminal - The Pinnacle Entrance Area"))
			to_chat(M, narrate_body("The Pinnacle of the PST continues to stand out in terms of how clean and untouched the station seems. It’s hard to tell if this is because the current layer of paint is fresh, or because the station is virtually unused."))
			sleep(50)
			to_chat(M, narrate_body("You notice that the rooms of the Pinnacle seem unusually tall and spacious, again something not typically done in space station architecture, where lavish spaces mean using up critical resources, both during production and maintenance."))


/obj/effect/step_trigger/message/seeonce/Dorms

	trigger_id = "Dorms"

/obj/effect/step_trigger/message/seeonce/Dorms/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			M.saw_narrations.Add("[trigger_id]")
			to_chat(M, narrate_head("The Outer Veil Primary Supply Terminal - Dorms, Deck 37"))
			to_chat(M, narrate_body("A rush of fresh, crisp air hits you as you step out of the elevator which immediately makes you feel somewhat uneasy. Supposedly, only the most lavish of the Corporate Arcologies of Mars can spare the expense in power and oxygen itself to afford something frivolous as climate control."))
			sleep(50)
			to_chat(M, narrate_body("And yet here it is. Fresh smelling, crisp, cold, pleasant air. It feels almost uncanny how such a small detail your years in the stars made you just assume is a given can gives you a very brief lasting, yet distinct moment of elation as your brain seems to react to the natural looking light and fresh air out its own accord."))

/obj/effect/step_trigger/message/seeonce/Crypt

	trigger_id = "Crypt"

/obj/effect/step_trigger/message/seeonce/Crypt/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			M.saw_narrations.Add("[trigger_id]")
			to_chat(M, narrate_head("Task Force 14 Hideout 007 - 'The Crypt'"))
			to_chat(M, narrate_body("You can tell almost immediately after stepping into the room - there was a fire here, possibly a while ago. Space station fires are extremely dangerous to their crews and if set on purpose, typically are considered one of the most hostile wartime actions one can take."))
			sleep(50)
			to_chat(M, narrate_body("For what it's worth, the traces of the fire have been covered up very well and someone clearly seems to be keeping this area clean. If you had to guess, you would say that most of the fire was centered around the bookcases scattered around the walls of this large living room-like area as you can see faint scorch marks on the walls."))
/obj/effect/step_trigger/message/seeonce/CryptInner

	trigger_id = "CryptInner"

/obj/effect/step_trigger/message/seeonce/CryptInner/Trigger(mob/M)
	if(!istype(M) || !M)
		return
	if(M.client)
		if(!("[trigger_id]" in M.saw_narrations))
			M.saw_narrations.Add("[trigger_id]")
			to_chat(M, narrate_head("The Testament of Sacrifice"))
			to_chat(M, narrate_body("The smell of burnt ozone, like the air after a thunderstorm, hits you almost immediately after you enter the chamber. This is the smell of Liquid Data and Crystalline, the medium used for FTL communications and the byproducts of Hyperspace travel, respectively."))
			sleep(50)
			to_chat(M, narrate_body("Sometimes these can be a sign of a serious malfunction, but considering the look of this area, it seems more likely you are near an LD systems cluster, a relay point used for receiving and sending FTL communications, or a similar machine."))
