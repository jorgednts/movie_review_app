import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source_impl.dart';
import 'package:app/src/data/repository/tmdb_repository_impl.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:provider/provider.dart';

class Dependencies {
  static final providers = [
    Provider<TMDBRemoteDataSource>(create: (_) => TMDBRemoteDataSourceImpl()),
    ProxyProvider<TMDBRemoteDataSource, TMDBRepository>(
      update:
          (_, remoteDataSource, __) =>
              TMDBRepositoryImpl(tmdbRemoteDataSource: remoteDataSource),
    ),
  ];
}
