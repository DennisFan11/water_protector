extends Node2D
var FluidServer
var draging:bool
var cancel:bool
var UI:Object
var card_pool:Object

var pollution:int
var fin_pollution:int
var money:int
var black:int
var green:int
var brown:int
func _process(delta):
	if get_global_mouse_position().x>=1060:
		cancel = true
	else:
		cancel = false
var card_respawn_time:float = 3 #s
var card_textures = {
	#--------------------------pollution_cards--------------------------
	"SPM":preload("res://asset/pollution_cards/SPM_card.png"),
	"acid":preload("res://asset/pollution_cards/acid_card.png"),
	"organic_pollution":preload("res://asset/pollution_cards/Organic Pollution_card.png"),
	"heavy_metal":preload("res://asset/pollution_cards/Heavy_Metal_card.png"),
	#--------------------------buildings-----------
	"monitoring_station":preload("res://asset/building_cards/monitoring_station.png"),
	"water_filter":preload("res://asset/building_cards/water_filter.png"),
	#--------------------------natural---------------
	"rainstorm":preload("res://asset/natural_cards/rainstorm_card.png"),
	"temperature":preload("res://asset/natural_cards/temperature_card.png"),
	#--------------------------purification---------------
	"biodiversity":preload("res://asset/purification_cards/biodiversity_card.png"),
	"volunteer":preload("res://asset/purification_cards/volunteer_card.png"),
	#--------------------------planing--------------
	"education":preload("res://asset/planning_cards/environmental_education_card.png"),
	"prevention":preload("res://asset/planning_cards/crisis_prevention_card.png"),
	"cooperation":preload("res://asset/planning_cards/water_cooperation_card.png")
}
func get_random_card() -> String:
	return card_textures.keys().pick_random()
func _get_good_card() -> String:
	var good = ["biodiversity","volunteer"].pick_random()
	return good
func _get_bad_card() -> String:
	var good = ["SPM","acid","organic_pollution","heavy_metal"].pick_random()
	return good










