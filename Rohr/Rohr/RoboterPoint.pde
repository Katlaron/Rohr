class RobPoint {
  PVector pos, dir;
  int rad;

  RobPoint(PVector robpos, int radius) {
    pos = robpos.copy();
    dir = new PVector(1, 0, 0);
    rad = radius;
  }
  
  void show(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    sphere(40);
    popMatrix();
  }
}