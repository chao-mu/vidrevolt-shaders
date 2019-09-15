#version 410

#pragma include includes/util.inc.glsl

out vec4 o;

#pragma input vec3 img0
#pragma input float mix 0

in vec2 uv;

uniform float iTime;

void main() {
    vec2 st = uv;

    float amount = pow(input_mix(), .01);
    vec2 c = mix(iResolution, vec2(4), amount);
    st = floor(st * c) / c;

    o.rgb = input_img0(to_tc(st, img0_res));
}
