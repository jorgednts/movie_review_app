import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:core/core.dart';

class SignOutUseCase implements BaseUseCase<NoParam, void> {
  final AuthRepository _authRepository;

  SignOutUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  AsyncResult<void> call(NoParam input) async {
    return await _authRepository.signOut();
  }
}
