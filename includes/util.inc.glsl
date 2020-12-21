uniform vec2 iResolution;

vec2 to_1to1(in vec2 uv) {
    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;

    return uv;
}

vec2 to_1to1(in vec2 uv, in vec2 res) {
    uv -= .5;
    uv.x *= res.x / res.y;

    return uv;
}

vec2 to_tc(vec2 uv, in vec2 res) {
    uv.x /= res.x / res.y;
    uv += .5;

    return uv;
}

bool tc_oob(vec2 tc) {
    return tc.x < 0 || tc.x > 1 || tc.y < 0 || tc.y > 1;
}

vec2 to_0to1(in vec2 uv) {
    return to_tc(uv, iResolution);
}

vec2 to_polar(in vec2 uv) {
    return vec2(length(uv), atan(uv.y, uv.x));
}

vec2 polar_to_1to1(in vec2 p) {
    return vec2(p.x * cos(p.y), p.x * sin(p.y));
}

vec2 polar_to_tc(in vec2 p, in vec2 res) {
    return to_tc(polar_to_1to1(p), res);
}

float rand(float x) {
    return fract(sin(x * 12.42356) * 3246.346787);
}

float rand(vec3 st) {
    return fract(sin(dot(st, vec3(478.4332, 899.3345, 312.4256))) * 3246.346787);
}


float rand(vec2 st) {
    return fract(sin(dot(st, vec2(899.3345, 312.4256))) * 3246.346787);
}
