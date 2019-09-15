#version 410

#pragma include includes/util.inc.glsl

#define PI 3.1415926
#define time iTime

out vec4 o;

#pragma input vec3 img0
#pragma input float tweak_1 0
#pragma input float mix 0

uniform float iTime;

in vec2 uv;
in vec2 tc;

void main() {
    vec2 p = uv;

    float a = atan(p.y,p.x);
    float r = length(p);

    a = sin(a * (input_tweak_1() * 7 + 1));

    p.x = r * cos(a);
    p.y = r * sin(a);

    p = mix(uv, p, input_mix());
    vec3 col = input_img0(to_tc(p, img0_res));

    o.rgba = vec4(col, 1.0);
}
