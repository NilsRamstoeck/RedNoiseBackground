uniform float xscale;
uniform float yscale;

uniform float z;
uniform float yoff;

uniform int layers;
uniform float freq_inc;

float mod289(float x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 mod289(vec4 x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 perm(vec4 x){return mod289(((x * 34.0) + 1.0) * x);}

float pnoise(vec3 p){
    vec3 a = floor(p);
    vec3 d = p - a;
    d = d * d * (3.0 - 2.0 * d);

    vec4 b = a.xxyy + vec4(0.0, 1.0, 0.0, 1.0);
    vec4 k1 = perm(b.xyxy);
    vec4 k2 = perm(k1.xyxy + b.zzww);

    vec4 c = k2 + a.zzzz;
    vec4 k3 = perm(c);
    vec4 k4 = perm(c + 1.0);

    vec4 o1 = fract(k3 * (1.0 / 41.0));
    vec4 o2 = fract(k4 * (1.0 / 41.0));

    vec4 o3 = o2 * d.z + o1 * (1.0 - d.z);
    vec2 o4 = o3.yw * d.x + o3.xz * (1.0 - d.x);

    return o4.y * d.y + o4.x * (1.0 - d.y);
}


float layerdNoise(vec3 p, int layers, float freq_inc){
   float freq = 1;
   float v = 0;
   float falloff = 1;
   for(int i = 0; i < layers; i++){
      v += pnoise(p * freq) * falloff;
      v *= 0.8;
      freq *= freq_inc;
      falloff *= 0.2;
   }

   return v;
}

void main( void ){
   vec3 p = vec3(gl_FragCoord.x * xscale, (gl_FragCoord.y + yoff) * yscale, z);
   float r = layerdNoise(p, layers, freq_inc);
   gl_FragColor = vec4(r, 0.0, 0.0, 1.0);
}
