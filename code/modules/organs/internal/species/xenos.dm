//XENOMORPH ORGANS
/obj/item/organ/internal/xenos
	name = "xeno organ"
	icon = 'icons/obj/surgery.dmi'
	desc = "It smells like an accident in a chemical factory."

/obj/item/organ/internal/xenos/eggsac
	name = "egg sac"
	parent_organ = BP_GROIN
	icon_state = "sac"
	organ_tag = O_EGG

/obj/item/organ/internal/xenos/eggsac/grey
	icon_state = "sac_grey"

/obj/item/organ/internal/xenos/eggsac/grey/colormatch/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(sync_color)), 15)

/obj/item/organ/internal/xenos/eggsac/grey/colormatch/proc/sync_color()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.species.blood_color)
			add_atom_color(H.species.blood_color)

/obj/item/organ/internal/xenos/plasmavessel
	name = "plasma vessel"
	parent_organ = BP_TORSO
	icon_state = "plasma"
	organ_tag = O_PLASMA
	var/stored_plasma = 0
	var/max_plasma = 500

	organ_verbs = list(
		/mob/living/carbon/human/proc/transfer_plasma
		)

/obj/item/organ/internal/xenos/plasmavessel/handle_organ_proc_special()
	if(!istype(owner))
		return

	var/modifier = 1 - 0.5 * is_bruised()

	if(owner.bloodstr.has_reagent("phoron"))
		adjust_plasma(round(4 * modifier))

	if(owner.ingested.has_reagent("phoron"))
		adjust_plasma(round(2 * modifier))

	adjust_plasma(1)

/obj/item/organ/internal/xenos/plasmavessel/proc/adjust_plasma(var/amount = 0)
	stored_plasma = clamp(stored_plasma + amount, 0, max_plasma)

/obj/item/organ/internal/xenos/plasmavessel/grey
	icon_state = "plasma_grey"
	stored_plasma = 200

/obj/item/organ/internal/xenos/plasmavessel/grey/colormatch/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(sync_color)), 15)

/obj/item/organ/internal/xenos/plasmavessel/grey/colormatch/proc/sync_color()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.species.blood_color)
			add_atom_color(H.species.blood_color)

/obj/item/organ/internal/xenos/plasmavessel/queen
	name = "bloated plasma vessel"
	stored_plasma = 200
	max_plasma = 500

/obj/item/organ/internal/xenos/plasmavessel/sentinel
	stored_plasma = 100
	max_plasma = 250

/obj/item/organ/internal/xenos/plasmavessel/hunter
	name = "tiny plasma vessel"
	stored_plasma = 100
	max_plasma = 150

/obj/item/organ/internal/xenos/acidgland
	name = "acid gland"
	parent_organ = BP_HEAD
	icon_state = "acidgland"
	organ_tag = O_ACID

	organ_verbs = list(
		/mob/living/carbon/human/proc/corrosive_acid,
		/mob/living/carbon/human/proc/neurotoxin,
		/mob/living/carbon/human/proc/acidspit
		)

/obj/item/organ/internal/xenos/acidgland/grey
	icon_state = "acidgland_grey"

/obj/item/organ/internal/xenos/acidgland/grey/colormatch/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(sync_color)), 15)

/obj/item/organ/internal/xenos/acidgland/grey/colormatch/proc/sync_color()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.species.blood_color)
			add_atom_color(H.species.blood_color)

/obj/item/organ/internal/xenos/hivenode
	name = "hive node"
	parent_organ = BP_TORSO
	icon_state = "xenode"
	organ_tag = O_HIVE

/obj/item/organ/internal/xenos/hivenode/grey
	icon_state = "xenode_grey"

/obj/item/organ/internal/xenos/hivenode/grey/colormatch/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(sync_color)), 15)

/obj/item/organ/internal/xenos/hivenode/grey/colormatch/proc/sync_color()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.species.blood_color)
			add_atom_color(H.species.blood_color)

/obj/item/organ/internal/xenos/resinspinner
	name = "resin spinner"
	parent_organ = BP_HEAD
	icon_state = "xenode"
	organ_tag = O_RESIN

	organ_verbs = list(
		/mob/living/carbon/human/proc/resin,
		/mob/living/carbon/human/proc/plant
		)

/obj/item/organ/internal/xenos/resinspinner/hybrid
	name = "weakend resinspinner"
	organ_verbs = list(
		/mob/living/carbon/human/proc/hybrid_resin,
		/mob/living/carbon/human/proc/hybrid_plant//replaced from the normal weed node to place a singular weed
	)

/obj/item/organ/internal/xenos/resinspinner/grey
	icon_state = "xenode_grey"

/obj/item/organ/internal/xenos/resinspinner/grey/colormatch/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(sync_color)), 15)

/obj/item/organ/internal/xenos/resinspinner/grey/colormatch/proc/sync_color()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.species.blood_color)
			add_atom_color(H.species.blood_color)

/obj/item/organ/internal/heart/xenomorph
	name = "xenomorph heart"


