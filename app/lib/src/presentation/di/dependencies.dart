import 'package:app/src/data/remote/client/custom_http_client.dart';
import 'package:app/src/data/remote/client/custom_http_client_impl.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source_impl.dart';
import 'package:app/src/data/repository/tmdb_repository_impl.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:http/http.dart' as http show Client;
import 'package:provider/provider.dart';

class Dependencies {
  static final providers = [
    // Http Client
    Provider<CustomHttpClient>(
      create: (_) => CustomHttpClientImpl(http.Client()),
    ),

    // Data Sources
    ProxyProvider<CustomHttpClient, TMDBRemoteDataSource>(
      update: (_, client, __) => TMDBRemoteDataSourceImpl(client: client),
    ),

    // Repositories
    ProxyProvider<TMDBRemoteDataSource, TMDBRepository>(
      update:
          (_, remoteDataSource, __) =>
              TMDBRepositoryImpl(tmdbRemoteDataSource: remoteDataSource),
    ),
  ];
}
