/datum/map
	var/species_to_job_whitelist = list()
	var/species_to_job_blacklist = list()
	var/job_to_species_whitelist = list()
	var/job_to_species_blacklist = list()

	/// Default job title which will be set in some cases.
	var/default_job_title
	/// Default job type which will be used if map lack of any jobs or for respawn.
	var/datum/job/default_job_type = /datum/job

// The white, and blacklist are type specific, any subtypes (of both species and jobs) have to be added explicitly
/datum/map/proc/is_species_job_restricted(var/decl/species/S, var/datum/job/J)
	if(!istype(S) || !istype(J))
		return TRUE

	var/list/whitelist = species_to_job_whitelist[S.type]
	if(whitelist)
		return !(J.type in whitelist)

	whitelist = job_to_species_whitelist[J.type]
	if(whitelist)
		return !(S.type in whitelist)

	var/list/blacklist = species_to_job_blacklist[S.type]
	if(blacklist)
		return (J.type in blacklist)

	blacklist = job_to_species_blacklist[J.type]
	if(blacklist)
		return (S.type in blacklist)

	return FALSE
