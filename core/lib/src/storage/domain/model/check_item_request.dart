class CheckItemRequest {
  final String uid;
  final String collectionName;
  final String itemId;

  CheckItemRequest({
    required this.uid,
    required this.collectionName,
    required this.itemId,
  });

  factory CheckItemRequest.fromJson(Map<String, dynamic> json) {
    return CheckItemRequest(
      uid: json['uid'],
      collectionName: json['collectionName'],
      itemId: json['itemId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'collectionName': collectionName, 'itemId': itemId};
  }
}
