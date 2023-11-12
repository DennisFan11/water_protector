shader_type canvas_item;
uniform vec3 vec = vec3(1.0,0.0,1.0);
void fragment() {
	COLOR = vec4(vec,1.0);
	COLOR.r+=sin(TIME)*0.001;
}