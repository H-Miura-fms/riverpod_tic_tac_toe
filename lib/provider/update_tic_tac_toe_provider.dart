import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/tic_tac_toe.dart';
import '../repository/tic_tac_toe_repository.dart';

final updateTicTacToeProvider =
    AutoDisposeFutureProviderFamily<void, TicTacToe>(
  (ref, arg) => ref.watch(ticTacToeRepositoryProvider).update(arg),
);
