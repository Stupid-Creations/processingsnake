class snake {
  int segments = 1;
  PVector pos;
  int segmentsize = 10;
  PVector vel = new PVector(0, 0);
  ArrayList<segment> segmentl = new ArrayList<segment>();
  snake(PVector p) {
    pos = p;
    segmentl.add(new segment(p, segmentsize));
  }
  void render() {
    for (int i = 0; i < segmentl.size(); i++) {
      segmentl.get(i).render();
    }
  }
  void updatePosition() {
    PVector prevPos = segmentl.get(0).pos.copy();
    segmentl.get(0).updatePos(vel);

    for (int i = 1; i < segmentl.size(); i++) {
      PVector tempPos = segmentl.get(i).pos.copy();
      segmentl.get(i).pos.set(prevPos);
      prevPos = tempPos;
    }
    render();
  }

  void addSegment() {
    segment lastSegment = segmentl.get(segmentl.size() - 1);
    PVector newSegmentPos = lastSegment.pos.copy();
    segmentl.add(new segment(newSegmentPos, segmentsize));
    segments++;
  }
}

class segment {
  PVector pos;
  int size;
  segment(PVector p, int s) {
    pos = p;
    size = s;
  }
  void render() {
    square(pos.x, pos.y, size);
  }
  void updatePos(PVector vel) {
    pos.add(vel);
  }
}

snake s = new snake(new PVector(40, 40));
PVector v = new PVector(0, 0);
void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  s.updatePosition();
  frameRate(10);
}

void keyPressed() {
  if (key == 'w') {
    s.vel = new PVector(0, -10);
  }
  if (key == 'a') {
    s.vel = new PVector(-10, 0);
  }
  if (key == 's') {
    s.vel = new PVector(0, 10);
  }
  if (key == 'd') {
    s.vel = new PVector(10, 0);
  }
    s.addSegment();

}
