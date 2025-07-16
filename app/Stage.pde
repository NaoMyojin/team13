class Stage {
  int stageNumber;
  ArrayList<ImageItem> items;
  ImageItem target;
  int timeLimit = 7; // 秒
  int startTime;
  boolean isMovingStage;

  Stage(int stageNumber) {
    this.stageNumber = stageNumber;
    items = new ArrayList<ImageItem>();
    
    isMovingStage = (stageNumber % 5 == 0);  //5の倍数ステージだけ動く
    loadStage();
  }

  void loadStage() {
    String[] labels = {"carrot", "pumpkin", "greenpepper", "apple"};
    String label = labels[int(random(labels.length))];
    target = createItem(label, isMovingStage);
    items.add(target); // ステージ上にターゲットは1つだけ

    // 他のランダム画像を追加（ターゲット以外）
    int totalItemCount = min(20 + stageNumber, 70); // 最大70個まで増やす
    
    while (items.size() < totalItemCount) {
      String l = labels[int(random(labels.length))];
      if (!l.equals(target.label)) {
        items.add(createItem(l, isMovingStage));
       }
     }


    startTime = millis();
  }

  ImageItem createItem(String label, boolean isMoving) {
    PImage img = loadImage(label + ".png");
    img.resize(64, 64);  //画像ファイルの読み込み、サイズ変更
    
    float x = random(200, width - 250);
    float y = random(100, height - 150);
    return new ImageItem(img, label, x, y, isMoving);
  }

  //画像の更新(移動など)
  void update() {
    for (ImageItem item : items) {
      item.update();
    }
  }

  //画像の表示
  void display() {
    for (ImageItem item : items) {
      item.display();
    }
  }

  //時間切れ判定
  boolean isTimeUp() {
    return (millis() - startTime) / 1000.0 > timeLimit;
  }
}
