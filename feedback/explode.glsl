#version 410

#pragma include ../includes/util.inc.glsl

out vec4 o;

#pragma input vec3 last_out

void main() {
    vec3 col = input_last_out();;
    vec2 polar = to_polar(to_1to1(last_out_tc, last_out_res));
    polar.x -= col.g * 0.002;

    o.rgb = input_last_out(polar_to_tc(polar, last_out_res));
    o.a = 1;
}
