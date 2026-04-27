shader_type spatial;

uniform float custom_time;
uniform float speed = 1.0;
uniform float emission_strength = 4.0;

void fragment() {

	float t = custom_time * speed;

	// position locale dans le mesh (stable car généré par Path)
	float pos = UV.y;

	float d = abs(pos - fract(t));

	float pulse = exp(-d * 25.0);

	vec3 color = vec3(0.0, 0.0, 0.4) * pulse;

	ALBEDO = color;
	EMISSION = color * emission_strength;
}