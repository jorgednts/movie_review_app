abstract class CollectionItemModel<T> {
  final String id;

  CollectionItemModel({required this.id});

  T fromStorage(Map<String, dynamic> storage);

  Map<String, dynamic> toStorage();
}
