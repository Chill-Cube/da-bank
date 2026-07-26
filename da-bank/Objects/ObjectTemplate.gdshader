shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float thickness : hint_range(0.0, 10.0) = 2.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);

	if (col.a < 1.0) {
		vec2 texel = thickness / vec2(textureSize(TEXTURE, 0));

		float alpha = 0.0;
		alpha += texture(TEXTURE, UV + vec2(texel.x, 0.0)).a;
		alpha += texture(TEXTURE, UV + vec2(-texel.x, 0.0)).a;
		alpha += texture(TEXTURE, UV + vec2(0.0, texel.y)).a;
		alpha += texture(TEXTURE, UV + vec2(0.0, -texel.y)).a;
		alpha += texture(TEXTURE, UV + vec2(texel.x, texel.y)).a;
		alpha += texture(TEXTURE, UV + vec2(-texel.x, texel.y)).a;
		alpha += texture(TEXTURE, UV + vec2(texel.x, -texel.y)).a;
		alpha += texture(TEXTURE, UV + vec2(-texel.x, -texel.y)).a;

		if (alpha > 0.0) {
			col = outline_color;
			col.a = min(alpha, 1.0);
		}
	}

	COLOR = col;
}