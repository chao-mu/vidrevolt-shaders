#version 410

out vec4 o;

#pragma input vec3 img0 vec3(0)
#pragma input float shrink 0

#pragma include includes/util.inc.glsl

in vec2 uv;

void main() {
    vec2 st = uv / (1 - input_shrink()); //vec2(input_offset_x(), input_offset_y()));

    vec2 tc = to_tc(st, img0_res);

    if (tc.x > 1 || tc.x < 0 || tc.y > 1 || tc.y < 0) {
        o.rgb = vec3(0);
    } else {
        o.rgb = input_img0(tc);
    }

    o.a = 1;
}
