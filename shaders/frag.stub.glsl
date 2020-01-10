#version 330

//default uniforms from GGGV

//futher sources are set as tex1, tex2, tex3
uniform sampler2D tex0;
uniform sampler2D tex1;
uniform sampler2D tex2;
uniform sampler2D tex3;
uniform sampler2D tex4;
uniform sampler2D tex5;
uniform sampler2D tex6;
uniform sampler2D tex7;
uniform sampler2D tex8;
uniform sampler2D tex9;

//result of the last render of this shader
uniform sampler2D lastFrame;

//only set when tex* is a FFsource
uniform float tex0Width;
uniform float tex0Height;

//seconds since application start. 
//monotonically increasing, will never be 0 
uniform float time;
//time the last frame took to render
uniform float renderTime;
//number of frames in the last second
uniform float fps;
//output window size
uniform float windowHeight;
uniform float windowWidth;
//cursor position
uniform float cursorX;
uniform float cursorY;

//texCoord
in vec2 fragTexCoord;
in vec2 screenCoord;
//output pixel color
out vec4 outputColor;

#define PI 3.1415926535897932384626433832795

vec2 screenToPolar(vec2 screenCoords) {
  screenCoords -= vec2(0.5, 0.5);
  screenCoords *= vec2(windowWidth, windowHeight);
  return vec2(
    length(screenCoords),
    atan(screenCoords.y, screenCoords.x)
  );
}

vec2 polarToScreen(vec2 polarCoords) {
  return vec2(0.5, 0.5) + vec2(
    polarCoords.x * cos(polarCoords.y),
    polarCoords.x * sin(polarCoords.y)
  ) / vec2(windowWidth, windowHeight);
}

uniform float rseed = 0;
float noise(vec2 coord, float t) {
  return fract(sin(dot(coord, vec2(217.983, 317.42))) * 82615.717 * ((sin(rseed+t) + 1) / 2));
}

float noise(vec2 coord) {
  return noise(coord, 0.);
}

float noise(float t) {
  return fract(sin(floor(t)*12.9898) * 43758.5453 * (sin(rseed) + 1) / 2);
}
