shader_type canvas_item;
uniform sampler2D field;
global uniform sampler2D sim_input;
global uniform vec3 sim_border_color;
global uniform float sim_k;
global uniform float sim_delta_time; //時間步長 delta time
void fragment() {
	float s = sim_k/sim_delta_time;
	vec2 uv = texture(field,UV).rg*s*TEXTURE_PIXEL_SIZE/2.0;
	COLOR = texture(TEXTURE,UV-uv);
	
	
	if(texture(sim_input,UV).rgb == sim_border_color){
		COLOR = vec4(0.0);
	}
	//COLOR.a = texture(field,uv).b;
}