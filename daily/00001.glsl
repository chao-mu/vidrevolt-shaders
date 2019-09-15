#version 410

out vec4 o;

in vec2 uv;

uniform float iTime;

#define time iTime

#define PI 3.1415926

#define ADD_SHAPE(dst, f) ##dst = min(dst, f)

// https://www.schemecolor.com/lgbt-flag-colors.php
#define COL_1 vec3(1.0, 0.0, 0.09411764705882353)
#define COL_2 vec3(1.0, 0.6470588235294118, 0.17254901960784313)
#define COL_3 vec3(1.0, 1.0, 0.2549019607843137)
#define COL_4 vec3(0.0, 0.5019607843137255, 0.09411764705882353)
#define COL_5 vec3(0.0, 0.0, 0.9764705882352941)
#define COL_6 vec3(0.5254901960784314, 0.0, 0.49019607843137253)

float sdCircle(vec2 st, float r) {
    return length(st) - r;
}

float sdRing(vec2 st, float s, float r) {
    return abs(sdCircle(st, s)) - r;;
}

// https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float sdLine( in vec2 p, in vec2 a, in vec2 b ) {
    vec2 pa = p-a, ba = b-a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h );
}


float draw(float dst) {
    const float r = 0.03;
    const float eps = 0.003;
    return smoothstep(r + eps, r - eps, dst);
}

mat2 rot(float a) {
    return mat2(cos(a), -sin(a), sin(a), cos(a));
}

float sdDownArrow(vec2 st, float stem, float legs) {
    vec2 from = vec2(0);
    vec2 to = vec2(0, -stem);

    float dst = 1;
    ADD_SHAPE(dst, sdLine(st, from, to));
    ADD_SHAPE(dst, sdLine(st, to, to + legs));
    ADD_SHAPE(dst, sdLine(st, to, to + vec2(-legs, legs)));

    return dst;
}

float sdMars(vec2 st, float ring_r) {
    float size = ring_r + 0.11;
    float arrow_legs = size * .37;

    float dst = 1;
    ADD_SHAPE(dst, sdRing(st, ring_r, 0));
    ADD_SHAPE(dst, sdDownArrow(rot(PI / 1.4 - time * .8) * st + vec2(0, ring_r), size, arrow_legs));

    return dst;
}

int mat = 0;
const float ring_r = 0.17;
float scene(vec2 st) {
    float mars1 = sdMars(st, ring_r);
    float mars2 = sdMars(st - vec2(ring_r, -ring_r), ring_r);
    if (draw(mars1) > 0) {
        mat = 1;
    } else if (draw(mars2) > 0) {
        mat = 2;
    }

    return min(mars1, mars2);
}

void main() {
    vec2 st = uv + vec2(ring_r * .5, -.05);
    st *= 1.15;
    st -= 0.01;

    float dst = scene(st);

    // Color
    vec3 cols[6] = vec3[](COL_1, COL_2, COL_3, COL_4, COL_5, COL_6);
    float off = mat == 1 ?  2 : -23;
    int y = int(uv.y * 20 - time * .6 + off + 100);
    vec3 col = cols[y % 6];
    col *= draw(dst);

    o = vec4(col, 1);
}
