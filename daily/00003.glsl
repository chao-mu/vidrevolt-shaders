#version 410

out vec4 o;

#pragma include ../includes/ColorSpaces.inc.glsl

#pragma input vec3 img0 vec3(0)
#pragma input float mix 0
#pragma input float time 0

void main() {
    vec3 col = input_img0();

	o.rgb = mix(col, abs(sin(col * 10 + input_time() * 5)), input_mix());
    o.a = 1;
}
