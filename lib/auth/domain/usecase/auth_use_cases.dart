import 'package:gypse/auth/data/repositories/auth_repository_impl.dart';
import 'package:gypse/auth/domain/models/auth_request.dart';
import 'package:gypse/auth/domain/repositories/auth_repository.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<String> invoke(UiAuthRequest request) async {
    'start'.log(tag: 'SignUpUseCase');
    return _repository.signUp(AuthRequest.fromPresentation(request));
  }
}

AutoDisposeProvider<SignUpUseCase> get signUpUseCaseProvider =>
    Provider.autoDispose<SignUpUseCase>(
        (AutoDisposeProviderRef<SignUpUseCase> ref) =>
            SignUpUseCase(ref.read(authRepositoryProvider)));

class GetUserUidUseCase {
  final AuthRepository _repository;

  GetUserUidUseCase(this._repository);

  String invoke() {
    'start'.log(tag: 'GetUserUidUseCase');
    String result = _repository.getUserUid;
    result.log(tag: 'GetUserUidUseCase');
    return result;
  }
}

AutoDisposeProvider<GetUserUidUseCase> get getUserUidUseCaseProvider =>
    Provider.autoDispose<GetUserUidUseCase>(
        (AutoDisposeProviderRef<GetUserUidUseCase> ref) =>
            GetUserUidUseCase(ref.read(authRepositoryProvider)));
