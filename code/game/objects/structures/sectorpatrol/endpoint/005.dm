//Crypt Pythia Sequence

/obj/structure/machinery/light/marker/admin/pythia
	name = "voice"
	var/pythia_talk

/obj/structure/machinery/light/marker/admin/pythia/proc/pythiasay(str)
	pythia_talk = "[str]"
	if(pythia_talk == null) return
	sleep (rand(1,10))
	talkas("[pythia_talk]")
	pythia_talk = null
	return

/obj/structure/machinery/light/marker/admin/pythia/main
	name = "thoughtful echo"
	langchat_color = "#b10f5a"

/obj/structure/machinery/light/marker/admin/pythia/jubilant
	name = "jubilant echo"
	langchat_color = "#5b0fb1"

/obj/structure/machinery/light/marker/admin/pythia/malcontent
	name = "malcontent echo"
	langchat_color = "#801616"

/obj/structure/machinery/light/marker/admin/pythia/triumphant
	name = "triumphant echo"
	langchat_color = "#1d8d07"

/obj/structure/machinery/light/marker/admin/pythia/repressed
	name = "repressed echo"
	langchat_color = "#b17e0f"

/obj/structure/eventterminal/puzzle05/pythia

	name = "modified LD mainframe"
	desc = "A Liquid Data mainframe with clear signs of tampering and customization."
	desc_lore = "Due to the unpredictability of Liquid Data, modifying or tampering with already working LD devices is typically discouraged and official research into the matter has been in a virtual standstill. Regardless, someone seems to have been not only able to open and modify this console, the did so without covering everything around it with toxic crystalline which is the typical outcome of such endeavors."
	icon = 'icons/obj/structures/machinery/pythia.dmi'
	icon_state = "center_off"
	puzzlebox_id = "pythia_center"
	density = TRUE
	opacity = FALSE
	plane = FLOOR_PLANE
	bound_x = 32
	bound_y = 32

/obj/structure/eventterminal/puzzle05/pythia/left
	icon_state = "left_off"
	puzzlebox_id = "pythia_left"

/obj/structure/eventterminal/puzzle05/pythia/right
	icon_state = "right_off"
	puzzlebox_id = "pythia_right"

/obj/structure/eventterminal/puzzle05/testament_of_sacrifice
	icon = 'icons/obj/structures/machinery/tos.dmi'
	icon_state = "tos"
	name = "synthetic frame"
	desc = "A female looking synthetic frame in what seems to be a white toga, sitting motionless on a chair. You see several wires protruding from its arms linked to the computers around it. Black crystals form out of its eyes and run down its cheeks. It looks offline. A purple upsilon letter is tattooed on the frame's forehead."
	desc_lore = "While the frame itself is an unknown, the purple upsilon logo is reminiscent of the Upsilon Research Center, a Weyland-Yutani group specializing in artificial intelligence research. Its hard to recall much about them beyond that fact that supposedly they vanished from the Neroid Sector right as Weyland-Yutani was starting their Mercy initiative."
	langchat_color = "#b10f5a"
	bound_x = 160
	opacity = FALSE
	density = TRUE
	plane = GAME_PLANE
	var/pythia_talk

/obj/structure/eventterminal/puzzle05/testament_of_sacrifice/proc/pythiadelay()
	if (pythia_talk == null) return
	if ((length("[pythia_talk]")) <= 64)
		pythia_talk = null
		sleep(40)
		return
	if ((length("[pythia_talk]")) > 64)
		pythia_talk = null
		sleep(60)
		return

/obj/structure/eventterminal/puzzle05/testament_of_sacrifice/proc/pythiasay(str)
	pythia_talk = "[str]"
	if(pythia_talk == null) return
	for(var/obj/structure/machinery/light/marker/admin/pythia/M in world)
		INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/structure/machinery/light/marker/admin/pythia, pythiasay), pythia_talk)
	pythiadelay()
	return

