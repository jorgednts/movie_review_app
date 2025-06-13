import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:core/core.dart';

abstract class CoreStorageRepository {
  AsyncResult<void> createUserStorage({
    required CreateUserStorageRequest request,
  });

  AsyncResult<String> getUsername({required String uid});

  AsyncResult<bool> addItemToCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<bool> deleteItemInCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<void> updateItemInCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<List<T>> getCollectionFromStorage<
    T extends AppCollectionItemModel
  >({required GetCollectionRequest<T> request});

  AsyncResult<bool> checkItemInCollection<T extends CollectionItemModel>({
    required CheckItemRequest request,
  });
}
