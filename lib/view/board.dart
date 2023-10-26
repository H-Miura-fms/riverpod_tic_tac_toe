// 三目並べのページビュー
import 'package:flutter/material.dart';

import '../model/tic_tac_toe.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  TicTacToe ticTacToe = TicTacToe.start(playerX: 'Dash', playerO: 'Sparky');

  String _statusMessage(TicTacToe ticTacToe) {
    //三目並べ盤面状況から、勝利者を判定
    final winner = ticTacToe.getWinner();

    //三目並べ盤面状況から、引き分けを判定
    final isDraw = ticTacToe.isDraw();

    if (winner.isNotEmpty) {
      return '$winnerの勝ち';
    } else if (isDraw) {
      return '引き分けです';
    } else {
      //勝利も引き分けでもないので、次の指し手を依頼
      return '${ticTacToe.currentPlayer}の番';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _statusMessage(ticTacToe),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  //横方向のマス個数（３個）
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
              //縦横のマス個数（３×３）
              itemCount: 9,
              itemBuilder: (context, index) {
                final row = index ~/ 3;
                final col = index % 3;
                //○× または空文字列を返す。
                final mark = ticTacToe.board[row][col];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      final winner = ticTacToe.getWinner();
                      if (mark.isEmpty && winner.isEmpty) {
                        ticTacToe = ticTacToe.placeMark(row, col);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        mark,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // ゲーム・リセットボタン
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ticTacToe = ticTacToe.resetBoard();
                });
              },
              child: const Text('ゲームをリセット'),
            ),
          ),
        ],
      ),
    );
  }
}
