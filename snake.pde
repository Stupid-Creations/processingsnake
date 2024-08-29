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
  void updatepos(PVector c) {
    vel = c;
    segmentl.get(0).updatePos(vel);
    for (int i = 1; i < segmentl.size(); i++) {
      segmentl.get(i).pos = segmentl.get(i-1).pos;
    }
  }
  void addsegment() {
    PVector tempnew = new PVector(segmentl.get(segmentl.size()-1).pos.x+segmentsize*(vel.x/segmentsize), segmentl.get(segmentl.size()-1).pos.y+segmentsize*(vel.y/segmentsize));
    println(tempnew);
    segmentl.add(new segment(tempnew, segmentsize));
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
  s.render();
  s.updatepos(v);
  s.addsegment();
  frameRate(10);
}

void keyPressed() {
  if (key == 'w') {
    v = new PVector(0, 0);
    v.y = -10;
  }
  if (key == 'a') {
    v = new PVector(0, 0);
    v.x = -10;
  }
  if (key == 's') {
    v = new PVector(0, 0);
    v.y = 10;
  }
  if (key == 'd') {
    v = new PVector(0, 0);
    v.x = 10;
  }
}
