///Overmap marker for the grass exoplanet
/obj/effect/overmap/visitable/sector/planetoid/exoplanet/grass
	name = "lush exoplanet"
	desc = "Planet with abundant flora and fauna."
	color = "#407c40"

/obj/effect/overmap/visitable/sector/planetoid/exoplanet/grass/get_surface_color()
	var/datum/planetoid_data/E = SSmapping.planetoid_data_by_id[planetoid_id]
	return E?.get_grass_color()

///Surface of a grass exoplanet
/datum/level_data/planetoid/exoplanet/grass
	base_area = /area/exoplanet/grass
	base_turf = /turf/exterior/wildgrass
	exterior_atmosphere = null
	exterior_atmos_temp = null
	level_generators = list(
		/datum/random_map/noise/exoplanet/grass
	)

///Flora data for a grass exoplanet
/datum/flora_generator/grass
	flora_diversity = 6
	plant_colors    = list(
		"#215a00",
		"#195a47",
		"#5a7467",
		"#9eab88",
		"#6e7248",
		"RANDOM"
	)
/datum/flora_generator/grass/adapt_seed(var/datum/seed/S)
	. = ..()
	var/carnivore_prob = rand(100)
	if(carnivore_prob < 30)
		S.set_trait(TRAIT_CARNIVOROUS,2)
		if(prob(75))
			S.get_trait(TRAIT_STINGS, 1)
	else if(carnivore_prob < 60)
		S.set_trait(TRAIT_CARNIVOROUS,1)
		if(prob(50))
			S.get_trait(TRAIT_STINGS)
	if(prob(15) || (S.get_trait(TRAIT_CARNIVOROUS) && prob(40)))
		S.set_trait(TRAIT_BIOLUM,1)
		S.set_trait(TRAIT_BIOLUM_COLOUR,get_random_colour(0,75,190))

	if(prob(30))
		S.set_trait(TRAIT_PARASITE,1)
	if(!S.get_trait(TRAIT_LARGE))
		var/vine_prob = rand(100)
		if(vine_prob < 15)
			S.set_trait(TRAIT_SPREAD,2)
		else if(vine_prob < 30)
			S.set_trait(TRAIT_SPREAD,1)

/datum/fauna_generator/grass
	fauna_types = list(
		/mob/living/simple_animal/yithian,
		/mob/living/simple_animal/tindalos,
		/mob/living/simple_animal/hostile/retaliate/jelly
	)
	megafauna_types = list(
		/mob/living/simple_animal/hostile/retaliate/parrot/space/megafauna,
		/mob/living/simple_animal/hostile/retaliate/goose/dire
	)

///Map template for generating a grass exoplanet
/datum/map_template/planetoid/exoplanet/grass
	name                 = "lush exoplanet"
	level_data_type      = /datum/level_data/planetoid/exoplanet/grass
	flora_generator_type = /datum/flora_generator/grass
	fauna_generator_type = /datum/fauna_generator/grass
	overmap_marker_type  = /obj/effect/overmap/visitable/sector/planetoid/exoplanet/grass
	template_parent_type = /datum/map_template/planetoid/exoplanet
	possible_rock_colors = list(
		COLOR_ASTEROID_ROCK,
		COLOR_GRAY80,
		COLOR_BROWN
	)

/datum/map_template/planetoid/exoplanet/grass/generate_daycycle(datum/planetoid_data/gen_data, datum/level_data/surface_level)
	if(prob(40))
		surface_level.ambient_light_level = rand(1,7)/10	//give a chance of twilight jungle
	. = ..()

/datum/map_template/planetoid/exoplanet/grass/get_target_temperature()
	return T20C + rand(10, 30)

///Area for the grass exoplanet surface
/area/exoplanet/grass
	base_turf       = /turf/exterior/wildgrass
	ambience        = list(
		'sound/effects/wind/wind_2_1.ogg',
		'sound/effects/wind/wind_2_2.ogg',
		'sound/effects/wind/wind_3_1.ogg',
		'sound/effects/wind/wind_4_1.ogg',
		'sound/ambience/eeriejungle2.ogg',
		'sound/ambience/eeriejungle1.ogg'
	)
	forced_ambience = list(
		'sound/ambience/jungle.ogg'
	)

///Map generator for the grass exoplanet surface
/datum/random_map/noise/exoplanet/grass
	descriptor = "grass exoplanet"
	land_type = /turf/exterior/wildgrass
	water_type = /turf/exterior/water
	coast_type = /turf/exterior/mud/dark
	water_level_min = 3
	flora_prob = 10
	grass_prob = 50
	large_flora_prob = 30
