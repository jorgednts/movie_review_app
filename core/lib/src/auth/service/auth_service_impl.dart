import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceImpl extends AuthService {
  final FirebaseAuth _auth;

  AuthServiceImpl() : _auth = FirebaseAuth.instance;

  @override
  AsyncResult<UserModel> signInWithEmail({required UserRequest request}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      if (result.user == null) {
        return Result.error(NullUserException());
      }
      return Result.ok(UserModel.fromUser(result.user!));
    } on FirebaseAuthException catch (e) {
      return Result.error(CustomFirebaseAuthException.fromCode(e.code));
    } catch (e) {
      return Result.error(AuthGenericException(cause: e.toString()));
    }
  }

  @override
  AsyncResult<UserModel> createUser({required UserRequest request}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      if (result.user == null) {
        return Result.error(NullUserException());
      }

      return Result.ok(UserModel.fromUser(result.user!));
    } on FirebaseAuthException catch (e) {
      return Result.error(CustomFirebaseAuthException.fromCode(e.code));
    } catch (e) {
      return Result.error(AuthGenericException(cause: e.toString()));
    }
  }

  @override
  AsyncResult<void> signOut() async {
    try {
      await _auth.signOut();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(LogoutException(cause: e.toString()));
    }
  }

  @override
  AsyncResult<UserModel?> checkLoggedUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return const Result.ok(null);
      }
      return Result.ok(UserModel.fromUser(user));
    } catch (e) {
      return Result.error(AuthGenericException(cause: e.toString()));
    }
  }

  @override
  AsyncResult<void> deleteUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Result.error(NullUserException());
      }
      await user.delete();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(AuthGenericException(cause: e.toString()));
    }
  }

  @override
  Stream<UserModel?> get userChanges {
    return _auth.userChanges().map((user) {
      if (user == null) return null;
      return UserModel(uid: user.uid, email: user.email ?? '');
    });
  }
}
