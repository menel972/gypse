import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

class RecapMultiCubit extends Cubit<UiMultiGame> {
  final UiPlayer userPlayer;
  // final QuestionsProvider _questionsProvider;
  final List<UiQuestion> Function({required String book}) _getQuestionsUseCase;

  RecapMultiCubit(
    this.userPlayer,
    this._getQuestionsUseCase,
  ) : super(
          UiMultiGame.empty(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

  void init(UiMultiGame game) {
    'INIT'.log(tag: 'STATE');
    emit(game);
  }

  UiPlayer get opponent {
    return state.players
        .firstWhere((player) => player.pseudo != userPlayer.pseudo);
  }

  String get title {
    if (state.hasToPlay != null) return 'en cours';
    if (state.winner == state.hasToPlay) return 'égalité';

    return state.winner == userPlayer.pseudo ? 'Victoire' : 'Défaite';
  }

  String get scores {
    int userScore = state
        .userResults(userPlayer.pseudo)
        .where((e) => e.isRightAnswer)
        .length;

    int opponentScore = state
        .opponentResults(userPlayer.pseudo)
        .where((e) => e.isRightAnswer)
        .length;

    if (state.userResults(userPlayer.pseudo).isEmpty) return ' - ';

    if (state.hasToPlay == opponent.pseudo &&
        state.userResults(userPlayer.pseudo).isNotEmpty) return '$userScore - ';


    return '$userScore - $opponentScore';
  }

  UiQuestion questions(String id) {
    return _getQuestionsUseCase(book: ' ').firstWhere((e) => e.uId == id);
  }

  bool hasSucceed(String id, UiPlayer player) {
    final List<UiAnsweredQuestions> results = player.pseudo == userPlayer.pseudo
        ? state.userResults(userPlayer.pseudo)
        : state.opponentResults(userPlayer.pseudo);

    return results.firstWhere((e) => e.qId == id).isRightAnswer;
  }
}
