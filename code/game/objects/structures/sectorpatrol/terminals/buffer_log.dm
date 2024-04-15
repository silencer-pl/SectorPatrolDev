/obj/structure/eventterminal/logbuffer
	name = "modified personal terminal"
	desc = "A personal terminal with custom key caps on the keyboard that seem to be louder than the standard issue ones. A small inscription on the side of the monitor reads 'LD Buffer Logs Collector'. "
	desc_lore = "Unlike the typical LNT, customized terminals are exceedingly rare on spaceships, partially due to the cost of the parts needed to maintain them and high chance of Crystalline contamination during Hyperspace jumps and partially because unrestricted software and hardware modifications can be a genuine threat to the lives of everyone on board a ship or installation. Getting found with one of those is typically at least grounds for an immediate and unpleasant CMISRS investigation."
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
	icon_state = "open_ok"
	puzzlebox_id = "civnet"
	item_serial = "UACM-OVPST-DRM37-LOGBFR"

/obj/structure/eventterminal/logbuffer/attack_hand(mob/user)
	if(!puzzlebox_user)
		puzzlebox_user = usr.real_name
	if(puzzlebox_user != usr.real_name)
		to_chat(usr, SPAN_WARNING("Someone is already using this terminal!"))
		return
	if(!("buffer_welcome" in usr.saw_narrations))
		welcome()
	return

/obj/structure/eventterminal/logbuffer/proc/welcome()
	terminal_speak("Hi, welcome to the Liquid Data Emergency Buffer Database!")
	terminal_speak("We've made some progress in maintaining those thanks to our new LD caretaker. Specifically, we can now cycle messages out of any LD emergency buffer we can find into this centralized unit.")
	terminal_speak("These messages still must exist somewhere, but at least it's one place now and we know where it is.")
	terminal_speak("Using any terminal while having a chipped dog tag on should be more than enough for our Friend to grab any message in its LD buffer. Deletion is not instantaneous and takes several hours to sync, so no need to stay behind for that.")
	terminal_speak("Meanwhile, on this terminal you can use the command LIST to see all available messages or a 12-character message ID, CASE SENSITIVE, to view a specific message.")
	terminal_speak("Each message found is not only information preserved, it can also contain valuable intel, please keep that in mind when viewing terminals out on assignment.")
	terminal_speak("Have fun!")
	terminal_speak("-Aly.")
	usr.saw_narrations.Add("buffer_welcome")
