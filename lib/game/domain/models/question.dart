import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';

///<i><small>`Domain Layer`</small></i>
///## Question's data <i><small>(received from the data layer)</small></i>
///
///```
///final String uId;
///final String question;
///final String book;
///```
///
///The `Question` is parsed to the `Presentation Layer` using the [Question.toPresentation] method.
///<br><br>
///It contains all the data for a question.
class Question extends Equatable {
  final String uId;
  final String question;
  final String book;

  ///<i><small>`Domain Layer`</small></i>
  ///### Question's data <i><small>(received from the data layer)</small></i>
  ///#### `Question` constructor
  ///<br>
  ///It contains all the data for a question.
  const Question({
    required this.uId,
    required this.question,
    required this.book,
  });

  @override
  List<Object> get props => [uId, question, book];

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts a `Question` into an `UiQuestion` according to the language of the user.
  UiQuestion toPresentation(Locales locale) {
    switch (locale) {
      case Locales.fr:
        return UiQuestion(
          uId,
          text: question,
          book: Books.values.firstWhere((b) => b.fr == book),
        );
      case Locales.en:
        return UiQuestion(
          uId,
          text: question,
          book: Books.values.firstWhere((b) => b.en == book),
        );
      default:
        return UiQuestion(
          uId,
          text: question,
          book: Books.values.firstWhere((b) => b.es == book),
        );
    }
  }
}
