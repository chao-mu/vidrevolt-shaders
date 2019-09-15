#version 410

out vec4 o;

#pragma include includes/util.inc.glsl

#pragma input vec3 img0
#pragma input float mix 0

in vec2 uv;

void main() {
    float m = input_mix();
    o.r = input_img0(to_tc(uv + m * 0.1, img0_res)).r;
    o.g = input_img0(to_tc(uv + m * 0.2, img0_res)).g;
    o.b = input_img0(to_tc(uv + m * 0.3, img0_res)).b;
    o.a = 1;
}
