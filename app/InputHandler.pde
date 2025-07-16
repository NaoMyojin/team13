class InputHandler {
  GameManager gm;

  InputHandler(GameManager gm) {
    this.gm = gm;
  }

 void handleClick(float mx, float my, Stage stage) {
  for (ImageItem item : stage.items) {
    if (item.isClicked(mx, my)) {
      boolean continueGame = gm.checkAnswer(item.label);
      if (!continueGame) {
        // ゲームオーバー判定をメインに通知したい
        onGameOver();
      }
      break;
    }
  }
}

void onGameOver() {
  changeScreen("result");
}

void mousePressed() {
    if (currentScreen.equals("game")) {
        input.handleClick(mouseX, mouseY, gm.currentStage); // InputHandler にゲームオーバー時の画面変更を任せる
    } else {
        ui.handleClick(mouseX, mouseY);
    }
}
}



  //マウスがクリックされたときに呼ばれ、画像をクリックしたかどうかの判定を行う
  //GameManager が管理すべきライフやステージ進行処理も一部入っている
