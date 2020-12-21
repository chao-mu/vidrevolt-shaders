#version 410

layout (location = 0) out vec3 o;

#pragma input vec3 img0
#pragma input float target 3
#pragma input float bands 6
#pragma input float mix

#pragma include includes/ColorSpaces.inc.glsl

void main() {
    vec3 col = input_img0();
    float lum = get_luminance(col);

    float bands = input_bands();
    float target = input_target();

    float res = 0;
    if (int(lum * bands + target) % int(bands) == 0) {
        res = 1;
    }

    o.rgb = mix(col, vec3(res), input_mix());
}
