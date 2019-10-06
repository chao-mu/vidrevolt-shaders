#version 410

out vec4 o;

#pragma include includes/ColorSpaces.inc.glsl

#pragma input vec3 img0
#pragma input float gamma 1
#pragma input float gamma_inc 0
#pragma input float gamma_dec 0
#pragma input float contrast 1
#pragma input float contrast_inc 0
#pragma input float contrast_dec 0
#pragma input float brightness 0
#pragma input bool split false

in vec2 uv;

// From https://alaingalvan.tumblr.com/post/79864187609/glsl-color-correction-shaders
vec3 Gamma(vec3 value, float param)
{
    return vec3(pow(abs(value.r), param),pow(abs(value.g), param),pow(abs(value.b), param));
}

// From https://alaingalvan.tumblr.com/post/79864187609/glsl-color-correction-shaders
vec3 brightnessContrast(vec3 value, float brightness, float contrast)
{
    return (value - 0.5) * contrast + 0.5 + brightness;
}

void main() {
    vec3 col = input_img0();
    col = brightnessContrast(col, input_brightness(), input_contrast() + input_contrast_inc() - input_contrast_dec());
    col = Gamma(col, input_gamma() + input_gamma_inc() - input_gamma_dec());
    o.rgb = input_split() && uv.x < 0 ? input_img0() : col;
    o.a = 1;
}
