#version 410

#pragma include includes/ColorSpaces.inc.glsl
#pragma include includes/util.inc.glsl

out vec4 o;

#pragma input vec3 img0
#pragma input float mix 0

in vec2 uv;

vec3 get(vec2 st) {
    return input_img0(to_tc(mix(uv, st, input_mix()), img0_res));
}

void main() {
    vec3 col = input_img0();

    o.r = get(uv + col.r).r;
    o.g = get(uv + col.g).g;
    o.b = get(uv + col.b).b;
    o.a = 1;
}
