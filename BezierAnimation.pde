//
//  BezierAnimation.pde
//
// github:
//     https://github.com/yoggy/BezierAnimation
//
// license:
//     Copyright (c) 2016 yoggy <yoggy0@gmail.com>
//     Released under the MIT license
//     http://opensource.org/licenses/mit-license.php;
//
DraggablePoint select_p;
DraggablePoint [] ps;

void setup() {
  size(400, 400);
  ps = new DraggablePoint[4];
  ps[0] = new DraggablePoint(50, 300, #ff0000);
  ps[1] = new DraggablePoint(100, 100, #ff0000);
  ps[2] = new DraggablePoint(300, 100, #ff0000);
  ps[3] = new DraggablePoint(350, 300, #ff0000);
}

void draw() {
  float t = (millis() / 2000.0f) % 1;
  
  background(0);
  strokeWeight(2);
  
  // bezier
  noFill();
  stroke(#ff00ff);
  bezier(ps[0].x, ps[0].y, ps[1].x, ps[1].y, ps[2].x, ps[2].y, ps[3].x, ps[3].y);

  for (DraggablePoint p : ps) {
    p.draw();
  }

  stroke(#ff0000);
  line(ps[0].x, ps[0].y, ps[1].x, ps[1].y); 
  line(ps[1].x, ps[1].y, ps[2].x, ps[2].y); 
  line(ps[2].x, ps[2].y, ps[3].x, ps[3].y); 

  PVector ma0 = lerp(ps[0], ps[1], t);
  PVector ma1 = lerp(ps[1], ps[2], t);
  PVector ma2 = lerp(ps[2], ps[3], t);

  noStroke();
  fill(#0000ff);
  ellipse(ma0.x, ma0.y, 10, 10);
  ellipse(ma1.x, ma1.y, 10, 10);
  ellipse(ma2.x, ma2.y, 10, 10);

  stroke(#0000ff);
  line(ma0.x, ma0.y, ma1.x, ma1.y);
  line(ma1.x, ma1.y, ma2.x, ma2.y);

  PVector mb0 = lerp(ma0, ma1, t);
  PVector mb1 = lerp(ma1, ma2, t);

  noStroke();
  fill(#00ffff);
  ellipse(mb0.x, mb0.y, 10, 10);
  ellipse(mb1.x, mb1.y, 10, 10);

  stroke(#00ffff);
  line(mb0.x, mb0.y, mb1.x, mb1.y);

  PVector mc0 = lerp(mb0, mb1, t);

  noStroke();
  fill(#ff00ff);
  ellipse(mc0.x, mc0.y, 20, 20);
}

PVector lerp(PVector p0, PVector p1, float t) {
  float x = lerp(p0.x, p1.x, t);
  float y = lerp(p0.y, p1.y, t);
  return new PVector(x, y);  
}

void mousePressed() {
  for (DraggablePoint p : ps) {
    if (p.isHit(mouseX, mouseY)) {
      select_p = p;
      return;
    }
  }
  select_p = null;
}

void mouseDragged() {
  if (select_p != null) {
    select_p.move(mouseX, mouseY);
  }
}

void mouseReleased() {
  select_p = null;
}