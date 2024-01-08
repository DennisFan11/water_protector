extends Marker2D
var color:String
func _ready():
	Global.UI.scanner.append([self,global_position])
func _process(delta):
	$Label.text = str("color=",color)
