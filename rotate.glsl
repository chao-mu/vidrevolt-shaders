#version 410

out vec4 o;

#pragma input vec3 img0
#pragma input float speed 0

#pragma include includes/util.inc.glsl

uniform float iTime;

in vec2 uv;

mat2 rot(float a) {
    return mat2(cos(a), sin(a), -sin(a), cos(a));
}

void main() {
    o.rgb = input_img0(to_tc(rot(iTime * input_speed()) * uv, img0_res));
    o.a = 1;
}
