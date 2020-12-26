#version 410

out vec3 o;

#pragma input vec3 hsv

#pragma include includes/hsv.inc.glsl

void main() {
    o.rgb = hsv2rgb(input_hsv());
}
