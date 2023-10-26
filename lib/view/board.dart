// 三目並べのページビュー
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tic_tac_toe/provider/tic_tac_toe_provider.dart';

import '../model/tic_tac_toe.dart';
import '../provider/get_tic_tac_toe_provider.dart';
import '../provider/update_tic_tac_toe_provider.dart';

class Board extends ConsumerWidget {
  const Board({super.key});

  //TicTacToe ticTacToe = TicTacToe.start(playerX: 'Dash', playerO: 'Sparky');

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
  Widget build(BuildContext context, WidgetRef ref) {
    // final ticTacToe = ref.watch(ticTacToeProvider);
    //AsyncValue を返却するProviderでは、このように when を使用することが可能
    final ticTacToeStream = ref.watch(getTicTacToeProvider);
    return ticTacToeStream.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, __) =>
          Center(child: Text('エラーが発生しました: ${error.toString()}')),
      data: (ticTacToe) {
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
                        final winner = ticTacToe.getWinner();
                        if (mark.isEmpty && winner.isEmpty) {
                          //ref.read(ticTacToeProvider.notifier).stateでproviderの状態にアクセス
                          // ref.read(ticTacToeProvider.notifier).state =
                          //     ticTacToe.placeMark(row, col);
                          ref.read(
                            updateTicTacToeProvider(
                                ticTacToe.placeMark(row, col)),
                          );
                        }
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
                    // ref.read(ticTacToeProvider.notifier).state =
                    //     ticTacToe.resetBoard();
                    ref.read(
                      updateTicTacToeProvider(ticTacToe.resetBoard()),
                    );
                  },
                  child: const Text('ゲームをリセット'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
