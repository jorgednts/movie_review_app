import 'package:app/src/domain/repository/app_repository.dart';
import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/app/get_search_suggestion_list_local_use_case.dart';
import 'package:app/src/domain/use_case/app/update_search_suggestion_list_local_use_case.dart';
import 'package:app/src/domain/use_case/auth/check_user_logged_use_case.dart';
import 'package:app/src/domain/use_case/auth/create_user_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_in_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_out_use_case.dart';
import 'package:app/src/domain/use_case/storage/add_item_to_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/check_item_in_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/create_user_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/delete_item_from_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_collection_from_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_username_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/create_guest_session_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_cast_members_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_tmdb_item_details_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_tv_series_use_case.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/navigation/custom_shell_branch.dart';
import 'package:app/src/presentation/ui/details/data/operation_command_request.dart';
import 'package:app/src/presentation/ui/details/view_model/details_view_model.dart';
import 'package:app/src/presentation/ui/details/widgets/details_view.dart';
import 'package:app/src/presentation/ui/home/view_model/home_view_model.dart';
import 'package:app/src/presentation/ui/home/widgets/home_view.dart';
import 'package:app/src/presentation/ui/reviews/view_model/reviews_view_model.dart';
import 'package:app/src/presentation/ui/reviews/widgets/reviews_view.dart';
import 'package:app/src/presentation/ui/search/view_model/search_view_model.dart';
import 'package:app/src/presentation/ui/search/widgets/search_view.dart';
import 'package:app/src/presentation/ui/shell/view_model/shell_view_model.dart';
import 'package:app/src/presentation/ui/shell/widgets/shell_view.dart';
import 'package:app/src/presentation/utils/custom_theme_notifier.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: CustomModalNavigator.modalNavigatorKey,
    initialLocation: AppRoute.home.path,
    onException: (context, _, _) => context.goNamed(AppRoute.home.name),
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) => Provider(
              create: (context) {
                final authRepository = context.read<AuthRepository>();
                final storageRepository = context.read<CoreStorageRepository>();
                final userStorageNotifier =
                    context.read<UserStorageChangeNotifier>();
                return ShellViewModel(
                  signInUseCase: SignInUseCase(authRepository: authRepository),
                  signOutUseCase: SignOutUseCase(
                    authRepository: authRepository,
                  ),
                  createUserUseCase: CreateUserUseCase(
                    authRepository: authRepository,
                  ),
                  checkUserLoggedUseCase: CheckUserLoggedUseCase(
                    authRepository: authRepository,
                  ),
                  dialogEventNotifier: MessageEventNotifier<AuthMessageType>(),
                  createUserStorageUseCase: CreateUserStorageUseCase(
                    coreStorageRepository: storageRepository,
                  ),
                  getUserStorageUseCase: GetCollectionFromStorageUseCase(
                    coreStorageRepository: storageRepository,
                  ),
                  getUsernameUseCase: GetUsernameUseCase(
                    coreStorageRepository: storageRepository,
                  ),
                  userChangeNotifier: userStorageNotifier,
                  themeNotifier: context.read<CustomThemeNotifier>(),
                );
              },
              child: ShellView(navigationShell: navigationShell),
            ),
        branches:
            customShellBranches
                .map((item) => item.buildStatefulShellBranch())
                .toList(),
      ),
      GoRoute(
        path: '${AppRoute.details.path}/:itemId',
        name: AppRoute.details.name,
        builder: (context, state) {
          final params = state.uri.queryParameters;
          return Provider(
            create: (context) {
              final detailsViewModel = DetailsViewModel(
                params: DetailsParams.fromJson(params),
                getTMDBItemDetailsUseCase: GetTMDBItemDetailsUseCase(
                  tmdbRepository: context.read<TMDBRepository>(),
                ),
                getSimilarMoviesUseCase: GetSimilarMoviesUseCase(
                  tmdbRepository: context.read<TMDBRepository>(),
                ),
                getSimilarTVSeriesUseCase: GetSimilarTVSeriesUseCase(
                  tmdbRepository: context.read<TMDBRepository>(),
                ),
                getCastMembersUseCase: GetCastMembersUseCase(
                  repository: context.read<TMDBRepository>(),
                ),
                addItemToCollectionUseCase: AddItemToCollectionUseCase(
                  coreStorageRepository: context.read<CoreStorageRepository>(),
                ),
                checkItemInCollectionUseCase: CheckItemInCollectionUseCase(
                  coreStorageRepository: context.read<CoreStorageRepository>(),
                ),
                deleteItemFromCollectionUseCase:
                    DeleteItemFromCollectionUseCase(
                      coreStorageRepository:
                          context.read<CoreStorageRepository>(),
                    ),
                watchlistMessageEventNotifier:
                    MessageEventNotifier<OperationMessageType>(),
                reviewMessageEventNotifier:
                    MessageEventNotifier<OperationMessageType>(),
              );
              return detailsViewModel;
            },
            child: const DetailsView(),
          );
        },
      ),
    ],
  );

  static final customShellBranches = [
    CustomShellBranch(
      appRoute: AppRoute.home,
      routes: [
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) {
            return Provider(
              create: (context) {
                final repository = context.read<TMDBRepository>();
                return HomeViewModel(
                  getPopularMoviesUseCase: GetPopularMoviesUseCase(
                    tmdbRepository: repository,
                  ),
                  getPopularTVSeriesUseCase: GetPopularTVSeriesUseCase(
                    tmdbRepository: repository,
                  ),
                  getTopRatedMoviesUseCase: GetTopRatedMoviesUseCase(
                    tmdbRepository: repository,
                  ),
                  getTopRatedTVSeriesUseCase: GetTopRatedTVSeriesUseCase(
                    tmdbRepository: repository,
                  ),
                  createGuestSessionUseCase: CreateGuestSessionUseCase(
                    tmdbRepository: repository,
                  ),
                );
              },
              child: const HomeView(),
            );
          },
        ),
      ],
    ),
    CustomShellBranch(
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
    ),
    CustomShellBranch(
      appRoute: AppRoute.reviews,
      routes: [
        GoRoute(
          path: AppRoute.reviews.path,
          name: AppRoute.reviews.name,
          builder:
              (context, state) => Provider(
                create: (context) => ReviewsViewModel(),
                child: const ReviewsView(),
              ),
        ),
      ],
    ),
    CustomShellBranch(
      appRoute: AppRoute.watchlist,
      routes: [
        GoRoute(
          path: AppRoute.watchlist.path,
          name: AppRoute.watchlist.name,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    ),
  ];
}
