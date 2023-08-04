import 'package:equatable/equatable.dart';

///<i><small>`Presentation Layer`</small></i>
///## Displayed answer <i><small>(received from the domain layer)</small></i>
///
///```
///final String qId;
///final bool isRightAnswer;
///final String text;
///final String url;
///final String verse;
///final String verseReference;
///```
///
///It contains all the data for an answer to be displayed on the screen.
class UiAnswer extends Equatable {
  final String qId;
  final bool isRightAnswer;
  final String text;
  final String url;
  final String verse;
  final String verseReference;

  ///<i><small>`Presentation Layer`</small></i>
  ///### Displayed answer <i><small>(received from the domain layer)</small></i>
  ///#### `UiAnswer` constructor
  ///<br>
  ///It contains all the data for an answer to be displayed on the screen.
  UiAnswer({
    required this.qId,
    required this.isRightAnswer,
    required this.text,
    required this.url,
    required this.verse,
    required this.verseReference,
  });

  @override
  List<Object> get props =>
      [qId, isRightAnswer, text, url, verse, verseReference];
}
