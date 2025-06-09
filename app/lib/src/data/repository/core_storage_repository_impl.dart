import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:core/core.dart';

class CoreStorageRepositoryImpl implements CoreStorageRepository {
  final StorageService _storageService;

  CoreStorageRepositoryImpl({required StorageService storageService})
    : _storageService = storageService;

  @override
  AsyncResult<void> createUserStorage({
    required CreateUserStorageRequest request,
  }) async {
    return await _storageService.createUserStorage(request: request);
  }

  @override
  AsyncResult<bool> addItemToCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  }) async {
    return await _storageService.addItemToCollection<T>(request: request);
  }

  @override
  AsyncResult<bool> deleteItemInCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  }) async {
    return await _storageService.deleteItemInCollection<T>(request: request);
  }

  @override
  AsyncResult<List<T>> getCollectionFromStorage<
    T extends AppCollectionItemModel
  >({required GetCollectionRequest<T> request}) async {
    return await _storageService.getCollection<T>(request: request);
  }

  @override
  AsyncResult<void> updateItemInCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  }) async {
    return await _storageService.updateItemInCollection<T>(request: request);
  }

  @override
  AsyncResult<String> getUsername({required String uid}) async {
    return await _storageService.getUsername(uid: uid);
  }

  @override
  AsyncResult<bool> checkItemInCollection<T extends CollectionItemModel>({
    required CheckItemRequest request,
  }) async {
    return await _storageService.checkItemInCollection<T>(request: request);
  }
}
