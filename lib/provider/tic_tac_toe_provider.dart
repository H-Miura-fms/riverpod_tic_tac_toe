import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/tic_tac_toe.dart';

// 三目並べの状態管理用のProvider
final ticTacToeProvider = StateProvider.autoDispose<TicTacToe>((ref) {
  return TicTacToe.start();
});
