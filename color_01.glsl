#version 410

#pragma include includes/ColorSpaces.inc.glsl
#pragma include includes/util.inc.glsl

out vec4 o;

#pragma input vec3 img0
#pragma input float mix 0

in vec2 uv;

void main() {
    vec3 col = input_img0();

    vec3 hsv = rgb_to_hsv(col);
    hsv.x = hsv.z;
    hsv.y = hsv.z;

    o.rgb = mix(col, hsv_to_rgb(hsv), input_mix());
    o.a = 1;
}
