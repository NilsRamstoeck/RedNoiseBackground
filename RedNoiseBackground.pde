float z = 0;
float zinc = 0.0025;

float xscale = 0.01;
float yscale = 0.01;

float yoff = 0;
float yinc = 0.2;

int layers = 3;
float freq_inc = 3.3;

PShader noise;
PGraphics pg;

void setup() {
  size(800, 800, P3D); 
  noise = loadShader("redNoiseBackground.glsl");
  pg = createGraphics(400, 400, P2D);
  pg.noSmooth();

  noise.set("xscale", xscale);
  noise.set("yscale", yscale);
  noise.set("layers", layers);
  noise.set("freq_inc", freq_inc);
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
