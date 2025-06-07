import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:core/core.dart';

class SignInUseCase implements BaseUseCase<UserRequest, UserModel> {
  final AuthRepository _authRepository;

  SignInUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  AsyncResult<UserModel> call(UserRequest input) async {
    return await _authRepository.signInWithEmail(request: input);
  }
}
