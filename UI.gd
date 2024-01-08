extends Control
@onready var texture = Global.FluidServer.get_node("output/dye_output").get_texture()
@onready var final_bar:ProgressBar = $Panel/final_pollution/ProgressBar
@onready var pollution_bar:ProgressBar = $Panel/pollution/ProgressBar
@onready var money_text:Label = $Panel/money
var scanner = []
func _process(delta):
	var img = texture.get_image()
	var tot:float = 680
	var attemp: float = 0
	for i in range(20,700): #0~720
		var pixel:Color = img.get_pixel(1260, i)
		var black = (pixel.r + pixel.g + pixel.b)/3.0 * pixel.a
		if black <= 0.15:
			attemp+=1
	for i in scanner:
		i[0].color = str(img.get_pixel(i[1].x, i[1].y))
	Global.fin_pollution = float(attemp/tot)*100
	final_bar.value = Global.fin_pollution
	pollution_bar.value = Global.pollution
	money_text.text = "money:" + str(Global.money)
