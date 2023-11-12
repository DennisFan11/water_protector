extends Node2D
var obj:Object
func _ready():
	obj = Global.FluidServer.RegEmitObj($SubViewport.get_texture())
	obj.material.set_shader_parameter("vec",Vector3(0.1,0.0,0.2))
	obj.position = global_position
	
