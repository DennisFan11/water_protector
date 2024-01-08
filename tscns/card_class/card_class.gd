extends TextureButton
class_name card #62*87
				#124*174
const normal_scale = Vector2(1,1)
const anime_time = 0.1
var default_texture = preload("res://card.png")
var stat_output:Label
var stat:String
var card_type:String
var desolve:float = -0.12
func _init():
	z_index = 3
	texture_normal = default_texture
	scale = normal_scale
	pivot_offset = Vector2(62,87)
	
var shader = preload("res://tscns/card_class/card_desolve.gdshader")
func _ready():
	stat = "normal"
	mouse_entered.connect(_mouse_in)
	mouse_exited.connect(_mouse_out)
	button_down.connect(_draging)
	button_up.connect(_dis_draging)
	stat_output = Label.new()
	add_child(stat_output)
	#----------shader
	var mater = ShaderMaterial.new()
	mater.set_shader(shader.duplicate(true))
	mater.set_shader_parameter("desolve", desolve)
	material = mater

func _process(delta):
	#stat_output.text = "stat:"+stat
	match stat:
		"draging":
			global_position = get_global_mouse_position() + drag_pos
		"deleting":
			z_index = 1
			material.set_shader_parameter("desolve", desolve)
	
	
func _mouse_in():
	var tween = get_tree().create_tween()
	z_index = 4
	match stat:
		"normal":
			tween.tween_property(self,"scale",Vector2(0.75,1.25),anime_time)
			tween.tween_property(self,"scale",Vector2(1.25,0.75),anime_time)
			tween.tween_property(self,"scale",normal_scale,anime_time)
		"ready", "draging":
			tween.tween_property(self,"scale",Vector2(1.5,1.5),anime_time)
func _mouse_out():
	z_index = 3
	match  stat:
		"normal":
			pass
		"ready", "draging":
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scale",normal_scale,anime_time)

func decide_contain(stat:int):
	match stat:
		0:
			card_type = Global.get_random_card()
		1:
			card_type = Global._get_good_card()
		2:
			card_type = Global._get_bad_card()
	texture_normal = Global.card_textures[card_type]
	
var drag_pos:Vector2 #相對屬標座標
func _draging():
	match stat:
		"ready":
			Global.draging = true
			stat = "draging"
			drag_pos = global_position - get_global_mouse_position()
func _dis_draging():
	match stat:
		"draging":
			stat = "ready"
			Global.draging = false
			if Global.cancel == false and _money_check():
				scale = normal_scale
				stat = "deleting"
				z_index = 1
				last_pos = get_global_mouse_position()
				_effect()
				
var last_pos:Vector2
func _desolve():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"desolve",1,anime_time*8)
	tween.tween_callback(queue_free)
func _add_dye():
	visible = 0
	var dye_obj = Global.FluidServer.RegDyeObj(Global.card_textures[card_type])
	dye_obj.position = global_position
	dye_obj.position += pivot_offset
	dye_obj.rotation = rotation
	dye_obj.z_index = 2
	var tween = get_tree().create_tween()
	await get_tree().process_frame
	await get_tree().process_frame
	dye_obj.queue_free()
	queue_free()
func _effect():
	match card_type:
		"SPM":
			Global.pollution += 1
			Global.money += 100
			Global.black += 1
			_desolve()
			#_add_dye()
		"acid":
			Global.green += 2
			Global.pollution += 2
			Global.money += 250
			_desolve()
			#_add_dye()
		"organic_pollution":
			Global.green += 3
			Global.pollution += 3
			Global.money += 400
			_desolve()
			#_add_dye()
		"heavy_metal":
			Global.brown += 4
			Global.pollution += 4
			Global.money += 600
			_desolve()
			#_add_dye()
		#--------------------------
		"monitoring_station":
			_scanner()
			_desolve()
		"water_filter":
			_fliter()
			_desolve()
		#--------------------------
		"rainstorm":
			Global.FluidServer.k *= 1.5
			_desolve()
		"temperature":
			Global.FluidServer.k *= 1.2
			_desolve()
		#--------------------------
		"biodiversity":
			Global.card_pool._add_a_g_card()
			Global.card_pool._add_a_g_card()
			Global.pollution -= 8
			_desolve()
		"volunteer":
			Global.pollution -= 2
			_desolve()
		#--------------------------
		"education":
			Global.card_pool._add_a_g_card()
			Global.card_pool._add_a_b_card()
			_desolve()
		"prevention":
			Global.card_pool._add_a_g_card()
			_desolve()
		"cooperation":
			Global.card_pool._add_a_g_card()
			_desolve()
			
@onready var scanner = preload("res://tscns/scene_object/scanner/scanner.tscn")
func _scanner():
	var s = scanner.instantiate()
	s.position = last_pos
	Global.UI.add_child(s)


@onready var fliter = preload("res://asset/fliter.png")
func _fliter():
	Global.FluidServer.RegDyeObj(fliter).position = last_pos
			
func _money_check()-> bool:
	var r = true
	var need:int = 0
	match card_type:
		"SPM":
			pass
		"acid":
			pass
		"organic_pollution":
			pass
		"heavy_metal":
			pass
		#--------------------------
		"monitoring_station":
			need = 100
		"water_filter":
			need = 1000
		#--------------------------
		"rainstorm":
			pass
		"temperature":
			pass
		#--------------------------
		"biodiversity":
			need = 800
		"volunteer":
			need = 300
		#--------------------------
		"education":
			pass
		"prevention":
			pass
		"cooperation":
			pass
	if Global.money < need:
		r = false
	else:
		Global.money-=need
		r = true
	return r


