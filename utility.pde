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
