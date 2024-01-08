shader_type canvas_item;
global uniform sampler2D sim_input;
global uniform vec3 sim_border_color;
void fragment() {
	int count = 4;
	vec2 pixel = TEXTURE_PIXEL_SIZE;
	float v0 = texture(TEXTURE,UV).r;
	float v1 = texture(TEXTURE,vec2(UV.x + pixel.x, UV.y)).b;
	float v2 = texture(TEXTURE,vec2(UV.x - pixel.x, UV.y)).b;
	float v3 = texture(TEXTURE,vec2(UV.x, UV.y + pixel.y)).b;
	float v4 = texture(TEXTURE,vec2(UV.x, UV.y - pixel.y)).b;
	/*
	if(texture(sim_input,vec2(UV.x + pixel.x, UV.y)).rgb == sim_border_color){
		v1 = 0.0;
		count-=1;
	}if(texture(sim_input,vec2(UV.x - pixel.x, UV.y)).rgb == sim_border_color){
		v2 = 0.0;
		count-=1;
	}if(texture(sim_input,vec2(UV.x, UV.y + pixel.y)).rgb == sim_border_color){
		v3 = 0.0;
		count-=1;
	}if(texture(sim_input,vec2(UV.x, UV.y - pixel.y)).rgb == sim_border_color){
		v4 = 0.0;
		count-=1;
	}*/
	
	float laplacian;
	if(count!=0){
		laplacian = (v1 + v2 + v3 + v4 - v0)/float(count);
	}else{
		laplacian = 0.0;
	}
	
	COLOR.b = laplacian;
	COLOR.r = v0;
	COLOR.a = 1.0;
}