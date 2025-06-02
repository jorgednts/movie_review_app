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
import 'package:app/src/domain/use_case/storage/create_user_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_collection_from_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_username_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/create_guest_session_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_tv_series_use_case.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/navigation/custom_shell_branch.dart';
import 'package:app/src/presentation/ui/home/view_model/home_view_model.dart';
import 'package:app/src/presentation/ui/home/widgets/home_view.dart';
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
                  dialogEventNotifier: DialogEventNotifier<AuthMessageType>(),
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
      appRoute: AppRoute.review,
      routes: [
        GoRoute(
          path: AppRoute.review.path,
          name: AppRoute.review.name,
          builder: (context, state) => const Placeholder(),
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
