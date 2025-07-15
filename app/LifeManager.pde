class LifeManager {
  int lives;
  final int MAX_LIVES = 3;

  LifeManager() {
    lives = MAX_LIVES;
  }

  // ライフを1減らす（下限0）
  void decreaseLife() {
    if (lives > 0) {
      lives--;
    }
  }

  // ライフを1増やす（上限3）
  void increaseLife() {
    if (lives < MAX_LIVES) {
      lives++;
    }
  }

  // 残りライフが0かを判定
  boolean isDead() {
    return lives <= 0;
  }

  // 残りライフを取得
  int getLives() {
    return lives;
  }

  // 初期化または再スタート用
  void reset() {
    lives = MAX_LIVES;
  }

  // ライフの表示（例：ハートの数を表示）
  void display(float x, float y) {
    for (int i = 0; i < MAX_LIVES; i++) {
      if (i < lives) {
        fill(255, 0, 0); // 赤（ライフあり）
      } else {
        fill(100);       // グレー（ライフなし）
      }
      ellipse(x + i * 30, y, 20, 20); // ハートの代わりに円を描画
    }
  }
}
