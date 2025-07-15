class InputHandler {
  void handleClick(float mx, float my, Stage stage) {
    for (ImageItem item : stage.items) {
      if (item.isClicked(mx, my)) {
        if (item.label.equals(stage.target.label)) {
          println("正解！");
        } else {
          println("不正解！");
          lives--;
          if (lives <= 0) {
            println("ゲームオーバー！");
            noLoop();
          }
        }
        isStageOver = true;
        delay(1000);
        nextStage();
        break;
      }
    }
  }
}

  //マウスがクリックされたときに呼ばれ、画像をクリックしたかどうかの判定を行う
  //GameManager が管理すべきライフやステージ進行処理も一部入っている
