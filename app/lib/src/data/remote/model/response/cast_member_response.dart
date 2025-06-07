class CastMemberResponse {
  final int id;
  final String? name;
  final String? profilePath;
  final String? character;

  CastMemberResponse({
    required this.id,
    required this.name,
    this.profilePath,

    required this.character,
  });

  factory CastMemberResponse.fromJson(Map<String, dynamic> json) {
    return CastMemberResponse(
      id: json['id'],
      name: json['name'] ?? '',
      profilePath: json['profile_path'],
      character: json['character'],
    );
  }
}
