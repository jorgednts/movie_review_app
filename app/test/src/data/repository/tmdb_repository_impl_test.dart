import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/repository/tmdb_repository_impl.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../resources/test_resources.dart';
import 'tmdb_repository_impl_test.mocks.dart';

@GenerateMocks([TMDBRemoteDataSource])
void main() {
  late MockTMDBRemoteDataSource mockDataSource;
  late TMDBRepositoryImpl repository;
  provideDummy<Result<List<MovieModel>>>(Result.ok([]));
  provideDummy<Result<List<TVSeriesModel>>>(Result.ok([]));

  setUp(() {
    mockDataSource = MockTMDBRemoteDataSource();
    repository = TMDBRepositoryImpl(tmdbRemoteDataSource: mockDataSource);
  });

  group('getPopularMovies', () {
    test('GIVEN a call '
        'WHEN getPopularMovies is called '
        'THEN it should call the data source once', () async {
      when(
        mockDataSource.getPopularMovies(),
      ).thenAnswer((_) async => Result.ok(TestResources.mockMovieList));

      await repository.getPopularMovies();
      verify(mockDataSource.getPopularMovies()).called(1);
    });

    test('GIVEN a successful response '
        'WHEN getPopularMovies is called '
        'THEN it should return a list of movies', () async {
      when(
        mockDataSource.getPopularMovies(),
      ).thenAnswer((_) async => Result.ok(TestResources.mockMovieList));

      final result = await repository.getPopularMovies();
      expect(result, isA<Ok<List<MovieModel>>>());
    });

    test('GIVEN a failure '
        'WHEN getPopularMovies is called '
        'THEN it should return an error', () async {
      when(mockDataSource.getPopularMovies()).thenAnswer(
        (_) async => Result.error(Exception('Error fetching movies')),
      );

      final result = await repository.getPopularMovies();
      expect(result, isA<Error>());
    });
  });

  group('getPopularTVSeries', () {
    test('GIVEN a call '
        'WHEN getPopularTVSeries is called '
        'THEN it should call the data source once', () async {
      when(
        mockDataSource.getPopularTVSeries(),
      ).thenAnswer((_) async => Result.ok(TestResources.mockTVSeriesList));

      await repository.getPopularTVSeries();
      verify(mockDataSource.getPopularTVSeries()).called(1);
    });

    test('GIVEN a successful response '
        'WHEN getPopularTVSeries is called '
        'THEN it should return a list of TV series', () async {
      when(
        mockDataSource.getPopularTVSeries(),
      ).thenAnswer((_) async => Result.ok(TestResources.mockTVSeriesList));

      final result = await repository.getPopularTVSeries();
      expect(result, isA<Ok<List<TVSeriesModel>>>());
    });

    test('GIVEN a failure '
        'WHEN getPopularTVSeries is called '
        'THEN it should return an error', () async {
      when(mockDataSource.getPopularTVSeries()).thenAnswer(
        (_) async => Result.error(Exception('Error fetching series')),
      );

      final result = await repository.getPopularTVSeries();
      expect(result, isA<Error>());
    });
  });
}
