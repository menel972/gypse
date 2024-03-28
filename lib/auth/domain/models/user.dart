// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/enums/locales_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';

part 'gypse_settings.dart';
part 'answered_questions.dart';
part 'player.dart';
part 'game_history.dart';

///<i><small>`Domain Layer`</small></i>
///## User's data <i><small>(received from the data layer)</small></i>
///
///```
///final String uid;
///final String userName;
///final bool isAdmin;
///Locales language;
///LoginState status;
///List<AnsweredQuestions> questions;
///GypseSettings settings;
///```
///
///The `User` is parsed to the `Presentation Layer` using the [User.toPresentation] method.
///<br><br>
///It contains all the data for an user.
class User extends Equatable {
  final String uid;
  final bool isAdmin;
  final Player player;
  final List<GameHistory> multiGamesHistory;
  final int fish;
  Locales language;
  LoginState status;
  List<AnsweredQuestions> questions;
  GypseSettings settings;

  ///<i><small>`Domain Layer`</small></i>
  ///### User's data <i><small>(received from the data layer)</small></i>
  ///#### `User` constructor
  ///<br>
  ///It contains all the data for an user.
  User({
    required this.uid,
    required this.isAdmin,
    required this.player,
    required this.multiGamesHistory,
    required this.fish,
    required this.language,
    required this.status,
    required this.questions,
    required this.settings,
  });

  User.mock({
    this.uid = 'ambuIUO',
    this.isAdmin = false,
    this.player = const Player.mock(),
    this.multiGamesHistory = const [GameHistory.mock()],
    this.fish = 5,
    this.language = Locales.fr,
    this.status = LoginState.authenticated,
    this.questions = const [AnsweredQuestions.mock()],
    required this.settings,
  });

  @override
  List<Object?> get props {
    return [
      uid,
      isAdmin,
      player,
      multiGamesHistory,
      fish,
      language,
      status,
      questions,
      settings,
    ];
  }

  /// <i><small>`Domain Layer`</small></i><br>
  /// Creates an `User` from an `UiUser`.
  factory User.fromPresentation(UiUser uiUser) {
    return User(
      uid: uiUser.uId,
      isAdmin: uiUser.isAdmin,
      player: Player.fromPresentation(uiUser.player),
      multiGamesHistory: uiUser.multiGamesHistory
          .map((uiGameHistory) => GameHistory.fromPresentation(uiGameHistory))
          .toList(),
      fish: uiUser.fish,
      language: uiUser.language,
      status: uiUser.status,
      questions: uiUser.questions
          .map((uiQuestion) => AnsweredQuestions.fromPresentation(uiQuestion))
          .toList(),
      settings: GypseSettings.fromPresentation(uiUser.settings),
    );
  }

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `User` into an `UiUser`.
  UiUser toPresentation() {
    return UiUser(
      uid,
      isAdmin: isAdmin,
      player: player.toPresentation(),
      multiGamesHistory: List<UiGameHistory>.from(
          multiGamesHistory.map((g) => g.toPresentation())),
      fish: fish,
      language: language,
      status: status,
      questions: List<UiAnsweredQuestions>.from(
          questions.map((q) => q.toPresentation())),
      settings: settings.toPresentation(),
    );
  }
}
