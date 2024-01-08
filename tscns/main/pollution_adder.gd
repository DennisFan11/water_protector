extends Marker2D
@export var black:Texture2D
@export var green:Texture2D
@export var brown:Texture2D
func _ready():
	Global.FluidServer.RegDyeObj(black).position = global_position
	Global.FluidServer.RegDyeObj(green).position = global_position
	Global.FluidServer.RegDyeObj(brown).position = global_position
	

func _process(delta):
	var poll = float(Global.black)/100.0
	black.color_ramp.set_offsets([0,poll,poll,1])
	poll = float(Global.green)/100.0
	green.color_ramp.set_offsets([0,poll,poll,1])
	poll = float(Global.brown)/100.0
	brown.color_ramp.set_offsets([0,poll,poll,1])
	
	
	
	
	
	
	
	
