#version 410

out vec4 o;

#pragma input vec3 img0
#pragma input float mix 0.

uniform bool firstPass;
uniform sampler2D lastOut;
uniform float iTime;

in vec2 tc;

void main() {
    vec3 cur = input_img0();
    vec3 last = firstPass ? cur : texture(lastOut, tc).rgb;

    o.rgb = mix(cur, last, input_mix());
    o.a = 1;
}
