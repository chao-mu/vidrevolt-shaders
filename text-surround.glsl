#version 410

out vec4 o;

#pragma input vec3 text0 vec3(0)
#pragma input vec3 img0 vec3(0)
#pragma input float speed 0.02

in vec2 tc;

uniform vec2 iResolution;
uniform float iTime;

void main() {
    vec2 st = vec2(
        tc.x / text0_res.x * iResolution.x,
        tc.y / text0_res.y * iResolution.y
    );

    float size = 1 / text0_res.y * 50;

    vec3 img = input_img0();
    if (text0_res.y * size > iResolution.y * tc.y) {
        vec3 text = input_text0(st / size + vec2(iTime * input_speed(), 0));
        if (length(text - vec3(0, 0, 0)) < 0.01) {
            o.rgb = mix(img, text, 0.6);
        } else {
            o.rgb = text;
        }
    } else {
        o.rgb = img;
    }

    o.a = 1;
}
