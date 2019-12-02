#version 410

out vec4 o;

in vec2 uv;

uniform float iTime;

#pragma include ../includes/ColorSpaces.inc.glsl

#define PI 3.1415926

#define time (iTime * .2)

float draw(float dst) {
    const float r = 0.03;
    const float eps = 0.003;
    return smoothstep(r + eps, r - eps, dst);
}

float sdCircle(vec2 st, float r) {
    return length(st) - r;
}

float sdRing(vec2 st, float s) {
    return abs(sdCircle(st, s));
}

mat2 rot(float a) {
    return mat2(cos(a), -sin(a), sin(a), cos(a));
}

// https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float sdLine( in vec2 p, in vec2 a, in vec2 b ) {
    vec2 pa = p-a, ba = b-a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h );
}

float cell(vec2 st) {
    return min(
        min(
            sdLine(st, vec2(-1, -1), vec2(1, 1)),
            sdLine(st, vec2(-1, 1), vec2(1, -1))
        ),
        sdRing(st, abs(sin(iTime) * 0.8))
    );
}


#define repeat(st) (mod(st, 1.) - 0.5)
float scene(vec2 st) {
    return min(
        cell(rot(sin(time) * PI * .5) * repeat(st * 3.)),
        1.
    );
}

void main() {
    float dst = scene(uv);

	o.rgb = vec3(draw(dst));
    o.a = 1;
}
