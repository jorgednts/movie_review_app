import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:core/core.dart';

class DetailsParams {
  final String itemId;
  final AppCollectionItemType itemType;
  final String language;
  final String? uid;
  final String itemStorageId;

  DetailsParams({
    required this.itemId,
    required this.itemType,
    required this.language,
    required this.uid,
    required this.itemStorageId,
  });

  factory DetailsParams.fromJson(Map<String, dynamic> json) {
    return DetailsParams(
      itemId: json['itemId'],
      itemType: AppCollectionItemType.fromStorage(json['itemType']),
      language: json['language'],
      uid: json['uid'],
      itemStorageId: json['itemStorageId'],
    );
  }

  Map<String, String> toJson() {
    return {
      'itemId': itemId,
      'itemType': itemType.name,
      'language': language,
      'uid': uid ?? '',
      'itemStorageId': itemStorageId,
    };
  }

  CheckItemRequest toCheckItemRequest(String collectionName) {
    return CheckItemRequest(
      uid: uid!,
      collectionName: collectionName,
      itemId: itemStorageId,
    );
  }
}
