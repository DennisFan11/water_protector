extends Node2D
var resolution:Vector2 = Vector2(1280,720):
	set(new):
		_set_resolution(self,new)
		resolution = new
var k = 0.5:
	set(new):
		k=new
		_set_parameter()
var border_line = 2.0:
	set(new):
		border_line=new
		_set_parameter()
var border_color = Vector3(0.0,0.0,-1.0):
	set(new):
		border_color=new
		_set_parameter()

var pressure_layer:int = 50
var jacobi_layer:int = 20

func _ready():
	_set_resolution(self,resolution)
	_set_parameter()
	
	
	
	
	
func _process(delta):
	RenderingServer.global_shader_parameter_set("sim_delta_time",delta)


func _set_pressure_viewport():
	var path:Object = $pressure_viewport
	var node:Object
	for i in range(pressure_layer):
		node = SubViewportContainer.new()
		path.add_child(node)
		path = node
		node = SubViewport.new()
		path.add_child(node)
		path = node
	node = Sprite2D.new()
	path.add_child(node)
	
	
	
	
func _set_parameter():
	RenderingServer.global_shader_parameter_set("sim_k",k)
	RenderingServer.global_shader_parameter_set("sim_border_line",border_line)
	RenderingServer.global_shader_parameter_set("sim_border_color",border_color)
	RenderingServer.global_shader_parameter_set("sim_input",$input_viewport.get_texture())
	
func _set_resolution(node:Object,new:Vector2):# dfs viewport初始化
	if node.is_class("SubViewport"):
		node.set_size(new) # 解析度
		node.set_use_hdr_2d(true) # HDR
		node.set_transparent_background(true) # 透明背景
	for i in node.get_children():
		_set_resolution(i,new)



