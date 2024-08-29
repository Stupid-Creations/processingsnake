float sigmoid(float x) {
  return 1/(1+exp(-x));
}

float[] sigmoid(float[] x) {
  float[]a = new float[x.length];
  for (int i = 0; i<a.length; i++) {
    a[i] = sigmoid(x[i]);
  }
  return a;
}

float tanh(float x) {
  return (exp(x*2)-1)/(exp(x*2)+1);
}
float[] tanh(float[] x) {
  float[]a = new float[x.length];
  for (int i = 0; i<a.length; i++) {
    a[i] = tanh(x[i]);
  }
  return a;
}

void printmatrix(float[][] a) {
  for (int i = 0; i<a.length; i++) {
    for (int j = 0; j<a[i].length; j++) {
      print(a[i][j]+" ");
    }
    println();
  }
}

class n_layer {
  int n1;
  int n2;
  float[][] w;
  float[]bias;
  float[]pred;
  float cost;
  n_layer(int a, int b) {
    n1 = a;
    n2 = b;
    bias = new float[n2];
    pred = new float[n2];
    w = new float[n2][n1];
    for (int i = 0; i<w.length; i++) {
      for (int j = 0; j<w[i].length; j++) {
        w[i][j] = random(0, 1);
      }
    }
    for (int i = 0; i < bias.length; i++) {
      bias[i] = random(0, 1);
    }
  }
  void activate(float[]m, boolean a) {
    int colsa = w[0].length;
    int rowsa = w.length;
    int colsb = 1;
    int rowsb = bias.length;

    if (n1 != m.length) {
      print(n1);
      return;
    }

    for (int i = 0; i < rowsa; i++) {
      for (int j = 0; j < colsb; j++) {
        float sum = 0;
        for (int k = 0; k<colsa; k++) {
          sum += w[i][k] * m[j];
        }
        pred[i] = sum;
      }
    }
    for (int i = 0; i<pred.length; i++) {
      pred[i]+=bias[i];
    }
    if (a) {
      pred = sigmoid(pred);
    }
  }
}

n_layer reproduce(n_layer a, n_layer b) {
  n_layer c = new n_layer(a.n1, a.n2);
  for (int i =0; i<a.w.length; i++) {
    for (int j = 0; j<a.w[0].length; j++) {
      int choose = int(random(-1, 10000));
      if (choose>0) {
        int choose1 = int(random(0, 2));
        if (choose1 == 1) {
          c.w[i][j] = a.w[i][j];
        }
        if (choose1 == 0) {
          c.w[i][j] = b.w[i][j];
        }
      }
      if (choose == -1) {
        c.w[i][j] = random(0, 1);
      }
    }
  }
  for (int i = 0; i<a.bias.length; i++) {
    int choose = int(random(-1, 100));
    if (choose>0) {
      int choose1 = int(random(0, 2));
      if (choose1 == 1) {
        c.bias[i] = a.bias[i];
      }
      if (choose1 == 0) {
        c.bias[i] = b.bias[i];
      }
    } else {
      c.bias[i] = random(0, 1);
    }
  }
  return c;
}

class snakegame {
  snake s;
  PVector food;
  n_layer ab;
  n_layer bc;
  color colour;
  boolean alive;
  float score = 0;
  snakegame() {
    s = new snake(new PVector(200, 200));
    food = new PVector(175, 175);
    ab = new n_layer(6, 8);
    bc = new n_layer(8, 4);
    colour = color(random(0, 255), random(0, 255), random(0, 255));
    alive = true;
  }
  void update() {
    float ld = 10000000;
    if (alive) {
      fill(colour);
      s.updatePosition();
      if (s.segmentl.get(0).pos.x == food.x && s.segmentl.get(0).pos.y == food.y) {
        score++;
        food = new PVector(int(random(0,39))*10,int(random(0,39))*10);
      }
      if(food.dist(s.segmentl.get(0).pos) < ld){
        ld = food.dist(s.segmentl.get(0).pos);
      }
      square(food.x,food.y,10);
      float lwall = s.segmentl.get(0).pos.x;
      float uwall = s.segmentl.get(0).pos.y;
      float rwall = 400-s.segmentl.get(0).pos.x;
      float dwall = 400-s.segmentl.get(0).pos.y;
      float foodxd = food.x-s.segmentl.get(0).pos.x;
      float foodyd = food.y-s.segmentl.get(0).pos.y;
      ab.activate(new float[] {lwall, uwall, rwall, dwall, foodxd, foodyd}, true);
      bc.activate(ab.pred, true);
      float maxpred = 0;
      for (int i = 0; i < bc.pred.length; i++) {
        if (max(bc.pred) == bc.pred[i]) {
          maxpred = i;
        }
      }
      if (maxpred == 0) {
        s.vel = new PVector(0, -10);
      }
      if (maxpred == 1) {
        s.vel = new PVector(-10, 0);
      }
      if (maxpred == 2) {
        s.vel = new PVector(0, 10);
      }
      if (maxpred == 3) {
        s.vel = new PVector(10, 0);
      }
      if(s.segmentl.get(0).pos.y < 0 || s.segmentl.get(0).pos.y > 390 || s.segmentl.get(0).pos.x < 0|| s.segmentl.get(0).pos.y>390){
        alive = false;
      }
    }
    if(alive == false){
      if(score == 0){
        score = ld/1000;
      }
    }
  }
}
