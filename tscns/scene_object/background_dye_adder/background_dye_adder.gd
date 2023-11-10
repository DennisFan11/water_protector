extends Node2D
var obj
func _ready():
	obj = Global.FluidServer.RegDyeObj($SubViewport.get_texture())
	add_child(obj)
	obj.position = Vector2(20,360.0)
	obj.visible = true

