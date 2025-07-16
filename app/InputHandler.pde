class InputHandler {
  GameManager gm;

  InputHandler(GameManager gm) {
    this.gm = gm;
  }

  void handleClick(float mx, float my, Stage stage) {
    for (ImageItem item : stage.items) {
      if (item.isClicked(mx, my)) {
        gm.checkAnswer(item.label); // GameManager に判定を任せる
        break;
      }
    }
  }
}

  //マウスがクリックされたときに呼ばれ、画像をクリックしたかどうかの判定を行う
  //GameManager が管理すべきライフやステージ進行処理も一部入っている
