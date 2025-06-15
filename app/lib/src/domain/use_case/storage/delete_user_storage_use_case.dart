import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class DeleteUserStorageUseCase implements BaseUseCase<String, void> {
  final CoreStorageRepository _coreStorageRepository;

  DeleteUserStorageUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  AsyncResult<void> call(String input) async {
    return await _coreStorageRepository.deleteUserStorage(input);
  }
}
