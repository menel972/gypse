import 'package:equatable/equatable.dart';

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
  /// Converts a `Question` into an object.
  Map<String, dynamic> toPresentation() {
    // TODO : Implements Method
    throw UnimplementedError();
  }
}
