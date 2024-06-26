/datum/sprite_accessory/tail/tiger_new
	name = "tiger tail (vwag)"
	id = "tail_tiger2"
	icon_state = "tigertail"
	ani_state = "tigertail_w"
	do_colouration = 1
	legacy_use_additive_color_matrix = FALSE
	extra_overlay = "tigertail_mark"
	extra_overlay_w = "tigertail_mark_w"

/datum/sprite_accessory/tail/tiger_white
	name = "tiger, colorable"
	id = "tail_tiger"
	icon_state = "tiger"
	do_colouration = 1
	legacy_use_additive_color_matrix = FALSE
	extra_overlay = "tigerinnerwhite"

/datum/sprite_accessory/tail/cat_big
	name = "kitty (big), colorable"
	id = "tail_cat_big"
	icon = 'icons/mob/sprite_accessory/tails/feline.dmi'
	icon_state = "catbig"
	variations = list(
		SPRITE_ACCESSORY_VARIATION_WAGGING = "catbig_wag",
	)
	do_colouration = TRUE
	legacy_use_additive_color_matrix = FALSE
	icon_sidedness = SPRITE_ACCESSORY_SIDEDNESS_FRONT_BEHIND

/datum/sprite_accessory/tail/kitty
	name = "kitty, colorable, downwards"
	id = "tail_cat_down"
	icon_state = "kittydown"
	ani_state = "kittydown_wag"
	do_colouration = 1
	legacy_use_additive_color_matrix = FALSE

/*/datum/sprite_accessory/tail/kitty_tg
	name = "kitty, colorable, main"
	id = "tail_cat_tg"
	icon_state = "kittytg"
	ani_state = "kittytg_wag"
	do_colouration = 1
	legacy_use_additive_color_matrix = FALSE
	Currently fucked - Tail renders ontop of the player even if it should be invisible. TODO: Find time to fix this.*/

/datum/sprite_accessory/tail/kittyup
	name = "kitty, colorable, upwards"
	id = "tail_cat_up"
	icon_state = "kittyup"
	ani_state = "kittyup_wag"
	do_colouration = 1
	legacy_use_additive_color_matrix = FALSE

/datum/sprite_accessory/tail/liontail
	name = "Lion Tail (vwag)"
	id = "tail_lion"
	icon_state = "liontail"
	ani_state = "liontail_w"
	do_colouration = 1
	legacy_use_additive_color_matrix = FALSE
	extra_overlay = "liontail_markings"
	extra_overlay_w = "liontail_markings_w"

/datum/sprite_accessory/tail/sneptail
	name = "Snep/Furry Tail (vwag)"
	id = "tail_snowleopard"
	icon_state = "sneptail"
	ani_state = "sneptail_w"
	do_colouration = 1
	legacy_use_additive_color_matrix = FALSE
	extra_overlay = "sneptail_mark"
	extra_overlay_w = "sneptail_mark_w"
