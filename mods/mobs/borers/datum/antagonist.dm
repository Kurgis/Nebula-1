/decl/special_role/borer
	name = "Cortical Borer"
	name_plural = "Cortical Borers"
	flags = ANTAG_OVERRIDE_MOB | ANTAG_RANDSPAWN | ANTAG_OVERRIDE_JOB

	mob_path = /mob/living/simple_animal/borer
	welcome_text = "Click a target while on GRAB intent to crawl into their ear and infiltrate their brain. You can only take control temporarily, and at risk of hurting your host, so be clever and careful; your host is encouraged to help you however they can. Talk to your host with Say, and your fellow borers with ,z."
	antag_indicator = "hudborer"
	antaghud_indicator = "hudborer"

	faction_name = "Borer Thrall"
	faction_descriptor = "Unity"
	faction_welcome = "You are now a thrall to a cortical borer. Please listen to what they have to say; they're in your head."
	faction = "borer"
	faction_indicator = "hudalien"

	hard_cap = 5
	hard_cap_round = 8
	initial_spawn_req = 3
	initial_spawn_target = 5

	spawn_announcement_title = "Lifesign Alert"
	spawn_announcement_delay = 5000

/decl/special_role/borer/get_extra_panel_options(var/datum/mind/player)
	return "<a href='?src=\ref[src];move_to_spawn=\ref[player.current]'>\[put in host\]</a>"

/decl/special_role/borer/create_objectives(var/datum/mind/player)
	if(!..())
		return
	player.objectives += new /datum/objective/borer_survive()
	player.objectives += new /datum/objective/borer_reproduce()
	player.objectives += new /datum/objective/escape()

/decl/special_role/borer/place_mob(var/mob/living/mob)
	var/mob/living/simple_animal/borer/borer = mob
	if(istype(borer))
		var/mob/living/carbon/human/host
		for(var/mob/living/carbon/human/H in SSmobs.mob_list)
			if(H.stat != DEAD && !H.has_brain_worms())
				var/obj/item/organ/external/head = GET_EXTERNAL_ORGAN(H, BP_HEAD)
				if(head && !BP_IS_PROSTHETIC(head))
					host = H
					break
		if(istype(host))
			var/obj/item/organ/external/head = GET_EXTERNAL_ORGAN(host, BP_HEAD)
			if(head)
				borer.host = host
				LAZYDISTINCTADD(head.implants, borer)
				borer.forceMove(head)
				if(!borer.host_brain)
					borer.host_brain = new(borer)
				borer.host_brain.SetName(host.name)
				borer.host_brain.real_name = host.real_name
				return
	..() // Place them at a vent if they can't get a host.

/decl/special_role/borer/Initialize()
	. = ..()
	spawn_announcement = replacetext(global.using_map.unidentified_lifesigns_message, "%STATION_NAME%", station_name())
	spawn_announcement_sound = global.using_map.lifesign_spawn_sound

/decl/special_role/borer/attempt_random_spawn()
	if(config.aliens_allowed) ..()
