#version 330

//default uniforms from GGGV

//futher sources are set as tex1, tex2, tex3
uniform sampler2D tex0;

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
//output pixel color
out vec4 outputColor;

#define PI 3.1415926535897932384626433832795

vec2 fragToScreen(vec2 fragCoords) {
    return fragCoords * vec2(windowWidth, windowHeight);
}

vec2 screenToFrag(vec2 screenCoords) {
    return screenCoords / vec2(windowWidth, windowHeight);
}


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

void main() {
    float dotDistance = 70;

    vec2 coords = fragToScreen(fragTexCoord);
    vec2 sampleCoords = vec2(
        floor(coords.x / dotDistance) * dotDistance,
        floor(coords.y / dotDistance) * dotDistance
    );
    vec2 centerCoords = vec2(
        floor(coords.x / dotDistance) * dotDistance + dotDistance/2,
        floor(coords.y / dotDistance) * dotDistance + dotDistance/2
    );
    outputColor = texture(tex0, screenToFrag(sampleCoords));
    float dotSize = 5 * (outputColor.r + outputColor.g + outputColor.b);
    if (length(centerCoords - coords) > dotSize) {
        outputColor = vec4(0,0,0,1);
    }
}
