#version 410

#pragma include includes/ColorSpaces.inc.glsl
#pragma include includes/util.inc.glsl

out vec4 o;

#pragma input vec3 img0
#pragma input float mix 0

in vec2 uv;

void main() {
    vec3 col = input_img0();

    float lum = get_luminance(col);

    vec2 pol = to_polar(uv);

    pol.x += mix(0, lum, input_mix());
    //pol += mix(vec2(0), vec2(sin(lum), cos(lum)), input_mix());

    o.rgb = input_img0(polar_to_tc(pol, img0_res));
}
