#version 410

#pragma input vec3 img0

#pragma input float lumin_threshold .5
#pragma input bool negate

#pragma include includes/ColorSpaces.inc.glsl

out vec4 o;

void main() {
    bool t;
    if (input_negate()) {
        t = get_luminance(input_img0()) < input_lumin_threshold();
    } else {
        t = get_luminance(input_img0()) > input_lumin_threshold();
    }
    o.rgb = vec3(t ? 1 : 0);
    o.a = 1;
}
