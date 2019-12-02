#version 410

out vec4 o;

in vec2 uv;
in vec2 uv_max;

#pragma input vec3 img0
#pragma include includes/util.inc.glsl

void main() {
    if (uv.x < 0 && uv.y < 0) {
        vec2 st = -uv;
        o.rgb = input_img0(to_tc(st, img0_res));
    } else {
        o.rgb = vec3(0);
    }

    o.a = 1;
}
