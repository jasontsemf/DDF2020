import processing.pdf.*;
boolean record = false;

RectBuilding b;

void setup() {
  size(800, 800);
  fill(255);
  stroke(0);
  background(255);
  frameRate(1);
}

void draw() {
  background(255);
  if (record == true) {
    beginRecord(PDF, "output.pdf");  // Start recording to the file
  }
  for (int x=0; x<width; x+=width/10) {
    for (int y=0; y<height; y+=width/10) {
      b = new RectBuilding(width/10);
      push();
      translate(x, y);
      b.display();
      pop();
    }
  }
  if (record == true) {
    endRecord();
    record = false; // Stop recording to the file
    println("recorded PDF");
  }
}

class RectBuilding {
  int x;
  int y;
  int x2;
  int y2;
  int w;
  int h;
  float offset = 0.2;
  float innerO = 0.5;
  int innerW;
  int innerH;

  RectBuilding(int a) {
    x = int(random(0, a * offset));
    y = int(random(0, a * offset));
    x2 = int(random(a * (1 - offset), a));
    y2 = int(random(a * (1 - offset), a));
    w = x2-x;
    h = y2-y;
    innerO = random(0.3, 0.7);
    //println(x, y, x2, y2, w, h);
  }

  void displayOut() {
    rect(x, y, w, h);
  }

  void displayIn() {
    //more complicated stuff
    int r = int(random(0, 2));
    if (r == 0) {
      // not sticking outline
      r = int(random(0, 2));
      if (r == 0) {
        rect(x*(1 + innerO), y*(1 + innerO), w*innerO, h*innerO);
      } else {
        rectMode(CENTER);
        rect((x+x2)/2, (y+y2)/2, w*innerO, h*innerO);
      }
    } else {
      // stick to inner
      r = int(random(0, 2));
      if (r==0) {
        // stick to 2 sides
        r = int(random(0, 4));
        switch(r) {
        case 0:
          rect(x, y, w*innerO, h*innerO);
          break;
        case 1:
          rect(x2, y, -(w*innerO), h*innerO);
          break;
        case 2:
          rect(x, y2, w*innerO, -(h*innerO));
          break;
        case 3:
          rect(x2, y2, -(w*innerO), -(h*innerO));
          break;
        default:
          rect(x, y, w*innerO, h*innerO);
        }
      } else {
        r = int(random(0, 7));
        switch(r) {
        case 0:
          rect(x, y*(1 + innerO), w*innerO, h*innerO);
          break;
        case 1:
          rect(x, y2*(1 - innerO), w*innerO, h*innerO);
          break;
        case 2:
          rect(x2, y*(1 + innerO), -(w*innerO), h*innerO);
          break;
        case 3:
          rect(x2, y2*.4, -(w*innerO), h*innerO);
          break;
        case 4:
          rect(x*(1 + innerO), y, w*innerO, h*innerO);
          break;
        case 5:
          rect(x2*(1 - innerO), y, w*innerO, h*innerO);
          break;
        case 6:
          rect(x*(1 + innerO), y2, w*innerO, -(h*innerO));
          break;
        case 7:
          rect(x2*(1 - innerO), y2, w*innerO, -(h*innerO));
          break;
        default:
          rect(x, y*(1 + innerO), w*innerO, h*innerO);
        }
      }
    }

    //rect(x*(1 + innerO), y*(1 + innerO), w*innerO, h*innerO);
    //rectMode(CENTER);
    //rect((x+x2)/2, (y+y2)/2, w*innerO, h*innerO);

    //rect(x, y, w*innerO, h*innerO);
    //rect(x2, y, -(w*innerO), h*innerO);
    //rect(x, y2, w*innerO, -(h*innerO));
    //rect(x2, y2, -(w*innerO), -(h*innerO));

    //rect(x, y*(1 + innerO), w*innerO, h*innerO);
    //rect(x, y2*(1 - innerO), w*innerO, h*innerO);
    //rect(x2, y*(1 + innerO), -(w*innerO), h*innerO);
    //rect(x2, y2*.4, -(w*innerO), h*innerO);

    //rect(x*(1 + innerO), y, w*innerO, h*innerO);
    //rect(x2*(1 - innerO), y, w*innerO, h*innerO);
    //rect(x*(1 + innerO), y2, w*innerO, -(h*innerO));
    //rect(x2*(1 - innerO), y2, w*innerO, -(h*innerO));
  }

  void display() {
    displayOut();
    displayIn();
  }
}

void keyPressed() {
  if (key == 'R' || key == 'r') { // Press R to save the file
    record = true;
  }
}
