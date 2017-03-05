import java.awt.Robot;  

float eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ;
float speedeyefront, speedeyeside, speedeyeUP,normalspeed;
PVector richtung;
PVector auge, UPVec;
PVector center;
float rmx, rmy;
Robot robot;  

void initCamera() {
normalspeed=10;
  auge = new PVector(200, 200, 200);
  UPVec = new PVector(0, 0, -1);
  noCursor();
  try { 
    robot = new Robot();
  }  
  catch(Throwable e) {
  }
  rmx=width/2;
  rmy=height/2;
  robot.mouseMove(
    frame.getX()+round(width/2), 
    frame.getY()+round(height/2));
}


void keyPressed() {
  if (key == 'a'||key == 'A') {  
    speedeyeside = normalspeed;
  }
  if (key == 'w'||key == 'W') {  
    speedeyefront = normalspeed;
  }
  if (key == 's'||key == 'S') {  
    speedeyefront = -normalspeed;
  }
  if (key == 'd'||key == 'D') {
    speedeyeside = -normalspeed;
  }

  if (key == ' ') {
    speedeyeUP = -normalspeed;
    //println("Space");
  }

  if (keyCode == SHIFT) {
    speedeyeUP = +normalspeed;
    //println("Shift");
  }
}
void keyReleased() {
  if (key == 'w'||key == 'W'&& speedeyefront>0) {
    speedeyefront = 0;
  }
  if (key == 's'||key == 'S'&& speedeyefront<0) {
    speedeyefront = 0;
  }
  if (key == 'a'||key == 'A'&& speedeyeside>0) {
    speedeyeside = 0;
  }
  if (key == 'd'||key == 'D'&& speedeyeside<0) {
    speedeyeside = 0;
  }
  if (key == ' '&& speedeyeUP<0) {
    speedeyeUP = 0;
  }
  if (keyCode == SHIFT&& speedeyeUP>0) {
    speedeyeUP = 0;
  }
}

void updateCamera() {

  PVector front, side, speedup;
  float phi = map(rmx, 0, width,  2*PI,0);
  float deta = map(rmy, 0, height,-PI,0 );
  richtung = new PVector(-cos(phi)*sin(deta), sin(phi)*sin(deta), -cos(deta));
  richtung.normalize();
  center= auge.copy();
  center.add(richtung);
  camera(auge.x, auge.y, auge.z, // eyeX, eyeY, eyeZ
    center.x, center.y, center.z, // centerX, centerY, centerZ
    UPVec.x, UPVec.y, UPVec.z); // upX, upY, upZ*/

  //println("Auge X:"+ auge.x+" Y:"+ auge.y+" Z:"+ auge.z );
  //println("Center X:"+ center.x+" Y:"+ center.y+" Z:"+ center.z );
  //println("Richtung X:"+ richtung.x+" Y:"+ richtung.y+" Z:"+ richtung.z+  " PHI:"+phi/(2*PI)*360+" DETA:"+deta/(2*PI)*360 );
  
  pushMatrix();
  PVector fadenkreuz,zwv;
  zwv=richtung.copy();
  fadenkreuz= auge.copy();
  zwv.mult(100);
  fadenkreuz.add(zwv);
  translate(fadenkreuz.x, fadenkreuz.y, fadenkreuz.z);
  //sphere(0.5);
  popMatrix();
  
  center.sub(richtung);

  front = richtung.copy();
  front.mult(speedeyefront);
  auge.add(front);
  side = UPVec.cross(richtung);
  side.normalize();
  side.mult(speedeyeside);
  auge.add(side);
  speedup = UPVec.copy();
  speedup.mult(speedeyeUP);
  auge.add(speedup);
  

}

void mouseMoved() {

  rmx += mouseX-width/2;  
  rmy += mouseY-height/2; 
  if (rmx>width)rmx=0;
  if (rmx<0)rmx=width;
  if (rmy>height-1)rmy=height-1;
  if (rmy<1)rmy=1;
  robot.mouseMove(
    frame.getX()+round(width/2), 
    frame.getY()+round(height/2));
}

PVector getAuge(){
return auge.copy();
}

PVector getRichtung(){
return richtung.copy();
}