extends Node2D
var obj:Object
func _ready():
	obj = Global.FluidServer.RegEmitObj($SubViewport.get_texture())
	add_child(obj)
func _process(delta):
	obj.vec = Vector3(1.0,0.0,0.1)
	obj.position = global_position
