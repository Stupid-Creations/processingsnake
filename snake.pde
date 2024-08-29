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
  for (int i =0; i < 100; i++) {
    snakes.add(new snakegame());
  }
}
int alivecounter = 100;
void draw() {
  background(255);
  alivecounter = 100;
  for (int i =0; i < 100; i++) {
    snakes.get(i).update();
    if (snakes.get(i).alive == false) {
      alivecounter--;
    }
  }
  if (alivecounter == 0) {
    println("ded");
    snakes.sort((a, b) -> {
      return int(b.score-a.score);
    }
    );
    for (int i = 50; i < 100; i++) {
      snakes.set(i, new snakegame());
      snakegame randa = snakes.get(int(random(0, 50)));
      snakegame rando = snakes.get(int(random(0, 50)));
      snakes.get(i).ab = reproduce(randa.ab, rando.ab);
      snakes.get(i).bc = reproduce(randa.bc, rando.bc);
    }
    for (int i = 0; i < 50; i++) {
      snakes.get(i).reset();
    }
  }
      snakes.sort((a, b) -> {
      return int(b.score-a.score);
    }
    );
    text(snakes.get(0).score,50,50);
  frameRate(10);
}

void keyPressed() {
  snakes.sort((a, b) -> {
    return int(b.score-a.score);
  }
  );
  for (int i = 50; i < 100; i++) {
    snakes.set(i, new snakegame());
    snakegame randa = snakes.get(int(random(0, 50)));
    snakegame rando = snakes.get(int(random(0, 50)));
    snakes.get(i).ab = reproduce(randa.ab, rando.ab);
    snakes.get(i).bc = reproduce(randa.bc, rando.bc);
  }
  for (int i = 0; i < 50; i++) {
    snakes.get(i).reset();
  }
}
