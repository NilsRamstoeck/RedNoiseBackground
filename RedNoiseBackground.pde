float z = 0;
float zinc = 0.004;

float xscale = 0.005;
float yscale = 0.005;

float yoff = 0;
float yinc = 1;

int layers = 3;
float freq_inc = 3;

float layer_fade = 0.82;
float falloff_m = 0.28;

PShader noise;
PGraphics pg;

void setup() {
  //size(800, 800, P3D); 
  fullScreen(P3D);
  noise = loadShader("redNoiseBackground.glsl");
  pg = createGraphics(width, height, P2D);
  pg.noSmooth();

  noise.set("xscale", xscale);
  noise.set("yscale", yscale);
  noise.set("layers", layers);
  noise.set("freq_inc", freq_inc);
  noise.set("layer_fade", layer_fade);
  noise.set("falloff_m", falloff_m);
}

void draw() {
  noise.set("z", z);
  
  noise.set("yoff", yoff);
  pg.beginDraw();
  pg.shader(noise);
  pg.rect(0, 0, pg.width, pg.height);
  pg.endDraw();
  image(pg, 0, 0, width, height);

  z += zinc;
  yoff += yinc;
}
