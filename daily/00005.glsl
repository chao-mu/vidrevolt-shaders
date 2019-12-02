#version 410

out vec4 o;

#pragma include ../includes/ColorSpaces.inc.glsl

#pragma input vec3 img0 vec3(0)
#pragma input float mix 0
#pragma input float time 0

uniform float iTime;

#define time iTime

void main() {
    vec3 col = input_img0();
    vec3 hsv = rgb_to_hsv(col);
    float lum = get_luminance(col);

    //int bands = int(input_mix() * 10);
    int bands = 6;
    int pos = int(abs(lum + time * .5) * bands) % bands;
    if (pos == 0 || pos == 2 || pos == 4) {
        o.rgb = col;
    } else {
        o.rgb = vec3(lum);
    }

    o.a = 1;
}
