import 'package:gypse/data/firebase/answers_firebase.dart';
import 'package:gypse/data/repositories/answers_repository_impl.dart';
import 'package:gypse/domain/repositories/answers_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswersDataProvider {
  get answersFirebaseProvider =>
      Provider.autoDispose<AnswersFirebase>((ref) => AnswersFirebase());

  get answersRepositoryProvider => Provider.autoDispose<AnswersRepository>(
      (ref) => AnswersRepositoryImpl(ref.read(answersFirebaseProvider)));
}
