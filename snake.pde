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

snakegame s = new snakegame();
ArrayList<snakegame> snakes = new ArrayList<snakegame>();

PVector v = new PVector(0, 0);

void setup() {
  size(400, 400);
  for(int i =0; i < 100;i++){
  snakes.add(new snakegame());
}
}

void draw() {
  background(0);
  for(int i =0; i < 100;i++){
  snakes.get(i).update();
}
  frameRate(10);
}



