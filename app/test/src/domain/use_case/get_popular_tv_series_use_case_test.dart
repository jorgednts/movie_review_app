import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_tv_series_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../resources/test_resources.dart';
import 'get_popular_tv_series_use_case_test.mocks.dart';

@GenerateMocks([TMDBRepository])
void main() {
  late MockTMDBRepository mockRepository;
  late GetPopularTVSeriesUseCase useCase;

  setUp(() {
    mockRepository = MockTMDBRepository();
    useCase = GetPopularTVSeriesUseCase(tmdbRepository: mockRepository);
  });

  provideDummy<Result<List<TVSeriesModel>>>(const Result.ok([]));

  test('should get list of popular TV series from repository', () async {
    when(
      mockRepository.getPopularTVSeries(),
    ).thenAnswer((_) async => Result.ok(TestResources.mockTVSeriesList));

    final result = await useCase.call(NoParam());

    verify(mockRepository.getPopularTVSeries()).called(1);
    expect(result, isA<Ok<List<TVSeriesModel>>>());
  });

  test('should return error when repository fails', () async {
    when(
      mockRepository.getPopularTVSeries(),
    ).thenAnswer((_) async => Result.error(Exception('Failed')));

    final result = await useCase.call(NoParam());

    verify(mockRepository.getPopularTVSeries()).called(1);
    expect(result, isA<Error>());
  });
}
