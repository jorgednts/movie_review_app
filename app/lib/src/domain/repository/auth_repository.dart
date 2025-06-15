import 'package:core/core.dart';

abstract class AuthRepository {
  AsyncResult<UserModel> createUser({required UserRequest request});

  AsyncResult<UserModel> signInWithEmail({required UserRequest request});

  AsyncResult<UserModel?> checkLoggedUser();

  AsyncResult<void> signOut();

  Stream<UserModel?> get userChanges;
}
