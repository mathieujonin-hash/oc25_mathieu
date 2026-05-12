shader_type spatial;

uniform vec4 glow_color : source_color = vec4(0.2, 0.8, 1.0, 1.0);

// 👉 variable réglable dans l’inspecteur par matériau
uniform float module_seed = 0.0;

uniform float speed = 0.3;

float hash(float n) {
    return fract(sin(n) * 43758.5453);
}

void fragment() {

    vec2 id = floor(NODE_POSITION_WORLD.xz);

    float t = TIME * speed;

    // seed + position = unicité module
    float base = hash(module_seed + id.x * 12.1 + id.y * 91.7);

    float anim = sin(t + base * 6.2831) * 0.5 + 0.5;

    float glow_strength = mix(0.3, 1.2, anim);

    ALBEDO = glow_color.rgb * 0.2;
    EMISSION = glow_color.rgb * glow_strength;
}