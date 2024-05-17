/obj/item/cargo/efolder/folder_pid/godbreaker
	efolder_folder_id = "godbreaker"
	item_serial = "AAR - OPERATION GODBREAKER - October 2178"

/obj/item/cargo/efolder/folder_pid/voidseeker
	efolder_folder_id = "voidseeker"
	item_serial = "AAR - OPERATION VOIDSEEKER - January 2179"

/obj/item/cargo/efolder/folder_pid/torchbearer
	efolder_folder_id = "torchbearer"
	item_serial = "AAR - OPERATION TORCHBEARER - April 2184"

/obj/item/cargo/efolder/folder_pid/we_failed
	efolder_folder_id = "we_failed"
	item_serial = "I geniuinelly thought these were my last words -C - April 2184"

/obj/structure/eventterminal/efolder_reader
	name = "personal log viewer"
	desc = "A small portable computer with a set of speakers. It opens and closes but does not seem to have any visible way of entering commands."
	desc_lore = "Devices like these are normally simple password locked electronic logbooks, however this device seems to have been severely modified, particularly it seems to be able to function despite the PST's anomalous disruption field. The lack of a keyboard indicates that there must be some external way of triggering playback or authenticating the user to use this device, but one does not seem to be apparent by just looking at it."
	icon = 'icons/obj/structures/machinery/computer.dmi'
	item_serial = "PERSONAL LOG VIEWER<br>ADAPTED FOR USE USING LD FRIENDLY MACHINERY BY ALY REED-WILO<br>PRODUCED IN THE OV-PST<hr>MANUFACTURE CODE: COMFORT-ELECTRONICS-LOGVIEWER"
	icon_state = "laptop_on"
	plane = GAME_PLANE
	var/playing_log = FALSE

/obj/structure/eventterminal/efolder_reader/attack_hand(mob/user as mob)
	if(playing_log == TRUE)
		terminal_speak("Log playback in progress...")
		return
	if(playing_log == FALSE)
		terminal_speak("TF-14 AAR VIEWER")
		terminal_speak("Awaiting AAR Folder.")
		to_chat(user, narrate_body("The terminal clearly awaits input, but it is missing a keyboard or anything else to interact with it."))
		return

