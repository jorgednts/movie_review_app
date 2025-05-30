import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class AddItemToCollectionUseCase<T extends AppCollectionItemModel>
    implements BaseUseCase<CRUDItemRequest<T>, void> {
  final CoreStorageRepository _coreStorageRepository;

  AddItemToCollectionUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  Future<Result<void>> call(CRUDItemRequest<T> input) {
    return _coreStorageRepository.addItemToCollection(request: input);
  }
}
