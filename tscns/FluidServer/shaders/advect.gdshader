shader_type canvas_item;
global uniform float sim_k;
global uniform float sim_delta_time; //時間步長 delta time
global uniform sampler2D sim_input;
global uniform vec3 sim_border_color;
vec3 bilerp(sampler2D sampler, vec2 uv, vec2 pixel) {
	vec2 st = uv / pixel - 0.5;
	vec2 uvInt = floor(st);
	vec2 uvFrac = fract(st);
	vec3 a = texture(sampler, (uvInt + vec2(0.5, 0.5)) * pixel).rgb;
	vec3 b = texture(sampler, (uvInt + vec2(1.5, 0.5)) * pixel).rgb;
	vec3 c = texture(sampler, (uvInt + vec2(0.5, 1.5)) * pixel).rgb;
	vec3 d = texture(sampler, (uvInt + vec2(1.5, 1.5)) * pixel).rgb;
	return mix(mix(a, b, uvFrac.x), mix(c, d, uvFrac.x), uvFrac.y);
}

void fragment()
{
	float S = sim_k/sim_delta_time;
	//讀取
	vec2 pixel = 1.0/vec2(1280.0,720.0);
	vec3 v0 = texture(TEXTURE,UV).rgb;
	vec3 v1 = texture(TEXTURE,vec2(UV.x + pixel.x, UV.y)).rgb;
	vec3 v2 = texture(TEXTURE,vec2(UV.x - pixel.x, UV.y)).rgb;
	vec3 v3 = texture(TEXTURE,vec2(UV.x, UV.y + pixel.y)).rgb;
	vec3 v4 = texture(TEXTURE,vec2(UV.x, UV.y - pixel.y)).rgb;
	
	// du / dx , du / dy
	//压力项
	//平流项
	vec2 laplacian = v1.xy + v2.xy + v3.xy + v4.xy - 4.0*v0.xy;
	//反向求解
	vec2 pos = UV - S*pixel*v0.rg; 
	v0.rgb = bilerp(TEXTURE, pos, pixel); //双线性插值
	//v0.rgb = clamp(v0.rgb, vec3(vec2(-10.0),0.5), vec3(vec2(10.0),3.0));//範圍限制
	COLOR.rgb = v0.rgb;
	if(texture(sim_input,UV+COLOR.rg*S*TEXTURE_PIXEL_SIZE).rgb == sim_border_color){
		COLOR.rg*=-1.0;
	}
	
	COLOR.a = 1.0;
}