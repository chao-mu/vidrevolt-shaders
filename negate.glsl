#version 410

out vec3 o;

#pragma input vec3 img0

void main() {
    o.rgb = 1 - input_img0();
}
