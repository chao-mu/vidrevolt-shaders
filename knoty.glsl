#version 410

out vec4 o;

#define PI 3.1415926

#pragma input vec3 img0 vec3(0)
#pragma input float mix 0

#pragma include includes/util.inc.glsl

in vec2 uv;

void main() {
    float s = sin(2 * PI * length(uv) + PI) * .5 + .5;
    s = mix(1, s + .2, input_mix());

    o.rgb = input_img0(to_tc(uv / s, img0_res));
    o.a = 1;
}
