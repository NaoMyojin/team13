class GameManager {
  Stage currentStage;
  LifeManager lives;
  int score;
  boolean isGameOver;

  GameManager() {
    lives = new LifeManager();
    score = 0;
    isGameOver = false;
  }

  void startGame() {
    score = 0;
    isGameOver = false;
    lives = new LifeManager();  // ライフ初期化
    currentStage = new Stage(1);
    currentStage.generateImages();
    timer.start(); // タイマー開始
  }

  void endGame() {
    isGameOver = true;
    println("ゲームオーバー。スコア：" + score);
    ranking.addScore("PLAYER", score); // スコア記録（仮に"PLAYER"）
  }

  void goToNextStage() {
    score++;
    int nextStageNum = currentStage.stageNumber + 1;
    currentStage = new Stage(nextStageNum);
    currentStage.generateImages();
    timer.start(); // 次のステージでもタイマー再始動
  }

  void checkAnswer(int imageId) {
    if (currentStage.targetImage.imageId == imageId) {
      println("正解！");
      lives.increaseLife();
      goToNextStage();
    } else {
      println("不正解！");
      lives.decreaseLife();
      if (lives.isDead()) {
        endGame();
        changeScreen("result");
      }
    }
  }
}
