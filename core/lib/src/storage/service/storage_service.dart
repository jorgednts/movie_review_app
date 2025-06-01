import 'package:core/core.dart';

abstract class StorageService {
  Future<Result<void>> createUserStorage({
    required CreateUserStorageRequest request,
  });

  Future<Result<String>> getUsername({required String uid});

  Future<Result<void>> addItemToCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  Future<Result<void>> deleteItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  Future<Result<void>> updateItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  });

  Future<Result<List<T>>> getCollection<T extends CollectionItemModel>({
    required GetCollectionRequest<T> request,
  });
}
