shader_type canvas_item;
void fragment() {
	COLOR = abs(texture(TEXTURE,UV));
	//COLOR.b*=30.0;
}