class Ant {
  int myX, myY, myColor;

  Ant() {
    myX = width/2;
    myY = height/2;
  }

  Ant(int x, int y) {
    myX = x;
    myY = y;
  }

  void show() {
    // right legs
    line(myX, myY, myX+10, myY-7); 
    line(myX, myY, myX+10, myY+7);
    line(myX, myY, myX+10, myY);
    // left legs
    line(myX, myY, myX-10, myY-7); 
    line(myX, myY, myX-10, myY+7);
    line(myX, myY, myX-10, myY);
    // antenna
    line(myX, myY, myX-4, myY-20); 
    line(myX, myY, myX+4, myY-20);
    // body
    ellipse(myX, myY-9, 10, 8);
    ellipse(myX, myY, 6, 10);
    ellipse(myX, myY+10, 10, 10);
  }

  void walk() {
    // random walk
    myX += (int)(Math.random()*3)-1; 
    myY += (int)(Math.random()*3)-1;
  }

  void moveTowards(int targetX, int targetY) {
    if (myX < targetX) 
      myX += (int)(Math.random()*4)-1;
    if (myX > targetX) 
      myX -= (int)(Math.random()*4)-1;
    if (myY < targetY) 
      myY += (int)(Math.random()*4)-1;
    if (myY > targetY) 
      myY -= (int)(Math.random()*4)-1;
  }

  void eat(Food food) {
    float distance = dist(myX, myY, food.myX, food.myY);
    if (distance < food.size / 2) { 
      food.size -= 1; // 
      if (food.size < 10) { // 
        food.size = 0;
      }
    }
  }
}

class Food {
  int myX, myY, myColor;
  float size = 50; 

  Food(int x, int y) {
    myX = x;
    myY = y;
    myColor = color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
  }

  void show() {
    pushStyle();
    fill(myColor);
    ellipse(myX, myY, size, size); 
    popStyle();
  }
}

Ant bob;
Ant[] ohio = new Ant[100];
Food food;

void setup() {
  size(600, 600);
  bob = new Ant();

  for (int i = 0; i < ohio.length; i++) {
    ohio[i] = new Ant(300, 300);
  }
}

void draw() {
  background(192);

  bob.walk();
  bob.show();

  for (int i = 0; i < ohio.length; i++) {
    if (food != null) {
      ohio[i].moveTowards(food.myX, food.myY); 
      ohio[i].eat(food); 
    } else {
      ohio[i].walk(); 
    }
    ohio[i].show();
  }

  if (food != null) {
    food.show(); 
  }
}

void mousePressed() {
  food = new Food(mouseX, mouseY); 
}
