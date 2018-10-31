/obj/mecha/combat/phazon
	desc = "An exosuit which can only be described as 'WTF?'."
	name = "Phazon"
	icon_state = "phazon"
	initial_icon = "phazon"
	step_in = 2
	dir_in = 2 //Facing south.
	step_energy_drain = 3
	normal_step_energy_drain = 3
	health = 200
	deflect_chance = 30
	damage_absorption = list("brute"=0.7,"fire"=0.7,"bullet"=0.7,"laser"=0.7,"energy"=0.7,"bomb"=0.7)
	armor = list(melee = 30, bullet = 30, laser = 30, energy = 30, bomb = 30, bio = 0, rad = 0)
	max_temperature = 25000
	infra_luminosity = 3
	wreckage = /obj/effect/decal/mecha_wreckage/phazon
	add_req_access = 1
	//operation_req_access = list()
	internal_damage_threshold = 25
	force = 15
	phase_state = "phazon-phase"
	max_equip = 3

/obj/mecha/combat/phazon/GrantActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Grant(user, src)

/obj/mecha/combat/phazon/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Remove(user)

/obj/mecha/combat/phazon/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/rcd
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/gravcatapult
	ME.attach(src)

/obj/mecha/combat/phazon/verb/switch_damtype()
	set category = "Exosuit Interface"
	set name = "Reconfigure arm microtool arrays"
	set src = usr.loc
	set popup_menu = 0
	if(usr != occupant)
		return
	var/new_damtype = alert(occupant, "Arm Tool Selection", null, "Fists", "Torch", "Toxic Injector")
	switch(new_damtype)
		if("Fists")
			damtype = "brute"
			occupant_message("Your exosuit's hands form into fists.")
		if("Torch")
			damtype = "fire"
			occupant_message("A torch tip extends from your exosuit's hand, glowing red.")
		if("Toxic Injector")
			damtype = "tox"
			occupant_message("A bone-chillingly thick plasteel needle protracts from the exosuit's palm.")
	playsound(src, 'sound/mecha/mechmove01.ogg', 50, 1)

/obj/mecha/combat/phazon/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=[UID()];switch_damtype=1'>Change melee damage type</a><br>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/phazon/Topic(href, href_list)
	..()
	if(href_list["switch_damtype"])
		switch_damtype()