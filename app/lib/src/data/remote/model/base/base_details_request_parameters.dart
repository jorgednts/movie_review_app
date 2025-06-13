import 'package:app/src/data/remote/model/base/base_request_parameters.dart';
import 'package:app/src/domain/model/app_collection_item_model.dart';

class BaseDetailsRequestParameters implements BaseRequestParameters {
  final String id;
  final String language;
  final AppCollectionItemType type;

  BaseDetailsRequestParameters({
    required this.id,
    required this.language,
    required this.type,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'language': language};
  }
}
