extends Marker2D
@export var texture:Texture2D
var _obj:Object
func _ready():
	_obj = Global.FluidServer.RegEmitObj(texture)
	_obj.position = global_position
	_obj.rotation = global_rotation
func _process(delta):
	texture.noise.offset.x += delta*20
