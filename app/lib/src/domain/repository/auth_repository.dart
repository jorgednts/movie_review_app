import 'package:core/core.dart';

abstract class AuthRepository {
  Future<Result<UserModel>> createUser({required UserRequest request});

  Future<Result<UserModel>> signInWithEmail({required UserRequest request});

  Future<Result<UserModel?>> checkLoggedUser();

  Future<Result<void>> signOut();
}
