#version 410

#pragma include includes/util.inc.glsl

out vec4 o;

#pragma input vec3 img0
#pragma input float mix 0

in vec2 uv;

uniform float iTime;

void main() {
    vec2 st = uv;
    float m = input_mix();

    st.x += cos(uv.y * iResolution.y) * m;
    st.y += cos(uv.x * iResolution.x) * m;

    o.rgb = input_img0(to_tc(st, img0_res));
}
