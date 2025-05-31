import 'package:app/src/data/remote/client/custom_http_client.dart';
import 'package:app/src/data/remote/client/custom_http_client_impl.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source_impl.dart';
import 'package:app/src/data/repository/auth_repository_impl.dart';
import 'package:app/src/data/repository/core_storage_repository_impl.dart';
import 'package:app/src/data/repository/tmdb_repository_impl.dart';
import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:http/http.dart' as http show Client;
import 'package:provider/provider.dart';

class Dependencies {
  static final providers = [
    // Theme Notifier
    ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),

    // Http Client
    Provider<CustomHttpClient>(
      create: (_) => CustomHttpClientImpl(http.Client()),
    ),

    // Data Sources
    ProxyProvider<CustomHttpClient, TMDBRemoteDataSource>(
      update: (_, client, __) => TMDBRemoteDataSourceImpl(client: client),
    ),

    // Services
    Provider<AuthService>(create: (_) => AuthServiceImpl()),
    Provider<StorageService>(create: (_) => StorageServiceImpl()),
    ChangeNotifierProvider<UserStorageChangeNotifier>(
      create: (_) => UserStorageChangeNotifier(),
    ),

    // Repositories
    ProxyProvider<TMDBRemoteDataSource, TMDBRepository>(
      update:
          (_, remoteDataSource, __) =>
              TMDBRepositoryImpl(tmdbRemoteDataSource: remoteDataSource),
    ),
    ProxyProvider<AuthService, AuthRepository>(
      update:
          (_, authService, __) => AuthRepositoryImpl(authService: authService),
    ),
    ProxyProvider<StorageService, CoreStorageRepository>(
      update:
          (_, storageService, __) =>
              CoreStorageRepositoryImpl(storageService: storageService),
    ),
  ];
}
