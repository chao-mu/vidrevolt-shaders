#version 410

out vec4 o;

#pragma include ../includes/util.inc.glsl

#pragma input vec3 a
#pragma input vec3 b
#pragma input float mix 0.3

in vec2 uv;
in vec2 max_uv;

uniform float iTime;

vec3 get_coords(vec2 tc, float shrink) {
    tc *= shrink;
    if (tc.x > 1. || tc.x < 0. || tc.y > 1. || tc.y < 0.) {
        return vec3(0);
    } else {
        return vec3(1, tc);
    }
}

mat2 rot(float a) {
    return mat2(cos(a), -sin(a), sin(a), cos(a));
}

vec2 rot_to_tc(vec2 st, float a, vec2 res) {
    return to_tc(rot(a) * st, res);
}

#define time iTime

void main() {
    float off = 0.5;
    float shrink = 2;
    vec3 corner1 = get_coords(rot_to_tc(uv * 2, time * .1, a_res), shrink);
    vec3 corner2 = get_coords(rot_to_tc(uv * 2, time * .2, a_res), shrink);
    vec3 corner3 = get_coords(rot_to_tc(uv * 2, time * .3, a_res), shrink);
    vec3 corner4 = get_coords(rot_to_tc(uv * 2, time * .4, a_res), shrink);
    vec3 corner5 = get_coords(rot_to_tc(uv * 2, time * .5, a_res), shrink);

    if (corner1.x == 1) {
        o.rgb = input_a(corner1.yz);
    } else if (corner2.x == 1) {
        o.rgb = input_a(corner2.yz);
    } else if (corner3.x == 1) {
        o.rgb = input_a(corner3.yz);
    } else if (corner4.x == 1) {
        o.rgb = input_a(corner4.yz);
    } else if (corner5.x == 1) {
        o.rgb = input_a(corner5.yz);
    } else {
        o.rgb = input_b();
    }

    o.a = 1;
}
