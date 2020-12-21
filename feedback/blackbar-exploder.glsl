#version 410

#pragma include ../includes/util.inc.glsl

out vec4 o;

#pragma input vec3 img0
#pragma input vec3 last_out
#pragma input float vertical 0.4

in vec2 uv;

void main() {
    vec2 st = uv / (1 - input_vertical()); //vec2(input_offset_x(), input_offset_y()));

    vec2 tc = to_tc(st, img0_res);

    vec3 col = input_img0();
    if (tc.y > 1 || tc.y < 0) {
        vec2 polar = to_polar(to_1to1(img0_tc, img0_res));
        polar.x -= 0.4 * col.r + 0.001;
        col = input_last_out(polar_to_tc(polar, img0_res));
    }

    o.rgb = col;
    o.a = 1;
}
