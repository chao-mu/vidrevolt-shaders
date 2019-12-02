#version 410

out vec4 o;

#pragma input float scale 0
#pragma input float depth 0
#pragma input vec3 img0 vec3(0)

void main() {
    float displacement = (input_depth() - .5) * 2 * input_scale();
    o.rgb = input_img0(clamp(img0_tc + displacement, 0, 1));
    o.a = 1;
}
