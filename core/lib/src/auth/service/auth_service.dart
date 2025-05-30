import 'package:core/core.dart';

abstract class AuthService {
  Future<Result<UserModel>> createUser({required UserRequest request});

  Future<Result<UserModel>> signInWithEmail({required UserRequest request});

  Future<Result<void>> signOut();

  Future<Result<UserModel?>> checkLoggedUser();

  Stream<UserModel?> get userChanges;
}
