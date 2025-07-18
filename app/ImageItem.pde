class ImageItem {
  PImage img;
  String label; // "carrot", "pumpkin"など
  float x, y;
  float vx, vy;
  boolean isMoving;

  //コンスタラクタ
  ImageItem(PImage img, String label, float x, float y, boolean isMoving) {
    this.img = img;
    this.label = label;
    this.x = x;
    this.y = y;
    this.isMoving = isMoving;
    this.vx = random(-2, 2);
    this.vy = random(-2, 2);
  }

  //移動処理
  void update() {
    if (isMoving) {
      x += vx;
      y += vy;

      // 画面の端でバウンド
      if (x < 0 || x + img.width > width) {
        vx *= -1;
      }
      if (y < 0 || y + img.height > height){
        vy *= -1;
      }
    }
  }
  
  //描画処理
  void display() {
    image(img, x, y);
  }

  void displayAt(float dx, float dy) {
    image(img, dx, dy);
　}

  //クリックされたかどうか
  boolean isClicked(float mx, float my) {
    return mx >= x && mx <= x + img.width && my >= y && my <= y + img.height;
  }
}
