#version 410

layout (location = 0) out vec3 o;

#pragma input vec3 a
#pragma input vec3 b
#pragma input vec3 reference
#pragma input float time
#pragma input float mix 1
#pragma input float bands 6

#pragma include includes/ColorSpaces.inc.glsl

void main() {
    vec3 a = input_a();
    float lum = get_luminance(input_reference());

    float t = input_time();
    int bands = int(input_bands());

    if (int(abs((lum + t) * bands)) % bands == 0) {
        o.rgb = mix(a, input_b(), input_mix());
    } else {
        o.rgb = a;
    }
}
