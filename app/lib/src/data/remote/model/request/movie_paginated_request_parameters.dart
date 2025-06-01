import 'package:app/src/data/remote/model/base/base_request_parameters.dart';

class MoviePaginatedRequestParameters extends BaseRequestParameters {
  final String query;
  final bool? includeAdult;
  final String? language;
  final String? primaryReleaseYear;
  final String? region;
  final int? page;
  final String? year;

  MoviePaginatedRequestParameters({
    required this.query,
    this.includeAdult,
    this.language,
    this.primaryReleaseYear,
    this.region,
    this.page,
    this.year,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{'query': query};

    if (includeAdult != null) {
      result['include_adult'] = includeAdult;
    }

    if (language != null) {
      result['language'] = language;
    }
    if (primaryReleaseYear != null) {
      result['primary_release_year'] = primaryReleaseYear;
    }
    if (region != null) {
      result['region'] = region;
    }
    if (page != null) {
      result['page'] = page;
    }
    if (year != null) {
      result['year'] = year;
    }

    return result;
  }

  MoviePaginatedRequestParameters copyWith({
    String? query,
    bool? includeAdult,
    String? language,
    String? primaryReleaseYear,
    String? region,
    int? page,
    String? year,
  }) {
    return MoviePaginatedRequestParameters(
      query: query ?? this.query,
      includeAdult: includeAdult ?? this.includeAdult,
      language: language ?? this.language,
      primaryReleaseYear: primaryReleaseYear ?? this.primaryReleaseYear,
      region: region ?? this.region,
      page: page ?? this.page,
      year: year ?? this.year,
    );
  }
}
