#ifdef GL_ES
precision mediump float;
#endif
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
#define PI  3.14159265359
#define PI2 6.28318530718
void main(void) {
	vec2 position = time * ((2.0 * gl_FragCoord.xy - resolution) / resolution.xx);
	float r = length(position);
	float a = -atan(position.y, position.x) + PI;
	float d = r - a + PI2;
	float n = PI2 * float(int(d/PI2));
	float da = a + n;
	float pos = (PI*0.02*da * da - time);
	vec3 norm;
	norm.xy = mouse*vec2(fract(pos)-0.5, fract(d/PI2)-0.5)*2.0;
	pos = floor(pos);
	float len = length(norm.xy);
	vec3 color = vec3(0.0);
    float low = 0.2;
    float red = 0.5;
    float green = 0.5;
    float blue = 0.5;
	if (len < 1.0) 	{
        norm.z = sqrt(1.0 - len*len);
        vec3 lightdir = normalize(vec3(0.0, -0.0, 1.0));
        float dd = max(dot(lightdir, norm), 0.0);
        color.rgb = dd*vec3(low+red*cos(pos+2.0), low+green*cos(pos+4.0), low+blue*cos(pos));
        vec3 halfv = normalize(lightdir + vec3(1.0, 1.0, 1.0));
        float spec = dot(halfv, norm);
        spec = max(spec, 0.0);
        spec = pow(spec, 1000000.0);
        color += vec3(spec);
    }
    gl_FragColor = vec4(color, 1.0);
}