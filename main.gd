extends Node
func _enter_tree():
	Global.FluidServer = $FluidServer
func _ready():
	$Scene/field_output.texture = $FluidServer/output/field_output.get_texture()
	$Scene/dye_output.texture = $FluidServer/output/dye_output.get_texture()
	$Scene/field_output.position = Global.FluidServer.resolution/2
	$Scene/dye_output.position = Global.FluidServer.resolution/2
	
func _process(delta):
	pass
