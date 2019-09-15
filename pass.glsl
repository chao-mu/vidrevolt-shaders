#version 410

out vec4 o;

#pragma input vec3 img0

in vec2 uv;

void main() {
    o = vec4(input_img0(), 1);
}
