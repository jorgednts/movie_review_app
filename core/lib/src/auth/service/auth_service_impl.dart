import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/result.dart';
import '../auth.dart';

class AuthServiceImpl extends AuthService {
  final FirebaseAuth _auth;

  AuthServiceImpl() : _auth = FirebaseAuth.instance;

  @override
  Future<Result<UserModel>> signInWithEmail({
    required UserRequest request,
  }) async {
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
  Future<Result<bool>> createUser({required UserRequest request}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      if (result.user == null) {
        return Result.error(NullUserException());
      }

      return Result.ok(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(CustomFirebaseAuthException.fromCode(e.code));
    } catch (e) {
      return Result.error(AuthGenericException(cause: e.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      return Result.ok(null);
    } catch (e) {
      return Result.error(LogoutException(cause: e.toString()));
    }
  }

  @override
  Future<Result<UserModel?>> checkLoggedUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Result.ok(null);
      }
      return Result.ok(UserModel.fromUser(user));
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
