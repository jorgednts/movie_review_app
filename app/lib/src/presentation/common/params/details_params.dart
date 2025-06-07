import 'package:app/src/domain/model/collection_item_model.dart';

class DetailsParams {
  final String itemId;
  final AppCollectionItemType itemType;
  final String language;

  DetailsParams({
    required this.itemId,
    required this.itemType,
    required this.language,
  });

  factory DetailsParams.fromJson(Map<String, dynamic> json) {
    return DetailsParams(
      itemId: json['itemId'],
      itemType: AppCollectionItemType.fromStorage(json['itemType']),
      language: json['language'],
    );
  }

  Map<String, String> toJson() {
    return {'itemId': itemId, 'itemType': itemType.name, 'language': language};
  }
}
