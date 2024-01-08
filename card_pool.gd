extends Node2D
var _obj:card
var _time:float = 0
var collid = preload("res://card.png")
func _ready():
	_new_card()
	_add_a_b_card()
	_add_a_b_card()
	_add_a_b_card()
	_add_a_b_card()
	_add_a_b_card()
	_add_a_b_card()
	_add_a_b_card()
	#Global.FluidServer.RegBordObj(collid).position = global_position
	#Global.FluidServer.RegBordObj(collid).position = $sprite.global_position
	
	
func _new_card():
	if _obj:
		_obj.pressed.disconnect(_click)
	_obj = card.new()
	_obj.position = $spawn_pos.global_position
	_obj.pressed.connect(_click)
	$"..".add_child.call_deferred(_obj)
	
func _click():
	if Global.money <100:
		return
	else:
		Global.money -=100
	var type = 0
	var rand = randi_range(1,10)
	if rand<8:
		type = 2
	elif rand<9:
		type = 1
	else:
		type = 0
	
	_obj.decide_contain(0)
	$"../player_cards".cards.append(_obj)
	_new_card()
func _add_a_g_card():
	_obj.decide_contain(1)
	$"../player_cards".cards.append(_obj)
	_new_card()
func _add_a_b_card():
	_obj.decide_contain(2)
	$"../player_cards".cards.append(_obj)
	_new_card()
