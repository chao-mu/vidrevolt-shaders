#version 410

out vec4 o;

#pragma include includes/ColorSpaces.inc.glsl

#pragma input vec3 img0 vec3(0)
#pragma input float mix 0

void main() {
    vec3 col = input_img0();

    float threshold = input_mix();
    if (get_luminance(col) < threshold) {
        col = 1. - col;
    }

    o.rgb = col;
    o.a = 1;
}
