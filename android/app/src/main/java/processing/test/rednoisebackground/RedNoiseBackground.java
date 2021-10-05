package processing.test.rednoisebackground;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class RedNoiseBackground extends PApplet {

float z = 0;
float zinc = 0.0025f;

float xscale = 0.01f;
float yscale = 0.01f;

float yoff = 0;
float yinc = 0.2f;

int layers = 3;
float freq_inc = 3.3f;

PShader noise;
PGraphics pg;

public void setup() {
   
  noise = loadShader("redNoiseBackground.glsl");
  pg = createGraphics(400, 400, P2D);
  pg.noSmooth();

  noise.set("xscale", xscale);
  noise.set("yscale", yscale);
  noise.set("layers", layers);
  noise.set("freq_inc", freq_inc);
}

public void draw() {
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
  public void settings() {  size(800, 800, P3D); }
}
