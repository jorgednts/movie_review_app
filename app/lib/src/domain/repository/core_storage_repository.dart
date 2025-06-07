import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:core/core.dart';

abstract class CoreStorageRepository {
  AsyncResult<void> createUserStorage({
    required CreateUserStorageRequest request,
  });

  AsyncResult<String> getUsername({required String uid});

  AsyncResult<void> addItemToCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  AsyncResult<void> deleteItemInCollection<
    T extends AppCollectionItemModel
  >({required CRUDItemRequest<T> request});

  AsyncResult<void> updateItemInCollection<
    T extends AppCollectionItemModel
  >({required CRUDItemRequest<T> request});

  AsyncResult<List<T>> getCollectionFromStorage<
    T extends AppCollectionItemModel
  >({required GetCollectionRequest<T> request});
}
