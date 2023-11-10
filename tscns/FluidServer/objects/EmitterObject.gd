class_name EmitterObject
extends Node
var texture:Texture2D
var position:Vector2
var agent:Sprite2D

var vec:Vector3:
	set(new):
		vec = new
		agent.material.set_shader_parameter("vec",vec)
var rotation = 0
		
var shader = preload("res://tscns/FluidServer/objects/emitter.gdshader")
func _sync():
	var m = ShaderMaterial.new()
	m.set_shader(shader.duplicate(true))
	agent.material = m
	
	
	
func _process(delta):
	agent.position = position
	agent.rotation = rotation
	
func _exit_tree():
	agent.queue_free()






