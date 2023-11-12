shader_type canvas_item;
global uniform sampler2D sim_input;
global uniform vec3 sim_border_color;
void fragment() {
	vec2 pixel = TEXTURE_PIXEL_SIZE;
	vec3 v0 = texture(TEXTURE,UV).rgb;
	vec3 v1 = texture(TEXTURE,vec2(UV.x + pixel.x, UV.y)).rgb;
	vec3 v2 = texture(TEXTURE,vec2(UV.x - pixel.x, UV.y)).rgb;
	vec3 v3 = texture(TEXTURE,vec2(UV.x, UV.y + pixel.y)).rgb;
	vec3 v4 = texture(TEXTURE,vec2(UV.x, UV.y - pixel.y)).rgb;
	float divergence = (v1.x - v2.x + v3.y - v4.y)*0.5;
	COLOR.r = divergence;
	/*
	if(texture(sim_input,vec2(UV.x + pixel.x, UV.y)).rgb == sim_border_color){
		COLOR.r = 0.0;
	}if(texture(sim_input,vec2(UV.x - pixel.x, UV.y)).rgb == sim_border_color){
		COLOR.r = 0.0;
	}if(texture(sim_input,vec2(UV.x, UV.y + pixel.y)).rgb == sim_border_color){
		COLOR.r = 0.0;
	}if(texture(sim_input,vec2(UV.x, UV.y - pixel.y)).rgb == sim_border_color){
		COLOR.r = 0.0;
	}*/
	COLOR.b = v0.b;
	COLOR.a = 1.0;
}