import 'package:gypse/data/providers/users_data_provider.dart';
import 'package:gypse/domain/usecases/users_usecases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersDomainProvider {
  final UsersDataProvider _dataProvider = UsersDataProvider();

  get createUserUsecaseProvider =>
      Provider.autoDispose<CreateUserUsecase>((ref) =>
          CreateUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));

  get fetchUserUsecaseProvider =>
      Provider.autoDispose<FetchUserUsecase>((ref) =>
          FetchUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));

  get updateUserUsecaseProvider =>
      Provider.autoDispose<UpdateUserUsecase>((ref) =>
          UpdateUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));

  get deleteUserUsecaseProvider =>
      Provider.autoDispose<DeleteUserUsecase>((ref) =>
          DeleteUserUsecase(ref.read(_dataProvider.usersRepositoryProvider)));
}
