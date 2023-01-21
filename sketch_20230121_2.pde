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

  boolean onScreen() {
    return y > 100;
  }

  void reset() {
    isDraw = false;
  }
}

class Enemy {
  float x;
  float y;
  float r = 50;
  boolean isDraw;
  float th = 0;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void setup(int x, int y) {
    this.x = x;
    this.y = y;
    isDraw = true;
  }

  void draw() {
    th += 0.01;
    y += 1;
    x += cos(th);
    fill(255,155,155);
    circle(x, y, r);
  }

  boolean onScreen() {
    return 0<=y && y<=height;
  }
  
  void reset() {
    isDraw = false;
  }
}

Bullet[] bulletPool;
Enemy[] enemyPool;
int timer;

void setup() {
  size(500, 500);
  initPool();
}

void draw() {
  background(255);
  setupEnemy();
  drawTriangle(mouseX, 400);
  drawBullet();
  drawEnemy();
}

void initPool() {
  bulletPool = new Bullet[10];
  enemyPool = new Enemy[10];
  for (int i = 0; i<10; i++) {
    bulletPool[i] = new Bullet(0, 0);
  }
  for (int i = 0; i<10; i++) {
    enemyPool[i] = new Enemy(0, 0);
  }
}

void setupEnemy() {
  timer++;
  if (timer > 60) {
    timer = 0;
    for (int i = 0; i<enemyPool.length; i++) {
      if (!enemyPool[i].isDraw) {
        enemyPool[i].setup(width/2, 0);
        break;
      }
    }
  }
}

void drawTriangle(float cx, float cy) {
  fill(155, 255, 155);
  triangle(cx-20, cy+20, cx, cy-20, cx+20, cy+20);
}

void drawBullet() {
  for (int i = 0; i<10; i++) {
    if (!bulletPool[i].isDraw)continue;
    if (bulletPool[i].onScreen()) {
      bulletPool[i].draw();
    } else {
      bulletPool[i].reset();
    }
  }
}

void drawEnemy() {
  for (int i = 0; i<10; i++) {
    if (!enemyPool[i].isDraw)continue;
    if (enemyPool[i].onScreen()) {
      enemyPool[i].draw();
    } else {
      enemyPool[i].reset();
    }
  }
}

void mousePressed() {
  setupNewBullet();
}

void setupNewBullet() {
  for (int i = 0; i<bulletPool.length; i++) {
    if (!bulletPool[i].isDraw) {
      bulletPool[i].setup(mouseX, 380);
      break;
    }
  }
}
