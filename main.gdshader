shader_type canvas_item;
uniform float R=1.;
uniform float G=1.;
uniform float B=1.;
void fragment() {
	COLOR = abs(texture(TEXTURE, UV));
	COLOR.r*=R;
	COLOR.g*=G;
	COLOR.b*=B;
}