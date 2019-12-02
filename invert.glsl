#version 410

out vec4 o;

#pragma input vec3 img0
#pragma input vec3 mix vec3(1)

#pragma include includes/ColorSpaces.inc.glsl

void main() {
    vec3 rgb = input_img0();
    o.rgb = mix(rgb, vec3(1) - rgb, input_mix());
    o.a = 1;
}
