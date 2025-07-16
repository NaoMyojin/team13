class UIManager {
  ArrayList<Button> buttons;
  GameManager gm;
  PApplet appInstance; // app.pdeのインスタンスを受け取るための変数

  UIManager(GameManager gm, PApplet appInstance) {
    this.gm = gm;
    this.appInstance = appInstance; // インスタンスを保存
    buttons = new ArrayList<Button>();
    setupHomeButtons();
  }

  // ホーム画面のボタンを設定
  void setupHomeButtons() {
    buttons.clear();
    buttons.add(new Button("ゲームスタート", width / 2 - 75, height / 2 - 30, 150, 40, "game"));
    buttons.add(new Button("マニュアル", width / 2 - 75, height / 2 + 30, 150, 40, "manual"));
    buttons.add(new Button("ランキング", width / 2 - 75, height / 2 + 90, 150, 40, "ranking"));
  }

  void displayHome() {
    background(30, 120, 200);
    fill(255);
    textSize(32);
    textAlign(CENTER);
    text("あなたはどこ？", width / 2, 100);

    for (Button b : buttons) {
      b.display();
    }
  }

  void displayManual() {
    background(60, 60, 60);
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text("【マニュアル】", 50, 80);
    text("・制限時間内に指定された画像を見つけてクリック\n・制限時間は1ステージ7秒\n・画像が動くステージと動かないステージがある\n・3回ミスでゲームオーバー\n・ステージクリアでライフ1回復\n\n←クリックでホームに戻る", 50, 120);
  }

  void displayResult(int score) {
    background(0);
    fill(255);
    textSize(28);
    textAlign(CENTER);
    text("ゲーム終了！", width / 2, 100);
    text("クリアステージ数: " + score, width / 2, 150);
    text("クリックでホームに戻る", width / 2, 250);
  }

  void handleClick(float x, float y) {
    if (currentScreen.equals("home")) {
      for (Button b : buttons) {
        if (b.isClicked(x, y)) {
          currentScreen = b.nextScreen;
          if (currentScreen.equals("game")) {
            gm.startGame();
            timer.start();  // タイマーも開始（必要に応じて）
          }
        }
      }
    } else if (currentScreen.equals("manual") || currentScreen.equals("ranking") || currentScreen.equals("result")) {
      currentScreen = "home";
      setupHomeButtons();
    }
  }
}