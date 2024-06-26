/obj/machinery/transportpod
	name = "Ballistic Transportation Pod"
	desc = "A fast transit ballistic pod used to get from one place to the next. Batteries not included!"
	icon = 'icons/obj/structures.dmi'
	icon_state = "borg_pod_opened"

	density = TRUE
	anchored = TRUE
	use_power = USE_POWER_OFF

	var/in_transit = 0
	var/mob/occupant = null

	var/xc = list(137, 209, 163, 110, 95, 60, 129, 201) // List of x values on the map to go to.
	var/yc = list(134, 99, 169, 120, 96, 122, 189, 219) // List of y values on the map to go to.

	var/limit_x = 3
	var/limit_y = 3

/obj/machinery/transportpod/process(delta_time)
	if(occupant)
		if(in_transit)
			var/locNum = rand(0, 7) //pick a random location
			var/turf/L = locate(xc[locNum], yc[locNum], 1) // Pairs the X and Y to get an actual location.
			limit_x = xc[locNum]+1
			limit_y = yc[locNum]+1
			build()
			sleep(20) //Give explosion time so the pod itself doesn't go boom
			src.forceMove(L)
			playsound(src, pick('sound/soundbytes/effects/explosion/explosion1.ogg', 'sound/soundbytes/effects/explosion/explosion2.ogg', 'sound/soundbytes/effects/explosion/explosion3.ogg', 'sound/soundbytes/effects/explosion/explosion4.ogg'))
			in_transit = 0
			sleep(2)
			go_out()
			sleep(2)
			del(src)

/obj/machinery/transportpod/relaymove(mob/user)
	if(user.stat)
		return
	go_out()
	return

/obj/machinery/transportpod/update_icon()
	..()
	if(occupant)
		icon_state = "borg_pod_closed"
	else
		icon_state = "borg_pod_opened"

/obj/machinery/transportpod/Bumped(mob/living/O)
	go_in(O)

/obj/machinery/transportpod/proc/go_in(mob/living/carbon/human/O)
	if(occupant)
		return

	if(O.incapacitated()) //aint no sleepy people getting in here
		return

	add_fingerprint(O)
	O.forceMove(src)
	O.update_perspective()
	occupant = O
	update_appearance()
	if(alert(O, "Are you sure you're ready to launch?", , "Yes", "No") == "Yes")
		in_transit = 1
		playsound(src, HYPERSPACE_WARMUP)
	else
		go_out()
	return 1

/obj/machinery/transportpod/proc/go_out()
	if(!occupant)
		return

	occupant.forceMove(src.loc)
	occupant.update_perspective()
	occupant = null
	update_icon()

/obj/machinery/transportpod/verb/move_eject()
	set category = VERB_CATEGORY_OBJECT
	set name = "Eject Pod"
	set src in oview(1)

	if(usr.incapacitated())
		return

	go_out()
	add_fingerprint(usr)
	return

/obj/machinery/transportpod/verb/move_inside()
	set category = VERB_CATEGORY_OBJECT
	set name = "Enter Pod"
	set src in oview(1)

	if(usr.incapacitated()) //just to DOUBLE CHECK the damn sleepy people don't touch the pod
		return

	go_in(usr)

/obj/machinery/transportpod/proc/build()
	for(var/x = limit_x-2, x <= limit_x, x++)
		for(var/y = limit_y-2, y <= limit_y, y++)
			var/current_cell = locate(x, y, 1)
			var/turf/T = get_turf(current_cell)
			if(!current_cell)
				continue
			T.ChangeTurf(/turf/unsimulated/floor/shuttle_ceiling)
