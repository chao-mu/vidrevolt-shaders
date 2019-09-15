#version 410

out vec4 o;

#pragma input float red 0
#pragma input float green 0
#pragma input float blue 0

void main() {
    o = vec4(input_red(), input_green(), input_blue(), 1);
}
