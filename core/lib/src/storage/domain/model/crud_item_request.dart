import 'package:core/src/storage/domain/model/collection_item_model.dart';

class CRUDItemRequest<T extends CollectionItemModel> {
  final String uid;
  final String collectionName;
  final CollectionItemModel<T> collectionItemModel;

  CRUDItemRequest({
    required this.uid,
    required this.collectionName,
    required this.collectionItemModel,
  });
}
