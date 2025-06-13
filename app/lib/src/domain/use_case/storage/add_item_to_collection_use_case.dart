import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class AddItemToCollectionUseCase<T extends AppCollectionItemModel>
    implements BaseUseCase<CRUDItemRequest<T>, bool> {
  final CoreStorageRepository _coreStorageRepository;

  AddItemToCollectionUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  AsyncResult<bool> call(CRUDItemRequest<T> input) {
    return _coreStorageRepository.addItemToCollection(request: input);
  }
}
