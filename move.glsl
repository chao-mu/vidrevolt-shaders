#version 410

out vec4 o;

#pragma input vec3 img0 vec3(0)
#pragma input float offset_x 0
#pragma input float offset_y 0

uniform float iTimeDelta;

void main() {
    o.rgb = input_img0(img0_tc + vec2(input_offset_x(), input_offset_y()));
    o.a = 1;
}
