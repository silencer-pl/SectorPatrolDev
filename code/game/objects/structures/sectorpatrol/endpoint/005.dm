//Crypt Pythia Sequence

/obj/structure/machinery/light/marker/admin/pythia
	name = "voice"
	var/pythia_talk

/obj/structure/machinery/light/marker/admin/pythia/proc/pythiasay(str)
	pythia_talk = "[str]"
	if(pythia_talk == null) return
	sleep (rand(1,10))
	talkas("[pythia_talk]")
	return



/obj/structure/eventterminal/puzzle05/testament_of_sacrifice
	name = "synthetic frame"
	desc = "A female looking synthetic frame in what seems to be a white toga, sitting motionless on a chair. You see several wires protruding from its arms linked to the computers around it. Black crystals form out of its eyes and run down its cheeks. It looks offline. A purple upsilon letter is tattooed on the frame's forehead."
	desc_lore = "While the frame itself is an unknown, the purple upsilon logo is reminiscent of the Upsilon Research Center, a Weyland-Yutani group specializing in artificial intelligence research. Its hard to recall much about them beyond that fact that supposedly they vanished from the Neroid Sector right as Weyland-Yutani was starting their Mercy initiative."
	langchat_color = "#b10f5a"
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
	talkas(pythia_talk)
	for(var/obj/structure/machinery/light/marker/admin/pythia/M in world)
		INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/structure/machinery/light/marker/admin/pythia, pythiasay), pythia_talk)
	pythiadelay()
	return
