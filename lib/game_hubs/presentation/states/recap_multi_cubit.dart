import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/models/ui_player.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/game_hubs/presentation/models/ui_multi_game.dart';

class RecapMultiCubit extends Cubit<UiMultiGame> {
  final UiPlayer userPlayer;
  final QuestionsProvider _questionsProvider;

  RecapMultiCubit(this.userPlayer, this._questionsProvider)
      : super(
          UiMultiGame.empty(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

  void init(UiMultiGame game) {
    'INIT'.log(tag: 'STATE');
    emit(game);
  }

  void dispose() {
    'DISPOSE'.log(tag: 'STATE');
    emit(
      UiMultiGame.empty(createdAt: DateTime.now(), updatedAt: DateTime.now()),
    );
  }

  UiPlayer get opponent {
    return state.players
        .firstWhere((player) => player.pseudo != userPlayer.pseudo);
  }

  String get title {
    if (state.winner == null) return 'En cours';

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

    if (state.winner != null) return '$userScore - $opponentScore';

    if (state.userResults(userPlayer.pseudo).isEmpty) return ' - ';

    return '$userScore - ';
  }

  UiQuestion questions(String id) {
    return _questionsProvider
        .getGameQuestions(book: ' ')
        .firstWhere((e) => e.uId == id);
  }

  bool hasSucceed(String id, UiPlayer player) {
    final List<UiAnsweredQuestions> results = player.pseudo == userPlayer.pseudo
        ? state.userResults(userPlayer.pseudo)
        : state.opponentResults(userPlayer.pseudo);

    return results.firstWhere((e) => e.qId == id).isRightAnswer;
  }
}
