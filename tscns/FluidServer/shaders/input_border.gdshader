shader_type canvas_item;
global uniform float sim_border_line;
global uniform vec3 sim_border_color;
void fragment() {
	vec2 pixel = TEXTURE_PIXEL_SIZE;
	COLOR = texture(TEXTURE,UV);
	if (UV.x <= pixel.x*sim_border_line){
		COLOR.rgb = sim_border_color;}
	else if (UV.y <= pixel.y*sim_border_line){
		COLOR.rgb = sim_border_color;}
	else if (UV.x >= 1.0 - pixel.x*sim_border_line){
		COLOR.rgb = sim_border_color;}
	else if (UV.y >= 1.0 - pixel.y*sim_border_line){
		COLOR.rgb = sim_border_color;}
	COLOR.a = 1.0;
}