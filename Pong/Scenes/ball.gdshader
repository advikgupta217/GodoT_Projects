shader_type canvas_item;

uniform vec4 neon_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform float glow_strength = 5.0;

void fragment() {
	// Base texture color
	vec4 tex = texture(TEXTURE, UV);

	// Neon effect
	vec3 glow = neon_color.rgb * glow_strength;

	// Final color
	COLOR = vec4(tex.rgb * glow, tex.a);
}
