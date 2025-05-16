import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/create_guest_session_use_case.dart';
import 'package:app/src/domain/use_case/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/get_top_rated_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/search_movies_use_case.dart';
import 'package:app/src/domain/use_case/search_tv_series_use_case.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/navigation/custom_shell_branch.dart';
import 'package:app/src/presentation/ui/home/widgets/home_view.dart';
import 'package:app/src/presentation/ui/home/view_model/home_view_model.dart';
import 'package:app/src/presentation/ui/shell/widgets/shell_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoute.home.path,
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                ShellView(navigationShell: navigationShell),
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
                  searchMoviesUseCase: SearchMoviesUseCase(
                    tmdbRepository: repository,
                  ),
                  searchTVSeriesUseCase: SearchTVSeriesUseCase(
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
          builder: (context, state) => const Placeholder(),
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
      appRoute: AppRoute.settings,
      routes: [
        GoRoute(
          path: AppRoute.settings.path,
          name: AppRoute.settings.name,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    ),
  ];
}