/obj/structure/eventterminal/efolder_reader/attackby(obj/item/W, mob/user)
	if(playing_log == TRUE)
		to_chat(usr, narrate_body("The reader does not react. It seems to be already playing something back."))
		return
	if(istype(W, /obj/item/cargo/efolder/folder_pid))
		var/obj/item/cargo/efolder/folder_pid/F = W
		switch(F.efolder_folder_id)
			if("godbreaker")
				playing_log = TRUE
				for (var/obj/structure/machinery/light/marker/admin/A in world)
					if (A.light_id == "efolder_viewer")
						emoteas("beeps loudly, then starts to play a message.", 20)
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.langchat_color = "#b3183e"
						A.talkas("These are additional and closing comments for Operation Godbreaker, Commander Cassandra Reed reporting.")
						A.talkas("I left these comments out of my original report, A few loose ends and things to follow up.")
						A.talkas("At the tail end of the operation, with the cult... Out of the way, the crew of my ship and I did what we always do. We started to scour the station for information.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("takes a moment to collect herself, some shuffling is heard from the background.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("First, the obvious. The Godseekers are gone. I put a bullet in the head of their prophet myself, not wanting to find out whether his babbling about UA backing was true or not.")
						A.talkas("I confirmed his identity, and we can put at least one mystery to rest. He is indeed the rogue Upsilon researcher that my mother reported concerns about.")
						A.talkas("Somehow, I'm not surprised and likely neither is she. This still feels like part Wey-Yu hitjob.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("sighs loudly.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("Quite the irony that one. Anyway. With the Godseekrs out of the way, I followed through on the rest of the directives and proceeded to eliminate those constructs...")
						A.talkas("These 'Upsilon' as they called the constructs. I assuming the name is not coincidence and this is based of stolen Wey-Yu tech.")
						A.talkas("Only one of them was able to answer my questions and only one of them survived our purge.")
						A.talkas("It calls itself 'Melinoe' and what it says... Well. Let's just say that I think at the very least, the Director should listen to this.")
						A.talkas("But it's huge. It could change everything, us, maybe even humanity as a whole.")
						A.talkas("At the very least, I'm sure my mother will be interested in meeting the synthetic namesake of her institute.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("sighs again, taps the desk the recorder is on in audible frustration.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("Fuck.", 15)
						A.talkas("I hate this. But this seems too important not to follow up.")
						A.talkas("Anyway, this is neither here nor there. The important thing for this report is that the Godseekers are no longer a threat and that their legacy...")
						A.talkas("Well, it's worth looking into. I'll provide more reports when I can.")
						playing_log = FALSE
						return
			if("voidseeker")
				playing_log = TRUE
				for (var/obj/structure/machinery/light/marker/admin/A in world)
					if (A.light_id == "efolder_viewer")
						emoteas("beeps loudly, then starts to play a message.", 20)
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.langchat_color = "#b3183e"
						A.talkas("These are additional and closing comments for Operation Voidseeker. Commander Cassandra Reed, reporting.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("takes a deep breath and exhales loudly for several seconds, seemingly at a loss for words.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("I kept my tone in the report itself professional, because this is no time to be imprecise due to my personal emotions, but on the inside, I'm... Not even sure how to describe it.")
						A.talkas("We're all in shock. Aly, myself, the crew of the Persephone, all of us. And yet none can deny what we saw.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("takes another deep breath. Taps her fingers against her desk audibly through the rest of the recording.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("Try as I may, I cannot put the two statements in question and as such, I will assume they are true.")
						A.talkas("First, there is a UA-wide conspiracy present within the USCMC that is secretly trying to provoke a war with the UPP using Black Goo based bioweapons and worse.")
						A.talkas("This station, the Upsilon, the Godseekers. Their leader was right. They DID have UA backing.")
						A.talkas("They are called 'Deep Void'. And taking the station was important, because...")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("takes another deep breath.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("...Because the Godseekers were right.")
						A.talkas("Liquid Data, as a whole, can be home to a living, intelligent consciousness. An independent living being with feelings and thoughts and the ability to learn and think in abstracts and all the other benchmarks my mother spent so much time thinking about.")
						A.talkas("It's here. It's alive. It's been alive longer than we existed and likely will survive us. With Melione's help... Let's just say it was similar to the Twilight Paradox.")
						A.talkas("When we knew what to look for... What was it that it said... 'In the ocean of data, amidst azure strands, she sleeps.' ")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("pauses again. The tapping gets faster.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("I need to consult with the director. Aly and me drew up a plan, a special STG, Task Force 14. Something to keep this under wraps.")
						A.talkas("Melinoe had a suggestion of their own. A new Upsilon Generation, as they called it. To help safeguard and understand 'her', whatever 'she' is.")
						A.talkas("Explore the capabilities.")
						A.talkas("Make first contact.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("laughs nervously.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("How the hell did she know. This is not possible.")
						A.talkas("The details leading to my conclusions are in the report. I am on my way back to Earth right now to discuss this in person. There is work to be done.")
						playing_log = FALSE
			if("torchbearer")
				playing_log = TRUE
				for (var/obj/structure/machinery/light/marker/admin/A in world)
					if (A.light_id == "efolder_viewer")
						emoteas("beeps loudly, then starts to play a message.", 20)
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.langchat_color = "#b3183e"
						A.talkas("Commander Cassandra Reed. These are supplementary comments for Operation Torchbearer.")
						A.talkas("There is very little time. It worked. We lost all the Upsilon frames, but it worked.")
						A.talkas("I have a name. I have connections. I have a whole web to investigate. I'm also out of time.")
						A.talkas("Blackfire will happen within forty hours.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("starts to tap her fingers against the desk the recorder is on as she speaks.", 10)
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("We recovered the Upsilon spheres and prepared them as Melinoe instructed.")
						A.talkas("I'm concerned she's not telling me something. But it can't be helped. I can't go back to the station now.")
						A.talkas("All TF14 assets are watching planets most likely to be hit by Blackfire. We must be able to do something, right? We know what's coming.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("takes a deep breath. The tapping stops.", 30)
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("We've done all we could. We really, really tried. I guess time will tell if this makes a difference.")
						A.talkas("Or maybe Melinoe is right. Maybe we have to wait for four to be properly formed to fully understand her and her constants and variables.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("sighs loudly and pauses for a few seconds.", 60)
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("It is what it is. I have the best team in this part of the galaxy under me. We'll be fine.", 100)
						A.talkas("We'll be fine.")
						playing_log = FALSE
			if("we_failed")
				playing_log = TRUE
				for (var/obj/structure/machinery/light/marker/admin/A in world)
					if (A.light_id == "efolder_viewer")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("Test Crews. I extracted this message out of the MUP and put it along with the others you found, and I leave it here for the sake of having a complete archive of those.")
						A.talkas("I would ask that you kindly respect that I was genuinely at a low point during this recording and consider the fact that I didn't bury myself ugly crying a sign of trust.")
						emoteas("pops softly and switches audio recordings.")
						A.name = "Cassandra"
						A.emoteas("audibly struggles to speak for a while, sniffles and coughs a few times.")
						A.talkas("I uh... I...", 30)
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("breaks down for a few seconds and audibly weeps.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("We failed. We failed so much. But how could we have not.")
						A.talkas("Literally all the world was against us. But that's... That's not what the problem was.")
						A.talkas("The problem was me. My arrogance.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("sniffs again and takes a few deep breaths. When she resumes speaking, her voice is much steadier.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("I thought that the information about Blackfire was presented as something we could affect. I completely misunderstood the chain Pythia was presenting.")
						A.talkas("So did the Upsilon. So did everyone.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("sighs loudly.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("Blackfire is not the result of a failure to investigate Deep Void. Blackfire was not a planned attack.")
						A.talkas("Blackfire happened because Task Force 14 exists. Because I exist and found Aly and Pythia.")
						A.talkas("The choice to create TF14, to investigate Deep Void is the mechanism that triggers Blackfire. This is what Pythia was warning me about.")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("Sighs loudly and takes some time to compose herself again.")
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("We now have a whole lot of evidence, enough to take down Deep Void... And the USCMC with it most likely. The question remains.")
						A.talkas("Who do we trust with it. Who do we go to. Who is uncorrupted. How do we get the information to them.")
						A.talkas("Do we even want to do this? I'll have to leave the decision in their hands, I don't have the right… They must know this is a death sentence to the Marines.")
						A.talkas("I could ask Pythia but...")
						A.langchat_color = COLOR_WHITE
						A.name = "Cassandra"
						A.emoteas("weeps quietly again, sniffs audibly.", 50)
						A.langchat_color = "#b3183e"
						A.name = "Voice of CDR. Cassandra Reed-Wilo"
						A.talkas("Melinoe is dead. They got to her. She knew this would happen and did what she had to. But the end effect is, we no longer have Pythia Interpreter. We no longer can focus her gaze.")
						A.talkas("Unless we do the unthinkable.")
						A.talkas("Unless we use a human Interpreter.")
						A.talkas("Alysia won't let me do it. I'm pretty sure she'll try to do it instead. Jokes on her. I'm not leaving here until she tries. We're doing this together, or not at all.")
						A.talkas("We have no illusions. Direct exposure to Pythia will pour Crystalline right into our cranial cavities. There is no way alive out of this.")
						A.talkas("But with the blueprint and Pythia herself... Maybe we can survive long enough to take Deep Void with us.")
						A.talkas("We owe them that much.")
						A.talkas("Reed, out.")
						A.talkas("I'm sorry.")
