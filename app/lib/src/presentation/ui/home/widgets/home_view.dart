import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/presentation/navigation/app_navigator.dart';
import 'package:app/src/presentation/ui/home/view_model/home_view_model.dart';
import 'package:app/src/presentation/ui/home/widgets/poster_carousel.dart';
import 'package:app/src/presentation/ui/home/widgets/tmdb_info_card.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.spacingMd,
          vertical: Dimensions.spacingMd,
        ),
        child: Column(
          spacing: Dimensions.spacingXl,
          children: [
            PosterCarousel<MovieModel>(
              title: AppIntl.of(context).home_popular_movies_title,
              command: viewModel.fetchPopularMovies,
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
                );
              },
            ),
            PosterCarousel<TVSeriesModel>(
              title: AppIntl.of(context).home_popular_tv_series_title,
              command: viewModel.fetchPopularTVSeries,
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
            ),
            PosterCarousel<MovieModel>(
              title: AppIntl.of(context).home_top_rated_movies_title,
              command: viewModel.fetchTopRatedMovies,
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
                );
              },
            ),
            PosterCarousel<TVSeriesModel>(
              title: AppIntl.of(context).home_top_rated_tv_series_title,
              command: viewModel.fetchTopRatedTVSeries,
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
            ),
          ],
        ),
      ),
    );
  }
}
