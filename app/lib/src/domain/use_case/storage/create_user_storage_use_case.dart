import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class CreateUserStorageUseCase
    implements BaseUseCase<CreateUserStorageRequest, void> {
  final CoreStorageRepository _coreStorageRepository;

  CreateUserStorageUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  AsyncResult<void> call(CreateUserStorageRequest input) async {
    return await _coreStorageRepository.createUserStorage(request: input);
  }
}
