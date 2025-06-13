import 'package:app/src/domain/repository/app_repository.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/app/get_search_suggestion_list_local_use_case.dart';
import 'package:app/src/domain/use_case/app/update_search_suggestion_list_local_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_tv_series_use_case.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/navigation/custom_shell_branch.dart';
import 'package:app/src/presentation/ui/search/view_model/search_view_model.dart';
import 'package:app/src/presentation/ui/search/widgets/search_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchDependency {
  static final dependency = CustomShellBranch(
    appRoute: AppRoute.search,
    routes: [
      GoRoute(
        path: AppRoute.search.path,
        name: AppRoute.search.name,
        builder:
            (context, state) => Provider(
              create: (context) {
                final tmdbRepository = context.read<TMDBRepository>();
                final appRepository = context.read<AppRepository>();
                return SearchViewModel(
                  searchMoviesUseCase: SearchMoviesUseCase(
                    tmdbRepository: tmdbRepository,
                  ),
                  searchTVSeriesUseCase: SearchTVSeriesUseCase(
                    tmdbRepository: tmdbRepository,
                  ),
                  getSearchSuggestionListLocalUseCase:
                      GetSearchSuggestionListLocalUseCase(
                        appRepository: appRepository,
                      ),
                  updateSearchSuggestionListLocalUseCase:
                      UpdateSearchSuggestionListLocalUseCase(
                        appRepository: appRepository,
                      ),
                );
              },
              child: const SearchView(),
            ),
      ),
    ],
  );
}
