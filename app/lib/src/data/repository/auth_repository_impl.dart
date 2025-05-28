import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:core/core.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
    : _authService = authService;

  @override
  Future<Result<bool>> createUser({required UserRequest request}) async {
    return await _authService.createUser(request: request);
  }

  @override
  Future<Result<UserModel>> signInWithEmail({
    required UserRequest request,
  }) async {
    return await _authService.signInWithEmail(request: request);
  }

  @override
  Future<Result<UserModel?>> checkLoggedUser() async {
    return await _authService.checkLoggedUser();
  }

  @override
  Future<Result<void>> signOut() async {
    return await _authService.signOut();
  }
}
