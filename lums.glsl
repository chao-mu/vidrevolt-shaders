#version 410

#pragma input vec3 img0

#pragma include includes/ColorSpaces.inc.glsl

out vec4 o;

void main() {
    o.rgb = vec3(get_luminance(input_img0()));
    o.a = 1;
}
