ArrayList<RobPoint> points = new ArrayList<RobPoint>();

PVector pos, dir;
int i;

void setup () {
  fullScreen(P3D);
  initCamera();
  colorMode(RGB, 1);
  pos = new PVector(100, 100, 0);
  dir = new PVector(1, 0, 0);
  roboterposfullen();
}


void draw () {
  lights();
  background(0);
  updateCamera(); 
  coordAxis();
  rohrzeichnen();
  //box(100);
  //wurfel();
}

void roboterposfullen() {
  PVector sp;
  pos = new PVector(0, 0, 0);
  for (int i = 0; i<10; i++) {
    pos = new PVector(300*cos(i*20*TWO_PI/360), 300*sin(i*20*TWO_PI/360), 0);
    points.add(new RobPoint(pos, 100));
  }
  for (int i = 1; i<10; i++) {
    pos.y -= i*20;
    points.add(new RobPoint(pos, 80));
  }
  sp = pos.copy();
  for (int i = 1; i<16; i++)
  {
    pos.x = sp.x;
    pos.y = sp.y-400*sin(i*10*TWO_PI/360);
    pos.z = sp.z+400-400*cos(i*10*TWO_PI/360);
    points.add(new RobPoint(pos, 90));
  }
  dirbestimmen();
}

void dirbestimmen() {
  for (int i = 1; i < points.size(); i++) {
    dir = points.get(i).pos.copy();
    dir.sub(points.get(i-1).pos);
    dir.normalize();
    points.get(i-1).dir = dir.copy();
    points.get(i).dir = dir.copy();
  }
}

void rohrzeichnen() {

  //fill(0,0,1,0.1);
  noStroke();
  beginShape(QUADS);
  for (int i = 1; i < points.size(); i++) {
    RobPoint prevpoint = points.get(i-1);
    RobPoint newpoint = points.get(i);
    PVector xnew, ynew, xprev, yprev, up;
    up = new PVector(0, 0, 1);
    xnew = up.cross(newpoint.dir);
    ynew = xnew.cross(newpoint.dir);
    xnew.normalize();
    ynew.normalize();
    xprev = up.cross(prevpoint.dir);
    yprev = xprev.cross(prevpoint.dir);
    xprev.normalize();
    yprev.normalize();

    int anzEcken = 18;
    for (int j = 0; j <= anzEcken; j ++) {
      PVector zw;
      float phi = (j*(360/anzEcken)*TWO_PI)/360;


      zw = Ecke(newpoint.pos, xnew, ynew, newpoint.rad, phi);
      vertex(zw.x, zw.y, zw.z);
      zw = Ecke(newpoint.pos, xnew, ynew, newpoint.rad, phi+((360/anzEcken)*TWO_PI)/360);
      vertex(zw.x, zw.y, zw.z);
      zw = Ecke(prevpoint.pos, xprev, yprev, prevpoint.rad, phi+((360/anzEcken)*TWO_PI)/360);
      vertex(zw.x, zw.y, zw.z);
      zw = Ecke(prevpoint.pos, xprev, yprev, prevpoint.rad, phi);
      vertex(zw.x, zw.y, zw.z);
    }
  }
  endShape();
}

PVector Ecke(PVector posr, PVector x, PVector y, int r, float phi ) {
  PVector zwpos, zwx, zwy;
  zwpos = posr.copy();
  zwx= x.copy();
  zwx.mult(r*cos(phi));
  zwpos.add(zwx);
  zwy= y.copy();
  zwy.mult(r*sin(phi));      
  zwpos.add(zwy);

  return zwpos;
}


void wurfel () {
  beginShape(QUADS);

  fill(0, 1, 1); 
  vertex(-100, 100, 100);
  fill(1, 1, 1); 
  vertex( 100, 100, 100);
  fill(1, 0, 1); 
  vertex( 100, -100, 100);
  fill(0, 0, 1); 
  vertex(-100, -100, 100);

  fill(1, 1, 1); 
  vertex( 100, 100, 100);
  fill(1, 1, 0); 
  vertex( 100, 100, -100);
  fill(1, 0, 0); 
  vertex( 100, -100, -100);
  fill(1, 0, 1); 
  vertex( 100, -100, 100);

  fill(1, 1, 0); 
  vertex( 100, 100, -100);
  fill(0, 1, 0); 
  vertex(-100, 100, -100);
  fill(0, 0, 0); 
  vertex(-100, -100, -100);
  fill(1, 0, 0); 
  vertex( 100, -100, -100);

  fill(0, 1, 0); 
  vertex(-100, 100, -100);
  fill(0, 1, 1); 
  vertex(-100, 100, 100);
  fill(0, 0, 1); 
  vertex(-100, -100, 100);
  fill(0, 0, 0); 
  vertex(-100, -100, -100);

  fill(0, 1, 0); 
  vertex(-100, 100, -100);
  fill(1, 1, 0); 
  vertex( 100, 100, -100);
  fill(1, 1, 1); 
  vertex( 100, 100, 100);
  fill(0, 1, 1); 
  vertex(-100, 100, 100);

  fill(0, 0, 0); 
  vertex(-100, -100, -100);
  fill(1, 0, 0); 
  vertex( 100, -100, -100);
  fill(1, 0, 1); 
  vertex( 100, -100, 100);
  fill(0, 0, 1); 
  vertex(-100, -100, 100);

  endShape();
}

void coordAxis() {
  stroke(255, 0, 0);
  line(0, 0, 0, 100, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 100);
}