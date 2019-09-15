#version 410

out vec4 o;

in vec2 uv;

uniform float iTime;

#define PI 3.1415926

// Maya Blue
const vec3 BLUE = vec3(0.3333333333333333, 0.803921568627451, 0.9882352941176471);
// White
const vec3 WHITE = vec3(1);
// Amaranth Pink
const vec3 PINK = vec3(0.9686274509803922, 0.6588235294117647, 0.7215686274509804);

float circle(vec2 st, float r, float b) {
    float dist = length(st);
    b /= 4.;
    float x = 1 +
        smoothstep(r, r + 0.01, dist - b) -
        smoothstep(r - 0.01, r, dist + b);
    return 1 - clamp(x, 0, 1);
}

float sdCircle(vec2 st, float r) {
    return length(st) - r;
}

float sdRing(vec2 st, float s, float r) {
    return abs(sdCircle(st, s)) - r;
}

// https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float sdLine( in vec2 p, in vec2 a, in vec2 b )
{
    vec2 pa = p-a, ba = b-a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h );
}


float sdDiagonal(vec2 st) {
    return length(uv - vec2(uv.x));
}

float draw(float dst, float r) {
    const float eps = 0.003;
    return smoothstep(r + eps, r - eps, dst);
}

mat2 rot(float a) {
    return mat2(cos(a), -sin(a), sin(a), cos(a));
}

#define ADD_SHAPE(dst, f) ##dst = min(dst, f)

float sdDownArrow(vec2 st, float stem, float legs) {
    vec2 from = vec2(0);
    vec2 to = vec2(0, -stem);

    float dst = 1;
    ADD_SHAPE(dst, sdLine(st, from, to));
    ADD_SHAPE(dst, sdLine(st, to, to + legs));
    ADD_SHAPE(dst, sdLine(st, to, to + vec2(-legs, legs)));

    return dst;
}

float sdDownCross(vec2 st, float s) {
    s *= .5;
    st += vec2(0, s);
    float dst = 1;
    ADD_SHAPE(dst, sdLine(st, vec2(-s, 0), vec2(s, 0)));
    ADD_SHAPE(dst, sdLine(st, vec2(0, -s), vec2(0, s)));

    return dst;
}

void main() {
    float ring_r = abs(sin(iTime) * .1) + .1;
    float dst = sdRing(uv, ring_r, .001);

    float size = .28;

    float arrow_legs = size * .37;

    float a_rot = sin(iTime * .4) * .2;
    float b_rot = sin(iTime * .5) * .2;
    float c_rot = sin(-iTime * .5) * .2;

    // Top right arrow
    ADD_SHAPE(dst, sdDownArrow(rot(PI / 1.4 + a_rot) * uv + vec2(0, ring_r), size, arrow_legs));

    // Bottom cross
    ADD_SHAPE(dst, sdDownCross(rot(c_rot) * uv + vec2(0, ring_r), size));

    // Top left combined symbol
    ADD_SHAPE(dst, sdDownArrow(rot(-PI / 1.4 + b_rot) * uv + vec2(0, ring_r), size, arrow_legs));
    ADD_SHAPE(dst, sdDownCross(rot(-PI / 1.4 + b_rot) * uv + vec2(0, ring_r), size * .7));

    vec3 col;
    float x = uv.x * .5 + .5;
    if (x <= .5) {
        x *= 2;
        col = mix(BLUE, WHITE, pow(x, 8));
    } else {
        x = 1 - (x - .5) * 2;
        col = mix(PINK, WHITE, pow(x, 8));
    }

    col *= draw(dst, 0.02);

    o = vec4(col, 1);
}
