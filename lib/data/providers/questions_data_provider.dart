import 'package:gypse/data/firebase/questions_firebase.dart';
import 'package:gypse/data/repositories/questions_repository_impl.dart';
import 'package:gypse/domain/repositories/questions_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsDataProvider {
  get questionsFirebaseProvider =>
      Provider.autoDispose<QuestionsFirebase>((ref) => QuestionsFirebase());

  get questionsRepositoryProvider => Provider.autoDispose<QuestionsRepository>(
      (ref) => QuestionsRepositoryImpl(ref.read(questionsFirebaseProvider)));
}
