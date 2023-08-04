import 'package:equatable/equatable.dart';

import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';

///<i><small>`Presentation Layer`</small></i>
///## Displayed question <i><small>(received from the domain layer)</small></i>
///
///```
///final String uId;
///final String question;
///final Books book;
///final List<UiAnswer> answers;
///```
///
///It contains all the data for a question to be displayed on the screen.
class UiQuestion extends Equatable {
  final String uId;
  final String text;
  final Books book;
  final List<UiAnswer> answers;

  ///<i><small>`Presentation Layer`</small></i>
  ///### Displayed question <i><small>(received from the domain layer)</small></i>
  ///#### `UiQuestion` constructor
  ///<br>
  ///It contains all the data for a question to be displayed on the screen.
  const UiQuestion(
    this.uId, {
    this.text = '',
    this.book = Books.gen,
    this.answers = const [],
  });

  @override
  List<Object> get props => [uId, text, book, answers];
}
