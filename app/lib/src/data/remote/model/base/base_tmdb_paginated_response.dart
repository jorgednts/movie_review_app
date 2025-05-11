class BaseTMDBPaginatedResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  BaseTMDBPaginatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory BaseTMDBPaginatedResponse.fromJson({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) {
    return BaseTMDBPaginatedResponse(
      page: json['page'],
      results:
          (json['results'] as List)
              .map((item) => fromJsonT(item as Map<String, dynamic>))
              .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
