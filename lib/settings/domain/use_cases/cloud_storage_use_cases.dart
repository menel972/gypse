import 'package:flutter/material.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/settings/data/repositories/cloud_storage_repository_impl.dart';
import 'package:gypse/settings/domain/repositories/cloud_storage_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FetchLegalsUseCase {
  final CloudStorageRepository _repository;

  FetchLegalsUseCase(this._repository);

  Future<void> invoke(BuildContext context, String path) async {
    await _repository
        .fetchLegals(context, path)
        .onError((Exception error, _) => error.failure(context));
  }
}

AutoDisposeProvider<FetchLegalsUseCase> get fetchLegalsUseCaseProvider =>
    Provider.autoDispose<FetchLegalsUseCase>(
        (AutoDisposeProviderRef<FetchLegalsUseCase> ref) =>
            FetchLegalsUseCase(ref.read(cloudStorageRepositoryProvider)));
