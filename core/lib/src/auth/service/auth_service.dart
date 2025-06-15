import 'package:core/core.dart';

abstract class AuthService {
  AsyncResult<UserModel> createUser({required UserRequest request});

  AsyncResult<UserModel> signInWithEmail({required UserRequest request});

  AsyncResult<void> signOut();

  AsyncResult<UserModel?> checkLoggedUser();

  AsyncResult<void> deleteUser();

  Stream<UserModel?> get userChanges;
}
