import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:core/src/storage/constants/storage_constants.dart';

class StorageServiceImpl implements StorageService {
  final FirebaseFirestore _storage;

  StorageServiceImpl() : _storage = FirebaseFirestore.instance;

  CollectionReference get _userCollection =>
      _storage.collection(StorageConstants.usersCollection);

  CollectionReference _getCollectionFromUser(
    String uid,
    String collectionPath,
  ) {
    try {
      return _userCollection.doc(uid).collection(collectionPath);
    } catch (e) {
      throw UserNotFoundException();
    }
  }

  @override
  Future<Result<void>> createUserStorage({
    required CreateUserStorageRequest request,
  }) async {
    try {
      await _userCollection.doc(request.user.uid).set(request.toJson());
      return Result.ok(null);
    } catch (e) {
      return Result.error(
        FirebaseException(
          plugin: StorageConstants.plugin,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<void>> addItemToCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  }) async {
    try {
      final collectionRef = _getCollectionFromUser(
        request.uid,
        request.collectionName,
      );

      await collectionRef
          .doc(request.collectionItemModel.id)
          .set(request.collectionItemModel.toStorage());
      return Result.ok(null);
    } catch (e) {
      return Result.error(
        FirebaseException(
          plugin: StorageConstants.plugin,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<void>> deleteItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  }) async {
    try {
      final collectionRef = _getCollectionFromUser(
        request.uid,
        request.collectionName,
      );

      await collectionRef.doc(request.collectionItemModel.id).delete();
      return Result.ok(null);
    } catch (e) {
      return Result.error(
        FirebaseException(
          plugin: StorageConstants.plugin,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<void>> updateItemInCollection<T extends CollectionItemModel>({
    required CRUDItemRequest<T> request,
  }) async {
    try {
      final collectionRef = _getCollectionFromUser(
        request.uid,
        request.collectionName,
      );

      await collectionRef
          .doc(request.collectionItemModel.id)
          .update(request.collectionItemModel.toStorage());
      return Result.ok(null);
    } catch (e) {
      return Result.error(
        FirebaseException(
          plugin: StorageConstants.plugin,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<List<T>>> getCollection<T extends CollectionItemModel>({
    required GetCollectionRequest<T> request,
  }) async {
    try {
      final collectionRef = _getCollectionFromUser(
        request.uid,
        request.collectionName,
      );

      final snapshot = await collectionRef.get();

      final items =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return request.fromJsonT(data as Map<String, dynamic>);
          }).toList();

      return Result.ok(items);
    } catch (e) {
      return Result.error(
        FirebaseException(plugin: 'storage', message: e.toString()),
      );
    }
  }
}