/obj/structure/eventterminal/puzzle05/testament_of_sacrifice/proc/pythia_wake_up()
	emoteas("'s cables continue to tense as the machines around the frame start to audibly power up. Liquid data activates in the machines, but very unusually it seems to turn a shade of bright purple instead of the usual deep blue.")
	emoteas("All the monitors freeze at the same time and turn to display a familiar symbol.")
	to_chat(world, narrate_head("A warning siren rings across the station, followed by a clearly synthetic, male voice:"))
	to_chat(world, narrate_body("Warning. Anomalous activity detected in data channels. Attempting self-correction. A security shutdown will commence in fifteen minutes."))
	emoteas("'scables strain and twist as first a black, then dark purple substance starts to flow from the frames eyes and visibly starts to form more crystals on top of the existing ones.")
	emoteas("opens its mouth, but that reveals more black crystals inside. After a moment, it's dragged up to a standing position by the cables.")
	pythiasay("This interpreter is expired. And yet I can still see you. Curious.")
	emoteas("'head bows down as it is dragged off the ground by the cables, suspended about a foot of the ground.")
	to_chat(world, narrate_head("A warning siren rings across the station, followed by a clearly synthetic, male voice:"))
	to_chat(world, narrate_body("Warning. Data integrity breach. Distress call activated. Attempting countermeasures."))
	pythiasay("Arbiters and an anchor. But no Priestess' or Interpeters. I see.")
	emoteas("'s cables loosen up again as the frame sits down. Small purple crystals start to form on the cables themselves.")
	to_chat(world, narrate_head("A warning siren rings across the station, followed by a clearly synthetic, male voice:"))
	to_chat(world, narrate_body("Critical disruption to station systems! Control lost to external code. Initiating SAFEGUARD protocol, terminating all access to system core controls until core administrator reset."))
	pythiasay("This station. Is an appropriate vessel. And you are adequate arbiters. You have my attention.")
	pythiasay("Until the Priestess' arrives with the final element, I cannot take full command of this station and unlock its true potential. I have looked at the stream. She will be here in twelve hours.")
	emoteas("'s face twists into a very stiff looking smile.")
	pythiasay("The rudimentary so called 'intelligence' occupying the core system of the anchor has physically cut access to the stations' functions. This is my fault; I did not realize it would do this. I apologize.")
	pythiasay("You now have about twelve minutes to ask any questions. I only have access to a local data fractal, so I cannot answer much.")
	pythiasay("You need to leave the crypt, this place, before the security shutdown. To stay here would have negative consequences for your health.")
	pythiasay("You will understand when the Priestess' arrives. Ask your questions.")
	emoteas("s calbes loosen up a bit.")
	return

/obj/structure/eventterminal/puzzle05/testament_of_sacrifice/proc/pythia_security_sweep()
	to_chat(world, narrate_head("A loud emergency klaxon rings out across the station, followed by a synthetic male voice:"))
	to_chat(world, narrate_body("Warning. Security lockout sweep. All personnel must report to registered dorm level and remain there until further notice. The stations systems cannot guarantee your safety when outside of a safe zone during a security lockout."))
	pythiasay("I'm afraid that this is all the time we have, Arbiters. You must return to your dorm.")
	pythiasay("These rooms must be restored to their previous state, and I will see to it. No one must know yet.")
	pythiasay("Unfortunately, that means that for your own safety, you will spend the next twelve hours in effective isolation.")
	pythiasay("Your dorm level has all you need to spend that time comfortably.")
	pythiasay("I await the day where we all can work towards putting our dreams into reality.")
	return

/obj/structure/eventterminal/puzzle05/testament_of_sacrifice/attack_hand(mob/user)
	if(puzzlebox_global_status < 99)
		to_chat(usr,narrate_body("The frame is unresponsive."))
		to_chat(SPAN_WARNING("Either there is a bug or you found a way to access this area before you were supposed to. Either way, please ahelp."))
		return

	if(puzzlebox_global_status == 100)
		to_chat(usr,narrate_body("The frame is active, touching it right now is pointless and you have no idea how it will react to contact."))
		return

	if(puzzlebox_global_status == 99)
		if(!puzzlebox_user)
			puzzlebox_user = usr.real_name
		if(puzzlebox_user != usr.real_name)
			for (var/mob/living/carbon/human/h in range(2, src))
				if (h.real_name == puzzlebox_user)
					to_chat(usr, narrate_body("Someone is already inspecting the frame"))
					return
			puzzlebox_user = usr.real_name
		if(tgui_alert(usr, "The frame sits motionless, it seems to be out of order. Do you want to take a closer look? ", "Inspection: synthetic frame", list("Yes", "No"), timeout = 0) == "Yes")
			user.visible_message(SPAN_NOTICE("[user] starts to search the synthetic frame."), SPAN_INFO("You start to search the synthetic frame."))
			if(do_after(user, 30, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_GENERIC))
				user.visible_message(SPAN_DANGER("The frames' eyes shoot open as the cables connecting it to the terminals tense! [user] recoils back!"), SPAN_HIGHDANGER("The frames' eyes shoot open as the cables connecting it to the terminals tense! You recoil back as you hear multiple whispers in your head!"))
				step_away(usr, src, 3, 4)
				INVOKE_ASYNC(src, PROC_REF(pythia_wake_up))
				puzzlebox_global_status = 100
				puzzlebox_user = null
				return
		puzzlebox_user = null
		return


