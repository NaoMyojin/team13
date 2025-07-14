int screenWidth = 1200;
int screenHeight = 700;

void setup() {
  size(screenWidth, screenHeight);
  textFont(createFont("メイリオ", 24));
  gm = new GameManager();
  ui = new UIManager();
  input = new InputHandler();
  ranking = new RankingManager();
  timer = new Timer();
  currentScreen = "game"; // テスト時用
  gm.startGame();
}

void draw() {
  background(0);

  if (currentScreen.equals("game")) {
    drawGameScreen();
  }
}

void drawGameScreen() {
  // ゲームオーバー時は描画を停止
  if (gm.isGameOver) return;

  // タイムオーバー処理
  if (timer.isTimeUp()) {
    println("時間切れ！");
    gm.lives.decreaseLife();

    if (gm.lives.isDead()) {
      gm.endGame();
      changeScreen("result");
    } else {
      gm.goToNextStage();
    }
    return;
  }

  // 1. 情報パネル（左）
  fill(255);
  rect(0, 0, 200, height);

  // タイマー
  fill(255, 255, 0);
  textAlign(CENTER, CENTER);
  textSize(32);
  text(nf(timer.getRemainingTime() / 1000.0, 1, 1) + "秒", 100, 50);

  // ライフ
  textSize(24);
  fill(255, 255, 0);
  text("のこり", 100, 150);
  for (int i = 0; i < gm.lives.lives; i++) {
    fill(255, 0, 0);
    text("❤", 60 + i * 30, 200);
  }

  // 2. ステージタイトル
  fill(255, 255, 0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text(gm.currentStage.stageNumber + "ステージ目", screenWidth / 2, 50);

  // 3. 中央の画像表示
  gm.currentStage.update();
  gm.currentStage.displayStage();

  // 4. 右のTARGET表示
  fill(255);
  rect(1000, 500, 200, 180);  // 枠
  fill(255, 255, 0);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("TARGET!!", 1100, 520);

  gm.currentStage.targetImage.dis
