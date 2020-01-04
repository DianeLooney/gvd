#version 330

uniform float amount;

uniform sampler2D tex0;
uniform float time;
in vec2 fragTexCoord;
in vec2 screenCoord;
out vec4 outputColor;

//neato code from the lolengine ppl
//http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl#
vec3 rgb2hsv(vec3 c)
{
  vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
  vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
  vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

  float d = q.x - min(q.w, q.y);
  float e = 1.0e-10;
  return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

//neato code from the lolengine ppl
//http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl#
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
  outputColor = texture(tex0, fragTexCoord);
  outputColor = vec4(rgb2hsv(outputColor.rgb), outputColor.a);
  outputColor.r = mod(outputColor.r + amount, 1);
  outputColor = vec4(hsv2rgb(outputColor.rgb), outputColor.a);
}
