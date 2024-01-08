shader_type canvas_item;
void fragment() {
	COLOR = texture(TEXTURE,UV);
	//COLOR.a = (COLOR.r+COLOR.g+COLOR.b)/3.0;
}