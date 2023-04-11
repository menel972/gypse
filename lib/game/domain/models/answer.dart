import 'package:equatable/equatable.dart';

///<i><small>`Domain Layer`</small></i>
///## Answer's data <i><small>(received from the data layer)</small></i>
///
///```
///final String id;
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
  final String uId;
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
    required this.uId,
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
      uId,
      qId,
      isRightAnswer,
      answer,
      url,
      verse,
      verseReference,
    ];
  }

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts an `Answer` into an object.
  toPresentation() {
    // TODO : Implements Method
    throw UnimplementedError();
  }
}
