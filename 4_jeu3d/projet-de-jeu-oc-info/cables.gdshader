shader_type spatial;

uniform float custom_time;
uniform float speed = 1.0;
uniform float emission_strength = 4.0;

void fragment() {

	float t = custom_time * speed;

	float pos = UV.x * 0.1;

	float travel = fract(t);

	float d = abs(pos - travel);

	float pulse = exp(-d * 25.0);

	vec3 color = vec3(0.0, 0.0, 0.4) * pulse;

	ALBEDO = color;
	EMISSION = color * emission_strength;
}