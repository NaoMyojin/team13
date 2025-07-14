class Timer {
  int startTime;   // ミリ秒単位
  int duration;    // 制限時間（ミリ秒）

  Timer() {
    duration = 7000;  // 7秒
    startTime = millis(); // 仮で初期化
  }

  void start() {
    startTime = millis();
  }

  boolean isTimeUp() {
    return millis() - startTime > duration;
  }

  int getRemainingTime() {
    int remaining = duration - (millis() - startTime);
    return max(remaining, 0);
  }

  void displayRemainingTime() {
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);
    text("残り時間: " + (getRemainingTime() / 1000.0) + "秒", 20, 20);
  }
}
