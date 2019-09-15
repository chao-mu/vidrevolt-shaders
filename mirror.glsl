#version 410

out vec4 o;

#pragma input vec3 img0
#pragma input float mix_x 0
#pragma input float mix_y 0

#pragma include includes/util.inc.glsl

in vec2 uv;
in float max_x;
in float max_y;

void main() {
    vec2 st = vec2(
        mix(uv.x, max_x - uv.x, input_mix_x()),
        mix(uv.y, max_y - uv.y, input_mix_y())
    );

    o.rgb = input_img0(to_tc(st, img0_res));
    o.a = 1;
}
