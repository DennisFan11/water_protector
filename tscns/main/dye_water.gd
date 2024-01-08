extends Marker2D
@export var texture:Texture2D
var _obj:Object


func _ready():
	_obj = Global.FluidServer.RegDyeObj(texture)
	_obj.position = global_position
var time =0
func _process(delta):
	var poll = float(Global.pollution)/100.0
	texture.color_ramp.set_offsets([0,poll,poll,1])
	texture.noise.offset.x += delta*20
	
	
