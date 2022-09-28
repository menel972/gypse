import 'package:gypse/data/firebase/answers_firebase.dart';
import 'package:gypse/data/repositories/answers_repository_impl.dart';
import 'package:gypse/data/sqlite/answers_sqlite.dart';
import 'package:gypse/domain/repositories/answers_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersDataProvider {
  /// Provides an instance of [AnswersFirebase]
  get answersFirebaseProvider =>
      Provider.autoDispose<AnswersFirebase>((ref) => AnswersFirebase());
      
  /// Provides an instance of [AnswersSqlite]
  get answersSqliteProvider =>
      Provider.autoDispose<AnswersSqlite>((ref) => AnswersSqlite());


  /// Provides an instance of [AnswersRepositoryImpl]
  get answersRepositoryProvider => Provider.autoDispose<AnswersRepository>(
      (ref) => AnswersRepositoryImpl(
            ref.read(answersSqliteProvider),
            ref.read(answersFirebaseProvider),
          ));
}
