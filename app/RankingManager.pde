 import java.util.Collections;
import java.util.Comparator;

class RankingManager {
  ArrayList<RankingEntry> rankingList;
  String rankingFile = "ranking.txt";
  int maxEntries = 10; // ランキングに表示する最大件数

  RankingManager() {
    rankingList = new ArrayList<RankingEntry>();
    loadRanking();
  }

  // ランキングデータをファイルから読み込む
  void loadRanking() {
    rankingList.clear();
    String[] lines = loadStrings(rankingFile);

    if (lines != null) {
      for (String line : lines) {
        String[] parts = split(line, ":");
        if (parts.length == 2) {
          String name = parts[0];
          int score = int(trim(parts[1]));
          rankingList.add(new RankingEntry(name, score));
        }
      }
    }

    sortRanking();
  }

  // スコアを追加し、ランキングを保存
  void saveRanking(String playerName, int score) {
    rankingList.add(new RankingEntry(playerName, score));
    sortRanking();

    // 上位 maxEntries 件までに制限
    int limit = min(rankingList.size(), maxEntries);
    String[] lines = new String[limit];
    for (int i = 0; i < limit; i++) {
      RankingEntry entry = rankingList.get(i);
      lines[i] = entry.name + ":" + entry.score;
    }

    saveStrings(rankingFile, lines);
  }

  // ランキングを画面に表示
  void displayRanking(float x, float y) {
    fill(255);
    textSize(20);
    text("🏆 ランキング", x, y - 30);

    textSize(16);
    for (int i = 0; i < min(rankingList.size(), maxEntries); i++) {
      RankingEntry entry = rankingList.get(i);
      text((i + 1) + ". " + entry.name + " - " + entry.score, x, y + i * 24);
    }
  }

  // スコア順に降順ソート

void sortRanking() {
  Collections.sort(rankingList, new Comparator<RankingEntry>() {
    @Override
    public int compare(RankingEntry a, RankingEntry b) {
      return b.score - a.score; // スコアの降順
    }
  });
}


  // 内部用ランキングエントリクラス
  class RankingEntry {
    String name;
    int score;

    RankingEntry(String name, int score) {
      this.name = name;
      this.score = score;
    }
  }
}
