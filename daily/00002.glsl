#version 410

out vec4 o;

#pragma input vec3 img0 vec3(0)
#pragma input float mix 0
#pragma input float contrast 20

void main() {
    vec2 s = vec2(1) / img0_res;
    vec3 col = vec3(.5);
    float contrast = input_contrast();

    col -= input_img0(img0_tc - s) * contrast;
    col += input_img0(img0_tc + s) * contrast;


    o.rgb = mix(input_img0(), col, input_mix());
    o.a = 1;
}
