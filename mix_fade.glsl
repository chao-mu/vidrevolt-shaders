#version 410

out vec3 o;

#pragma input vec3 a
#pragma input vec3 b
#pragma input float mix

void main() {
    o.rgb = mix(input_a(), input_b(), input_mix());
}
