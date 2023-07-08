import 'package:flutter/material.dart';
import 'package:gypse/auth/data/repositories/user_repository_impl.dart';
import 'package:gypse/auth/domain/models/user.dart';
import 'package:gypse/auth/domain/repositories/user_repository.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnNewUserUseCase {
  final UserRepository _repository;

  OnNewUserUseCase(this._repository);

  Future<void> invoke(UiUser user) async {
    'start'.log(tag: 'OnNewUserUseCase');
    return await _repository.onNewUser(User.fromPresentation(user));
  }
}

AutoDisposeProvider<OnNewUserUseCase> get onNewUserUseCaseProvider =>
    Provider.autoDispose<OnNewUserUseCase>(
        (AutoDisposeProviderRef<OnNewUserUseCase> ref) =>
            OnNewUserUseCase(ref.read(userRepositoryProvider)));

class GetCurrentUserUseCase {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UiUser> invoke(String id) async {
    'start'.log(tag: 'GetCurrentUserUseCase');
    return await _repository
        .getCurrentUser(id)
        .then((user) => user.toPresentation());
  }
}

AutoDisposeProvider<GetCurrentUserUseCase> get getCurrentUserUseCaseProvider =>
    Provider.autoDispose<GetCurrentUserUseCase>(
        (AutoDisposeProviderRef<GetCurrentUserUseCase> ref) =>
            GetCurrentUserUseCase(ref.read(userRepositoryProvider)));

class OnUserChangedUseCase {
  final UserRepository _repository;

  OnUserChangedUseCase(this._repository);

  Future<void> invoke(BuildContext context, UiUser user) async {
    'start'.log(tag: 'OnUserChangedUseCase');
    await _repository.onUserChanged(context, User.fromPresentation(user));
  }
}

AutoDisposeProvider<OnUserChangedUseCase> get onUserChangedUseCaseProvider =>
    Provider.autoDispose<OnUserChangedUseCase>(
        (AutoDisposeProviderRef<OnUserChangedUseCase> ref) =>
            OnUserChangedUseCase(ref.read(userRepositoryProvider)));

class OnDeleteUserUseCase {
  final UserRepository _repository;

  OnDeleteUserUseCase(this._repository);

  Future<void> invoke(BuildContext context, String id) async {
    'start'.log(tag: 'OnDeleteUserUseCase');
    await _repository.onDeleteUser(context, id);
  }
}

AutoDisposeProvider<OnDeleteUserUseCase> get onDeleteUserUseCaseProvider =>
    Provider.autoDispose<OnDeleteUserUseCase>(
        (AutoDisposeProviderRef<OnDeleteUserUseCase> ref) =>
            OnDeleteUserUseCase(ref.read(userRepositoryProvider)));
