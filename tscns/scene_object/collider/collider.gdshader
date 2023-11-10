shader_type canvas_item;
void fragment() {
	COLOR = vec4(sin(TIME*2.0)/2.0+0.5,sin(TIME*2.0)/2.0+0.5,1.0,1.0);
}