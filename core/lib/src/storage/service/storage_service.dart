import 'package:core/core.dart';

abstract class StorageService {
  AsyncResult<void> createUserStorage({
    required CreateUserStorageRequest request,
  });

  AsyncResult<String> getUsername({required String uid});

  AsyncResult<void> addItemToCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<void> deleteItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<void> updateItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<List<T>> getCollection<T extends CollectionItemModel>({
    required GetCollectionRequest<T> request,
  });
}
