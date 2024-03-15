import 'package:equatable/equatable.dart';
import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:gypse/common/utils/enums/locales_enum.dart';
import 'package:gypse/game/domain/models/answer.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';

///<i><small>`Domain Layer`</small></i>
///## Question's data <i><small>(received from the data layer)</small></i>
///
///```
///final String uId;
///final String question;
///final String book;
///final List<Answer> answers;
///```
///
///The `Question` is parsed to the `Presentation Layer` using the [Question.toPresentation] method.
///<br><br>
///It contains all the data for a question.
class Question extends Equatable {
  final String uId;
  final String question;
  final String book;
  final List<Answer> answers;

  ///<i><small>`Domain Layer`</small></i>
  ///### Question's data <i><small>(received from the data layer)</small></i>
  ///#### `Question` constructor
  ///<br>
  ///It contains all the data for a question.
  const Question({
    required this.uId,
    required this.question,
    required this.book,
    required this.answers,
  });

  @override
  List<Object> get props => [uId, question, book];

  /// <i><small>`Domain Layer`</small></i><br>
  /// Converts a `Question` into an `UiQuestion` according to the language of the user.
  UiQuestion toPresentation({Locales locale = Locales.fr}) {
    switch (locale) {
      case Locales.fr:
        return UiQuestion(
          uId,
          text: question,
          book: Books.values.firstWhere((b) => b.fr == book),
          answers: [...answers.map((answer) => answer.toPresentation())],
        );
      case Locales.en:
        return UiQuestion(
          uId,
          text: question,
          book: Books.values.firstWhere((b) => b.en == book),
          answers: [...answers.map((answer) => answer.toPresentation())],
        );
      default:
        return UiQuestion(
          uId,
          text: question,
          book: Books.values.firstWhere((b) => b.es == book),
          answers: [...answers.map((answer) => answer.toPresentation())],
        );
    }
  }
}
