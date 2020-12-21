#version 410

layout (location = 0) out vec4 o;

#pragma input vec3 img0
#pragma input float mix

#pragma include includes/util.inc.glsl

void main() {
    vec2 tc = img0_tc;
    vec2 flipped = vec2(img0_res.x - tc.x, tc.y);

    o.rgb = mix(input_img0(), input_img0(flipped), input_mix());
    o.a = 1;
}
