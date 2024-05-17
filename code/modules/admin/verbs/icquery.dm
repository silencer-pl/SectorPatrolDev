/client/proc/cmd_answer_civnet(mob/M)
	set category = null
	set name = "Answer CivNet Query"

	if (M.civnet_query == null)
		to_chat(usr, SPAN_WARNING("This mob has not sent a CivNet query this round."))
		return
	to_chat(usr, narrate_body("Question: [M.civnet_query]"))
	M.civnet_answer = tgui_input_text(usr, "See chat for full question.", "CivNet Answer, [M.name]", max_length = MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE, timeout = 0)
	to_chat(usr, narrate_body("[M.civnet_answer] set."))
