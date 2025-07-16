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

 boolean checkAnswer(String label) {
  if (currentStage.target.label.equals(label)) {
    println("正解！");
    lives.increaseLife();
    goToNextStage();
    return true;
  } else {
    println("不正解！");
    lives.decreaseLife();
    if (lives.isDead()) {
      endGame();
      return false; // ゲームオーバー
    }
    return true;
  }
 }
}
