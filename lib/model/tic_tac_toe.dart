import '../model/players.dart';

/// 三目並べのデータモデル
class TicTacToe {
  final List<List<String>> board;
  final Players players;
  final String currentPlayer;

  TicTacToe(
    this.board,
    this.players,
    this.currentPlayer,
  );

  //初期化
  factory TicTacToe.start({
    playerX = "X",
    playerO = "O",
  }) {
    final players = Players(playerX: playerX, playerO: playerO);

    return TicTacToe([
      ["", "", ""],
      ["", "", ""],
      ["", "", ""],
    ], players, players.playerX);
  }

  // マス目にマークを配置
  TicTacToe placeMark(int row, int col) {
    //マス目が空欄である場合
    if (board[row][col].isEmpty) {
      //現在のリストから新しいリストを作成
      final newBoard = List.of(board);
      newBoard[row][col] = currentPlayer == players.playerX ? 'X' : 'O';
      String nextPlayer =
          currentPlayer == players.playerX ? players.playerO : players.playerX;

      return TicTacToe(newBoard, players, nextPlayer);
    }
    return this;
  }

  //勝敗判定
  String getWinner() {
    for (int i = 0; i < 3; i++) {
      // row = i における横の判定
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0].isNotEmpty) {
        return board[i][0] == 'X' ? players.playerX : players.playerO;
      }
      // col = i における縦の判定
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i].isNotEmpty) {
        return board[0][i] == 'X' ? players.playerX : players.playerO;
      }
    }
    // 左上から右下への斜めの判定
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0].isNotEmpty) {
      return board[0][0] == 'X' ? players.playerX : players.playerO;
    }
    // 右上から左下への斜めの判定
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2].isNotEmpty) {
      return board[0][2] == 'X' ? players.playerX : players.playerO;
    }
    return '';
  }

  //引き分け判定
  bool isDraw() {
    return getWinner().isEmpty &&
        board.every((row) => row.every((cell) => cell.isNotEmpty));
  }

  //ゲームリセット
  TicTacToe resetBoard() {
    return TicTacToe.start(playerX: players.playerX, playerO: players.playerO);
  }
}
