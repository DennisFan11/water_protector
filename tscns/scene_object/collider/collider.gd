extends Node2D
var Bobj:Object
@export var pos:Vector2
@export var rot_speed:int
var ratio:float
func _ready():
	Bobj = Global.FluidServer.RegBordObj($SubViewport.get_texture())
var time = 0
func _process(delta):
	time+=delta
	Bobj.position = pos
	Bobj.rotation = time*ratio
