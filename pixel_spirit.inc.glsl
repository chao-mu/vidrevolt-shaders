#define SS_EPS 0.01

/*
Copyright (c) 2017 Patricio Gonzalez Vivo
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the copyright holder nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// Modified to work with coordinates with center at 0.

float spiralSDF(vec2 st, float t) {
    //st -= .5;
    float r = dot(st, st);
    float a = atan(st.y, st.x);

    return abs(sin(fract(log(r) * t + a * 0.159)));
}

float circleSDF(vec2 st) {
    return length(st) * 2;
}

float triSDF(vec2 st) {
    st *= 2;

    return max(
            abs(st.x) * 0.866025 + st.y * 0.5,
            -st.y * 0.5);
}

float fill(float x, float size) {
    return 1. - step(size, x);
}

float stroke( float x, float s, float w) {
    float d = step(s, x + w * .5) - step(s, x - w * .5);
    return clamp(d, 0., 1.);
}

/*
// Modified to use smoothstep
float fill(float x, float size) {
    return 1. - smoothstep(size, size + SS_EPS, x);
}

// Modified to use smoothstep
float stroke(float x, float s, float w) {
    const float a = 0.01;
    return min(
            smoothstep(s - SS_EPS, s, x + w),
            smoothstep(s + SS_EPS, s, x));
}
*/
