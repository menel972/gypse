// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/locales_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';

part 'ui_gypse_settings.dart';
part 'ui_answered_questions.dart';
part 'ui_game_history.dart';
part 'ui_player.dart';

///<i><small>`Presentation Layer`</small></i>
///## User's data <i><small>(received from the domain layer)</small></i>
///
///```
///final String uId;
///final String userName;
///final bool isAdmin;
///Locales language;
///LoginState status;
///List<UiAnsweredQuestions> questions;
///UiGypseSettings settings;
///```
///
///It contains all the data for an user.
class UiUser extends Equatable {
  final String uId;
  final bool isAdmin;
  final UiPlayer player;
  final List<UiGameHistory> multiGamesHistory;
  final int fish;
  Locales language;
  LoginState status;
  List<UiAnsweredQuestions> questions;
  UiGypseSettings settings;

  ///<i><small>`Presentation Layer`</small></i>
  ///### User's data' <i><small>(received from the domain layer)</small></i>
  ///#### `UiUser` constructor
  ///<br>
  ///It contains all the data for an user.
  UiUser(
    this.uId, {
    this.isAdmin = false,
    this.player = const UiPlayer.initial(),
    this.multiGamesHistory = const [],
    this.fish = 5,
    this.language = Locales.fr,
    this.status = LoginState.loading,
    this.questions = const [],
    required this.settings,
  });

  factory UiUser.anonymous(String uId) => UiUser(
        uId,
        isAdmin: false,
        player: const UiPlayer.initial(),
        language: Locales.fr,
        status: LoginState.loading,
        questions: const [],
        settings: const UiGypseSettings(),
      );

  @override
  List<Object?> get props => [
        uId,
        isAdmin,
        player,
        multiGamesHistory,
        fish,
        language,
        status,
        questions,
        settings,
      ];

  UiUser copyWith({
    UiPlayer? player,
    LoginState? status,
    List<UiAnsweredQuestions>? questions,
    UiGypseSettings? settings,
  }) =>
      UiUser(
        uId,
        isAdmin: isAdmin,
        player: player ?? this.player,
        language: language,
        status: status ?? this.status,
        questions: questions ?? this.questions,
        settings: settings ?? this.settings,
      );

  bool get isAnonymous => player.pseudo.isEmpty;

  (bool, int?) get levelMedUnlocked {
    int? delta;

    final List<UiAnsweredQuestions> condition = questions
        .where((q) => q.level == Level.easy && q.isRightAnswer)
        .toList();
    final List<UiAnsweredQuestions> medList = questions
        .where((q) => q.level == Level.medium && q.isRightAnswer)
        .toList();

    if (condition.length < 3) delta = 3 - condition.length;

    return (delta.isNull || medList.isNotEmpty, delta);
  }

  (bool, int?) get levelHardUnlocked {
    int? delta;

    final List<UiAnsweredQuestions> condition = questions
        .where((q) => q.level == Level.medium && q.isRightAnswer)
        .toList();
    final List<UiAnsweredQuestions> hardList = questions
        .where((q) => q.level == Level.hard && q.isRightAnswer)
        .toList();

    if (condition.length < 10) delta = 10 - condition.length;

    return (delta.isNull || hardList.isNotEmpty, delta);
  }
}
