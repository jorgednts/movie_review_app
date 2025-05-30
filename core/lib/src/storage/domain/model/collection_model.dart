import 'package:core/src/storage/domain/model/collection_item_model.dart';

abstract class CollectionModel<T extends CollectionItemModel> {
  final String collectionName;
  final List<T> items;

  CollectionModel({required this.collectionName, required this.items});

  Map<String, dynamic> toStorage() {
    return {
      'name': collectionName,
      'items': items.map((item) => item.toStorage()).toList(),
    };
  }
}
