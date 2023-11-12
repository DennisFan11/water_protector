extends Control
var stat:Sprite2D
var text:Texture2D = preload("res://icon.svg")

var vis:bool
var zoom:float = 1.0
func _ready():
	$"../Scene/collider".ratio = 1
	$"../Scene/collider2".ratio = -1
	
func _process(delta):
	$Panel/HBoxContainer/Panel2/Label.text = str("fps:",\
	Performance.get_monitor(0),"\n",\
	"vram:",int(Performance.get_monitor(14)/1000000),"MB" )
	if stat:
		stat.position = get_global_mouse_position()
		stat.visible = vis
		stat.scale = Vector2(zoom,zoom)
		
	
func _unhandled_input(event):
	if event.is_action_pressed("left_key"):
		vis = true
	elif event.is_action_released("left_key"):
		vis = false
	
	if event.is_action("roll_up"):
		zoom*=1.1
	elif event.is_action("roll_down"):
		zoom*=0.9
		
func _on_button_pressed(): #染料
	if stat:
		stat.queue_free()
	stat = Global.FluidServer.RegDyeObj(text)
	$Panel/HBoxContainer/Button.button_pressed = true
	$Panel/HBoxContainer/Button2.button_pressed = false
	$Panel/HBoxContainer/Button3.button_pressed = false


func _on_button_2_pressed(): #向量
	if stat:
		stat.queue_free()
	stat = Global.FluidServer.RegVecObj(text)
	$Panel/HBoxContainer/Button.button_pressed = false
	$Panel/HBoxContainer/Button2.button_pressed = true
	$Panel/HBoxContainer/Button3.button_pressed = false


func _on_button_3_pressed(): #碰撞
	if stat:
		stat.queue_free()
	stat = Global.FluidServer.RegBordObj(text)
	$Panel/HBoxContainer/Button.button_pressed = false
	$Panel/HBoxContainer/Button2.button_pressed = false
	$Panel/HBoxContainer/Button3.button_pressed = true


func _on_r_toggled(toggled_on):
	$"../Scene/field_output".material.set_shader_parameter("R",float(toggled_on))

func _on_g_toggled(toggled_on):
	$"../Scene/field_output".material.set_shader_parameter("G",float(toggled_on))


func _on_b_toggled(toggled_on):
	$"../Scene/field_output".material.set_shader_parameter("B",float(toggled_on))


func _on_dye_toggled(toggled_on):
	$"../Scene/dye_output".visible = toggled_on


func _on_v_slider_value_changed(value):
	$"../Scene/collider".ratio = value


func _on_v_slider_2_value_changed(value):
	$"../Scene/collider2".ratio = value*-1


func _on_speed_value_changed(value):
	$"../Scene/water_emitter".obj.material.set_shader_parameter("vec",Vector3(value,0.0,0.2))
