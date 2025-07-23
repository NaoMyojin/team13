GameManager gm;
UIManager ui;
InputHandler input;
RankingManager ranking;
Timer timer;
String currentScreen;

int screenWidth = 1200;
int screenHeight = 700;

// 画像をラベル名で管理するマップ
HashMap<String, PImage> imageMap;

void settings() {
  size(screenWidth, screenHeight);
}

void setup() {
  textFont(createFont("メイリオ", 24));
  ranking = new RankingManager();

  // 画像を一括読み込み
  imageMap = new HashMap<String, PImage>();
  String[] labels = {"carrot", "pumpkin", "greenpepper", "apple"};
  for (String label : labels) {
    PImage img = loadImage(label + ".png");
    img.resize(64, 64);
    imageMap.put(label, img);
  }

  gm = new GameManager(ranking);
  ui = new UIManager(gm, this);
  input = new InputHandler(gm);
  timer = new Timer();
  currentScreen = "home"; // テスト時用
  gm.startGame();
}

void draw() {
  background(155);//←色を変えた(7/22)

  if (currentScreen.equals("game")) {
    drawGameScreen();
  } else if (currentScreen.equals("result")) {
    ui.displayResult(gm.score);
  } else if (currentScreen.equals("home")) {
    ui.displayHome();
  } else if (currentScreen.equals("manual")) {
    ui.displayManual();
  } else if (currentScreen.equals("ranking")) {
    ranking.displayRanking(width / 2 - 100, 150);
  }
}

void drawGameScreen() {
  if (gm.isGameOver) return;

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

  fill(255);
  line(200, 0, 200, height);
  //rect(0, 0, 200, height); この行を消しました7/22

  fill(255, 255, 0);
  textAlign(CENTER, CENTER);
  textSize(32);
  text(nf(timer.getRemainingTime() / 1000.0, 1, 1) + "秒", 100, 50);

  textSize(24);
  fill(255, 255, 0);
  text("のこり", 100, 150);
  for (int i = 0; i < gm.lives.lives; i++) {
    fill(255, 0, 0);
    text("❤", 60 + i * 30, 200);
  }

  fill(255);
  line(200, 100, 1000, 100);//←ここを変えた7/22

  fill(255, 255, 0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text(gm.currentStage.stageNumber + "ステージ目", screenWidth / 2, 50);

  gm.currentStage.update();
  gm.currentStage.display();

  fill(255);
  rect(1000, 500, 200, 180);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("TARGET!!", 1100, 520);
  gm.currentStage.target.displayAt(1100, 550);  // ← ここを修正

  fill(255);
  line(1000, 0, 1000, 700); //←ここ2行を修正7/22

  fill(255, 255, 0);
  textSize(28);
  textAlign(LEFT, CENTER);
  text("クリアステージ数: " + gm.score, 20, height - 40);
}

void changeScreen(String screenName) {
  currentScreen = screenName;

  if (currentScreen.equals("game")) {
    gm.startGame();
    timer.start();
  } else if (currentScreen.equals("result")) {
    ranking.saveRanking("PLAYER", gm.score);
  } else if (currentScreen.equals("home")) {
    ui.setupHomeButtons();
  }
}

void mousePressed() {
  if (currentScreen.equals("game")) {
    input.handleClick(mouseX, mouseY, gm.currentStage);
  } else {
    ui.handleClick(mouseX, mouseY);
  }
}
