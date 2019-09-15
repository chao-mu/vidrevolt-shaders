#version 410

out vec4 o;

#pragma include ../pixel_spirit.inc.glsl

#pragma input float balance 0.5
#pragma input float speed 0

uniform float iTime;

in vec2 uv;

mat2 rot(float a) {
    return mat2(cos(a), sin(a), -sin(a), cos(a));
}

void main() {
    vec2 st = rot(-iTime * input_speed()) * uv;
    o.rgb = vec3(step(input_balance(), spiralSDF(st, .13)));
    o.a = 1;
}
