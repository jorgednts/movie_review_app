import 'package:app/src/domain/model/collection_item_model.dart';

class BaseDetailsRequestParameters {
  final String uid;
  final String language;
  final AppCollectionItemType type;

  BaseDetailsRequestParameters({
    required this.uid,
    required this.language,
    required this.type,
  });

  Map<String, dynamic>? toJson() {
    return {'language': language};
  }
}
