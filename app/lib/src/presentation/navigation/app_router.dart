import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/get_top_rated_tv_series_use_case.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/home/home_view.dart';
import 'package:app/src/presentation/ui/home/home_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoute.home.path,
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
              );
            },
            child: const HomeView(),
          );
        },
      ),
    ],
  );
}
