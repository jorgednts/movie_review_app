import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class GetCollectionFromStorageUseCase<T extends AppCollectionItemModel>
    implements BaseUseCase<GetCollectionRequest<T>, List<T>> {
  final CoreStorageRepository _coreStorageRepository;

  GetCollectionFromStorageUseCase({
    required CoreStorageRepository coreStorageRepository,
  }) : _coreStorageRepository = coreStorageRepository;

  @override
  AsyncResult<List<T>> call(GetCollectionRequest<T> input) async {
    return await _coreStorageRepository.getCollectionFromStorage(
      request: input,
    );
  }
}
