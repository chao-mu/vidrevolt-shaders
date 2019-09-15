#version 410

out vec4 o;

#pragma include ../pixel_spirit.inc.glsl

uniform float iTime;

in vec2 uv;

mat2 rot(float a) {
    return mat2(cos(a), sin(a), -sin(a), cos(a));
}

void main() {
    vec2 st = uv;
    float circle = circleSDF(st - vec2(.0, .1));
    float triangle = triSDF(st + vec2(.0, .1));

    vec3 col = vec3(0);
    col += stroke(circle, .45, .1);
    col *= smoothstep(.30, .30 + SS_EPS, triangle);
    col += fill(triangle, .25);

    o.rgb = clamp(col, 0, 1);
    o.a = 1;
}
