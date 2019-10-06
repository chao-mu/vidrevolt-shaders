#version 410

out vec4 o;

#pragma include includes/ColorSpaces.inc.glsl

#pragma input vec3 img0 vec3(0)
#pragma input float mix 0
#pragma input float time 0

#define BANDS 6
#define COL_1 vec3(1.0, 0.0, 0.09411764705882353)
#define COL_2 vec3(1.0, 0.6470588235294118, 0.17254901960784313)
#define COL_3 vec3(1.0, 1.0, 0.2549019607843137)
#define COL_4 vec3(0.0, 0.5019607843137255, 0.09411764705882353)
#define COL_5 vec3(0.0, 0.0, 0.9764705882352941)
#define COL_6 vec3(0.5254901960784314, 0.0, 0.49019607843137253)

const vec3 cols[6] = vec3[](COL_1, COL_2, COL_3, COL_4, COL_5, COL_6);

uniform float iTime;

void main() {
    vec3 img = input_img0();
    float lum = get_luminance(img);

    // We subtract epsilon so lum = 1 doesn't give us 6.
    o.rgb = mix(img, cols[int(abs((lum + input_time() * .5) * BANDS)) % BANDS], input_mix());
    o.a = 1;
}
