import 'package:app/src/data/remote/model/base/base_request_parameters.dart';

class TVSeriesPaginatedRequestParameters extends BaseRequestParameters {
  final String query;
  final int? firstAirDate;
  final bool? includeAdult;
  final String? language;
  final int? page;
  final int? year;

  TVSeriesPaginatedRequestParameters({
    required this.query,
    this.firstAirDate,
    this.includeAdult,
    this.language,
    this.page,
    this.year,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{'query': query};
    if (firstAirDate != null) {
      result['first_air_date'] = firstAirDate;
    }
    if (includeAdult != null) {
      result['include_adult'] = includeAdult;
    }
    if (language != null) {
      result['language'] = language;
    }
    if (page != null) {
      result['page'] = page;
    }
    if (year != null) {
      result['year'] = year;
    }
    return result;
  }
}
