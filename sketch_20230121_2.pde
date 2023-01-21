class Bullet {
  float x;
  float y;
  int r = 10;
  boolean isDraw;

  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void setup(float x, float y) {
    this.x = x;
    this.y = y;
    isDraw = true;
  }

  void draw() {
    y -= 3;
    circle(x, y, r);
  }

  boolean offScreen() {
    return y > 100;
  }
  
  void reset(){
    // リセット処理
    isDraw = false;
  }
}

class Enemy {
  float x;
  float y;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

Bullet[] bulletPool;
Enemy[] enemyPool;

void setup() {
  size(500, 500);
  bulletPool = new Bullet[10];
  enemyPool = new Enemy[10];
  for (int i = 0; i<10; i++) {
    bulletPool[i] = new Bullet(0, 0);
  }
  for (int i = 0; i<10; i++) {
    enemyPool[i] = new Enemy(0, 0);
  }
}

void draw() {
  background(255);
  drawTriangle(mouseX, 400);

  for (int i = 0; i<10; i++) {
    if(!bulletPool[i].isDraw)continue;
    if (bulletPool[i].offScreen()) {
      bulletPool[i].draw();
    } else {
      bulletPool[i].reset();
    }
  }
}

void drawTriangle(float cx, float cy) {
  fill(155, 255, 155);
  triangle(cx-20, cy+20, cx, cy-20, cx+20, cy+20);
}

void mousePressed() {
  for(int i = 0; i<bulletPool.length; i++){
    if(!bulletPool[i].isDraw){
      bulletPool[i].setup(mouseX, 380);
      break;
    }
  }
}
