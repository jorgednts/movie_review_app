import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:core/core.dart';

class StreamUserChangesUseCase {
  final AuthRepository _authRepository;

  StreamUserChangesUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Stream<UserModel?> get userChanges => _authRepository.userChanges;
}
