#version 410

out vec4 o;

#pragma input float blue 0.
#pragma input vec3 img0 vec3(0)

// reminder: debugging shows amp uniform is never set if input is a value. input however is set.
void main() {
    //o.rgba = vec4(1,0, input_blue(), 1);
    o.rgb =  input_img0();
    o.a = 1;
}
