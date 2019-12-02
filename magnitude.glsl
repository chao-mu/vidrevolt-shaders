#version 410

out vec4 o;

#pragma input vec3 img0

void main() {
    o.rgba = vec4(vec3(length(input_img0())), 1);
}
