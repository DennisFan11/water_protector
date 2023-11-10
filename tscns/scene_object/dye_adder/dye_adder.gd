extends Node2D
var obj:Object
func _ready():
	obj = Global.FluidServer.RegDyeObj($SubViewport.get_texture())
	add_child(obj)
var time = 0


func _process(delta):
	time+=delta
	obj.position = get_global_mouse_position()
	obj.rotation = time
	obj.visible = Input.is_action_pressed("left_key")
	
	
