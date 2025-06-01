import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class GetUsernameUseCase implements BaseUseCase<String, String> {
  final CoreStorageRepository _coreStorageRepository;

  GetUsernameUseCase({required CoreStorageRepository coreStorageRepository})
    : _coreStorageRepository = coreStorageRepository;

  @override
  Future<Result<String>> call(String input) async {
    return await _coreStorageRepository.getUsername(uid: input);
  }
}
