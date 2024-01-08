shader_type canvas_item;
global uniform sampler2D sim_input;
global uniform vec3 sim_border_color;
global uniform float sim_viscosity_scale;
void fragment() {
	vec2 pixel = TEXTURE_PIXEL_SIZE;
	vec2 v0 = texture(TEXTURE,UV).rg;
	vec2 alpha = TEXTURE_PIXEL_SIZE * TEXTURE_PIXEL_SIZE/sim_viscosity_scale;
	vec2 v1 = texture(TEXTURE,vec2(UV.x + pixel.x, UV.y)).rg;
	vec2 v2 = texture(TEXTURE,vec2(UV.x - pixel.x, UV.y)).rg;
	vec2 v3 = texture(TEXTURE,vec2(UV.x, UV.y + pixel.y)).rg;
	vec2 v4 = texture(TEXTURE,vec2(UV.x, UV.y - pixel.y)).rg;
	int count = 4;
	/*
	if(texture(sim_input,vec2(UV.x + pixel.x, UV.y)).rgb == sim_border_color){
		v1 = vec2(0.0);
		count-=1;
	}if(texture(sim_input,vec2(UV.x - pixel.x, UV.y)).rgb == sim_border_color){
		v2 = vec2(0.0);
		count-=1;
	}if(texture(sim_input,vec2(UV.x, UV.y + pixel.y)).rgb == sim_border_color){
		v3 = vec2(0.0);
		count-=1;
	}if(texture(sim_input,vec2(UV.x, UV.y - pixel.y)).rgb == sim_border_color){
		v4 = vec2(0.0);
		count-=1;
	} */
	vec2 laplacian = (v1 + v2 + v3 + v4 - v0*alpha)/(alpha+float(count));
	COLOR.rg = laplacian;
	COLOR.a = 1.0;
	
}