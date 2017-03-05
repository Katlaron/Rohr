
// Dieser Abschnitt kümmert sich ausschließlich um die Kamera Bewegung
// Bewegung mit WASD sowie SHIFT für Höhe gewinnen und SPACE um zu sinken
// Um die Camera zu verwenden im setup() initCamera() aufrufen
// Um die Camera zu aktualiesieren in draw() updateCamera() aufrufen

import java.awt.Robot;  

float eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ;
float speedeyefront, speedeyeside, speedeyeUP,normalspeed;
PVector richtung;
PVector auge, UPVec;
PVector center;
float rmx, rmy;
Robot robot;  

void initCamera() {              // initialiesiert die Kamera 
normalspeed=10;                            // init Wert für die Augengeschwindigkeit
  auge = new PVector(200, 200, 200);        // init Werete für die Augenposition
  UPVec = new PVector(0, 0, -1);             // init für die Richtung die als oben erscheinen soll
  noCursor();                                // deaktiviert den Curser
  try {                   
    robot = new Robot();                     // versucht Robot zu erstellen, wird benötigt um Maus in der Bildschirmmitte gefangen zu halten
  }  
  catch(Throwable e) {
  }
  rmx=width/2;
  rmy=height/2;
  robot.mouseMove(
    frame.getX()+round(width/2), 
    frame.getY()+round(height/2));
}


void keyPressed() {                              // reagiert auf Tastendrücke und verändert die Augenposition
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
void keyReleased() {                                        // kümmert sich darum, dass Bewegung aufhört wenn eine Taste losgelassen wird
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

void updateCamera() {        // eigentliche Berechnung der Kamera

  PVector front, side, speedup;
  float phi = map(rmx, 0, width,  2*PI,0);              // mapt die Mausposition X auf einen Winkel phi in Kugelkoordinaten
  float deta = map(rmy, 0, height,-PI,0 );              // mapt die Mausposition Y auf den Winkel deta
  richtung = new PVector(-cos(phi)*sin(deta), sin(phi)*sin(deta), -cos(deta));   // macht einen Richtungsvektor draus
  richtung.normalize();
  center= auge.copy();
  center.add(richtung);                                              // Punkt auf den die Camera schaut
  camera(auge.x, auge.y, auge.z, // eyeX, eyeY, eyeZ
    center.x, center.y, center.z, // centerX, centerY, centerZ
    UPVec.x, UPVec.y, UPVec.z); // upX, upY, upZ*/

  pushMatrix();                // nachfolgend wird mit sphere() ein Punkt in der Mitte des Bildschirms geschaffen (Fadenkreuz)
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
  auge.add(front);                  // Auge + Geschwindigkeit in Blickrichtung
  side = UPVec.cross(richtung);      // Bestimmung eines Vektors der zur Seite zeigt
  side.normalize();
  side.mult(speedeyeside);
  auge.add(side);                    // auge + senkrechte Geschwindigkeit
  speedup = UPVec.copy();
  speedup.mult(speedeyeUP);
  auge.add(speedup);                // auge + nach oben Gerichtete Geschwindigkeit
  

}

void mouseMoved() {              // speichert Mausbewegung in rmx, rmy und setzt dannach die Mausposition wieder zurück

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

//PVector getAuge(){
//return auge.copy();
//}

//PVector getRichtung(){
//return richtung.copy();
//}