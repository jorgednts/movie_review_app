import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:core/core.dart';

class CreateUserUseCase implements BaseUseCase<UserRequest, bool> {
  final AuthRepository _authRepository;

  CreateUserUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Result<bool>> call(UserRequest input) async {
    return await _authRepository.createUser(request: input);
  }
}
