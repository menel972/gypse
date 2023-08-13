import 'package:flutter/material.dart';
import 'package:gypse/settings/data/web_services/ws_cloud_storage_service.dart';
import 'package:gypse/settings/domain/repositories/cloud_storage_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CloudStorageRepositoryImpl extends CloudStorageRepository {
  final WsCloudStorageService _cloudStorageService;

  CloudStorageRepositoryImpl(this._cloudStorageService);

  @override
  Future<void> fetchLegals(BuildContext context, String path) async {
    await _cloudStorageService.fetchLegals(context, path);
  }
}

AutoDisposeProvider<CloudStorageRepository>
    get cloudStorageRepositoryProvider =>
        Provider.autoDispose<CloudStorageRepository>(
            (AutoDisposeProviderRef<CloudStorageRepository> ref) =>
                CloudStorageRepositoryImpl(
                    ref.read(wsCloudStorageServiceProvider)));
