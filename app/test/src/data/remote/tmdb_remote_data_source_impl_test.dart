import 'package:app/src/data/remote/client/custom_http_client.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source_impl.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../resources/test_resources.dart';
import 'tmdb_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CustomHttpClient])
void main() {
  late MockCustomHttpClient mockClient;
  late TMDBRemoteDataSource dataSource;

  setUp(() {
    mockClient = MockCustomHttpClient();
    dataSource = TMDBRemoteDataSourceImpl(client: mockClient);
  });

  group('getPopularMovies', () {
    test('GIVEN a call'
        'WHEN getPopularMovies is called '
        'THEN it should call once', () async {
      when(
        mockClient.get(any, headers: anyNamed('headers')),
      ).thenAnswer((_) async => TestResources.mockMoviePaginatedResponse);
      await dataSource.getPopularMovies();
      verify(mockClient.get(any)).called(1);
    });
    test('GIVEN a call'
        'WHEN getPopularMovies is called successfully '
        'THEN it should return a list of movies', () async {
      when(
        mockClient.get(any, headers: anyNamed('headers')),
      ).thenAnswer((_) async => TestResources.mockMoviePaginatedResponse);
      final result = await dataSource.getPopularMovies();
      expect(result, isA<Result<List<MovieModel>>>());
    });
    test(
      'GIVEN a call'
          'WHEN getPopularMovies is called unsuccessfully '
          'THEN it should return an error',
        () async {
          when(
            mockClient.get(any, headers: anyNamed('headers')),
          ).thenThrow(Exception('Error'));
          final result = await dataSource.getPopularMovies();
          expect(result, isA<Error>());
        }
    );
  });


  group('getPopularTVSeries', () {
    test(
      'GIVEN a call '
          'WHEN getPopularTVSeries is called '
          'THEN it should call once',
          () async {
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => TestResources.mockTVSeriesPaginatedResponse);
        await dataSource.getPopularTVSeries();
        verify(mockClient.get(any)).called(1);
      },
    );

    test(
      'GIVEN a call '
          'WHEN getPopularTVSeries is called successfully '
          'THEN it should return a list of tv series',
          () async {
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => TestResources.mockTVSeriesPaginatedResponse);
        final result = await dataSource.getPopularTVSeries();
        expect(result, isA<Result<List<TVSeriesModel>>>());
      },
    );

    test(
      'GIVEN a call '
          'WHEN getPopularTVSeries is called unsuccessfully '
          'THEN it should return an error',
          () async {
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenThrow(Exception('Error'));
        final result = await dataSource.getPopularTVSeries();
        expect(result, isA<Error>());
      },
    );
  });
}
