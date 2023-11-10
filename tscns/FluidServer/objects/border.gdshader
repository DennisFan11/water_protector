shader_type canvas_item;
global uniform vec3 sim_border_color;
void fragment() {
	if(texture(TEXTURE,UV).a != 0.0){
		COLOR.rgb = sim_border_color;
		COLOR.a = 1.0;
	}
}