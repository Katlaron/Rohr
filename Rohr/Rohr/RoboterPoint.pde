// Klasse beeinhaltet einfach nur Mittelpunkt, dessen Richtung sowie Radius und speichert diese

class RobPoint {
  PVector pos, dir;
  int rad;

  RobPoint(PVector robpos, int radius) {
    pos = robpos.copy();
    dir = new PVector(1, 0, 0);
    rad = radius;
  }
}