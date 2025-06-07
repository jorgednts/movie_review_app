import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class DeleteItemFromCollectionUseCase<T extends AppCollectionItemModel>
    implements BaseUseCase<CRUDItemRequest<T>, void> {
  final CoreStorageRepository _coreStorageRepository;

  DeleteItemFromCollectionUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  AsyncResult<void> call(CRUDItemRequest<T> input) {
    return _coreStorageRepository.deleteItemInCollection(request: input);
  }
}
