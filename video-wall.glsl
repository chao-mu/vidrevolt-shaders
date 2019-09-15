#version 410

out vec4 o;

#pragma input float boxes 0.5
#pragma input float min_brightness 0.3
#pragma input vec3 img0 vec3(0)
#pragma input float mix 0

#pragma include includes/util.inc.glsl

in vec2 uv;

void main() {
    vec2 px = uv * mix(0, 15, input_mix());

    // Decide the shade of each panel
    float shade;
    if (floor(px + .5) == vec2(0)) {
        shade = 1;
    } else {
        shade = clamp(input_min_brightness() + rand(floor(px + 0.5)), 0., 1.);
    }

    // Calculate the grid
    float g = smoothstep(0.4, 0.49, distance(floor(px.x + 0.5), px.x))
        + smoothstep(0.4, 0.49, distance(floor(px.y + 0.5), px.y));
    g = 1. - clamp(g, 0., 1.);

    vec3 col = input_img0();

    // Output to screen
    o = vec4(g * shade * col, 1.);
}
