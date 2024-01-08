shader_type canvas_item;
uniform float desolve = -0.1;
global uniform sampler2D card_noise;
void fragment() {
	float noise = texture(card_noise,UV).r;
	COLOR = texture(TEXTURE,UV);
	if(noise-0.1 <= desolve && desolve <= noise){
		COLOR.r = 1.0;
	}else if(noise <= desolve){
		discard;
	}
}
