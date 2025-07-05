import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/presentation/navigation/app_navigator.dart';
import 'package:app/src/presentation/ui/home/widgets/poster_carousel.dart';
import 'package:app/src/presentation/ui/home/widgets/tmdb_info_card.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget({super.key, required this.getSimilarMovies});

  final Command0<List<MovieModel>> getSimilarMovies;

  @override
  Widget build(BuildContext context) {
    return PosterCarousel<MovieModel>(
      title: AppIntl.of(context).details_similar,
      titleStyle: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      command: getSimilarMovies,
      cardBuilder:
          (movie) => PosterCard(
            posterUrl: movie.posterUrl,
            infoWidget: TMDBInfoCard(
              title: movie.title,
              voteAverage: movie.voteAverage,
              releaseYear: movie.releaseYear,
            ),
          ),
      onTapItem: (item) {
        context.navigateToDetails(
          item.id.toString(),
          AppCollectionItemType.movie,
          item.storageId,
          push: true,
        );
      },
    );
  }
}
