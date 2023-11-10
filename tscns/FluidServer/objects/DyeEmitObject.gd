class_name DyeEmitObject
extends Node
var texture:Texture2D
var position:Vector2

var agent:Sprite2D
var rotation = 0
var visible = false	
var shader = preload("res://tscns/FluidServer/objects/dye.gdshader")
func _sync():
	var m = ShaderMaterial.new()
	m.set_shader(shader.duplicate(true))
	agent.material = m
	
	
	
func _process(delta):
	agent.position = position
	agent.rotation = rotation
	agent.visible = visible
	
func _exit_tree():
	agent.queue_free()
