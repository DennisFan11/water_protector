extends Node
@export var card_noise:Texture2D
func _enter_tree():
	Global.FluidServer = $FluidServer
func _ready():
	RenderingServer.global_shader_parameter_set("card_noise", card_noise)
	$Scene/field_output.texture = $FluidServer/output/field_output.get_texture()
	$Scene/dye_output.texture = $FluidServer/output/dye_output.get_texture()
	$Scene/pollution_output.texture = $FluidServer/output/pollution_output.get_texture()
	$Scene/field_output.position = Global.FluidServer.resolution/2
	$Scene/dye_output.position = Global.FluidServer.resolution/2
	$Scene/pollution_output.position = Global.FluidServer.resolution/2
	$UI/GG.visible = 0
	Global.pollution = 0
	Global.fin_pollution = 0
	Global.black = 0
	Global.green = 0
	Global.brown = 0
	Global.UI = $UI
	Global.card_pool = $cards/card_pool
var tot_time:float = 0
var end:bool = false
func _process(delta):
	$UI/zone.visible = Global.draging
	$cards/card_pool.visible = not(Global.draging)
	tot_time +=delta
	if tot_time>=15 and Global.fin_pollution>=90 and end == false:
		end = true
		$UI/GG.visible = 1
		await  get_tree().create_timer(5).timeout
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()
	
