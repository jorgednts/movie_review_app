import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class CheckItemInCollectionUseCase
    implements BaseUseCase<CheckItemRequest, bool> {
  final CoreStorageRepository _coreStorageRepository;

  CheckItemInCollectionUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  AsyncResult<bool> call(CheckItemRequest input) async {
    return await _coreStorageRepository.checkItemInCollection(request: input);
  }
}
