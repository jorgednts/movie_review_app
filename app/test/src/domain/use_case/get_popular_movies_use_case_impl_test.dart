import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/get_popular_movies_use_case.dart';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../resources/test_resources.dart';
import 'get_popular_movies_use_case_impl_test.mocks.dart';

@GenerateMocks([TMDBRepository])
void main() {
  late MockTMDBRepository mockRepository;
  late GetPopularMoviesUseCase useCase;

  setUp(() {
    mockRepository = MockTMDBRepository();
    useCase = GetPopularMoviesUseCase(tmdbRepository: mockRepository);
  });

  provideDummy<Result<List<MovieModel>>>(Result.ok([]));

  test('should get list of popular movies from repository', () async {
    when(mockRepository.getPopularMovies())
        .thenAnswer((_) async => Result.ok(TestResources.mockMovieList));

    final result = await useCase.call(NoParam());

    verify(mockRepository.getPopularMovies()).called(1);
    expect(result, isA<Ok<List<MovieModel>>>());
  });

  test('should return error when repository fails', () async {
    when(mockRepository.getPopularMovies())
        .thenAnswer((_) async => Result.error(Exception('Failed')));

    final result = await useCase.call(NoParam());

    verify(mockRepository.getPopularMovies()).called(1);
    expect(result, isA<Error>());
  });
}
