#version 410

out vec3 o;

#pragma input vec3 img0

#pragma include includes/ColorSpaces.inc.glsl

void main() {
    vec3 col = input_img0();
    if (get_luminance(col) < 0.1) {
        col = vec3(1);
    }

    o.rgb = col;
}
