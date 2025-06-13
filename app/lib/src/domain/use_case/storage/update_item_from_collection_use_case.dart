import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class UpdateItemFromCollectionUseCase<T extends AppCollectionItemModel>
    implements BaseUseCase<CRUDItemRequest<T>, void> {
  final CoreStorageRepository _coreStorageRepository;

  UpdateItemFromCollectionUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  AsyncResult<void> call(CRUDItemRequest<T> input) {
    return _coreStorageRepository.updateItemInCollection(request: input);
  }
}
