#version 410

out vec4 o;

#pragma input vec3 img0 vec3(0)
#pragma input float mask 0
#pragma input float mix 0

#pragma include includes/util.inc.glsl

in vec2 uv;
void main() {
    vec3 orig = input_img0();
    vec3 col;
    if (!tc_oob(mask_tc) && input_mask() > 0.5) {
        col = orig;
    } else {
        col = vec3(0);
    }

    o.rgb = mix(orig, col, input_mix());
    o.a = 1;
}
