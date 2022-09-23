import 'package:gypse/data/providers/users_data_provider.dart';
import 'package:gypse/domain/usecases/users_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersDomainProvider {
  final UsersDataProvider _dataProvider = UsersDataProvider();

  /// Provides an instance of [CreateUserUsecase]
  get createUserUsecaseProvider =>
      Provider.autoDispose<CreateUserUsecase>((ref) =>
          CreateUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));

  /// Provides an instance of [FetchUserUsecase]
  get fetchUserUsecaseProvider =>
      Provider.autoDispose<FetchUserUsecase>((ref) =>
          FetchUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));

  /// Provides an instance of [UpdateUserUsecase]
  get updateUserUsecaseProvider =>
      Provider.autoDispose<UpdateUserUsecase>((ref) =>
          UpdateUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));

  /// Provides an instance of [DeleteUserUsecase]
  get deleteUserUsecaseProvider =>
      Provider.autoDispose<DeleteUserUsecase>((ref) =>
          DeleteUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));
}
