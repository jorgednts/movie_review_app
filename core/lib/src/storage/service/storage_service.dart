import 'package:core/core.dart';

abstract class StorageService {
  AsyncResult<void> createUserStorage({
    required CreateUserStorageRequest request,
  });

  AsyncResult<String> getUsername({required String uid});

  AsyncResult<bool> addItemToCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<bool> deleteItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<void> updateItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<List<T>> getCollection<T extends CollectionItemModel>({
    required GetCollectionRequest<T> request,
  });

  AsyncResult<bool> checkItemInCollection<T extends CollectionItemModel>({
    required CheckItemRequest request,
  });
}
