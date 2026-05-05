shader_type spatial;

render_mode diffuse_burley;

// --- réglages ---
uniform vec3 base_color : source_color = vec3(0.1, 0.1, 0.5);
uniform vec3 glow_color : source_color = vec3(0.05, 0.1, 0.6);

uniform float pulse_speed = 1.2;
uniform float glow_strength = 6.0;

void fragment() {

    float t = TIME * pulse_speed;

    // 🔹 pulsation simple (énergie vivante)
    float pulse = sin(t) * 0.5 + 0.5;
    pulse = pow(pulse, 2.5);

    // 🔹 fresnel (bords lumineux = volume)
    float fresnel = pow(1.0 - dot(NORMAL, VIEW), 3.0);

    // 🔹 variation simple basée sur orientation du mesh
    float normal_variation = abs(NORMAL.y);

    // 🔹 mélange pour créer une "carte d'énergie"
    float mask = mix(normal_variation, fresnel, 0.6);

    // --- couleur de base ---
    ALBEDO = base_color;

    // --- émission (glow structuré) ---
    EMISSION = glow_color * pulse * mask * glow_strength;
}