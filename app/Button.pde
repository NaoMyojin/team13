class Button {
  String label;
  float x, y, w, h;
  String nextScreen;

  Button(String label, float x, float y, float w, float h, String nextScreen) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.nextScreen = nextScreen;
  }

  void display() {
    fill(255);
    stroke(0);
    rect(x, y, w, h, 10);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(label, x + w / 2, y + h / 2);
  }

  boolean isClicked(float mx, float my) {
    return (mx >= x && mx <= x + w && my >= y && my <= y + h);
  }
}
