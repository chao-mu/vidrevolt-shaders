#version 410

out vec3 o;

#pragma input vec3 rgb

#pragma include includes/hsv.inc.glsl

void main() {
    o.rgb = rgb2hsv(input_rgb());
}
