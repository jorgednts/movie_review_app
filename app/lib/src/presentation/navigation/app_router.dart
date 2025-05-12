import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/get_popular_movies_use_case.dart';
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
        builder:
            (context, state) => HomeView(
              viewModel: HomeViewModel(
                getPopularMoviesUseCase: GetPopularMoviesUseCase(
                  tmdbRepository: context.read<TMDBRepository>(),
                ),
              ),
            ),
      ),
    ],
  );
}
