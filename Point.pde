class DraggablePoint extends PVector {
  color c;
  float r = 30;
  
  DraggablePoint(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }
  
  void draw() {
    ellipseMode(CENTER);

    noStroke();
    fill(c);
    ellipse(x, y, r, r);
  }
  
  boolean isHit(float x, float y) {
    println("x=" + x + ", y=" + y);
    float d = sqrt(pow(x - this.x, 2) + pow(y - this.y, 2));
    if (d < r) return true;
    return false;
  }
  
  void move(float x, float y) {
    this.x = x;
    this.y = y;
  }
   
}