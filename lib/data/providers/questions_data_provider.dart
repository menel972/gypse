import 'package:gypse/data/firebase/questions_firebase.dart';
import 'package:gypse/data/repositories/questions_repository_impl.dart';
import 'package:gypse/data/sqlite/questions_sqlite.dart';
import 'package:gypse/domain/repositories/questions_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsDataProvider {
  /// Provides an instance of [QuestionsFirebase]
  get questionsFirebaseProvider =>
      Provider.autoDispose<QuestionsFirebase>((ref) => QuestionsFirebase());
      
  /// Provides an instance of [QuestionsSqlite]
  get questionsSqliteProvider =>
      Provider.autoDispose<QuestionsSqlite>((ref) => QuestionsSqlite());


  /// Provides an instance of [QuestionsRepositoryImpl]
  get questionsRepositoryProvider => Provider.autoDispose<QuestionsRepository>(
      (ref) => QuestionsRepositoryImpl(
            ref.read(questionsFirebaseProvider),
            ref.read(questionsSqliteProvider),
          ));
}
