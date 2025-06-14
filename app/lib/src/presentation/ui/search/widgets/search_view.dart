import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/presentation/navigation/app_navigator.dart';
import 'package:app/src/presentation/ui/search/view_model/search_view_model.dart';
import 'package:app/src/presentation/ui/search/widgets/loading_more_widget.dart';
import 'package:app/src/presentation/ui/search/widgets/search_info_widget.dart';
import 'package:app/src/presentation/ui/search/widgets/search_retry_button.dart';
import 'package:app/src/presentation/ui/search/widgets/search_state_stacked_icon_card.dart';
import 'package:app/src/presentation/ui/search/widgets/tmdb_overview_poster_card.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SearchViewModel>();
    viewModel.language = Localizations.localeOf(context).toLanguageTag();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.spacingMd),
      child: Column(
        spacing: Dimensions.spacingMd,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: Dimensions.spacingMd,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListenableBuilder(
                    listenable: viewModel.getSuggestions,
                    builder: (_, __) {
                      List<String> suggestions = [];
                      switch (viewModel.getSuggestions.state) {
                        case CommandState.init:
                        case CommandState.loading:
                        case CommandState.error:
                          break;
                        case CommandState.completed:
                          final result =
                              viewModel.getSuggestions.result
                                  as Ok<List<String>>;
                          suggestions.addAll(result.value);
                      }
                      return DefaultSearchBarWithAnchor(
                        searchController: viewModel.searchController,
                        onTap: (controller) => controller.openView(),
                        onChanged: (value, controller) {
                          if (value.isEmpty) {
                            controller.closeView(value);
                            viewModel.initState.value = true;
                            return;
                          }
                          controller.openView();
                        },
                        onSearch: viewModel.handleSearch,
                        suggestions: suggestions,
                        onSuggestionSelected:
                            viewModel.triggerSearchFromSelection,
                      );
                    },
                  ),
                ),
              ),
              SegmentedSwitchButton<AppCollectionItemType>(
                segments: AppCollectionItemType.values,
                iconBuilder: (segment) => segment.icon,
                labelBuilder: (segment) => segment.nameTranslated(context),
                onSelectionChanged: viewModel.onSegmentChange,
                initialIndex: AppCollectionItemType.values.indexOf(
                  viewModel.selectedSegment,
                ),
              ),
            ],
          ),
          Flexible(
            child: ListenableBuilder(
              listenable: Listenable.merge([
                viewModel.searchTVSeries,
                viewModel.searchMovies,
                viewModel.initState,
              ]),
              builder: (context, child) {
                final isMovie =
                    viewModel.selectedSegment == AppCollectionItemType.movie;
                final notifier =
                    isMovie ? viewModel.searchMovies : viewModel.searchTVSeries;

                if (viewModel.initState.value) {
                  return child!;
                }

                final children = <Widget>[];

                if (notifier.items.isEmpty) {
                  if (notifier.isLoading) {
                    children.add(const Expanded(child: LoadingGrid()));
                  } else if (notifier.error != null) {
                    children.add(
                      const Expanded(
                        child: Center(
                          child: SearchStateStackedIconCard.error(),
                        ),
                      ),
                    );
                  } else {
                    children.add(
                      const Expanded(
                        child: Center(
                          child: SearchStateStackedIconCard.empty(),
                        ),
                      ),
                    );
                  }
                } else {
                  children.add(
                    Flexible(
                      child: PaginatedGrid(
                        itemCount: notifier.items.length,
                        hasMoreItems: () => notifier.hasMore,
                        scrollController: viewModel.scrollController,
                        bottomLoadingWidget: const LoadingMoreWidget(),
                        showLoading: () => notifier.isLoading,
                        onLoadMore: notifier.loadNextPage,
                        showRetry:
                            () => !notifier.isLoading && notifier.error != null,
                        retryWidget: SearchRetryButton(
                          onPressed: notifier.loadNextPage,
                        ),
                        itemBuilder: (index) {
                          if (isMovie) {
                            final movie = notifier.items[index] as MovieModel;
                            return TMDBOverviewPosterCard(
                              posterUrl: movie.posterUrl,
                              title: movie.title,
                              voteAverage: movie.voteAverage,
                              releaseYear: movie.releaseYear,
                              overview: movie.overview,
                              onTap:
                                  () => context.navigateToDetails(
                                    movie.id.toString(),
                                    AppCollectionItemType.movie,
                                    movie.storageId,
                                  ),
                            );
                          } else {
                            final tvSeries =
                                notifier.items[index] as TVSeriesModel;
                            return TMDBOverviewPosterCard(
                              posterUrl: tvSeries.posterUrl,
                              title: tvSeries.name,
                              voteAverage: tvSeries.voteAverage,
                              releaseYear: tvSeries.releaseYear,
                              overview: tvSeries.overview,
                              onTap:
                                  () => context.navigateToDetails(
                                    tvSeries.id.toString(),
                                    AppCollectionItemType.tvSeries,
                                    tvSeries.storageId,
                                  ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                }
                return Column(
                  spacing: Dimensions.spacingMd,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SearchInfoWidget(itemsListenable: notifier),
                    ...children,
                  ],
                );
              },
              child: const SearchStateStackedIconCard.init(),
            ),
          ),
        ],
      ),
    );
  }
}
