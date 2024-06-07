/obj/structure/terminal/
	name = "terminal- master definition"
	desc = "This is a master item. It should not be placed anywhere in the game world."
	desc_lore = "If you have the time, please consider reporting this as a bug."
	icon = 'icons/sectorpatrol/salvage/items.dmi'
	icon_state = "master"
	var/terminal_id = "default"
	var/terminal_intro_text = "Hello. I am a terminal and this is my intro text."
	var/list/terminal_buffer = list()
	var/terminal_busy = 0

/obj/structure/terminal/proc/reset_buffer()
	terminal_buffer = null
	terminal_buffer = list()
	terminal_buffer += terminal_intro_text

/obj/structure/terminal/Initialize(mapload, ...)
	. = ..()
	reset_buffer()

/obj/structure/terminal/proc/kill_window()
	usr << browse(null, "window=[terminal_id]")
	reset_buffer()

/obj/structure/terminal/proc/terminal_display()
	var/terminal_output = ("<p>" + jointext(terminal_buffer, "</p><p>") + "/<p>")
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
	usr << browse(terminal_html,"window=[terminal_id];display=1;size=500x700;border=5px;can_close=0;can_resize=0;can_minimize=0;titlebar=0")
	onclose(usr, "[terminal_id]")

/obj/structure/terminal/proc/terminal_input()
	terminal_buffer += html_encode(">_")
	terminal_display()
	var/terminal_input = tgui_input_text(usr, message = "Please enter a command, use cancel or close the window to close the terminal.", title = "Terminal Input", timeout = 0)
	if(!terminal_input)
		kill_window()
		return
	terminal_buffer -= html_encode(">_")
	terminal_buffer += (html_encode("> ") + terminal_input)
	terminal_display()
	sleep(TERMINAL_STANDARD_SLEEP)
	terminal_buffer += ("If I had something to say, it would show up here.")
	terminal_display()
	sleep(TERMINAL_STANDARD_SLEEP)
	terminal_input()


/obj/structure/terminal/attack_hand(mob/user)
	terminal_input()
	return
