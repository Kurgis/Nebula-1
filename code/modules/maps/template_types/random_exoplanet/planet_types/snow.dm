/obj/effect/overmap/visitable/sector/planetoid/exoplanet/snow
	name          = "snow exoplanet"
	desc          = "Cold planet with limited plant life."
	color         = "#dcdcdc"
	surface_color = "#e8faff"
	water_color   = "#b5dfeb"

/datum/level_data/planetoid/exoplanet/snow
	base_area = /area/exoplanet/snow
	base_turf = /turf/exterior/snow
	exterior_atmosphere = null
	exterior_atmos_temp = null

/datum/flora_generator/snow
	plant_colors = list(
		"#d0fef5",
		"#93e1d8",
		"#93e1d8",
		"#b2abbf",
		"#3590f3",
		"#4b4e6d"
	)

/datum/fauna_generator/snow
	fauna_types = list(
		/mob/living/simple_animal/hostile/retaliate/beast/samak,
		/mob/living/simple_animal/hostile/retaliate/beast/diyaab,
		/mob/living/simple_animal/hostile/retaliate/beast/shantak
	)
	megafauna_types = list(
		/mob/living/simple_animal/hostile/retaliate/giant_crab
	)

/datum/map_template/planetoid/exoplanet/snow
	name                  = "snow exoplanet"
	level_data_type       = /datum/level_data/planetoid/exoplanet/snow
	flora_generator_type  = /datum/flora_generator/snow
	fauna_generator_type  = /datum/fauna_generator/snow
	initial_weather_state = /decl/state/weather/snow
	overmap_marker_type   = /obj/effect/overmap/visitable/sector/planetoid/exoplanet/snow
	template_parent_type  = /datum/map_template/planetoid/exoplanet
	//#TODO: Do weather stuff to init properly
	//water_material  = null // Will prevent the weather system causing rainfall.
	possible_rock_colors = list(
		COLOR_DARK_BLUE_GRAY,
		COLOR_GUNMETAL,
		COLOR_GRAY80,
		COLOR_DARK_GRAY
	)
	map_generators = list(
		/datum/random_map/automata/cave_system/mountains/snow,
		/datum/random_map/noise/exoplanet/snow,
		/datum/random_map/noise/ore/poor
	)

/datum/map_template/planetoid/exoplanet/snow/get_target_temperature()
	return T0C - rand(10, 100)

/datum/random_map/automata/cave_system/mountains/snow
	iterations = 2
	descriptor = "ice mountains"
	wall_type =  /turf/exterior/wall/ice
	mineral_turf = /turf/exterior/wall/random/ice
	rock_color = COLOR_CYAN_BLUE

/datum/random_map/noise/exoplanet/snow
	descriptor = "snow exoplanet"
	smoothing_iterations = 1
	flora_prob = 5
	large_flora_prob = 10
	water_level_max = 3
	land_type = /turf/exterior/snow
	water_type = /turf/exterior/ice

/area/exoplanet/snow
	base_turf = /turf/exterior/snow
	ambience  = list(
		'sound/effects/wind/tundra0.ogg',
		'sound/effects/wind/tundra1.ogg',
		'sound/effects/wind/tundra2.ogg',
		'sound/effects/wind/spooky0.ogg',
		'sound/effects/wind/spooky1.ogg'
	)
