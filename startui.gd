extends Control
var tscn = preload("res://main.tscn")
func _on_button_button_down():
	$Panel.visible = 0
	add_child(tscn.instantiate())
	
	
