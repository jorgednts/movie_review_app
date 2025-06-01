class BaseTMDBPaginatedModel<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  BaseTMDBPaginatedModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}
