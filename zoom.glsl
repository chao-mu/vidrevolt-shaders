#version 410

layout (location = 0) out vec4 o;

#pragma include includes/util.inc.glsl

#pragma input vec3 img0
#pragma input float amount 0.7

void main() {
    vec2 st = to_1to1(img0_tc, img0_res);
    st = clamp(st * input_amount(), -1, 1);

    o.rgb = input_img0(to_tc(st, img0_res));
    o.a = 1;
}
