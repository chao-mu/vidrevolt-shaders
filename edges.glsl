#version 410

out vec4 o;

#pragma input vec3 img0
#pragma input vec2 noise vec2(0, 0)
#pragma input float mix 1
#pragma input bool negate false

uniform float iTime;

in vec2 texcoord;
in vec2 texcoordL;
in vec2 texcoordR;
in vec2 texcoordT;
in vec2 texcoordTL;
in vec2 texcoordTR;
in vec2 texcoordB;
in vec2 texcoordBL;
in vec2 texcoordBR;

vec3 applyKernel(in mat3 m) {
    vec2 noise = input_noise(texcoord);
    return m[0][2] * input_img0(texcoordBL + noise) +
        m[1][2] * input_img0(texcoordB) +
        m[2][2] * input_img0(texcoordBR) +
        m[0][1] * input_img0(texcoordL) +
        m[1][1] * input_img0(texcoord) +
        m[2][1] * input_img0(texcoordR) +
        m[0][0] * input_img0(texcoordTL) +
        m[1][0] * input_img0(texcoordT) +
        m[2][0] * input_img0(texcoordTR);
}

#define KERNEL_SCHARR_Y \
    mat3( \
        3, 10, 3, \
        0, 0, 0, \
        -3, -10, -3 \
    )

#define KERNEL_SCHARR_X \
    mat3( \
        3, 0, -3, \
        10, 0, -10, \
        3, 0, -3 \
    )

void main() {
    vec3 a = applyKernel(KERNEL_SCHARR_X);
    vec3 b = applyKernel(KERNEL_SCHARR_Y);
	vec3 edge = sqrt((a * a) + (b * b));

    if (input_negate()) {
        edge = vec3(1) - edge;
    }

    o.rgb = mix(input_img0(), edge, input_mix());
    o.a = 1;
}
