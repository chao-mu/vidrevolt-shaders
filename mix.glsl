#version 410

layout (location = 0) out vec4 o;

#pragma input vec3 a
#pragma input vec3 b
#pragma input float mix_fade 0
#pragma input float mix_fade2 0
#pragma input float mix_fade3 0
#pragma input float mix_bars 0
#pragma input float mix_lumin_a 0
#pragma input float mix_lumin_b 0
#pragma input float mix_diff 0

#pragma include includes/ColorSpaces.inc.glsl

in vec2 tc;

uniform float iTime;

float rand(float x) {
    return fract(sin(x * 1234.5434) * 3446.7453);
}

float noise(float x) {
    float i = floor(x);
    float f = fract(x);

    return mix(rand(i), rand(i + 1), f);
}

vec3 mix_bars(vec3 a, vec3 b, float m) {
    float x = tc.x * noise(tc.x * 10 + iTime);
    float n = noise(x * 10 - iTime);

    return n >= m ? a : b;
}

vec3 mix_lumin_a(vec3 a, vec3 b, float m) {
    return get_luminance(a) < m ? b : a;
}

vec3 mix_lumin_b(vec3 a, vec3 b, float m) {
    return get_luminance(a) < m ? a : b;
}

vec3 mix_diff(vec3 a, vec3 b, float m) {
    return mix(a, abs(a - b), m);
}

void main() {
    vec3 a = input_a();
    vec3 b = input_b();
    vec3 col = vec3(0);

    col = mix_lumin_a(a, b, input_mix_lumin_a());
    col = mix_lumin_b(b, col, input_mix_lumin_b());
    col = mix(col, b, input_mix_fade2());
    col = mix(col, b, input_mix_fade3());
    col = mix_bars(col, b, input_mix_bars());
    col = mix_diff(col, b, input_mix_diff());
    col = mix(col, b, clamp(input_mix_fade(), 0, 1));

    o.rgb = col;
    o.a = 1;
}
