#version 410

out vec4 o;

#pragma input vec3 img0
#pragma input float thresh

#pragma include includes/ColorSpaces.inc.glsl

void main() {
    vec3 col = input_img0();

    if (get_luminance(col) > (1 - input_thresh() + 0.01)) {
        o.rgb = vec3(0);
    } else {
        o.rgb = col;
    }

    o.a = 1;
}
