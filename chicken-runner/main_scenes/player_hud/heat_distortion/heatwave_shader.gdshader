shader_type canvas_item;

uniform float speed : hint_range(0.0, 10.0) = 1.0;
uniform float distortion_strength : hint_range(0.0, 0.1) = 0.02;
uniform float glow_strength : hint_range(0.0, 1.0) = 0.5;
uniform vec2 wave_scale = vec2(6.0, 6.0);

void fragment() {
    vec2 uv = UV;

    // Time animation
    float t = TIME * speed;

    // Heat wave distortion
    float wave_x = sin((uv.y * wave_scale.y) + t * 2.0) * distortion_strength;
    float wave_y = cos((uv.x * wave_scale.x) + t * 1.5) * distortion_strength;

    uv.y += sin((uv.x * 12.0) + t * 4.0) * distortion_strength;
	uv.x += cos((uv.y * 10.0) + t * 3.0) * distortion_strength;

    // Sample texture
    vec4 tex = texture(TEXTURE, uv);

    // Pulsing glow
    float pulse = sin(TIME * 3.0) * 0.5 + 0.5;

    // Enhance hot colors
    vec3 glow = tex.rgb * glow_strength * pulse;

    // Final color
    COLOR.rgb = tex.rgb + glow * 0.35;
    COLOR.a = tex.a;
}