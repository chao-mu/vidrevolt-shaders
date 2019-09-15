#version 410

out vec4 o;

#pragma input float width 0.5
#pragma input float height 0.5

in vec2 uv;
in vec2 max_uv;

void main() {
    vec2 dim = max_uv * vec2(input_width(), input_height());
    o.rg = step(0.5, fract(uv * dim * 14));
    o.b = clamp(o.r + o.g, 0, 1);
    o.a = 1;
}
