import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:core/core.dart';

class CheckUserLoggedUseCase implements BaseUseCase<NoParam, UserModel?> {
  final AuthRepository _authRepository;

  CheckUserLoggedUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  AsyncResult<UserModel?> call(NoParam input) async {
    return await _authRepository.checkLoggedUser();
  }
}
