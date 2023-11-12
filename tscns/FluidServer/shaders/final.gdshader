shader_type canvas_item;
uniform sampler2D input;
uniform sampler2D jacobi;
uniform sampler2D pressure;

global uniform float sim_vorticity;
global uniform float sim_k;
global uniform float sim_delta_time; //時間步長 delta time
global uniform float sim_border_line;
global uniform vec3 sim_border_color;

float curl(sampler2D tex, vec2 uv, vec2 pixel) {
	float p1 = texture(tex,vec2(uv.x + pixel.x, uv.y)).g;
	float p2 = texture(tex,vec2(uv.x - pixel.x, uv.y)).g;
	float p3 = texture(tex,vec2(uv.x, uv.y + pixel.y)).r;
	float p4 = texture(tex,vec2(uv.x, uv.y - pixel.y)).r;
	return(p1-p2+p4-p3);
}
bool check(vec2 uv, vec2 pixel){
	bool a = (texture(input,uv).rgb==sim_border_color);
	bool b = (texture(input,vec2(uv.x + pixel.x, uv.y)).rgb==sim_border_color);
	bool c = (texture(input,vec2(uv.x - pixel.x, uv.y)).rgb==sim_border_color);
	bool d = (texture(input,vec2(uv.x, uv.y + pixel.y)).rgb==sim_border_color);
	bool e = (texture(input,vec2(uv.x, uv.y - pixel.y)).rgb==sim_border_color);
	return (a || b || c || d || e);
}
void fragment() {
	vec2 pixel = TEXTURE_PIXEL_SIZE;
	vec3 a = texture(input,UV).rgb;
	vec3 b = texture(jacobi,UV).rgb;
	float p0 = texture(pressure,UV).b;
	float p1 = texture(pressure,vec2(UV.x + pixel.x, UV.y)).b;
	float p2 = texture(pressure,vec2(UV.x - pixel.x, UV.y)).b;
	float p3 = texture(pressure,vec2(UV.x, UV.y + pixel.y)).b;
	float p4 = texture(pressure,vec2(UV.x, UV.y - pixel.y)).b;
	
	
	//p0 = clamp(p0,0.5,30.0);//範圍限制
	COLOR.rg = b.rg - vec2(p1-p2,p3-p4)*0.5;//壓力向量
	COLOR.b = p0;//壓力
	
	//重力
	//COLOR.rg += vec2(0,0.005)*COLOR.b;
	//邊界條件
	if(a == sim_border_color){
		
		COLOR.rgb = vec3(0.0);
		float totp = 0.;
		vec2 totv = vec2(0.);
		if(texture(input,vec2(UV.x + pixel.x, UV.y)).rgb != sim_border_color){
			totp+=p1;
			totv+=texture(jacobi,vec2(UV.x + pixel.x, UV.y)).rg*-1.;
		}
		if(texture(input,vec2(UV.x - pixel.x, UV.y)).rgb != sim_border_color){
			totp+=p2;
			totv+=texture(jacobi,vec2(UV.x - pixel.x, UV.y)).rg*-1.;
		}
		if(texture(input,vec2(UV.x, UV.y + pixel.y)).rgb != sim_border_color){
			totp+=p3;
			totv+=texture(jacobi,vec2(UV.x, UV.y + pixel.y)).rg*-1.;
		}
		if(texture(input,vec2(UV.x, UV.y - pixel.y)).rgb != sim_border_color){
			totp+=p4;
			totv+=texture(jacobi,vec2(UV.x, UV.y - pixel.y)).rg*-1.;
		}
		COLOR.b = totp*1.;
		COLOR.rg = totv*2.;
	}else{
		//vorticity
		/*
		bool a1 = check(vec2(UV.x + pixel.x, UV.y),pixel);
		bool a2 = check(vec2(UV.x - pixel.x, UV.y),pixel);
		bool a3 = check(vec2(UV.x, UV.y + pixel.y),pixel);
		bool a4 = check(vec2(UV.x, UV.y - pixel.y),pixel);
		if(!(a1||a2||a3||a4)){
			float x = abs(curl(jacobi, vec2(UV.x + pixel.x, UV.y), pixel)) - abs(curl(jacobi, vec2(UV.x - pixel.x, UV.y), pixel));
			float y = abs(curl(jacobi, vec2(UV.x, UV.y + pixel.y), pixel)) - abs(curl(jacobi, vec2(UV.x, UV.y - pixel.y), pixel));
			vec2 dir = sim_vorticity * vec2(x,y) / (length(vec2(x,y)) + 1e-5);
			vec2 v = dir * curl(jacobi, UV, pixel);
			COLOR.rg +=v;
		}
		
		*/
		/*
		float x = (curl(jacobi, vec2(UV.x + pixel.x, UV.y), pixel)) - (curl(jacobi, vec2(UV.x - pixel.x, UV.y), pixel));
		float y = (curl(jacobi, vec2(UV.x, UV.y + pixel.y), pixel)) - (curl(jacobi, vec2(UV.x, UV.y - pixel.y), pixel));
		vec2 dir = sim_vorticity * vec2(x,y) / (length(vec2(x,y)) + 0.00001);
		vec2 v = dir * curl(jacobi, UV, pixel);
		COLOR.rg +=v;
		*/
		
		
		COLOR.rgb += a;	//外力
	}
	COLOR.a = 1.0;
}

