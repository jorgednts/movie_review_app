import 'package:core/core.dart';

abstract class AuthService {
  AsyncResult<UserModel> createUser({required UserRequest request});

  AsyncResult<UserModel> signInWithEmail({required UserRequest request});

  AsyncResult<void> signOut();

  AsyncResult<UserModel?> checkLoggedUser();

  Stream<UserModel?> get userChanges;
}
