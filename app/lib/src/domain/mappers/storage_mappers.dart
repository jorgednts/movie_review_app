import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';

extension MovieStorageExtension on MovieModel {
  AppCollectionItemModel toReviewItemModel() {
    return AppCollectionItemModel(
      type: AppCollectionItemType.movie,
      backdropPath: backdropPath,
      tmdbId: id,
      releaseDate: releaseDate,
      originalLanguage: originalLanguage,
      overview: overview,
      posterPath: posterPath,
      title: title,
      voteAverage: voteAverage,
      review: null
    );
  }
}

extension TVSeriesStorageExtension on TVSeriesModel {
  AppCollectionItemModel toReviewItemModel() {
    return AppCollectionItemModel(
      type: AppCollectionItemType.tvSeries,
      backdropPath: backdropPath,
      tmdbId: id,
      releaseDate: firstAirDate,
      originalLanguage: originalLanguage,
      overview: overview,
      posterPath: posterPath,
      title: name,
      voteAverage: voteAverage,
      review: null,
    );
  }
}
