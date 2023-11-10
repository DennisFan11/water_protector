extends Node2D
var Bobj:Object
@export var pos:Vector2
@export var rot_speed:int
func _ready():
	Bobj = Global.FluidServer.RegBordObj($SubViewport.get_texture())
	add_child(Bobj)
var time = 0
func _process(delta):
	time+=delta*rot_speed
	Bobj.position = pos
	Bobj.rotation = time
