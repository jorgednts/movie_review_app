import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:core/core.dart';

enum AppCollectionType { review, watchlist }

final class ReviewModel extends AppCollectionModel {
  ReviewModel.review({required super.items}) : super.review();
}

final class WatchlistModel extends AppCollectionModel {
  WatchlistModel.watchlist({required super.items}) : super.watchlist();
}

class AppCollectionModel implements CollectionModel<AppCollectionItemModel> {
  @override
  final List<AppCollectionItemModel> items;
  final AppCollectionType collectionType;

  AppCollectionModel.review({required this.items})
    : collectionType = AppCollectionType.review;

  AppCollectionModel.watchlist({required this.items})
    : collectionType = AppCollectionType.watchlist;

  @override
  String get collectionName => collectionType.name;

  @override
  Map<String, dynamic> toStorage() {
    return {'items': items.map((e) => e.toStorage()).toList()};
  }
}
