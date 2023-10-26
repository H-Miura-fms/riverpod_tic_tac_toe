import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/tic_tac_toe.dart';
import '../repository/tic_tac_toe_repository.dart';

final getTicTacToeProvider = AutoDisposeStreamProvider<TicTacToe>(
  (ref) =>
      // 対戦相手同士のIDを設定する（プレイヤー名は後ほど変更します）
      ref.watch(ticTacToeRepositoryProvider).get(
            playerX: 'Dash',
            playerO: 'Sparky',
          ),
);
