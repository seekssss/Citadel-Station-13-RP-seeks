//
// Simple Pipes - Just a tube, maybe bent
//
/obj/machinery/atmospherics/pipe/simple
	icon = 'icons/atmos/pipes.dmi'
	icon_state = ""
	var/pipe_icon = "" //what kind of pipe it is and from which dmi is the icon manager getting its icons, "" for simple pipes, "hepipe" for HE pipes, "hejunction" for HE junctions
	name = "pipe"
	desc = "A one meter section of regular pipe"

	volume = ATMOS_DEFAULT_VOLUME_PIPE

	dir = SOUTH
	initialize_directions = SOUTH|NORTH

	pipe_flags = PIPING_CARDINAL_AUTONORMALIZE
	construction_type = /obj/item/pipe/binary/bendable
	pipe_state = "simple"

	var/maximum_pressure = 70*ONE_ATMOSPHERE
	var/fatigue_pressure = 55*ONE_ATMOSPHERE
	alert_pressure = 55*ONE_ATMOSPHERE

/obj/machinery/atmospherics/pipe/simple/Initialize(mapload)
	. = ..()

	// Pipe colors and icon states are handled by an image cache - so color and icon should
	//  be null. For mapping purposes color is defined in the object definitions.
	icon = null
	alpha = 255

/obj/machinery/atmospherics/pipe/simple/check_pressure(pressure)
	var/datum/gas_mixture/environment = loc.return_air()

	var/pressure_difference = pressure - environment.return_pressure()

	if(pressure_difference > maximum_pressure)
		burst()

	else if(pressure_difference > fatigue_pressure)
		//TODO: leak to turf, doing pfshhhhh
		if(prob(5))
			burst()

	else return 1

/obj/machinery/atmospherics/pipe/simple/init_dir()
	switch(dir)
		if(SOUTH)
			initialize_directions = SOUTH|NORTH
		if(NORTH)
			initialize_directions = SOUTH|NORTH
		if(EAST)
			initialize_directions = EAST|WEST
		if(WEST)
			initialize_directions = EAST|WEST
		if(NORTHEAST)
			initialize_directions = NORTH|EAST
		if(NORTHWEST)
			initialize_directions = NORTH|WEST
		if(SOUTHEAST)
			initialize_directions = SOUTH|EAST
		if(SOUTHWEST)
			initialize_directions = SOUTH|WEST

/obj/machinery/atmospherics/pipe/simple/proc/burst()
	src.visible_message("<span class='danger'>\The [src] bursts!</span>");
	playsound(src.loc, 'sound/effects/bang.ogg', 25, 1)
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(1,0, src.loc, 0)
	smoke.start()
	qdel(src)

/obj/machinery/atmospherics/pipe/simple/proc/normalize_dir()
	if(dir==3)
		setDir(1)
	else if(dir==12)
		setDir(4)

/obj/machinery/atmospherics/pipe/simple/Destroy()
	if(node1)
		node1.disconnect(src)
		node1 = null
	if(node2)
		node2.disconnect(src)
		node1 = null

	. = ..()

/obj/machinery/atmospherics/pipe/simple/pipeline_expansion()
	return list(node1, node2)

/obj/machinery/atmospherics/pipe/simple/change_color(var/new_color)
	..()
	//for updating connected atmos device pipes (i.e. vents, manifolds, etc)
	if(node1)
		node1.update_underlays()
	if(node2)
		node2.update_underlays()

/obj/machinery/atmospherics/pipe/simple/update_icon()
	. = ..()
	if(!check_icon_cache())
		return

	alpha = 255

	cut_overlays()

	if(node1 && node2)
		add_overlay(icon_manager.get_atmos_icon("pipe", , pipe_color, "[pipe_icon]intact[icon_connect_type]"))
	else
		add_overlay(icon_manager.get_atmos_icon("pipe", , pipe_color, "[pipe_icon]exposed[node1?1:0][node2?1:0][icon_connect_type]"))

/obj/machinery/atmospherics/pipe/simple/update_underlays()
	return

/obj/machinery/atmospherics/pipe/simple/atmos_init()
	normalize_dir()
	var/node1_dir
	var/node2_dir

	for(var/direction in GLOB.cardinal)
		if(direction&initialize_directions)
			if (!node1_dir)
				node1_dir = direction
			else if (!node2_dir)
				node2_dir = direction

	for(var/obj/machinery/atmospherics/target in get_step(src,node1_dir))
		if(can_be_node(target, 1))
			node1 = target
			break
	for(var/obj/machinery/atmospherics/target in get_step(src,node2_dir))
		if(can_be_node(target, 2))
			node2 = target
			break

	if(!node1 && !node2)
		qdel(src)
		return

	update_icon()

/obj/machinery/atmospherics/pipe/simple/disconnect(obj/machinery/atmospherics/reference)
	if(reference == node1)
		if(istype(node1, /obj/machinery/atmospherics/pipe))
			qdel(parent)
		node1 = null

	if(reference == node2)
		if(istype(node2, /obj/machinery/atmospherics/pipe))
			qdel(parent)
		node2 = null

	update_icon()

	return null

/obj/machinery/atmospherics/pipe/simple/visible
	icon_state = "intact"
	hides_underfloor = OBJ_UNDERFLOOR_NEVER

