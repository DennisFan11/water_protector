shader_type canvas_item;
uniform float angle;
void fragment() {
	COLOR = texture(TEXTURE,UV);
	vec2 fin = texture(TEXTURE,UV).rg;
	COLOR.r = fin.x*cos(angle) - fin.y*sin(angle);
	COLOR.g = fin.x*sin(angle) + fin.y*cos(angle);
}