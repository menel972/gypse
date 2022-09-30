import 'package:gypse/domain/usecases/account_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountDomainProvider {
  /// Provides an instance of [GetLabelsUsecase]
  get getLabelsUsecaseProvider =>
      Provider.autoDispose<GetLabelsUsecase>(((ref) => GetLabelsUsecase()));

  /// Provides an instance of [GetViewsUsecase]
  get getViewsUsecaseProvider =>
      Provider.autoDispose<GetViewsUsecase>(((ref) => GetViewsUsecase()));
}
