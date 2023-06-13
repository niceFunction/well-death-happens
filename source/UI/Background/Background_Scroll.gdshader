shader_type canvas_item;

uniform vec2 Direction = vec2(1.0, -1.0);
uniform float ScrollSpeed = 0.04;

void fragment()
{
	COLOR = texture(TEXTURE, UV + (Direction * TIME * ScrollSpeed));
}