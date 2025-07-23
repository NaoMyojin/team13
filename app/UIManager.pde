class UIManager {
  ArrayList<Button> buttons;
  Button backButton;
  Button resultBackButton;
  GameManager gm;
  PApplet appInstance;

  UIManager(GameManager gm, PApplet appInstance) {
    this.gm = gm;
    this.appInstance = appInstance;
    buttons = new ArrayList<Button>();
    setupHomeButtons();
    resultBackButton = new Button("ホームに戻る", appInstance.width / 2 - 75, 300, 150, 40, "home");
  }

  void setupHomeButtons() {
    buttons.clear();
    buttons.add(new Button("ゲームスタート", appInstance.width / 2 - 75, appInstance.height / 2 - 30, 150, 40, "game"));
    buttons.add(new Button("マニュアル", appInstance.width / 2 - 75, appInstance.height / 2 + 30, 150, 40, "manual"));
    buttons.add(new Button("ランキング", appInstance.width / 2 - 75, appInstance.height / 2 + 90, 150, 40, "ranking"));
    backButton = null;
  }

  void setupBackButton() {
    backButton = new Button("ホームに戻る", appInstance.width / 2 - 75, appInstance.height - 100, 150, 40, "home");
  }

  void displayHome() {
    appInstance.background(30, 120, 200);
    appInstance.fill(255);
    appInstance.textSize(32);
    appInstance.textAlign(CENTER);
    appInstance.text("あなたはどこ？", appInstance.width / 2, 100);
    for (Button b : buttons) {
      b.display();
    }
  }

  void displayManual() {
    appInstance.background(60, 60, 60);
    appInstance.fill(255);
    appInstance.textSize(20);
    appInstance.textAlign(LEFT);
    appInstance.text("【マニュアル】", 50, 80);
    appInstance.text("・制限時間内に指定された画像を見つけてクリック\n・制限時間は1ステージ7秒\n・画像が動くステージと動かないステージがある\n・3回ミスでゲームオーバー\n・ステージクリアでライフ1回復\n", 50, 120);
    if (backButton == null) setupBackButton();
    backButton.display();
  }

  void displayResult(int score) {
    appInstance.background(0);
    appInstance.fill(255);
    appInstance.textSize(28);
    appInstance.textAlign(CENTER);
    appInstance.text("ゲーム終了！", appInstance.width / 2, 100);
    appInstance.text("クリアステージ数: " + score, appInstance.width / 2, 150);
    resultBackButton.display();
  }

  void displayRankingBackButton() {
    if (backButton == null) setupBackButton();
    backButton.display();
  }

  void handleClick(float x, float y) {
    if (currentScreen.equals("home")) {
      for (Button b : buttons) {
        if (b.isClicked(x, y)) {
          currentScreen = b.nextScreen;
          if (currentScreen.equals("game")) {
            gm.startGame();
            timer.start();
          }
          backButton = null;
          break;
        }
      }
    } else if (currentScreen.equals("manual") || currentScreen.equals("ranking")) {
      if (backButton != null && backButton.isClicked(x, y)) {
        currentScreen = "home";
        setupHomeButtons();
        backButton = null;
      }
    } else if (currentScreen.equals("result")) {
      if (resultBackButton.isClicked(x, y)) {
        currentScreen = "home";
        setupHomeButtons();
      }
    }
  }
}