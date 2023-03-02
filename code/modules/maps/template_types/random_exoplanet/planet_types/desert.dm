/obj/effect/overmap/visitable/sector/planetoid/exoplanet/desert
	name          = "desert exoplanet"
	desc          = "An arid exoplanet with sparse biological resources but rich mineral deposits underground."
	color         = "#a08444"
	surface_color = "#d6cca4"
	water_color   = null

/datum/level_data/planetoid/exoplanet/desert
	base_turf = /turf/exterior/sand
	base_area = /area/exoplanet/desert
	exterior_atmosphere = null
	exterior_atmos_temp = null

/datum/flora_generator/desert
	has_trees       = FALSE
	flora_diversity = 4
	plant_colors    = list(
		"#efdd6f",
		"#7b4a12",
		"#e49135",
		"#ba6222",
		"#5c755e",
		"#701732"
	)

/datum/flora_generator/desert/adapt_seed(var/datum/seed/S)
	..()
	if(prob(90))
		S.set_trait(TRAIT_REQUIRES_WATER,0)
	else
		S.set_trait(TRAIT_REQUIRES_WATER,1)
		S.set_trait(TRAIT_WATER_CONSUMPTION,1)
	if(prob(75))
		S.set_trait(TRAIT_STINGS,1)
	if(prob(75))
		S.set_trait(TRAIT_CARNIVOROUS,2)
	S.set_trait(TRAIT_SPREAD,0)

/datum/fauna_generator/desert
	fauna_types           = list(
		/mob/living/simple_animal/thinbug,
		/mob/living/simple_animal/tindalos,
		/mob/living/simple_animal/hostile/slug,
		/mob/living/simple_animal/hostile/antlion,
	)
	megafauna_types = list(
		/mob/living/simple_animal/hostile/antlion/mega,
	)

/datum/map_template/planetoid/exoplanet/desert
	name                  = "desert exoplanet"
	level_data_type       = /datum/level_data/planetoid/exoplanet/desert
	flora_generator_type  = /datum/flora_generator/desert
	fauna_generator_type  = /datum/fauna_generator/desert
	overmap_marker_type   = /obj/effect/overmap/visitable/sector/planetoid/exoplanet/desert
	initial_weather_state = null
	template_parent_type  = /datum/map_template/planetoid/exoplanet
	possible_rock_colors = list(
		COLOR_BEIGE,
		COLOR_PALE_YELLOW,
		COLOR_GRAY80,
		COLOR_BROWN
	)
	map_generators = list(
		/datum/random_map/noise/exoplanet/desert,
		/datum/random_map/noise/ore/rich,
	)

/datum/map_template/planetoid/exoplanet/desert/generate_daycycle(datum/planetoid_data/gen_data, datum/level_data/surface_level)
	if(prob(70))
		surface_level.ambient_light_level = rand(5,10)/10	//deserts are usually :lit:
	. = ..()

/datum/map_template/planetoid/exoplanet/desert/get_target_temperature()
	return T20C + rand(20, 100)

/datum/random_map/noise/exoplanet/desert
	descriptor = "desert exoplanet"
	smoothing_iterations = 4
	land_type = /turf/exterior/sand
	flora_prob = 5
	grass_prob = 2
	large_flora_prob = 0

/datum/random_map/noise/exoplanet/desert/get_additional_spawns(var/value, var/turf/T)
	..()
	var/v = noise2value(value)
	if(v > 6 && prob(10))
		new/obj/effect/quicksand(T)

/datum/random_map/noise/exoplanet/desert/get_appropriate_path(var/value)
	. = ..()
	if(noise2value(value) > 6)
		return /turf/exterior/dry

/area/exoplanet/desert
	ambience = list(
		'sound/effects/wind/desert0.ogg',
		'sound/effects/wind/desert1.ogg',
		'sound/effects/wind/desert2.ogg',
		'sound/effects/wind/desert3.ogg',
		'sound/effects/wind/desert4.ogg',
		'sound/effects/wind/desert5.ogg'
	)
	base_turf = /turf/exterior/sand
