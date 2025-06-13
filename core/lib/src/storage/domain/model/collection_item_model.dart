abstract class CollectionItemModel<T> {
  final String id;

  CollectionItemModel({required this.id});

  Map<String, dynamic> toStorage();
}
