import 'package:flutter/material.dart';

abstract class CloudStorageRepository {
  Future<void> fetchLegals(BuildContext context, String path);
}
