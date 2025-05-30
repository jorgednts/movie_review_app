class GetCollectionRequest<T> {
  final String uid;
  final String collectionName;
  final T Function(Map<String, dynamic> json) fromJsonT;

  GetCollectionRequest({
    required this.uid,
    required this.collectionName,
    required this.fromJsonT,
  });
}
