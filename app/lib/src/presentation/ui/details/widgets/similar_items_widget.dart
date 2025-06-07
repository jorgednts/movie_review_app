import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/home/widgets/poster_carousel.dart';
import 'package:app/src/presentation/ui/home/widgets/tmdb_info_card.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class SimilarItemsWidget extends StatelessWidget {
  const SimilarItemsWidget({
    super.key,
    required this.getSimilarItems,
    required this.items,
  });

  final Command getSimilarItems;
  final List items;

  void _navigateToDetails(
    BuildContext context,
    String id,
    AppCollectionItemType type,
  ) {
    context.pushNamed(
      AppRoute.details.name,
      pathParameters: {'itemId': id},
      queryParameters:
          DetailsParams(
            itemId: id,
            itemType: type,
            language: Localizations.localeOf(context).toLanguageTag(),
          ).toJson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items is List<MovieModel>) {
      return PosterCarousel<MovieModel>(
        title: AppIntl.of(context).details_similar,
        titleStyle: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        command: getSimilarItems,
        items: items as List<MovieModel>,
        cardBuilder:
            (movie) => PosterCard(
              posterUrl: movie.posterUrl,
              infoWidget: TMDBInfoCard(
                title: movie.title,
                voteAverage: movie.voteAverage,
                releaseYear: movie.releaseYear,
              ),
            ),
        onTapItem: (index) {
          _navigateToDetails(
            context,
            items[index].id.toString(),
            AppCollectionItemType.movie,
          );
        },
      );
    }
    return PosterCarousel<TVSeriesModel>(
      title: AppIntl.of(context).details_similar,
      command: getSimilarItems,
      items: items as List<TVSeriesModel>,
      cardBuilder:
          (tvSeries) => PosterCard(
            posterUrl: tvSeries.posterUrl,
            infoWidget: TMDBInfoCard(
              title: tvSeries.name,
              voteAverage: tvSeries.voteAverage,
              releaseYear: tvSeries.releaseYear,
            ),
          ),
      onTapItem:
          (index) => _navigateToDetails(
            context,
            items[index].id.toString(),
            AppCollectionItemType.tvSeries,
          ),
    );
  }
}