/obj/machinery/atmospherics/pipe/simple/visible/scrubbers
	name = "Scrubbers pipe"
	desc = "A one meter section of scrubbers pipe"
	icon_state = "intact-scrubbers"
	connect_types = CONNECT_TYPE_SCRUBBER
	piping_layer = PIPING_LAYER_SCRUBBER
	layer = PIPES_SCRUBBER_LAYER
	icon_connect_type = "-scrubbers"
	color = PIPE_COLOR_RED

/obj/machinery/atmospherics/pipe/simple/visible/supply
	name = "Air supply pipe"
	desc = "A one meter section of supply pipe"
	icon_state = "intact-supply"
	connect_types = CONNECT_TYPE_SUPPLY
	piping_layer = PIPING_LAYER_SUPPLY
	layer = PIPES_SUPPLY_LAYER
	icon_connect_type = "-supply"
	color = PIPE_COLOR_BLUE

/obj/machinery/atmospherics/pipe/simple/visible/fuel
	name = "Fuel pipe"
	desc = "A one meter section of fuel pipe"
	icon_state = "intact-fuel"
	connect_types = CONNECT_TYPE_FUEL
	piping_layer = PIPING_LAYER_FUEL
	layer = PIPES_FUEL_LAYER
	icon_connect_type = "-fuel"
	color = PIPE_COLOR_YELLOW

/obj/machinery/atmospherics/pipe/simple/visible/aux
	name = "Aux pipe"
	desc = "A one meter section of aux pipe"
	icon_state = "intact-aux"
	connect_types = CONNECT_TYPE_AUX
	piping_layer = PIPING_LAYER_AUX
	layer = PIPES_AUX_LAYER
	icon_connect_type = "-aux"
	color = PIPE_COLOR_CYAN

/obj/machinery/atmospherics/pipe/simple/visible/yellow
	color = PIPE_COLOR_YELLOW

/obj/machinery/atmospherics/pipe/simple/visible/cyan
	color = PIPE_COLOR_CYAN

/obj/machinery/atmospherics/pipe/simple/visible/green
	color = PIPE_COLOR_GREEN

/obj/machinery/atmospherics/pipe/simple/visible/black
	color = PIPE_COLOR_BLACK

/obj/machinery/atmospherics/pipe/simple/visible/red
	color = PIPE_COLOR_RED

/obj/machinery/atmospherics/pipe/simple/visible/blue
	color = PIPE_COLOR_BLUE

/obj/machinery/atmospherics/pipe/simple/visible/purple
	color = PIPE_COLOR_PURPLE

/obj/machinery/atmospherics/pipe/simple/hidden
	icon_state = "intact"

/obj/machinery/atmospherics/pipe/simple/hidden/scrubbers
	name = "Scrubbers pipe"
	icon_state = "intact-scrubbers"
	connect_types = CONNECT_TYPE_SCRUBBER
	piping_layer = PIPING_LAYER_SCRUBBER
	layer = PIPES_SCRUBBER_LAYER
	icon_connect_type = "-scrubbers"
	color = PIPE_COLOR_RED

/obj/machinery/atmospherics/pipe/simple/hidden/supply
	name = "Air supply pipe"
	icon_state = "intact-supply"
	connect_types = CONNECT_TYPE_SUPPLY
	piping_layer = PIPING_LAYER_SUPPLY
	layer = PIPES_SUPPLY_LAYER
	icon_connect_type = "-supply"
	color = PIPE_COLOR_BLUE

/obj/machinery/atmospherics/pipe/simple/hidden/fuel
	name = "Fuel pipe"
	icon_state = "intact-fuel"
	connect_types = CONNECT_TYPE_FUEL
	piping_layer = PIPING_LAYER_FUEL
	layer = PIPES_FUEL_LAYER
	icon_connect_type = "-fuel"
	color = PIPE_COLOR_YELLOW

/obj/machinery/atmospherics/pipe/simple/hidden/aux
	name = "Aux pipe"
	icon_state = "intact-aux"
	connect_types = CONNECT_TYPE_AUX
	piping_layer = PIPING_LAYER_AUX
	layer = PIPES_AUX_LAYER
	icon_connect_type = "-aux"
	color = PIPE_COLOR_CYAN

/obj/machinery/atmospherics/pipe/simple/hidden/yellow
	color = PIPE_COLOR_YELLOW

/obj/machinery/atmospherics/pipe/simple/hidden/cyan
	color = PIPE_COLOR_CYAN

/obj/machinery/atmospherics/pipe/simple/hidden/green
	color = PIPE_COLOR_GREEN

/obj/machinery/atmospherics/pipe/simple/hidden/black
	color = PIPE_COLOR_BLACK

/obj/machinery/atmospherics/pipe/simple/hidden/red
	color = PIPE_COLOR_RED

/obj/machinery/atmospherics/pipe/simple/hidden/blue
	color = PIPE_COLOR_BLUE

/obj/machinery/atmospherics/pipe/simple/hidden/purple
	color = PIPE_COLOR_PURPLE

/obj/machinery/atmospherics/pipe/simple/insulated
	icon = 'icons/obj/atmospherics/red_pipe.dmi'
	icon_state = "intact"

	construction_type = /obj/item/pipe/binary/bendable
	pipe_state = "insulated"

	maximum_pressure = 1000*ONE_ATMOSPHERE
	fatigue_pressure = 900*ONE_ATMOSPHERE
	alert_pressure = 900*ONE_ATMOSPHERE

	hides_underfloor = OBJ_UNDERFLOOR_NEVER
