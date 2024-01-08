extends Node2D
var resolution:Vector2 = Vector2(1280,720):
	set(new):
		_set_resolution(self,new)
		resolution = new
var k = 1.0:
	set(new):
		k=new
		_set_parameter()
var border_line = 4.0:
	set(new):
		border_line=new
		_set_parameter()
var border_color = Vector3(0.0,0.0,-1.0):
	set(new):
		border_color=new
		_set_parameter()
var viscosity_scale = 64
var vorticity = 2

var pressure_layer:int = 25#50
var jacobi_layer:int = 20#40

var pressure_shader:Shader = preload("res://tscns/FluidServer/shaders/pressure.gdshader")
var jacobi_shader:Shader = preload("res://tscns/FluidServer/shaders/jacobi.gdshader")
@onready var input_viewport = $input_viewport/shader/ctrl_viewport
@onready var dye_viewport = $output/fluid_viewport/buffer/SubViewport
@onready var pollution_viewport = $output/pollution_viewport/SubViewportContainer/SubViewport

@onready var dye_output = $output/dye_output.get_texture()
@onready var field_output = $output/field_output.get_texture()
@onready var pollution_output = $output/pollution_output.get_texture()
func _ready():
	_set_resolution(self,resolution)
	_set_parameter()
	_spawn_viewport($jacobi_viewport,jacobi_shader,jacobi_layer).set_texture($advect_viewport.get_texture())
	_spawn_viewport($pressure_viewport,pressure_shader,pressure_layer).set_texture($divergence_viewport.get_texture())
	
	
	

func _process(delta):
	RenderingServer.global_shader_parameter_set("sim_delta_time",delta)


var DyeShader = preload("res://tscns/FluidServer/objects/dye.gdshader")
var BorderShader = preload("res://tscns/FluidServer/objects/border.gdshader")
var EmitterShader = preload("res://tscns/FluidServer/objects/emitter.gdshader")
func RegDyeObj(text:Texture2D):#註冊實例
	var object = Sprite2D.new()
	object.texture = text
	object.material = ShaderMaterial.new()
	object.material.set_shader(DyeShader.duplicate(true))
	dye_viewport.add_child(object)
	return(object)
	
func RegBordObj(text:Texture2D):
	var object = Sprite2D.new()
	object.texture = text
	object.material = ShaderMaterial.new()
	object.material.set_shader(BorderShader.duplicate(true))
	input_viewport.add_child(object)
	return(object)

func RegVecObj(text:Texture2D):
	var object = Sprite2D.new()
	object.texture = text
	input_viewport.add_child(object)
	return(object)
	
func RegEmitObj(text:Texture2D):
	var object = Sprite2D.new()
	object.texture = text
	object.material = ShaderMaterial.new()
	object.material.set_shader(EmitterShader.duplicate(true))
	input_viewport.add_child(object)
	return(object)
	
func RegPollutionObj(text:Texture2D):
	var object = Sprite2D.new()
	object.texture = text
	object.material = ShaderMaterial.new()
	object.material.set_shader(DyeShader.duplicate(true))
	pollution_viewport.add_child(object)
	return(object)




func _spawn_viewport(path:Object,shader:Shader,layer:int):
	var origin:Object = path
	var node:Object
	for i in range(layer):
		node = SubViewportContainer.new()
		path.add_child(node)
		var m = ShaderMaterial.new()
		m.set_shader(shader.duplicate(true))
		node.material = m
		path = node
		node = SubViewport.new()
		path.add_child(node)
		path = node
	node = Sprite2D.new()
	path.add_child(node)
	_set_resolution(origin,resolution)
	return node
func _set_parameter():
	RenderingServer.global_shader_parameter_set("sim_k",k)
	RenderingServer.global_shader_parameter_set("sim_border_line",border_line)
	RenderingServer.global_shader_parameter_set("sim_border_color",border_color)
	RenderingServer.global_shader_parameter_set("sim_viscosity_scale",viscosity_scale)
	RenderingServer.global_shader_parameter_set("sim_vorticity",vorticity)
	RenderingServer.global_shader_parameter_set("sim_input",$input_viewport.get_texture())
	
func _set_resolution(node:Object,new:Vector2):# dfs viewport初始化
	for i in node.get_children():
		_set_resolution(i,new)
		
	if node.is_class("SubViewport"):
		node.set_size(new) # 解析度
		node.set_use_hdr_2d(true) # HDR
		node.set_transparent_background(true) # 透明背景
		node.set_update_mode(4) # 始终更新渲染目标
	if node.is_class("Sprite2D"):
		node.position = resolution/2




