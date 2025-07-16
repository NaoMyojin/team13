class GameManager {
  Stage currentStage;
  LifeManager lives;
  int score;
  boolean isGameOver;
  RankingManager ranking;

  GameManager(RankingManager ranking) {
    this.ranking = ranking;
    lives = new LifeManager();
    score = 0;
    isGameOver = false;
  }

  void startGame() {
    score = 0;
    isGameOver = false;
    lives = new LifeManager();
    currentStage = new Stage(1);
    timer.start();
  }

  void endGame() {
    isGameOver = true;
    println("ゲームオーバー。スコア：" + score);
    ranking.saveRanking("PLAYER", score);
  }

  void goToNextStage() {
    score++;
    int nextStageNum = currentStage.stageNumber + 1;
    currentStage = new Stage(nextStageNum);
    timer.start();
  }

  void checkAnswer(String label) {
    if (currentStage.target.label.equals(label)) {
      println("正解！");
      lives.increaseLife();
      goToNextStage();
    } else {
      println("不正解！");
      lives.decreaseLife();
      if (lives.isDead()) {
        endGame();
        changeScreen("result"); // 呼び出せない → 呼び出し元（add.pde）で処理すべき
      }
    }
  }
}
