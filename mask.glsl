#version 410

out vec4 o;

#pragma input vec3 img0 vec3(0)
#pragma input float mask 0

#pragma include includes/util.inc.glsl

in vec2 uv;

void main() {
    if (!tc_oob(mask_tc) && input_mask() > 0.5) {
        o.rgb = input_img0();
    } else {
        o.rgb = vec3(0);
    }

    o.a = 1;
}
