#version 410

out vec4 o;

#pragma input float intensity
#pragma input vec3 img0

#pragma include includes/ColorSpaces.inc.glsl

void main() {
    vec3 hsv = rgb_to_hsv(input_img0());
    if (hsv.z > 0.0001) {
        hsv.z = clamp(hsv.z + input_intensity(), 0, 1);
    }

    o.rgba = vec4(hsv_to_rgb(hsv), 1);
}
