import 'package:app/src/data/remote/model/response/cast_member_response.dart';

class CreditsResponse {
  final List<CastMemberResponse>? cast;

  CreditsResponse({required this.cast});

  factory CreditsResponse.fromJson(Map<String, dynamic> json) {
    return CreditsResponse(
      cast:
          (json['cast'] as List<dynamic>?)
              ?.map((e) => CastMemberResponse.fromJson(e))
              .toList(),
    );
  }
}
