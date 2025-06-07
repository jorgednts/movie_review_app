import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/home/view_model/home_view_model.dart';
import 'package:app/src/presentation/ui/home/widgets/poster_carousel.dart';
import 'package:app/src/presentation/ui/home/widgets/tmdb_info_card.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
    final viewModel = context.watch<HomeViewModel>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.spacingMd),
        child: Column(
          spacing: Dimensions.spacingXl,
          children: [
            PosterCarousel<MovieModel>(
              title: AppIntl.of(context).home_popular_movies_title,
              command: viewModel.fetchPopularMovies,
              items: viewModel.popularMovies,
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
                  viewModel.popularMovies[index].id.toString(),
                  AppCollectionItemType.movie,
                );
              },
            ),
            PosterCarousel<TVSeriesModel>(
              title: AppIntl.of(context).home_popular_tv_series_title,
              command: viewModel.fetchPopularTVSeries,
              items: viewModel.popularTVSeries,
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
                    viewModel.popularTVSeries[index].id.toString(),
                    AppCollectionItemType.tvSeries,
                  ),
            ),
            PosterCarousel<MovieModel>(
              title: AppIntl.of(context).home_top_rated_movies_title,
              command: viewModel.fetchTopRatedMovies,
              items: viewModel.topRatedMovies,
              cardBuilder:
                  (movie) => PosterCard(
                    posterUrl: movie.posterUrl,
                    infoWidget: TMDBInfoCard(
                      title: movie.title,
                      voteAverage: movie.voteAverage,
                      releaseYear: movie.releaseYear,
                    ),
                  ),
              onTapItem:
                  (index) => _navigateToDetails(
                    context,
                    viewModel.topRatedMovies[index].id.toString(),
                    AppCollectionItemType.movie,
                  ),
            ),
            PosterCarousel<TVSeriesModel>(
              title: AppIntl.of(context).home_top_rated_tv_series_title,
              command: viewModel.fetchTopRatedTVSeries,
              items: viewModel.topRatedTVSeries,
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
                    viewModel.topRatedTVSeries[index].id.toString(),
                    AppCollectionItemType.tvSeries,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
