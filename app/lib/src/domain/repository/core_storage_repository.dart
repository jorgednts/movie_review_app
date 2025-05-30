import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:core/core.dart';

abstract class CoreStorageRepository {
  Future<Result<void>> createUserStorage({
    required CreateUserStorageRequest request,
  });

  Future<Result<void>> addItemToCollection<T extends AppCollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  Future<Result<void>> deleteItemInCollection<
    T extends AppCollectionItemModel
  >({required CRUDItemRequest<T> request});

  Future<Result<void>> updateItemInCollection<
    T extends AppCollectionItemModel
  >({required CRUDItemRequest<T> request});

  Future<Result<List<T>>> getCollectionFromStorage<
    T extends AppCollectionItemModel
  >({required GetCollectionRequest<T> request});
}
