class_name BorderObject
extends Node
var texture:Texture2D
var position:Vector2
var agent:Sprite2D
var shader = preload("res://tscns/FluidServer/objects/border.gdshader")
var rotation = 0
func _sync():
	var m = ShaderMaterial.new()
	m.set_shader(shader.duplicate(true))
	agent.material = m

	
func _process(delta):
	agent.position = position
	agent.rotation = rotation
func _exit_tree():
	agent.queue_free()




