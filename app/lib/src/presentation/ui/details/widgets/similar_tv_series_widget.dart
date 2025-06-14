import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/presentation/navigation/app_navigator.dart';
import 'package:app/src/presentation/ui/home/widgets/poster_carousel.dart';
import 'package:app/src/presentation/ui/home/widgets/tmdb_info_card.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class SimilarTVSeriesWidget extends StatelessWidget {
  const SimilarTVSeriesWidget({super.key, required this.getSimilarTVSeries});

  final Command0<List<TVSeriesModel>> getSimilarTVSeries;

  @override
  Widget build(BuildContext context) {
    return PosterCarousel<TVSeriesModel>(
      title: AppIntl.of(context).details_similar,
      command: getSimilarTVSeries,
      cardBuilder:
          (tvSeries) => PosterCard(
            posterUrl: tvSeries.posterUrl,
            infoWidget: TMDBInfoCard(
              title: tvSeries.name,
              voteAverage: tvSeries.voteAverage,
              releaseYear: tvSeries.releaseYear,
            ),
          ),
      onTapItem: (item) {
        context.navigateToDetails(
          item.id.toString(),
          AppCollectionItemType.tvSeries,
          item.storageId,
        );
      },
    );
  }
}
