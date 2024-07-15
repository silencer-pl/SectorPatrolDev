

/obj/structure/terminal/briefing
	name = "briefing display"
	desc = "A large-scale display, safely mounted inside a slot made in the hull of the ship"
	desc_lore = "Computer displays on most ships tend to be adjusted for single colored text, initially due to lack of technology that allowed for better quality displays to survive out in space. Over time this became more a habit than anything else, as evidenced by PDAs which do not limit themselves in terms of display capabilities. Large scale displays such as this one have resisted over a hundred years' worth of technological progress and still reign supreme across human space ships. Truly, you are looking at a classic. For better or worse."
	icon = 'icons/obj/structures/machinery/displaymonitor.dmi'
	icon_state = "off"
	terminal_id = "briefing"
	var/terminal_range = 20
	terminal_window_size = "500x500"
	terminal_line_length = 42
	terminal_line_height = 13

/obj/structure/terminal/briefing/kill_window(reset = 1)
	for (var/mob/mobs in world)
		mobs << browse(null, "window=[terminal_id]")
		if(reset == 1) reset_buffer()

/obj/structure/terminal/briefing/terminal_display() // Display loop. HTML encodes (which incidentally should also prevent a lot of HTML shenanigans since it escapes characters) and displays current buffer. Please don't laugh at my placeholder HTML -_- , in normal circumstances should not need edits unless you want to change the style for an individual terminal.
	trim_buffer()
	var/terminal_output = ("<p>" + jointext((terminal_buffer), "</p><p>") + "/<p>")
	var/terminal_html ={"<!DOCTYPE html>
	<html>
	<head>
	<style>
	body {
	background-color:black;
	}
	#terminal_text {
	font-family: 'Courier New',
	cursive, sans-serif;
	color: #1bdd4b;
	text-align: left;
	padding: 0em 1em;
	}
	</style>
	</head>
	<body>
	<div id="terminal_text">
	<p>
	[terminal_output]
	</p>
	</div>
	</body>
	"}
	for (var/mob/mobs_in_range in view(terminal_range, src))
		mobs_in_range << browse(terminal_html,"window=[terminal_id];display=1;size=[terminal_window_size];border=5px;can_close=1;can_resize=0;can_minimize=0;titlebar=1")
		onclose(mobs_in_range, "[terminal_id]")

/obj/structure/terminal/briefing/attack_hand(mob/user)
	to_chat(usr, SPAN_INFO("This monitor is activated remotely, as long as you are in range and it is active, its contents will be displayed to you. There is no escape."))
	return

/obj/structure/terminal/briefing/proc/display_briefing()
	var/obj/structure/machinery/light/marker/admin/marker = new(get_turf(src))
	marker.name = "RDML. Thomas Boulette"
	marker.langchat_color = "#268323"
	emoteas("buzzes audibly then comes to life.")
	terminal_buffer += "<br>"
	terminal_buffer += "<center><b>UACM 2ND LOGISTICS</b><br>RDML. Thomas Boulette<hr>OPERATION PHOENIX</center>"
	terminal_reserved_lines = 4
	terminal_display()
	marker.talkas("Good morning, Test Crews. Cassandra says you are ready to go to work, which is just as well, because we have work to do.")
	marker.talkas("As of right now, the Second Logistics is joining the UAAC-TIS operation codenamed Operation Phoenix.")
	marker.talkas("Long story short, with cooperation from our TWE allies, we are scouring a part of Neroid Dark Space and recovering wreckage lost to the dark.")
	marker.talkas("Our point of contact for this operation is our own Commander…s Reed-Wilo as it were and their TWE counterpart, Major Asuka Bannister.")
	marker.talkas("Some of you read the files that were unclassified for you I hope, so that name should ring a bell.")
	terminal_display_line("A derelict USCMC vessel was found during the search. The ship was claimed by the PST for recovery.<br>", 0, 1)
	terminal_display_line("Recover all materials from the ship compoments and structure using the PST disassembler array and drones.<br>", 0, 1)
	terminal_display_line("Paper and Electronic Intelligence is avaialble. Keep an eye an use according procedures to secure them.<br>", 0, 1)
	terminal_display_line("Mission Control has any more additonal information you may need.", 0, 0)
	marker.talkas("While we work on the bigger picture and getting you the clearance you need to actively partake in the operation, an opportunity present itself to give you a dry run of an important function you will be fulfilling as Test Crews.")
	marker.talkas("Salvage anything that's not intel and isn't bolted down. Deconstruct and salvage anything that is. ")
	marker.talkas("Take everything. You should have the tools to completely recycle the whole vessel.")
	marker.talkas("Mission Control will handle any details. You can trust her with your life.")
	marker.talkas("I hope to finally be able to formally meet you soon. Good luck.")
	kill_window()
	reset_buffer()

