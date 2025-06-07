class CastMemberModel {
  final int id;
  final String name;
  final String profilePath;
  final String character;

  CastMemberModel({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
  });

  String get profileUrl => 'https://image.tmdb.org/t/p/original/$profilePath';
}
