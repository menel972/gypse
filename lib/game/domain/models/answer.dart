import 'package:equatable/equatable.dart';
import 'package:gypse/game/presentation/models/ui_answer.dart';

///<i><small>`Domain Layer`</small></i>
///## Answer's data <i><small>(received from the data layer)</small></i>
///
///```
///final bool isRightAnswer;
///final String answer;
///final String url;
///final String verse;
///final String verseReference;
///```
///
///The `Answer` is parsed to the `Presentation Layer` using the [Answer.toPresentation] method.
///<br><br>
///It contains all the data for an answer.
class Answer extends Equatable {
  final String qId;
  final bool isRightAnswer;
  final String answer;
  final String url;
  final String verse;
  final String verseReference;

  ///<i><small>`Domain Layer`</small></i>
  ///### Answer's data <i><small>(received from the data layer)</small></i>
  ///#### `Answer` constructor
  ///<br>
  ///It contains all the data for an answer.
  const Answer({
    required this.qId,
    required this.isRightAnswer,
    required this.answer,
    required this.url,
    required this.verse,
    required this.verseReference,
  });

  @override
  List<Object> get props {
    return [
      qId,
      isRightAnswer,
      answer,
      url,
      verse,
      verseReference,
    ];
  }

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `Answer` into an `UiAnswer`.
  UiAnswer toPresentation() {
    return UiAnswer(
      qId: qId,
      isRightAnswer: isRightAnswer,
      text: answer,
      url: url,
      verse: verse,
      verseReference: verseReference,
    );
  }
}
